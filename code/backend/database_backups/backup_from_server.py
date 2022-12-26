# run in WSL
import os
import datetime
import requests  # pip install requests
import sys

numberOfRecords = requests.get("http://weatheranalytics.tk:8080/count").json()["count"]

isAlreadyBackedUp = False

filesInCurrrentDirectory = os.listdir()
for eachFile in filesInCurrrentDirectory:
    if ".7z" not in eachFile:
        continue

    numberOfRecordsBackedUpInThisBackup = (
        eachFile.split("T")[1].split("-")[3].split(".")[0]
    )
    if int(numberOfRecordsBackedUpInThisBackup) == int(numberOfRecords):
        isAlreadyBackedUp = True
        break

if not isAlreadyBackedUp:
    keyFilePath = "~/.ssh/co300.pem"
    if len(sys.argv) > 1:
        keyFilePath = sys.argv[1]

    os.system(
        f"ssh -i {keyFilePath} Nipun@weatheranalytics.tk 'rm -rf dump;mongodump; rm dump.7z ;7z a dump.7z dump/'"
    )
    currentDatetime = datetime.datetime.now().isoformat().replace(":", "-")
    os.system(
        f"scp -i {keyFilePath} Nipun@weatheranalytics.tk:/home/Nipun/dump.7z ./{currentDatetime}-{numberOfRecords}.7z"
    )
else:
    print("DB already backed up")
