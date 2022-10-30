import oracledb
import os

sysCS = f'{"system"}/{"1234"}@{"localhost"}:{1521}/{"xe"}'
turCS = f'{"USR_TURISMO_REAL"}/{"USR_TURISMO_REAL"}@{"localhost"}:{1521}/{"xe"}'


def runScrpit(con, path, quiet=False):
    script = readScript(path)
    for line in script:
        runCommand(con, line)

def readScript(path):
    script = []
    with open(path) as f:
        raw = f.readlines()
        lastLine = ""
        nestedLvl = 0
        for line in raw:
            line = line.replace("\n", "").replace("/", "")
            if ("--" in line or line == ""):
                continue
            if (";" in line):
                if "end" in line.lower():
                    nestedLvl -= 1
                if nestedLvl == 0:
                    if "end" not in line.lower():
                        line = line.replace(";","")
                    script.append(lastLine + line)
                    lastLine = ""
                    continue
            
            lastLine = lastLine + line + " "
            if "begin" in line.lower():
                nestedLvl += 1
                    
            
    return script

def runCommand(con, command):
    print(command)
    with con.cursor() as cursor:
        cursor.execute(command)

def createUser():
    with oracledb.connect(sysCS) as connection:
        runScrpit(connection, "../scripts/USR_TURISMO_REAL.sql")

def fillDB():
    with oracledb.connect(turCS) as connection:
        runScrpit(connection, "../scripts/CREATE TABLES.sql")
        runScrpit(connection, "../scripts/BASIC DATA.sql")
        runScrpit(connection, "../scripts/REGIONES_Y_COMUNAS.sql")

if __name__ == "__main__":
    createUser()
    fillDB()