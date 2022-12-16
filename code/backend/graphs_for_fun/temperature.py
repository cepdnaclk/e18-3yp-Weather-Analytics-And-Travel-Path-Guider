import requests
import matplotlib.pyplot as plt

data = requests.get("http://weatheranalytics.tk:8080").json()

x = []
temp = []
humid = []

for each in data:
    x.append(each["dateTime"])
    temp.append(each["temperature"])
    humid.append(each["humidity"])

plt.plot(x, temp, x, humid)
plt.legend(["Temperature", "Humidity %"])
plt.show()
