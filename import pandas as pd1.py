import pandas as pd
import matplotlib.pyplot as plt


data = [
    ['Andhra Pradesh', 21, 12.9, 9],
    ['Arunachal Pradesh', 31, 19.6, 11.7],
    ['Assam', 43, 39.9, 19.5],
    ['Bihar', 63, 46.8, 11.8],
    ['Chhattisgarh', 61, 36.4, 18],
    ['Goa', 24, 7.2, 3.4],
    ['Gujarat', 32, 31.2, 10],
    ['Haryana', 28, 33.4, 11.5],
    ['Jharkhand', 59, 38.1, 17.2],
    ['Maharashtra', 25, 18.6, 8.9]
]


df = pd.DataFrame(data, columns=['State', 'Maternal', 'Infant', 'Neonatal'])


filtered_df = df[df['State'].isin(['Bihar', 'Maharashtra'])]
plt.figure(figsize=(10, 6))
plt.plot(filtered_df['State'], filtered_df['Maternal'], marker='o', label='Maternal Mortality Rate')
plt.plot(filtered_df['State'], filtered_df['Infant'], marker='s', label='Infant Mortality Rate')
plt.plot(filtered_df['State'], filtered_df['Neonatal'], marker='^', label='Neonatal Mortality Rate')

plt.title('Mortality Indicators: Bihar vs Maharashtra')
plt.xlabel('State')
plt.ylabel('Rate (per 100,000)')
plt.legend()
plt.grid(True)
plt.tight_layout()
plt.show()