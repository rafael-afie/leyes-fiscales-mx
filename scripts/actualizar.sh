#!/bin/bash
# actualizar.sh — Descarga las versiones más recientes de las leyes desde fuentes oficiales
# Uso: bash scripts/actualizar.sh   (desde la raíz del repo)

set -e

# Colores para legibilidad
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}=== Actualizando leyes fiscales desde fuentes oficiales ===${NC}"
echo ""

# Función helper: descarga y reporta tamaño
descargar() {
    local url="$1"
    local destino="$2"
    local nombre="$3"

    if curl -sLo "$destino.tmp" "$url" && file "$destino.tmp" | grep -q "PDF document"; then
        # Si existe versión previa, comparar tamaño
        if [ -f "$destino" ]; then
            antes=$(stat -f%z "$destino" 2>/dev/null || stat -c%s "$destino" 2>/dev/null)
            ahora=$(stat -f%z "$destino.tmp" 2>/dev/null || stat -c%s "$destino.tmp" 2>/dev/null)
            if [ "$antes" != "$ahora" ]; then
                echo -e "  ${GREEN}✓${NC} $nombre — ${YELLOW}CAMBIÓ${NC} ($antes → $ahora bytes)"
            else
                echo -e "  ${GREEN}✓${NC} $nombre — sin cambios"
            fi
        else
            echo -e "  ${GREEN}✓${NC} $nombre — nuevo"
        fi
        mv "$destino.tmp" "$destino"
    else
        echo -e "  ${RED}✗${NC} $nombre — falló (URL: $url)"
        rm -f "$destino.tmp"
    fi
}

DIP="https://www.diputados.gob.mx/LeyesBiblio"
SAT="https://www.sat.gob.mx/minisitio/NormatividadRMFyRGCE/documentos2026/rmf"

echo "Leyes federales (diputados.gob.mx):"
descargar "$DIP/pdf/CFF.pdf"          "cff/CFF.pdf"            "CFF"
descargar "$DIP/regley/Reg_CFF.pdf"   "cff/RCFF.pdf"           "Reglamento CFF"
descargar "$DIP/pdf/LISR.pdf"         "lisr/LISR.pdf"          "LISR"
descargar "$DIP/regley/Reg_LISR_060516.pdf" "lisr/RLISR.pdf"   "Reglamento LISR"
descargar "$DIP/pdf/LIVA.pdf"         "liva/LIVA.pdf"          "LIVA"
descargar "$DIP/regley/Reg_LIVA_250914.pdf" "liva/RLIVA.pdf"   "Reglamento LIVA"
descargar "$DIP/pdf/LSS.pdf"          "lss/LSS.pdf"            "LSS"
descargar "$DIP/regley/Reg_LSS_MACERF.pdf"  "lss/RLSS_MACERF.pdf" "Reg. LSS (afiliación/recaudación)"
descargar "$DIP/regley/Reg_LSS_MAEBA.pdf"   "lss/RLSS_MAEBA.pdf"  "Reg. LSS (afiliación empresas)"
descargar "$DIP/pdf/LIFNVT.pdf"       "infonavit/LIFNVT.pdf"   "Ley INFONAVIT"
descargar "$DIP/pdf/LFT.pdf"          "lft/LFT.pdf"            "LFT"
descargar "$DIP/pdf/LIF_2026.pdf"     "otros/LIF_2026.pdf"     "LIF 2026"
descargar "$DIP/pdf/LIEPS.pdf"        "otros/LIEPS.pdf"        "LIEPS"

echo ""
echo "Resolución Miscelánea Fiscal 2026 (sat.gob.mx):"
descargar "$SAT/rmf/RMF_2026-DOF-28122025.pdf"             "rmf/RMF_2026.pdf"        "RMF 2026"
descargar "$SAT/anexos/Anexo-1-RMF-2026_DOF-28122025.pdf"  "rmf/Anexo_1_RMF_2026.pdf" "Anexo 1 (formas oficiales)"
descargar "$SAT/anexos/Anexo_7_RMF2026-09012026.pdf"       "rmf/Anexo_7_RMF_2026.pdf" "Anexo 7 (criterios SAT)"
descargar "$SAT/anexos/Anexo-8-RMF-2026_DOF-28122025.pdf"  "rmf/Anexo_8_RMF_2026.pdf" "Anexo 8 (tarifas ISR)"

echo ""
echo -e "${YELLOW}=== Listo ===${NC}"
echo "Si hubo cambios, revisa con: git diff --stat"
echo "Para extraer fechas de última reforma de los PDFs: python3 scripts/verificar_vigencia.py"
