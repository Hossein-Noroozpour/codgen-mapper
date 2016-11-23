from xml.etree import ElementTree as Elm
from database import rec_table
from map import *
import pypyodbc
import copy
import convertors
import offices

source_xml_file = "E:\\Projects\\FRM32 Mapping\\FRM32_1395-exp-2.xml"

con = pypyodbc.connect('Driver={SQL Server};Server=ITS-H-NOROUZPOU\SQLEXPRESS;Database=Eris;uid=sa;pwd=123456')
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
        select_employee_columns += column + ", "
    else:
        print(column)
        continue
print(select_employee_columns)

query = "select distinct " + select_cols + """Month, NationalCode, Employer.Id, Lists.Id
from Salary join Lists on Salary.ListId=Lists.Id join Employer on Employer.Id=Lists.UserId
order by Employer.Id"""

print("Query string: ", query)

employee_query = "select distinct " + select_employee_columns[:len(select_employee_columns)-2] + """
from Salary
join Lists on Salary.ListId=Lists.Id
join CompEmp on CompEmp.Id=Salary.CompEmpId
join Employee on Employee.Id=CompEmp.EmployeeId
where CompEmp.UserId=? and Lists.Id=?
"""

payments_query = """
select PaymentId, BankId, ShobeName, PaidDate, GhabzNo, MablagPardakhti, KhazanehMablagh
from Lists
where UserId=? and Lists.Id=?
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
        return str(v)


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
                    element.remove(child)
                    continue
            elif tag == "foreign_national_comprehensive_code":
                if nationality != 2:
                    element.remove(child)
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
                child.text = convert(payment_row[5], tag)
        elements.append(element)
    return elements


def fill_xml(row, file_name):
    tax_period = row[len(row)-4]
    national_id = row[len(row)-3]
    employer_id = row[len(row)-2]
    list_id = row[len(row)-1]
    row = row[:len(row)-4]
    tree = Elm.parse(source_xml_file)
    r = tree.getroot()
    ret = None

    for e in r.iter('MessageID'):
        e.text = 'Hossein-Noroozpour-xml-' + str(file_name)
        break

    for e in r.iter('barCode'):
        e.text = 'hossein1111130011_' + str(file_name)
        break

    for e in r.iter('taxpayerId'):
        e.text = str(national_id).strip()
        break

    for e in r.iter('officeId'):
        e.text = str(national_id).strip()
        break

    for e in r.iter('taxPeriod'):
        e.text = str(tax_period).strip()
        break

    for e in r.iter('officeId'):
        hoze = 321123
        e.text = str(offices.offices[int(hoze / 100)])
        break

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
    tree.write("E:\\Projects\\FRM32 Mapping\\output\\" + str(file_name) + ".xml", encoding="UTF-8", xml_declaration=True)

rows = csr.fetchall()

print(len(rows))

xml_file = 0

for row in rows:
    fill_xml(row, xml_file)
    xml_file += 1
    print("file ", xml_file, " done.")
