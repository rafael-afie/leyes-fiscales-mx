# Leyes Fiscales · México · Ejercicios 2020-2026

Repositorio de trabajo para contabilidades fiscales de personas morales con cobertura **2020-2026**. Combina mapeo histórico de vigencias por ejercicio + papeles de trabajo + ligas a textos oficiales.

> **Proyecto vinculado:** [`leyes-fiscales-mx/`](../leyes-fiscales-mx/) contiene los textos vigentes actuales en PDF + TXT (LISR, LIVA, LIEPS, CFF + reglamentos + RMF 2026 + LSS + LFT + INFONAVIT). Este proyecto NO duplica esos textos: los referencia. Ver [`00-indices/conexion-leyes-fiscales-mx.md`](00-indices/conexion-leyes-fiscales-mx.md) para detalles.

> **Aviso fiscal.** Para cada ejercicio cerrado (2020-2025), valida la versión vigente al **31 de diciembre** de ese año. Para el ejercicio en curso (2026), usa el vigente actual desde el repo `leyes-fiscales-mx`. El texto vigente cambia con cada decreto DOF — verifica siempre contra fuente oficial.

---

## Estructura

```
leyes-fiscales 2020 a 2025/
├── 00-indices/                            # Índices y referencias maestras
│   ├── vigencias-por-ano.md              # 🎯 Tabla maestra: qué versión aplica a cada cierre
│   ├── conexion-leyes-fiscales-mx.md     # 🎯 Cómo conectar con el repo de vigentes
│   ├── reformas-DOF-2021-2025.md         # Índice de decretos de reforma DOF
│   └── CFF_referencia_vigente_mayo2026.md # Texto CFF actual en MD buscable (referencia)
├── 2020/  ← NUEVO
│   ├── README.md
│   ├── 01-leyes/vigencias.md             # Versiones aplicables al cierre 2020
│   ├── 02-reglamentos/
│   ├── 03-RMF-y-anexos/
│   └── 04-reformas-DOF/
├── 2021/  ...mismo patrón con vigencias del cierre 2021
├── 2022/  ...
├── 2023/  ...
├── 2024/  ...
├── 2025/  ...
├── 2026/  ← NUEVO. Vigente actual → apunta a leyes-fiscales-mx
├── fuentes-oficiales/
└── scripts/
    ├── baja-leyes.sh                     # Pipeline reusable para refrescar leyes
    └── limpia_ley.py                     # Conversor PDF→MD
```

---

## Cómo usar este proyecto

### Caso 1: Trabajar contabilidad de un ejercicio cerrado (2020-2025)

1. Abre la carpeta del año (`2023/` por ejemplo).
2. Lee `01-leyes/vigencias.md` para saber qué decreto era vigente al cierre.
3. Para consultar el texto, hay dos rutas:
   - **Si el texto vigente al cierre coincide con el actual** (caso de LIVA en todos los años 2022-2025): usa el archivo de `leyes-fiscales-mx/`.
   - **Si difiere** (caso de LISR 2020-2023 vs vigente actual): descarga el PDF oficial desde el link DOF que aparece en `vigencias.md`.

### Caso 2: Trabajar contabilidad 2026 (en curso)

1. Los textos vigentes están en `leyes-fiscales-mx/` (repo separado, también en tu Mac).
2. Esta carpeta (`2026/`) es para guardar papeles de trabajo del ejercicio en curso, no para almacenar textos.

### Caso 3: Buscar un artículo histórico

```bash
# Ejemplo: ¿qué decía el Art. 27 LISR en 2023?
# 1. Consulta vigencias 2023:
cat "00-indices/vigencias-por-ano.md"
# 2. Como vigente 2023 = DOF 12-11-2021, descarga ese PDF desde la URL en vigencias.md
# 3. Compara con vigente actual si necesitas:
grep -A 50 "Artículo 27\." ../leyes-fiscales-mx/lisr/LISR.txt
```

---

## Estado del proyecto (2026-05-19)

✅ Estructura ampliada de 5 a **7 ejercicios (2020-2026)**
✅ Conexión documentada con `leyes-fiscales-mx` (proyecto vinculado)
✅ Tabla maestra de vigencias por ejercicio
✅ Índice de reformas DOF 2021-2025
✅ Archivo `vigencias.md` en cada año (2020-2026) con liga oficial a cada decreto
✅ Pipeline reusable de descarga (`scripts/`)
✅ Referencia CFF vigente mayo 2026 en MD buscable

### Pendiente

- ⏳ Reconstruir LISR, LIVA, LIEPS textos consolidados por año si se requiere para auditoría específica (bajo demanda)
- ⏳ Bajar RMF anuales 2020-2025 + anexos clave (la 2026 ya está en `leyes-fiscales-mx`)
- ⏳ Reglamentos por año (RLISR, RLIVA, RCFF) — para 2026 ya están en `leyes-fiscales-mx`

### No haremos aquí

- ❌ Duplicar textos vigentes que ya están en `leyes-fiscales-mx`
- ❌ Subir papeles privados (RFCs, importes, nombres de clientes) — eso va en este proyecto local, NO en `leyes-fiscales-mx` (que es legislación pública)

---

## Fuentes oficiales

- **Cámara de Diputados** — textos vigentes y catálogo de reformas: https://www.diputados.gob.mx/LeyesBiblio/index.htm
- **DOF** — decretos de reforma originales: https://www.dof.gob.mx/
- **SAT** — RMF, anexos, criterios: https://www.sat.gob.mx/normatividad/

---

*Repositorio mantenido por Rafa (Querétaro). Última actualización: 2026-05-19.*
