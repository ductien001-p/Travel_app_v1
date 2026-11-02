import re
from pathlib import Path

html = Path(
    r"c:\Project\Travel_V1\travel_app\docs\design\screen\profile\user-saved-trip\saved-places.html"
).read_text(encoding="utf-8")
urls = sorted(set(re.findall(r"https?://[^\"'\s)]+", html)))
print("\n".join(urls))
print("count", len(urls))
