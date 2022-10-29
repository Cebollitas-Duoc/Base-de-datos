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
        for line in raw:
            line = line.replace("\n", "")
            if ("--" in line or line == ""):
                continue
            if (";" in line):
                    script.append(lastLine + line)
                    lastLine = ""
            else:
                lastLine = lastLine + line + " "
            
    return script

def runCommand(con, command):
    command = command.replace(";","")
    with con.cursor() as cursor:
        cursor.execute(command)


with oracledb.connect(sysCS) as connection:
    runScrpit(connection, "../scripts/USR_TURISMO_REAL.sql")


