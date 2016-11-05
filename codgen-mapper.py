with open("E:\\Projects\\FRM32 Mapping\\map-dic.txt", encoding="Latin") as f:
    with open("E:\\1.txt", "w", encoding="Latin") as o:
        for line in f:
            first = None
            for e in line.split(' '):
                e = e.trim()
                if len(e) == 0:
                    continue
                if first is not None 
                if len(e) != 0 and e.startswith("<") and e.endswith(">"):
                    first = e[1:len(e)-1]