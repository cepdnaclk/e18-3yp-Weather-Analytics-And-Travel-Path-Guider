## Author: E/18/098 Ishan Fernando - e18098@eng.pdn.ac.lk

# At first the documents were created using the Date type. Therefore, the time was saved in GMT00:00 mode.
# This script converts the time into GMT+5:30 zone as a string and updates the db.
# Should only be run once at most

# converts from  'dateTime': datetime.datetime(2022, 12, 16, 11, 49, 30)
# to "dateTime": "12/23/2022, 8:23:38 AM",

import pymongo
import datetime


myclient = pymongo.MongoClient("mongodb://localhost:27017/")["test"]
all_records = myclient["sensordatas"].find()
for eachRecord in all_records:
    dateTime = eachRecord["dateTime"]
    try:
        eachRecord["dateTime"] = dateTime.strftime("%m/%d/%Y, %I:%M:%S %p")
        myclient["sensordatas"].find_one_and_update(
            {"_id": eachRecord["_id"]}, {"$set": {"dateTime": eachRecord["dateTime"]}}
        )
        # print(eachRecord["dateTime"])
    except AttributeError:
        pass
