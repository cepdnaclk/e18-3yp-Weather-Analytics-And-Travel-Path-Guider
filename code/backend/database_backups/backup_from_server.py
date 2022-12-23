# run in WSL
import os
import datetime
import requests
import sys

numberOfRecords = requests.get("http://weatheranalytics.tk:8080/count").json()["count"]

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
