#!/bin/bash

# 🧠 NETSECURE IA_TUNNEL — Activation autonome

echo "🔧 Installation des dépendances..."
python3 -m venv venv
source venv/bin/activate
pip install fastapi uvicorn jinja2

echo "📁 Création de la structure du tunnel..."
mkdir -p NETSECURE_IA_TUNNEL/templates
touch NETSECURE_IA_TUNNEL/main.py
touch NETSECURE_IA_TUNNEL/templates/cockpit.html
touch NETSECURE_IA_TUNNEL/requirements.txt

echo "🧠 Injection du moteur IA local..."
cat <<EOF > NETSECURE_IA_TUNNEL/main.py
from fastapi import FastAPI, Request, Form
from fastapi.responses import HTMLResponse
from fastapi.templating import Jinja2Templates

app = FastAPI()
templates = Jinja2Templates(directory="templates")

def generate_response(question):
    return f"Réponse IA simulée pour : '{question}' → Le cockpit NETSECURE est actif."

@app.get("/", response_class=HTMLResponse)
async def get_form(request: Request):
    return templates.TemplateResponse("cockpit.html", {"request": request, "question": None, "response": None})

@app.post("/", response_class=HTMLResponse)
async def post_form(request: Request, question: str = Form(...)):
    response = generate_response(question)
    return templates.TemplateResponse("cockpit.html", {"request": request, "question": question, "response": response})
EOF

echo "🎨 Stylisation du cockpit..."
cat <<EOF > NETSECURE_IA_TUNNEL/templates/cockpit.html
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <title>NETSECURE IA_TUNNEL</title>
  <style>
    body { font-family: 'Orbitron', sans-serif; background-color: #0f172a; color: #e2e8f0; padding: 2em; }
    .cockpit { background: #1e293b; border-radius: 12px; padding: 2em; box-shadow: 0 0 20px #38bdf8; }
    .module { margin-bottom: 1em; padding: 1em; background: #334155; border-left: 5px solid #38bdf8; border-radius: 8px; }
    input, button { padding: 0.5em; font-size: 1em; margin-top: 1em; }
  </style>
</head>
<body>
  <h1>🧠 NETSECURE IA_TUNNEL</h1>
  <form method="post">
    <input type="text" name="question" placeholder="Pose ta question à l'IA" required>
    <button type="submit">Envoyer</button>
  </form>
  {% if question %}
  <div class="cockpit">
    <div class="module">
      <h2>Entrée</h2>
      <p>{{ question }}</p>
    </div>
    <div class="module">
      <h2>Réponse IA</h2>
      <p>{{ response }}</p>
    </div>
  </div>
  {% endif %}
</body>
</html>
EOF

echo "📦 Déclaration des dépendances..."
echo -e "fastapi\nuvicorn\njinja2" > NETSECURE_IA_TUNNEL/requirements.txt

echo "🚀 Tunnel NETSECURE IA prêt. Pour lancer :"
echo "cd NETSECURE_IA_TUNNEL && uvicorn main:app --reload"
