# Leyes Fiscales México

Compendio versionado de la legislación fiscal y laboral mexicana, organizado en dos planos:

- **`vigente/`** — snapshot actual de cada ordenamiento (lo que rige HOY)
- **`historico/`** — snapshots por año (2020–2026) para clasificar CFDIs viejos con la ley que aplicaba en su momento

Consumido por **ISD-conta** (motor de clasificación automática de CFDIs) como git submódulo. Actualizado semanalmente vía GitHub Actions desde fuentes oficiales.

> **Privacidad:** Solo legislación pública. NO subir papeles de trabajo, pólizas, CFDIs ni datos de clientes — eso vive en repos privados aparte.

## Estructura

```
leyes-fiscales-mx/
├── vigente/                          ← snapshot CURRENT (se actualiza solo)
│   ├── lisr/      LISR + Reglamento
│   ├── liva/      LIVA + Reglamento
│   ├── cff/       CFF + Reglamento
│   ├── rmf/       RMF 2026 + Anexos
│   ├── lss/       Ley Seguro Social + Reglamentos
│   ├── infonavit/ Ley INFONAVIT
│   ├── lft/       Ley Federal del Trabajo
│   ├── otros/     LIF 2026, LIEPS, etc.
│   └── condensados/ Glosario y resúmenes propios
│
├── historico/                        ← snapshots por año (NO se modifican)
│   ├── 00-indices/  vigencias-por-ano.md + referencias condensadas
│   ├── 2020/        01-leyes / 02-reglamentos / 03-RMF-y-anexos / 04-reformas-DOF
│   ├── 2021/        idem
│   ├── 2022/        idem
│   ├── 2023/        idem
│   ├── 2024/        idem
│   ├── 2025/        idem
│   ├── 2026/        idem
│   └── fuentes-oficiales/  ligas DOF/SAT para auditoría
│
├── scripts/
│   ├── actualizar.sh         descarga PDFs vigentes de diputados.gob.mx + sat.gob.mx
│   ├── verificar_vigencia.py extrae "Última reforma DOF" de cada PDF
│   ├── baja-leyes.sh         baja + convierte a MD para historico/00-indices/
│   ├── limpia_ley.py         normalizador de texto extraído de PDFs
│   └── setup-git-hetzner.sh  bootstrap del repo en VPS Hetzner (futuro)
│
├── claude-project-setup/     instrucciones para subir a Claude Projects
├── docs/HETZNER-DEPLOYMENT.md plan de migración a VPS productivo
└── .github/workflows/actualizar-leyes.yml   GitHub Action lunes 9 AM CDMX
```

## Cómo lo usa ISD-conta

```python
from pathlib import Path

LEYES = Path(__file__).parent / "data" / "leyes-fiscales-mx"

# Clasificar CFDI del 2024-08
snapshot_2024 = LEYES / "historico" / "2024" / "01-leyes" / "vigencias.md"
contexto = snapshot_2024.read_text()

# Clasificar CFDI del mes vigente
lisr_actual = LEYES / "vigente" / "lisr" / "LISR.pdf"
```

El motor de clasificación selecciona el snapshot correcto según `fecha_emision` del CFDI y carga solo los artículos relevantes según régimen + clave SAT del producto.

## Actualización automática

**GitHub Action (`.github/workflows/actualizar-leyes.yml`)** corre cada lunes 9 AM hora de Querétaro:

1. Descarga PDFs desde diputados.gob.mx y sat.gob.mx (`scripts/actualizar.sh`)
2. Hashea antes/después para detectar cambios reales (no solo timestamps)
3. Si hubo cambios: commit + push automático con mensaje detallado
4. Si no: termina sin tocar nada

**ISD-conta** corre un watcher cada 6 h que detecta commits nuevos en este remote y muestra alerta en el dashboard ("Hay reforma pendiente de aprobar"). Tú/contadora aprueba → submódulo se actualiza.

Reforma manual: `bash scripts/actualizar.sh` desde local, después commit y push.

## Convención de commits

- `update: 1 ley(es) actualizada(s) — YYYY-MM-DD` ← lo genera la GH Action
- `add: Anexo 1-A RMF 2026` ← nuevos anexos
- `snapshot: rotación anual 2027 → historico/` ← snapshot anual del vigente al cierre de año
- `docs: …` ← README / docs

## Inventario vigente

Ver `vigente/` y correr `python3 scripts/verificar_vigencia.py` para el reporte actualizado de "Última reforma DOF" por archivo.

## Fuentes oficiales

- **diputados.gob.mx** — Leyes federales con texto vigente
- **sat.gob.mx** — RMF, anexos, criterios
- **dof.gob.mx** — Decretos de reformas (texto del DOF original)

## Disclaimer

Compilación profesional para consulta. Las versiones vinculantes son las publicadas en el DOF y portales oficiales. Verifica siempre la fuente oficial antes de tomar decisiones con efectos fiscales o legales.
