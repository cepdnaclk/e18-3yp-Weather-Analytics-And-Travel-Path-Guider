import requests
import datetime
import matplotlib.pyplot as plt
import pytz

data = requests.get("http://weatheranalytics.tk:8080").json()

x = []
temp = []
humid = []

i = 0

lastUpdateTime = ""
for each in data:
    x.append(i)
    i += 1
    temp.append(int(each["temperature"]))
    humid.append(int(each["humidity"]))

    lastUpdateTime = each["dateTime"]

parsed = datetime.datetime.fromisoformat(lastUpdateTime)
print("Last Updated: " , parsed.astimezone(pytz.timezone("Asia/Colombo")))

fig, axs = plt.subplots(2)
axs[0].plot(x, temp)
axs[0].legend("Temperature")

axs[1].plot(x, humid)
axs[1].legend("Humidity %")

plt.show()
