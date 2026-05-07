# Leyes Fiscales México

Repositorio personal con las leyes fiscales y laborales vigentes en México, organizadas para consulta con Claude (Cowork, Projects o chat con archivos adjuntos).

> **Privacidad:** Este repo contiene solo legislación pública (dominio público). NO subir aquí papeles de trabajo, pólizas, CFDIs ni datos de clientes — eso debe ir en repos privados aparte.

## Última actualización

Snapshot al **6 de mayo de 2026**. Ver columna "Última reforma DOF" abajo para vigencia de cada ordenamiento.

## Estructura

```
leyes-fiscales-mx/
├── lisr/           Ley del ISR + Reglamento
├── liva/           Ley del IVA + Reglamento
├── cff/            Código Fiscal de la Federación + Reglamento
├── rmf/            Resolución Miscelánea Fiscal 2026 + Anexos clave
├── lss/            Ley del Seguro Social + Reglamentos
├── infonavit/      Ley del INFONAVIT
├── lft/            Ley Federal del Trabajo
├── otros/          LIF 2026, LIEPS y otros
├── condensados/    Resúmenes y glosarios propios (lo que tú agregues)
└── scripts/        Script para refrescar leyes desde fuentes oficiales
```

## Inventario

### Leyes federales (fuente: diputados.gob.mx)

| Archivo | Ley | Última reforma DOF | Páginas |
|---|---|---|---|
| `cff/CFF.pdf` | Código Fiscal de la Federación | 09-04-2026 | 377 |
| `cff/RCFF.pdf` | Reglamento del CFF | — | 40 |
| `lisr/LISR.pdf` | Ley del Impuesto Sobre la Renta | 01-04-2024 | 313 |
| `lisr/RLISR.pdf` | Reglamento de la LISR | 06-05-2016 | 93 |
| `liva/LIVA.pdf` | Ley del Impuesto al Valor Agregado | 12-11-2021 | 128 |
| `liva/RLIVA.pdf` | Reglamento de la LIVA | 25-09-2014 | — |
| `lss/LSS.pdf` | Ley del Seguro Social | 15-01-2026 | 181 |
| `lss/RLSS_MACERF.pdf` | Reg. LSS – Afiliación, Clasificación, Recaudación, Fiscalización | — | 111 |
| `lss/RLSS_MAEBA.pdf` | Reg. LSS – Afiliación de Empresas y Beneficiarios | — | 19 |
| `infonavit/LIFNVT.pdf` | Ley del INFONAVIT | — | 93 |
| `lft/LFT.pdf` | Ley Federal del Trabajo | 15-01-2026 | 452 |
| `otros/LIF_2026.pdf` | Ley de Ingresos de la Federación 2026 | 07-11-2025 | 47 |
| `otros/LIEPS.pdf` | Ley del IEPS | — | 165 |

> Aunque LISR y LIVA muestran fechas anteriores, esa es la versión vigente. Las reformas para 2026 a estas dos leyes se publicaron en la **LIF 2026** (DOF 7-nov-2025), no en el cuerpo principal.

### Resolución Miscelánea Fiscal 2026 (fuente: sat.gob.mx)

| Archivo | Contenido | DOF |
|---|---|---|
| `rmf/RMF_2026.pdf` | Texto completo RMF 2026 (666 páginas) | 28-12-2025 |
| `rmf/Anexo_1_RMF_2026.pdf` | Formas oficiales fiscales | 28-12-2025 |
| `rmf/Anexo_7_RMF_2026.pdf` | Criterios normativos del SAT | 09-01-2026 |
| `rmf/Anexo_8_RMF_2026.pdf` | Tarifas ISR 2026 | 28-12-2025 |

## Cómo usar este repo

### Opción A: Con Cowork (recomendada)

1. Clona el repo a tu Mac:
   ```bash
   git clone https://github.com/TU_USUARIO/leyes-fiscales-mx.git ~/Documents/leyes-fiscales-mx
   ```
2. En Cowork, da acceso a la carpeta `~/Documents/leyes-fiscales-mx/`.
3. Pídele consultas naturales: *"Revisa el Art. 27 LISR y dime los requisitos de las deducciones autorizadas para personas morales."*

Ventaja: no consume tu límite de "knowledge" del Claude Project — Cowork lee bajo demanda.

### Opción B: Con Claude Project

Sube selectivamente los PDFs que más uses. Para no saturar la capacidad del proyecto, prioriza en este orden:

1. CFF + Anexo 7 RMF (criterios SAT)
2. RMF 2026 (texto principal)
3. LISR + Anexo 8 RMF (tarifas)
4. LIVA
5. LSS + INFONAVIT (si manejas nómina)
6. LFT + LIEPS (según necesidad)

## Actualización

Las leyes federales cambian. Para refrescar el repo a la última versión publicada en diputados.gob.mx, ejecuta:

```bash
cd leyes-fiscales-mx
bash scripts/actualizar.sh
```

El script descarga sobre los archivos existentes y muestra un diff de fechas de "Última reforma" si algo cambió. Revisa los cambios antes de hacer commit.

## Convención de commits

Para mantener trazabilidad fiscal:

- `update: CFF reforma DOF 09-04-2026` — al refrescar una ley reformada
- `add: Anexo 1-A RMF 2026` — al sumar un nuevo anexo
- `docs: actualizar índice` — cambios al README o a `condensados/`

## Fuentes oficiales

- **diputados.gob.mx** — Leyes federales con texto vigente
- **sat.gob.mx** — RMF, anexos, criterios
- **dof.gob.mx** — Decretos de reformas (texto del DOF original)

## Disclaimer

Esta es una compilación personal con fines de consulta profesional. Las versiones oficiales vinculantes son las publicadas en el DOF y en los portales oficiales del gobierno mexicano. Verifica siempre contra la fuente oficial antes de tomar decisiones que tengan efectos fiscales o legales.
