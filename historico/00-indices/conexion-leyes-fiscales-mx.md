---
title: Conexión con el repo leyes-fiscales-mx
fecha: 2026-05-19
proyecto-vinculado: /Users/raal/Documents/Clientes/00 Sinube y excel/leyes-fiscales-mx
---

# Conexión con `leyes-fiscales-mx`

Este repositorio (`leyes-fiscales 2020 a 2025`, ahora extendido a 2026) **NO duplica** los textos vigentes. Se conecta con `leyes-fiscales-mx`, que contiene los textos vigentes actuales en PDF + TXT.

## División de responsabilidades

| Repositorio | Qué guarda | Cuándo se usa |
|-------------|------------|----------------|
| **`leyes-fiscales-mx/`** (otro proyecto) | Texto vigente **actual** + reglamentos + RMF actual + leyes laborales (LSS, LFT, INFONAVIT) | Cuando trabajas el ejercicio en curso (2026) o necesitas consultar la última versión |
| **`leyes-fiscales 2020 a 2025/`** (este proyecto) | Mapeo de **vigencias históricas por año** + índice de decretos de reforma DOF + carpetas por año (2020-2026) para guardar papeles de trabajo, dictámenes y reconstrucciones específicas | Cuando trabajas contabilidades de ejercicios pasados (2020-2025) y necesitas el texto vigente al cierre de ese ejercicio |

## Inventario disponible en `leyes-fiscales-mx`

Archivos en formato PDF + TXT (ya convertidos para búsqueda):

| Ruta | Ley/Documento | Última reforma DOF |
|------|---------------|--------------------|
| `cff/CFF.pdf` / `.txt` | Código Fiscal de la Federación | **09-04-2026** |
| `cff/RCFF.pdf` / `.txt` | Reglamento del CFF | — |
| `lisr/LISR.pdf` / `.txt` | Ley del ISR | **01-04-2024** |
| `lisr/RLISR.pdf` / `.txt` | Reglamento de la LISR | 06-05-2016 |
| `liva/LIVA.pdf` / `.txt` | Ley del IVA | **12-11-2021** |
| `liva/RLIVA.pdf` / `.txt` | Reglamento de la LIVA | 25-09-2014 |
| `otros/LIEPS.pdf` | Ley del IEPS | (verificar — pendiente fecha) |
| `lss/LSS.pdf` / `.txt` | Ley del Seguro Social | **15-01-2026** |
| `lss/RLSS_MACERF.pdf` | Reg. LSS (afiliación, clasificación, recaudación, fiscalización) | — |
| `lss/RLSS_MAEBA.pdf` | Reg. LSS (afiliación de empresas y beneficiarios) | — |
| `infonavit/LIFNVT.pdf` | Ley del INFONAVIT | — |
| `lft/LFT.pdf` / `.txt` | Ley Federal del Trabajo | **15-01-2026** |
| `otros/LIF_2026.pdf` | Ley de Ingresos de la Federación 2026 | 07-11-2025 |
| `rmf/RMF_2026.pdf` / `.txt` | Resolución Miscelánea Fiscal 2026 | 28-12-2025 |
| `rmf/Anexo_1_RMF_2026.pdf` / `.txt` | Anexo 1 — Formas oficiales | 28-12-2025 |
| `rmf/Anexo_7_RMF_2026.pdf` / `.txt` | Anexo 7 — Criterios normativos SAT | 09-01-2026 |
| `rmf/Anexo_8_RMF_2026.pdf` / `.txt` | Anexo 8 — Tarifas ISR 2026 | 28-12-2025 |

## Cómo referenciar leyes-fiscales-mx desde este proyecto

Cuando trabajas un ejercicio de **2026**, los textos vigentes están directamente en `leyes-fiscales-mx`. Este proyecto (`leyes-fiscales 2020 a 2025`) solo guarda los papeles de trabajo y el mapeo histórico.

**Ejemplo en una conversación con Claude:**
> "Revisa el Art. 27 LISR en `~/Documents/Clientes/00 Sinube y excel/leyes-fiscales-mx/lisr/LISR.txt` y verifica si las deducciones que declaramos en 2026 cumplen los requisitos."

Para ejercicios **2020-2025**, usa la tabla de vigencias en [`vigencias-por-ano.md`](vigencias-por-ano.md) para saber qué versión aplica.

## Convención de uso

1. **No copies archivos** de `leyes-fiscales-mx` aquí. Referencia por ruta.
2. **No edites** archivos en `leyes-fiscales-mx` que provengan de fuentes oficiales. Si necesitas notas propias, ponlas en el carpeta `condensados/` de ese repo o en este proyecto.
3. **Sí sube a este proyecto** papeles de trabajo, conciliaciones, dictámenes y reconstrucciones de versiones históricas para auditoría de ejercicios pasados.
4. **NO subas** datos fiscales reales (RFCs, nombres de clientes, importes) al repo público `leyes-fiscales-mx`. Eso es solo legislación pública. Los papeles privados van en este proyecto que es local.
