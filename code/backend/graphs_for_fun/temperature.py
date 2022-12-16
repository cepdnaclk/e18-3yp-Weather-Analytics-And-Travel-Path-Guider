import requests
import matplotlib.pyplot as plt

data = requests.get("http://weatheranalytics.tk:8080").json()

x = []
temp = []
humid = []

i = 0
for each in data:
    x.append(i)
    i += 1
    temp.append(int(each["temperature"]))
    humid.append(int(each["humidity"]))

fig, axs = plt.subplots(2)
axs[0].plot(x, temp)
axs[0].legend("Temperature")

axs[1].plot(x, humid)
axs[1].legend("Humidity %")

plt.show()
