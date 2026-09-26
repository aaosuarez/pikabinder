# To use, run:
# ```scripts/.venv/bin/python scripts/fetch_cards.py```
import os

import requests
import json
from dotenv import load_dotenv

load_dotenv()

headers = {
    "X-Api-Key": os.getenv("SCRYDEX_API_KEY"),
    "X-Team-ID": "magicpopcorn" # DO NOT COMMIT
}

data = []

page = 1

# Do this until all pages are accounted for
while True:
    print (f"Fetching page {page}")
    response = requests.get(f"https://api.scrydex.com/pokemon/v1/cards?q=name%3APikachu&page={page}", headers=headers)
    response_data = response.json()

    if response_data["count"] <= 0:
        break

    for card in response_data["data"]:
        data.append(card)
    page += 1

print("Saving JSON file")
with open("cards.json", "w", encoding="utf-8") as file:
    json.dump({"data": data}, file)

print("Done")