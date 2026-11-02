import json
import re
import html
from pathlib import Path

p = Path(
    r"C:\Users\phanc\.cursor\projects\c-Project-Travel-V1\agent-tools\6ebfee89-314d-4d6b-9e5d-bcd4da76e6c1.txt"
)
data = json.loads(p.read_text(encoding="utf-8"))
print("keys", list(data.keys()))
html_text = data.get("html") or ""
print("html len", len(html_text))
out = Path(r"c:\Project\Travel_V1\travel_app\docs\design\screen\profile\user-saved-trip")
out.mkdir(parents=True, exist_ok=True)
(out / "saved-places.html").write_text(html_text, encoding="utf-8")
text = re.sub(r"<script[\s\S]*?</script>", " ", html_text, flags=re.I)
text = re.sub(r"<style[\s\S]*?</style>", " ", text, flags=re.I)
plain = re.sub(r"<[^>]+>", "\n", text)
plain = html.unescape(plain)
lines = [ln.strip() for ln in plain.splitlines() if ln.strip()]
(out / "saved-places.txt").write_text("\n".join(lines), encoding="utf-8")
print("lines", len(lines))
print("\n".join(lines[:250]))
