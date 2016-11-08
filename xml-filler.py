from xml.etree import ElementTree as Elm
from database import rec_table
from map import *

root = Elm.parse("E:\\Projects\\FRM32 Mapping\\FRM32_1395.xml").getroot()
# data_root = Elm.parse("C:\\Users\\h.norouzpour\\Documents\\1.xml").getroot()

ret_form = None

for e in root.iter('RetForm'):
    ret_form = e
    break

select_cols = ""

for child in ret_form:
    t = child.tag.split('\0')[0].strip()
    col = ""
    if t in data_to_xml:
        col = data_to_xml[t]
    else:
        pass
    if col in rec_table:
        select_cols = select_cols + col + ", "
    else:
        pass

print(select_cols)




