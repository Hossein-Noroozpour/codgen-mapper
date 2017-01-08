fi = open("C:\\Users\\h.norouzpour\\PycharmProjects\\codgen-mapper\\countries.txt")
fo = open("C:\\Users\\h.norouzpour\\PycharmProjects\\codgen-mapper\\countries.py", "w")
fo.write("countries = dict()\n")
for l in fi:
    s = l.strip()
    s = s.split("\t")
    fo.write("countries[" + s[0] + "] = '" + s[1] + "'\n")
