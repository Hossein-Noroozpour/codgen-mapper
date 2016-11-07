import map
import database

fi = open("E:\\Projects\\FRM32 Mapping\\FRM32_1395.xml", "r")
fo = open("E:\\Projects\\FRM32 Mapping\\FRM32_1395-explained.xml", "w")

for l in fi:
    l = l[:len(l) - 1]
    s = l.strip()
    t = ""
    s = s.split('>')[0].split('<')[1].strip()
    # s = s[]
    fo.write('\n')
    fo.write(l)
    if len(s) < 2:
        continue
    c = ord(s[0])
    if c < ord('A') or c > ord('z') or ord('Z') < c < ord('a'):
        continue
    fo.write(" <!--")
    if s in map.data_to_xml:
        k = map.data_to_xml[s]
        fo.write(database.rec_table[k] + "." + k)
    else:
        fo.write("NOT FOUND")
        print(s)
    fo.write("-->")
