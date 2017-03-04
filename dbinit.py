

with open("./docs/Untitled_sqlite_create.sql", "r") as sql:
    cmd = ""
    with open("dbinit.R","w") as db:
        db.write('library(RSQLite)\n')
        db.write('db <- dbConnect(SQLite(), dbname="./docs/test.sqlite")\n')     

        for line in sql:
            if line == "\n":
                continue
            elif line == ");\n":
                cmd += line.strip()
                db.write('dbSendQuery(conn = db,"' + cmd + '")\n')
                cmd = ""
            else:
                cmd += line
        db.write('dbDisconnect(db)')

