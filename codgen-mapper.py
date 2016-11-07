with open("E:\\Projects\\FRM32 Mapping\\map-dic.txt", encoding="Latin") as f:
    with open("C:\\Users\\h.norouzpour\\PycharmProjects\\codgen-mapper\\map.py", "w") as o:
        o.write("data_to_xml = dict()\nxml_to_data = dict()\n")
        for line in f:
            first = None
            second = None
            for e in line.split(' '):
                e = e.strip()
                if len(e) == 0:
                    continue
                if first is not None:
                    if len(e) != 0:
                        hu = True
                        for c in e:
                            if ord('0') > ord(c) or ord(c) > ord('z'):
                                hu = False
                                break
                        if hu:
                            if second is None:
                                second = e
                            else:
                                second = None
                                break
                        else:
                            second = None
                            break
                elif len(e) != 0 and e.startswith("<") and e.endswith(">"):
                    first = e[1:len(e) - 1]
            if first is not None and second is not None:
                first = first.strip()
                second = second.strip()
                s = "data_to_xml[\"" + first + "\"] = \"" + second + "\"\n" + "xml_to_data[\"" + second + "\"] = \"" + first + "\"\n"
                o.write(s)
                print(s)
