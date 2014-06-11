# This doesn't appear
print("Plotting pce vs date but not using print. This plot won't appear.")
qplot(date, pce, data=economics, main="Personal Consumption Expenditures")
# This appears
print("Plotting population vs date using print. This plot should appear.")
print(qplot(date, pop, data=economics, main="Population"))
