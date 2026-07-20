import json
from pathlib import Path

SPANISH = [
    ("gn", "Gn", "Génesis"),
    ("ex", "Éx", "Éxodo"),
    ("lv", "Lv", "Levítico"),
    ("nm", "Nm", "Números"),
    ("dt", "Dt", "Deuteronomio"),
    ("js", "Jos", "Josué"),
    ("jud", "Jue", "Jueces"),
    ("rt", "Rt", "Rut"),
    ("1sm", "1 S", "1 Samuel"),
    ("2sm", "2 S", "2 Samuel"),
    ("1kgs", "1 R", "1 Reyes"),
    ("2kgs", "2 R", "2 Reyes"),
    ("1ch", "1 Cr", "1 Crónicas"),
    ("2ch", "2 Cr", "2 Crónicas"),
    ("ezr", "Esd", "Esdras"),
    ("ne", "Neh", "Nehemías"),
    ("et", "Est", "Ester"),
    ("job", "Job", "Job"),
    ("ps", "Sal", "Salmos"),
    ("pr", "Pr", "Proverbios"),
    ("ec", "Ec", "Eclesiastés"),
    ("so", "Cnt", "Cantares"),
    ("is", "Is", "Isaías"),
    ("je", "Jer", "Jeremías"),
    ("la", "Lm", "Lamentaciones"),
    ("ez", "Ez", "Ezequiel"),
    ("da", "Dn", "Daniel"),
    ("ho", "Os", "Oseas"),
    ("joel", "Jl", "Joel"),
    ("am", "Am", "Amós"),
    ("ob", "Abd", "Abdías"),
    ("jon", "Jon", "Jonás"),
    ("mic", "Mi", "Miqueas"),
    ("na", "Nah", "Nahúm"),
    ("hab", "Hab", "Habacuc"),
    ("zep", "Sof", "Sofonías"),
    ("hag", "Hag", "Hageo"),
    ("zec", "Zac", "Zacarías"),
    ("mal", "Mal", "Malaquías"),
    ("mt", "Mt", "Mateo"),
    ("mk", "Mr", "Marcos"),
    ("lk", "Lc", "Lucas"),
    ("jh", "Jn", "Juan"),
    ("act", "Hch", "Hechos"),
    ("rm", "Ro", "Romanos"),
    ("1co", "1 Co", "1 Corintios"),
    ("2co", "2 Co", "2 Corintios"),
    ("gl", "Gá", "Gálatas"),
    ("eph", "Ef", "Efesios"),
    ("ph", "Fil", "Filipenses"),
    ("cl", "Col", "Colosenses"),
    ("1ts", "1 Ts", "1 Tesalonicenses"),
    ("2ts", "2 Ts", "2 Tesalonicenses"),
    ("1tm", "1 Ti", "1 Timoteo"),
    ("2tm", "2 Ti", "2 Timoteo"),
    ("tt", "Tit", "Tito"),
    ("phm", "Flm", "Filemón"),
    ("hb", "He", "Hebreos"),
    ("jm", "Stg", "Santiago"),
    ("1pe", "1 P", "1 Pedro"),
    ("2pe", "2 P", "2 Pedro"),
    ("1jh", "1 Jn", "1 Juan"),
    ("2jh", "2 Jn", "2 Juan"),
    ("3jh", "3 Jn", "3 Juan"),
    ("jd", "Jud", "Judas"),
    ("re", "Ap", "Apocalipsis"),
]

# Order of books in thiagobodruk es_rvr.json is standard Protestant order.
ROOT = Path(__file__).resolve().parents[1]
src_path = ROOT / "assets" / "bible" / "thiago.json"
with src_path.open(encoding="utf-8-sig") as f:
    src = json.load(f)

if len(src) != 66:
    raise SystemExit(f"Expected 66 books, got {len(src)}")

out_books = []
for i, ((_, abbr, name), book) in enumerate(zip(SPANISH, src), start=1):
    out_books.append(
        {
            "id": i,
            "abbrev": abbr,
            "name": name,
            "testament": "AT" if i <= 39 else "NT",
            "chapters": book["chapters"],
        }
    )

payload = {
    "id": "rvr1909",
    "name": "Reina-Valera 1909",
    "shortName": "RVR1909",
    "license": "Dominio público",
    "books": out_books,
}

out = ROOT / "assets" / "bible" / "rvr1909.json"
with out.open("w", encoding="utf-8") as f:
    json.dump(payload, f, ensure_ascii=False, separators=(",", ":"))

print("wrote", out, "bytes", out.stat().st_size)
print(out_books[0]["name"], out_books[0]["chapters"][0][0])
print(out_books[42]["name"], out_books[42]["chapters"][0][0][:80])

for p in [
    ROOT / "assets" / "bible" / "thiago.json",
    ROOT / "assets" / "bible" / "rv_1909.json",
    ROOT / "assets" / "bible" / "arul.json",
    ROOT / "assets" / "bible" / "api.json",
]:
    p.unlink(missing_ok=True)
print("cleaned temps")
