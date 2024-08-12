# v.2024-08-10
import sys
from datetime import datetime

# Pridobitev argumenta iz ukazne vrstice
coin = sys.argv[1]

# Naloži podatke iz datoteke block_{coin}.list v strukturiran format
file_name = f'block_{coin}.list'
with open(file_name, 'r') as f:
    lines = f.readlines()

# Parsiranje vrstic v seznam slovarjev
blocks = []
for line in lines:
    parts = line.strip().split(maxsplit=4)
    blocks.append({
        "height": int(parts[0]),        # Višina bloka
        "pool": parts[1],               # Bazen
        "timestamp": parts[2] + " " + parts[3],  # Časovni žig
        "worker": parts[4] if len(parts) > 4 else ""  # Delavec (ali oznaka)
    })

# Razvrsti bloke po naraščajočem vrstnem redu glede na časovni žig
blocks.sort(key=lambda x: datetime.strptime(x["timestamp"], "%Y-%m-%d %H:%M:%S.%f") if '.' in x["timestamp"] else datetime.strptime(x["timestamp"], "%Y-%m-%d %H:%M:%S"))

# Dodajanje zaporedne številke v mesecu
current_month = None
counter = 0

for block in blocks:
    try:
        block_date = datetime.strptime(block["timestamp"], "%Y-%m-%d %H:%M:%S.%f")
    except ValueError:
        block_date = datetime.strptime(block["timestamp"], "%Y-%m-%d %H:%M:%S")

    if current_month != block_date.strftime("%Y-%m"):
        current_month = block_date.strftime("%Y-%m")
        counter = 1
    else:
        counter += 1
    block["worker"] = counter  # Zamenjaj delavca z zaporedno številko

# Razvrsti bloke nazaj po višini bloka v padajočem vrstnem redu
blocks.sort(key=lambda x: x["height"], reverse=True)

# Zapiši posodobljene podatke nazaj v datoteko
with open(file_name, 'w') as f:
    for block in blocks:
        f.write(f"{block['height']}   {block['pool']}   {block['timestamp']}   {block['worker']}\n")
