import pypyodbc as db

con = db.connect("Driver={SQL Server};Server=ITS-H-NOROUZPOU\SQLEXPRESS;Database=Eris;Uid=sa;Pwd=123456;")
cur = con.cursor()
cur.execute("")

cur.close()
con.close()