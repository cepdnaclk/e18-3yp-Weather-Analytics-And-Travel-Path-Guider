import requests
import datetime
import matplotlib.pyplot as plt
import pytz

data = requests.get("http://weatheranalytics.tk:8080").json()

x = []
temp = []
humid = []
rain = []
light = []

i = 0

lastUpdateTime = ""
for each in data:
    x.append(i)
    i += 1
    temp.append(int(each["temperature"]))
    humid.append(int(each["humidity"]))
    rain.append(int(each["isRaining"]))
    light.append(int(each["lightIntensity"]))

    lastUpdateTime = each["dateTime"]

print("Last Updated: ", lastUpdateTime)

fig, axs = plt.subplots(4)
axs[0].plot(x, temp)
axs[0].legend("Temperature")

axs[1].plot(x, humid)
axs[1].legend("Humidity %")

axs[2].plot(x, rain)
axs[2].legend("Rain")

axs[3].plot(x, light)
axs[3].legend("Light")

plt.show()
