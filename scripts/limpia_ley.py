#!/usr/bin/env python3
"""Limpia un texto plano extraído de PDF de Diputados y lo convierte a MD básico."""
import re, sys

if len(sys.argv) < 3:
    print("Uso: limpia_ley.py entrada.txt salida.md TITULO")
    sys.exit(1)

inp, outp, titulo = sys.argv[1], sys.argv[2], sys.argv[3] if len(sys.argv) > 3 else "Ley"

with open(inp, encoding='utf-8') as f:
    raw = f.read()

# Quitar encabezados repetidos del PDF móvil
patrones_basura = [
    r'CÁMARA DE DIPUTADOS DEL H\. CONGRESO DE LA UNIÓN[^\n]*',
    r'Secretaría General[^\n]*',
    r'Secretaría de Servicios Parlamentarios[^\n]*',
    r'Versión PDF para vista en dispositivo móvil[^\n]*',
    r'Última reforma publicada DOF [^\n]*',
    r'^\s*\d+\s*$',  # números de página solos
]
for p in patrones_basura:
    raw = re.sub(p, '', raw, flags=re.MULTILINE)

# Colapsar líneas en blanco múltiples
raw = re.sub(r'\n{3,}', '\n\n', raw)

# Convertir "Artículo N.-" o "Artículo N." en header markdown
def header_art(m):
    return f"\n\n## Artículo {m.group(1)}\n\n"
raw = re.sub(r'(?:^|\n)\s*Artículo\s+(\d+[\w\- ]*?)\.\s*[-]?', header_art, raw)

# Convertir TITULO PRIMERO / SEGUNDO / etc. y CAPITULO en headers
raw = re.sub(r'(?:^|\n)\s*(TÍTULO\s+[A-Z]+[^\n]*)', r'\n\n# \1\n', raw)
raw = re.sub(r'(?:^|\n)\s*(CAPÍTULO\s+[A-Z]+[^\n]*)', r'\n\n## \1\n', raw)
raw = re.sub(r'(?:^|\n)\s*(SECCIÓN\s+[A-Z]+[^\n]*)', r'\n\n### \1\n', raw)

# Trim espacios al inicio de líneas
raw = re.sub(r'\n[ \t]+', '\n', raw)

# Limpiar dobles espacios
raw = re.sub(r'  +', ' ', raw)

# Cabecera markdown
header = f"""---
title: {titulo}
fuente: diputados.gob.mx
version: Texto extraído del PDF móvil oficial de Cámara de Diputados
nota: |
  Este archivo es una conversión automática del PDF. Conserva el contenido
  íntegro pero el formato (sangrías, fracciones) puede no replicar el original.
  Para citas formales valida contra el PDF oficial.
---

# {titulo}

"""

with open(outp, 'w', encoding='utf-8') as f:
    f.write(header)
    f.write(raw.strip())
    f.write('\n')

print(f"OK -> {outp}  ({len(raw):,} chars)")
