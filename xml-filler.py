from xml.etree import ElementTree as Elm
from database import rec_table
from map import *
import pypyodbc
import copy

con = pypyodbc.connect('Driver={SQL Server};Server=ITS-H-NOROUZPOU\SQLEXPRESS;Database=Eris;uid=sa;pwd=123456')
csr = con.cursor()
root = Elm.parse("E:\\Projects\\FRM32 Mapping\\FRM32_1395.xml").getroot()
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
        pass
    if column in rec_table:
        select_cols = select_cols + column + ", "
    else:
        pass
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
        select_employee_columns += column + ", "
    else:
        print(column)
        continue
print(select_employee_columns)

query = "select distinct " + select_cols + """Employer.Id
from Salary join Lists on Salary.ListId=Lists.Id join Employer on Employer.Id=Lists.UserId
order by Employer.Id"""


employee_query = "select distinct " + select_employee_columns[:len(select_employee_columns)-2] + """
from Salary
join Lists on Salary.ListId=Lists.Id
join CompEmp on CompEmp.Id=Salary.CompEmpId
join Employee on Employee.Id=CompEmp.EmployeeId
"""
# print("Query is: ", query)
print("Employee query is: ", employee_query)

csr.execute(query)

xml_file = 0


def fill_employee(employee_element):
    csr.execute(employee_query)
    employee_rows = csr.fetchall()
    elements = []
    for employee_row in employee_rows:
        element = copy.deepcopy(employee_element)
        for child in element:
            tag = child.tag.strip()
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
            child.text = str(employee_row[index])
        elements.append(element)
    return elements


def fill_xml(row, file_name):
    tree = Elm.parse("E:\\Projects\\FRM32 Mapping\\FRM32_1395.xml")
    r = tree.getroot()
    ret = None

    for e in r.iter('RetForm'):
        ret = e
        break

    col_index = 0
    appendee_employee = []
    for ch in ret:
        t = ch.tag.strip()
        if t == "table2_employees_demographic_data":
            print("dfdfsdfsdfsdfsdfsdfsdfsdfsdfsdsdfs")
            chcopy = copy.deepcopy(ch)
            ret.remove(ch)
            appendee_employee = fill_employee(chcopy)
            continue
        col = ""
        if t in data_to_xml:
            col = data_to_xml[t]
        else:
            continue
        if col in rec_table:
            ch.text = str(row[col_index])
            col_index += 1
        else:
            continue
    for element in appendee_employee:
        ret.append(element)
    tree.write("E:\\Projects\\FRM32 Mapping\\output\\" + str(file_name) + ".xml")

rows = csr.fetchall()

for row in rows:
    fill_xml(row, xml_file)
    xml_file += 1
    print("file ", xml_file, " done.")
