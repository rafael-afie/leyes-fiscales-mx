#!/usr/bin/env python3
"""
verificar_vigencia.py — Lee las primeras páginas de cada PDF y extrae
la fecha de "Última reforma DOF" para confirmar qué versión tienes.

Uso: python3 scripts/verificar_vigencia.py
Requiere: pip install pypdf
"""
import re
import sys
from pathlib import Path

try:
    from pypdf import PdfReader
except ImportError:
    print("Falta pypdf. Instala con: pip install pypdf --break-system-packages")
    sys.exit(1)

ROOT = Path(__file__).resolve().parent.parent

# Lista de PDFs vigentes a verificar (relativos a la raíz del repo)
# Estructura nueva: vigente/<dir>/<archivo>.pdf
PDFS = [
    ('CFF',           'vigente/cff/CFF.pdf'),
    ('RCFF',          'vigente/cff/RCFF.pdf'),
    ('LISR',          'vigente/lisr/LISR.pdf'),
    ('RLISR',         'vigente/lisr/RLISR.pdf'),
    ('LIVA',          'vigente/liva/LIVA.pdf'),
    ('RLIVA',         'vigente/liva/RLIVA.pdf'),
    ('LSS',           'vigente/lss/LSS.pdf'),
    ('LIFNVT',        'vigente/infonavit/LIFNVT.pdf'),
    ('LFT',           'vigente/lft/LFT.pdf'),
    ('LIF 2026',      'vigente/otros/LIF_2026.pdf'),
    ('LIEPS',         'vigente/otros/LIEPS.pdf'),
    ('RMF 2026',      'vigente/rmf/RMF_2026.pdf'),
    ('Anexo 1 RMF',   'vigente/rmf/Anexo_1_RMF_2026.pdf'),
    ('Anexo 7 RMF',   'vigente/rmf/Anexo_7_RMF_2026.pdf'),
    ('Anexo 8 RMF',   'vigente/rmf/Anexo_8_RMF_2026.pdf'),
]

# Patrones para extraer fechas
PATRON_REFORMA = re.compile(
    r'(?:Última|Ultima)\s+[Rr]eforma\s+(?:publicada\s+)?(?:DOF\s+)?(\d{2}[-/]\d{2}[-/]\d{4})'
)
PATRON_PUBLICACION = re.compile(
    r'publicada?\s+(?:el\s+)?(\d{1,2}\s+de\s+\w+\s+de\s+\d{4})',
    re.IGNORECASE
)

print(f"{'Documento':<18} {'Páginas':>8}  Última reforma / publicación")
print("-" * 70)

for nombre, ruta in PDFS:
    pdf_path = ROOT / ruta
    if not pdf_path.exists():
        print(f"{nombre:<18} {'-':>8}  ⚠️  archivo faltante")
        continue
    try:
        reader = PdfReader(pdf_path)
        npages = len(reader.pages)
        # Leer primera página (a veces la segunda)
        texto = reader.pages[0].extract_text() or ""
        if len(texto) < 100 and npages > 1:
            texto = reader.pages[1].extract_text() or ""

        m_reforma = PATRON_REFORMA.search(texto)
        m_pub = PATRON_PUBLICACION.search(texto)

        if m_reforma:
            info = f"DOF {m_reforma.group(1)}"
        elif m_pub:
            info = f"Publicada {m_pub.group(1)}"
        else:
            info = "(sin fecha detectada)"

        print(f"{nombre:<18} {npages:>8}  {info}")
    except Exception as e:
        print(f"{nombre:<18} {'-':>8}  ❌ error: {e}")

print()
print("Notas:")
print("- LISR y LIVA muestran fechas viejas pero esa ES la versión vigente.")
print("  Las reformas 2026 a estas leyes están en LIF 2026 (DOF 7-nov-2025).")
print("- RMF 2026: la oficial se publicó en DOF 28-12-2025; revisa")
print("  modificaciones posteriores en https://www.sat.gob.mx/minisitio/NormatividadRMFyRGCE/")
