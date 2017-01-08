fi = open("C:\\Users\\h.norouzpour\\PycharmProjects\\codgen-mapper\\database.txt", "r")
fo = open("C:\\Users\\h.norouzpour\\PycharmProjects\\codgen-mapper\\database.py", "w")

fo.write("rec_table = dict()\n")

v = ""

ks = dict()

for l in fi:
    s = l.strip()
    s = s.split("[")
    if len(s) == 1:
        v = s[0]
        continue
    elif len(s) == 0:
        raise Exception("len == 0")
    s = s[len(s)-1].split("]")[0].strip()
    if s in ks:
        print(s + " duplicate " + v)
        print(ks[s])
    else:
        ks[s] = []
    ks[s].append(v)
    fo.write("rec_table['" + s + "'] = '" + v + "'\n")
