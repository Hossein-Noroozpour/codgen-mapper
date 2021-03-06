#!/usr/bin/python3
from xml.etree import ElementTree as Elm
from database import rec_table
from map import *
import pypyodbc
import copy
import convertors
import random
import string
import sys

TAX_YEAR = 1395
TAX_YEAR_STR = '1395'
BARCODE_FORMAT = string.digits
BARCODE = ''.join(random.SystemRandom().choice(BARCODE_FORMAT) for _ in range(10)) + '_'
database = 'Eris'
username = 'SA'
source_xml_file = "xmls/sample.xml"
output_xml_directory = "output/"
if sys.platform == 'linux':
    server = 'localhost'
    password = 'Sql1$project'
else:
    server = '.\SQLEXPRESS'
    password = '123456'
#for mac
#driver = '{/usr/local/lib/libtdsodbc.so}'
#for linux or windows
driver= '{ODBC Driver 13 for SQL Server}'
connection_string = 'DRIVER=' + driver + ';PORT=1433;SERVER=' + server + ';PORT=1443;DATABASE=' + database + ';UID='
connection_string = connection_string + username + ';PWD=' + password
con = pypyodbc.connect(connection_string)
csr = con.cursor()
root = Elm.parse(source_xml_file).getroot()
ret_form = None
for element in root.iter('RetForm'):
    ret_form = element
    break
select_cols = ""
for child in ret_form:
    tag = child.tag.split('\0')[0].strip()
    column = ""
    if tag in data_to_xml:
        column = data_to_xml[tag]
    else:
        print("Tag:", tag, " does not have equivalent in database.")
        continue
    if column in rec_table:
        if column == "SalaryPayment86":
            column = "max(case when SalaryPayment86=1 then 1 else 0 end)"
        elif column == "cash_noncash_ongoing_uncontinuous_salaries_current_tota":
            column = "sum(cash_noncash_ongoing_uncontinuous_salaries_current_tota)"
        elif column == "net_tax_total":
            column = "sum(net_tax_total)"
        select_cols = select_cols + column + ", "
    else:
        print("Column:", column, " not found in database.")
        continue
print(select_cols)
for element in root.iter('table2_employees_demographic_data'):
    ret_form = element
    break
select_employee_columns = ""
columns_index = dict()
index = 0
for child in ret_form:
    tag = child.tag.strip()
    column = ""
    if tag in data_to_xml:
        column = data_to_xml[tag]
    else:
        continue
    if '__' in column:
        columns_index[column] = index
        index += 1
        column_split = column.split()
        select_employee_columns += "IIF(" + column_split[0] + "=NULL, " + column_split[1] + ", " + column_split[0] + "), "
    elif column in rec_table:
        if column in columns_index:
            continue
        columns_index[column] = index
        index += 1
        if column == "MelliCode":
            column = "Employee.MelliCode"
        elif column == "Name":
            column = "Employee.Name"
        elif column == "MoafiatId":
            column = "Employee.MoafiatId"
        elif column == "Address":
            column = "Employee.Address"
        elif column == "WorkPlaceStatus":
            column = "CompEmp.WorkPlaceStatus"
        select_employee_columns += column + ", "
    else:
        print(column)
        continue
print(select_employee_columns)

CREATE_FAKE_TINS = False
FILTER_EMPLOYERS = False
FAKE_OFFICE_ID = "1753"
query = None
if CREATE_FAKE_TINS:
    query = "select distinct " + select_cols + """SendDate, List.Hozeh, Month,
        InstEmployers.fake_tin, InstEmployers.fake_office, Employer.Id, List.Id
        from Salary
        join List on Salary.ListId=List.Id
        join Employer on Employer.Id=List.UserId
        join [ErisHelper].[dbo].EmployerFilter on Employer.NationalCode=EmployerFilter.tin
        join [ErisHelper].[dbo].InstEmployers on EmployerFilter.tin = InstEmployers.real_tin
        group by RoznameDate, KarkonanNo, KharejiNo, OwnerShipTypeDesc, Month, SendDate, List.Hozeh, Month,
        InstEmployers.fake_tin, InstEmployers.fake_office, Employer.Id, List.Id
        order by InstEmployers.fake_tin, List.Id"""
