from flask import Flask
import sqlite3

app = Flask(__name__)

DB = "counter.db"

def init_db():
    conn = sqlite3.connect(DB)
    cur = conn.cursor()

    cur.execute("""
        CREATE TABLE IF NOT EXISTS counter (
            id INTEGER PRIMARY KEY,
            visits INTEGER
        )
    """)

    cur.execute("SELECT * FROM counter WHERE id=1")

    if cur.fetchone() is None:
        cur.execute(
            "INSERT INTO counter (id, visits) VALUES (1,0)"
        )

    conn.commit()
    conn.close()

init_db()

@app.route("/")
def home():
    conn = sqlite3.connect(DB)
    cur = conn.cursor()

    cur.execute(
        "SELECT visits FROM counter WHERE id=1"
    )

    visits = cur.fetchone()[0]

    conn.close()

    return f"""
    <!DOCTYPE html>
<html>
<head>
    <title>Viikko 4</title>
    <style>
        body {{
            font-family: Arial, sans-serif;
            background-color: #f4f6f9;
            margin: 0;
            padding: 40px;
        }}

        .container {{
            max-width: 800px;
            margin: auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }}

        h1 {{
            color: #005bbb;
        }}

        .counter {{
            font-size: 2em;
            text-align: center;
            padding: 20px;
            background: #e8f4ff;
            border-radius: 8px;
            margin: 20px 0;
        }}

        h2 {{
            border-bottom: 2px solid #ddd;
            padding-bottom: 5px;
        }}
    </style>
</head>
<body>

<div class="container">

<h1>Week 4 replica of Week 2 site</h1>

<div class="counter">
    Visits: <strong>{visits}</strong>
</div>

<h2>Database</h2>
<p>
This page displays data fron the replicated database.
</p>

<h2>GitHub</h2>
<p>
<a href="https://github.com/VV-OH/Linux-kurssi/">
GitHub-repo
</a>
</p>

</div>

</body>
</html>
"""

if __name__ == "__main__":
    app.run()
