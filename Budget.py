import pandas as pd
import matplotlib.pyplot as plt

# Define the data manually from the table
data = {
    'Scheme': [f'Scheme {i}' for i in range(1, 10)] + ['Total'],
    '2022-23 Actuals': [19178, 2340, 1243, 1016, 1000, 1425, 1472, 1000, 2384, 32058],
    '2023-24 BE':       [21520, 2336, 1243, 1016, 1000, 1425, 1472, 1000, 2384, 34376],
    '2024-25 BE':       [22671, 3157, 1243, 1016, 1000, 1425, 1472, 1000, 2384, 36372],
    '% Change':         [5, 35, 0, 0, 0, 0, 0, 0, 0, 6]
}

# Create DataFrame
df = pd.DataFrame(data)

# Plotting
plt.figure(figsize=(12, 6))
for year in ['2022-23 Actuals', '2023-24 BE', '2024-25 BE']:
    plt.plot(df['Scheme'], df[year], marker='o', label=year)

plt.title('Budget Allocation Trends by Scheme (₹ Crores)')
plt.xlabel('Scheme')
plt.ylabel('Allocation Amount')
plt.xticks(rotation=45)
plt.legend()
plt.grid(True)
plt.tight_layout()
plt.show()