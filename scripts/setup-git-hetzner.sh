#!/bin/zsh
# ============================================================
# setup-git-hetzner.sh
# Inicializa el repo git y lo conecta a tu git server en Hetzner.
#
# Uso:
#   cd "~/Documents/Clientes/00 Sinube y excel/leyes-fiscales 2020 a 2025"
#   ./scripts/setup-git-hetzner.sh
#
# Antes de correr, edita las variables HETZNER_GIT_URL y BRANCH abajo.
# ============================================================

set -e

# === Configuración (EDITA esto antes de correr) ===
HETZNER_GIT_URL="ssh://git@<TU-IP-HETZNER>:<PUERTO>/<RUTA>/leyes-fiscales-historico.git"
# Ejemplos según el git server que uses:
#   Gitea:   ssh://git@gitea.tudominio.com:22/rafa/leyes-fiscales-historico.git
#   Forgejo: ssh://git@forgejo.tudominio.com:22/rafa/leyes-fiscales-historico.git
#   Bare git: ssh://git@<IP>/srv/git/leyes-fiscales-historico.git
#   Vía Tailscale: ssh://git@<machine-name>:22/srv/git/leyes-fiscales-historico.git

BRANCH="main"

# === Validar ubicación ===
if [[ ! -f "README.md" ]] || [[ ! -d "00-indices" ]]; then
  echo "❌ Error: corre este script desde la raíz de 'leyes-fiscales 2020 a 2025/'"
  exit 1
fi

# === Verificar que .gitignore está bien ===
if [[ ! -f ".gitignore" ]]; then
  echo "❌ Falta .gitignore — abortando para no subir basura."
  exit 1
fi

echo "🔍 Verificando que no se cuelen datos privados..."
if find . -path ./.git -prune -o -type f \( -name "*.xml" -o -name "*.suaq" \) -print | grep -q .; then
  echo "⚠️  Se encontraron archivos XML/SUA. Revisa antes de continuar:"
  find . -path ./.git -prune -o -type f \( -name "*.xml" -o -name "*.suaq" \) -print
  echo ""
  read -q "REPLY?¿Continuar de todas formas? (y/n) "
  echo ""
  [[ $REPLY != "y" ]] && exit 1
fi

# === Inicializar git si no existe ===
if [[ ! -d ".git" ]]; then
  echo "📦 Inicializando repositorio git..."
  git init
fi

git config user.name "Rafa"
git config user.email "rafael_afie@hotmail.com"

# === Cambiar rama default a main ===
git branch -M "$BRANCH" 2>/dev/null || true

# === Primer commit ===
echo "📝 Haciendo primer commit..."
git add .
git status --short | head -30

if git diff --cached --quiet; then
  echo "Nada para commit."
else
  git commit -m "init: estructura inicial leyes fiscales 2020-2026

- Estructura de carpetas por ejercicio (2020-2026)
- Índices maestros de vigencias y reformas DOF
- Conexión con repo leyes-fiscales-mx
- Pipeline de descarga (scripts/)
- Paquete de setup para Claude Project
"
fi

# === Agregar remote Hetzner ===
if git remote get-url origin 2>/dev/null; then
  echo "⚠️  Remote 'origin' ya existe:"
  git remote -v
  read -q "REPLY?¿Reemplazar con HETZNER_GIT_URL? (y/n) "
  echo ""
  [[ $REPLY == "y" ]] && git remote set-url origin "$HETZNER_GIT_URL"
else
  echo "🔗 Agregando remote origin -> $HETZNER_GIT_URL"
  git remote add origin "$HETZNER_GIT_URL"
fi

# === Push inicial ===
echo ""
echo "🚀 Listo para push. Ejecuta manualmente cuando confirmes la URL:"
echo ""
echo "   git push -u origin $BRANCH"
echo ""
echo "(O corre este script de nuevo después de editar HETZNER_GIT_URL si aún no lo hiciste.)"