elif FILTER_EMPLOYERS:
    query = "select distinct " + select_cols + """SendDate, List.Hozeh, Month,
        EmployerFilter.tin, EmployerFilter.office, Employer.Id, List.Id
        from Salary
        join List on Salary.ListId=List.Id
        join Employer on Employer.Id=List.UserId
        join [ErisHelper].[dbo].EmployerFilter on Employer.NationalCode=EmployerFilter.tin
        group by RoznameDate, KarkonanNo, KharejiNo, OwnerShipTypeDesc, Month, SendDate, List.Hozeh, Month,
        EmployerFilter.tin, EmployerFilter.office, Employer.Id, List.Id
        order by EmployerFilter.tin, List.Id"""
else:
    query = """
SELECT DISTINCT
    %s SendDate, List.Hozeh, Month, Employer.NationalCode,
    SUBSTRING(Employer.TaxOfficeCode, 0, 4), Employer.Id, List.Id
FROM
    Salary
    JOIN List ON Salary.ListId = List.Id
    JOIN Employer ON Employer.Id = List.UserId
GROUP BY
    RoznameDate, KarkonanNo, KharejiNo, OwnerShipTypeDesc, Month, SendDate,
    List.Hozeh, Month, Employer.NationalCode,
    SUBSTRING(Employer.TaxOfficeCode, 0, 4), Employer.Id, List.Id
ORDER BY Employer.NationalCode, List.Id
""" % (select_cols)

print("Query string: ", query)

employee_query = "select distinct " + select_employee_columns[:len(select_employee_columns)-2] + """
from Salary
join List on Salary.ListId=List.Id
join CompEmp on CompEmp.Id=Salary.CompEmpId
join Employee on Employee.Id=CompEmp.EmployeeId
where List.UserId=? and List.Id=?
"""

payments_query = """
select PaymentId, BankId, ShobeName, PaidDate, GhabzNo, MablagPardakhti, KhazanehMablagh
from List
where UserId=? and List.Id=?
"""
# print("Query is: ", query)
print("Employee query is: ", employee_query)

csr.execute(query)


def convert(v, t):
    if v is None:
        return ""
    try:
        return convertors.v2x[t](v)
    except KeyError:
        return str(v).strip()


def fill_employee(employee_element, employer_id, list_id):
    csr.execute(employee_query, [employer_id, list_id])
    employee_rows = csr.fetchall()
    elements = []
    for employee_row in employee_rows:
        element = copy.deepcopy(employee_element)
        # find nationality
        nationality = convert(employee_row[columns_index["NationalityId"]], 'nationality')
        if "01" == nationality:
            nationality = 1
        elif "02" == nationality:
            nationality = 2
        else:
            nationality = 0
        element.find('nationality')
        for child in element:
            tag = child.tag.strip()
            # nationality
            if tag == "id":
                if nationality != 1:
                    child.text = None
                    continue
            elif tag == "foreign_national_comprehensive_code":
                if nationality != 2:
                    child.text = None
                    continue

            column = ""
            index = -1
            if tag in data_to_xml:
                column = data_to_xml[tag]
            else:
                continue
            if '__' in column:
                index = columns_index[column]
            elif column in rec_table:
                index = columns_index[column]
            else:
                continue
            child.text = convert(employee_row[index], tag)
        elements.append(element)
    return elements


def fill_payments(payment_element, employer_id, list_id):
    csr.execute(payments_query, [employer_id, list_id])
    payments_rows = csr.fetchall()
    elements = []
    for payment_row in payments_rows:
        element = copy.deepcopy(payment_element)
        for child in element:
            tag = child.tag
            if tag == "payment_type":
                child.text = convert(payment_row[0], tag)
            if tag == "bank":
                child.text = convert(payment_row[1], tag)
            if tag == "branch":
                child.text = convert(payment_row[2], tag)
            if tag == "slip_date":
                child.text = convert(payment_row[3], tag)
            if tag == "slip_number":
                child.text = convert(payment_row[4], tag)
            if tag == "amount":
                amount = 0
                if payment_row[5] is not None:
                    amount += float(payment_row[5])
                if payment_row[6] is not None:
                    amount += float(payment_row[6])
                child.text = convert(amount, tag)
        elements.append(element)
    return elements


