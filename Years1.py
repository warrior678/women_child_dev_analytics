import pandas as pd
import matplotlib.pyplot as plt

# Manually define the data from the CSV structure
data = {
    'Region': ['All-India', 'Urban', 'Rural'],
    '2015-16': [36, 29, 38],
    '2019-21': [32, 26, 33]
}

# Create DataFrame
df = pd.DataFrame(data)

# Melt for plotting
df_melted = df.melt(id_vars='Region', var_name='Year', value_name='Malnutrition (%)')

# Plotting
plt.figure(figsize=(10, 6))
for region in df['Region']:
    region_data = df_melted[df_melted['Region'] == region]
    plt.plot(region_data['Year'], region_data['Malnutrition (%)'], marker='o', label=region)

plt.title('Malnutrition Trends by Region (Underweight Children)')
plt.xlabel('Year')
plt.ylabel('Percentage of Underweight Children')
plt.legend()
plt.grid(True)
plt.tight_layout()
plt.show()