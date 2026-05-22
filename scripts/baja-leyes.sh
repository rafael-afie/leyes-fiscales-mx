#!/bin/zsh
# baja-leyes.sh — descarga PDFs vigentes de Diputados y los convierte a MD buscable.
#
# Requisitos: curl, pdftotext (poppler), python3
#   En Mac:  brew install poppler
#
# Uso:
#   ./baja-leyes.sh                # baja las 4 leyes vigentes actuales
#   ./baja-leyes.sh LISR           # solo una
#
# Salida: archivos *.md en la carpeta del proyecto.

set -e

DIR="$(cd "$(dirname "$0")/.." && pwd)"
TMP="$DIR/scripts/.tmp"
mkdir -p "$TMP"

# Mapeo ley -> (URL PDF vigente, título, slug archivo)
typeset -A URLS=(
  LISR   "https://www.diputados.gob.mx/LeyesBiblio/pdf_mov/Ley_del_Impuesto_sobre_la_Renta.pdf"
  LIVA   "https://www.diputados.gob.mx/LeyesBiblio/pdf_mov/Ley_del_Impuesto_al_Valor_Agregado.pdf"
  LIEPS  "https://www.diputados.gob.mx/LeyesBiblio/pdf_mov/Ley_del_Impuesto_Especial_sobre_Produccion_y_Servicios.pdf"
  CFF    "https://www.diputados.gob.mx/LeyesBiblio/pdf_mov/Codigo_Fiscal_de_la_Federacion.pdf"
)
typeset -A TITULOS=(
  LISR  "Ley del Impuesto sobre la Renta"
  LIVA  "Ley del Impuesto al Valor Agregado"
  LIEPS "Ley del Impuesto Especial sobre Producción y Servicios"
  CFF   "Código Fiscal de la Federación"
)

LEYES=(${@:-LISR LIVA LIEPS CFF})

for KEY in $LEYES; do
  URL=${URLS[$KEY]}
  TIT=${TITULOS[$KEY]}
  [[ -z "$URL" ]] && { echo "Ley desconocida: $KEY"; continue; }

  echo ">> Descargando $KEY..."
  curl -sL -o "$TMP/$KEY.pdf" "$URL"

  echo ">> Convirtiendo a texto..."
  pdftotext -layout "$TMP/$KEY.pdf" "$TMP/$KEY.txt"

  OUT="$DIR/historico/00-indices/${KEY}_referencia_vigente.md"
  echo ">> Limpiando y formateando -> $OUT"
  python3 "$DIR/scripts/limpia_ley.py" "$TMP/$KEY.txt" "$OUT" "$TIT"

  echo "   ✓ $KEY listo ($(wc -l < "$OUT") líneas, $(grep -c "^## Artículo" "$OUT") artículos)"
done

echo ""
echo "Listo. Archivos en: $DIR/00-indices/"
