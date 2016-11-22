fi = open("offices.txt")
fo = open("offices.py", "w")
fo.write("offices = dict()\n")
for l in fi:
    s = l.strip()
    s = s.split("\t")
    fo.write("offices[" + str(int(s[1])) + "] = " + str(int(s[0])) + "\n")
