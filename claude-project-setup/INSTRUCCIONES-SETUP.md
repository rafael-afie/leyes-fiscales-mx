# Setup del Claude Project · Fiscal México 2020-2026

Esta carpeta contiene todo lo necesario para configurar un Project de Claude (claude.ai → Projects) listo para consultas fiscales mexicanas.

## Pasos para configurar

### 1. Crear el Project

1. Abre claude.ai → click en **Projects** (sidebar izquierdo).
2. Click **New project**.
3. Nombre sugerido: **Fiscal México · 2020-2026**
4. Descripción sugerida: *Consultas de leyes fiscales mexicanas (LISR, LIVA, LIEPS, CFF, RMF) para contabilidades de personas morales ejercicios 2020-2026.*

### 2. Pegar las Custom Instructions

Abre el archivo [`CUSTOM-INSTRUCTIONS.md`](CUSTOM-INSTRUCTIONS.md) y **copia todo su contenido** al campo "Custom instructions" del Project.

### 3. Subir archivos al knowledge del Project

Sube los archivos de la subcarpeta `archivos-para-subir/` al knowledge del Project.

**Orden de prioridad** (subir en este orden hasta llenar capacidad):

| # | Archivo | Tamaño aprox | ¿Imprescindible? |
|---|---------|---------------|------------------|
| 1 | `vigencias-por-ano.md` | ~7 KB | ✅ Sí — la guía operativa |
| 2 | `conexion-leyes-fiscales-mx.md` | ~3 KB | ✅ Sí — explica el modelo |
| 3 | `reformas-DOF-2021-2025.md` | ~11 KB | ✅ Sí — índice de decretos |
| 4 | `CFF_referencia.md` | ~830 KB | 🟡 Recomendado — texto CFF vigente buscable |
| 5 | `vigencias-2020.md` a `vigencias-2026.md` | ~3 KB c/u | 🟡 Recomendado — uno por año |

> **Nota sobre capacidad:** Claude Projects tiene un límite de aproximadamente 200 MB / 500K tokens en el knowledge. Los archivos arriba suman ~860 KB, muy por debajo del límite. Tienes espacio de sobra para sumar después la RMF y anexos si los necesitas.

### 4. Probar el Project

En el chat del Project, prueba:

> "¿Qué versión de LISR aplica al ejercicio 2023?"

Respuesta esperada: Claude debería decir que es el DOF 12-11-2021 (paquete fiscal 2022), citando `vigencias-por-ano.md`.

> "Dame el texto del Art. 17-A del CFF."

Respuesta esperada: Claude debería citar el texto exacto del CFF.

## Estructura del paquete

```
claude-project-setup/
├── INSTRUCCIONES-SETUP.md       ← este archivo
├── CUSTOM-INSTRUCTIONS.md       ← copiar/pegar en el campo del Project
└── archivos-para-subir/         ← subir al knowledge del Project
    ├── vigencias-por-ano.md
    ├── conexion-leyes-fiscales-mx.md
    ├── reformas-DOF-2021-2025.md
    ├── CFF_referencia.md
    └── vigencias-2020.md, 2021.md, ... 2026.md (uno por año)
```

## Mantenimiento

Cuando se publique una reforma DOF nueva:

1. Actualiza `vigencias-por-ano.md` y `reformas-DOF-2021-2025.md` en el proyecto local de Cowork.
2. Sube las versiones actualizadas al knowledge del Project (reemplaza los archivos viejos).
3. Si la reforma afecta al CFF, actualiza también `CFF_referencia.md` corriendo el script `scripts/baja-leyes.sh CFF` desde Terminal en Mac.
