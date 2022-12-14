import oracledb
from os import listdir
from os.path import isfile, join

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
        line_count = 0
        for line in raw:
            line_count += 1
            if line_count == 393:
                pass
            line = line.replace("\n", "")
            if ("--" in line or line == "" or line == " " or line == "/"):
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
            if isNesting(line):
                nestedLvl += 1
            
            
    return script

def buildPackage(con, path, quiet=False):
    package = readPackage(path)
    runCommand(con, package)

def readPackage(path):
    script = ""
    with open(path) as f:
        raw = f.readlines()
        for line in raw:
            if "/" in line:
                continue
            script += line
    return script

def runCommand(con, command):
    print("--")
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
        buildPackage(connection, "../scripts/TRIGGERS.sql")
        ceatePackages(connection)

def ceatePackages(connection):
    mypath = "../scripts/pkg"
    allfiles = [f for f in listdir(mypath) if isfile(join(mypath, f))]
    pks = list(filter(lambda x: x[-3:] == "pks", allfiles))
    pkb = list(filter(lambda x: x[-3:] == "pkb", allfiles))
    scripts = pks + pkb
    for script in scripts:
        buildPackage(connection, join(mypath, script))

def isNesting(line):
    line = line.lower()
    if "begin" in line:
        return True
    if "if" in line:
        return True
    return False

if __name__ == "__main__":
    createUser()
    fillDB()
    print("Ready")
