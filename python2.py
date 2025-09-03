import pandas as pd
import matplotlib.pyplot as plt

# Load CSV from GitHub raw link
url = "https://raw.githubusercontent.com/warrior678/women_child_dev_analytics/main/DFG_MoWCD(Malnutrition_by_year).csv"
df = pd.read_csv(url)

# Preview the data
print(df.head())

# Optional: Clean column names
df.columns = df.columns.str.strip().str.replace(' ', '_').str.lower()

# Plotting malnutrition trends
plt.figure(figsize=(10, 6))

# Assuming columns like 'year', 'stunted', 'wasted', 'underweight' exist
plt.plot(df['year'], df['stunted'], marker='o', label='Stunted')
plt.plot(df['year'], df['wasted'], marker='s', label='Wasted')
plt.plot(df['year'], df['underweight'], marker='^', label='Underweight')

plt.title('Malnutrition Trends in Children Over the Years')
plt.xlabel('Year')
plt.ylabel('Percentage (%)')
plt.legend()
plt.grid(True)
plt.tight_layout()
plt.show()