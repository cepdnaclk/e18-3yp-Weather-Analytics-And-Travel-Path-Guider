# run in WSL
import os
import datetime

os.system(
    "ssh -i $HOME/.ssh/co300.pem Nipun@weatheranalytics.tk 'mongodump; 7z a dump.7z dump/'"
)
currentDatetime = datetime.datetime.now().isoformat().replace(":", "-")
os.system(
    f"scp -i $HOME/.ssh/co300.pem Nipun@weatheranalytics.tk:/home/Nipun/dump.7z ./{currentDatetime}.7z"
)