def fill_xml(row, file_name, row_number):
    send_date = int(str(row[len(row)-7]).strip())
    hoze = int(str(row[len(row)-6]).strip())
    tax_period = row[len(row)-5]
    national_id = row[len(row)-4]
    eris_helper_office = row[len(row)-3]
    employer_id = row[len(row)-2]
    list_id = row[len(row)-1]
    row = row[:len(row)-5]
    tree = Elm.parse(source_xml_file)
    r = tree.getroot()

    def set_elm_txt(tag, txt):
        for ee in r.iter(tag):
            ee.text = txt
            break

    ret = None

    for e in r.iter('MessageID'):
        e.text = 'generated-xml-' + str(file_name)
        break

    for e in r.iter('barCode'):
        e.text = BARCODE + str(file_name)
        break

    for e in r.iter('taxpayerId'):
        e.text = str(national_id).strip()
        break

    for e in r.iter('taxPeriod'):
        e.text = str(tax_period).strip()
        break

    for e in r.iter('officeId'):
        # version 1
        # hoze = int(hoze / 100)
        # try:
        #     e.text = str(offices.offices[hoze])
        # except KeyError:
        #     return False
        # break
        # version 2
        # import tin2office
        # try:
        #     e.text = str(tin2office.t2o[int(national_id.strip())])  # + "-" + str(int(int(hoze) / 100))
        # except KeyError:
        #     e.text = FAKE_OFFICE_ID
        # print(national_id, e.text)
        # break
        # version 3
        e.text = eris_helper_office

    period_from = int(str(tax_period).strip())
    if period_from < 7:
        period_to = TAX_YEAR_STR + str(period_from).zfill(2) + "31"
    elif period_from != 12:
        period_to = TAX_YEAR_STR + str(period_from).zfill(2) + "30"
    else:
        period_to = TAX_YEAR_STR + str(period_from).zfill(2) + "30"
    period_from = TAX_YEAR_STR + str(period_from).zfill(2) + "01"

    set_elm_txt('periodFrom', convertors.a_date_filler(int(period_from)))
    set_elm_txt('periodTo', convertors.a_date_filler(int(period_to)))
    send_date = str(send_date)
    send_date = send_date[0:4] + "-" + send_date[4:6] + "-" + send_date[6:8]
    set_elm_txt('fillingDate', send_date)

    for e in r.iter('RetForm'):
        ret = e
        break

    col_index = 0
    appendee_employee = []
    appendee_payments = []
    for ch in ret:
        t = ch.tag.strip()
        # special tags
        if t == "table2_employees_demographic_data":
            chcopy = copy.deepcopy(ch)
            ret.remove(ch)
            appendee_employee = fill_employee(chcopy, employer_id, list_id)
            continue
        elif t == "table1_payments_made_to_inta":
            chcopy = copy.deepcopy(ch)
            ret.remove(ch)
            appendee_payments = fill_payments(chcopy, employer_id, list_id)
        col = ""
        if t in data_to_xml:
            col = data_to_xml[t]
        else:
            continue
        if col in rec_table:
            ch.text = convert(row[col_index], t)
            col_index += 1
        else:
            continue
    for element in appendee_employee:
        ret.append(element)
    if len(appendee_payments) == 0:
        raise Exception('Error 0 payment')
    for element in appendee_payments:
        ret.append(element)
    tree.write(
        output_xml_directory + str(file_name).zfill(9) + "-" + str(row_number).zfill(9) +
        "-" + str(employer_id).zfill(9) + ".xml", encoding="UTF-8", xml_declaration=True)

rows = csr.fetchall()

print(len(rows))

xml_file = 0
row_number = 0

for row in rows:
    res = fill_xml(row, xml_file, row_number)
    row_number += 1
    if res is not None and not res:
        continue
    xml_file += 1
    print("file ", xml_file, " done.")
