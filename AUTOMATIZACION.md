# Automatización con GitHub Actions

Este repo se actualiza solo cada lunes a las 9:00 AM hora de México (Querétaro/CDMX).

## Cómo funciona

1. GitHub enciende un servidor temporal (Ubuntu) cada lunes 15:00 UTC
2. Clona este repo, ejecuta `scripts/actualizar.sh`
3. Calcula el SHA256 de cada PDF antes y después
4. Si algún hash cambió, hace commit y push automático con un mensaje detallado
5. Si nada cambió, no hace nada (no genera commits vacíos)

## Notificaciones

Para que te llegue email cuando haya cambios:

1. Ve a https://github.com/settings/notifications
2. En **"Email notifications"** verifica que tu correo principal esté activo
3. En **"System notifications"** activa **"Actions"** → **"Send notifications for failed workflows only"** (recomendado, así solo te enteras de problemas) o **"Send notifications for all workflows"** (si quieres confirmación de cada corrida)
4. Como `github-actions[bot]` hace commits que afectan el repo, también te llegan en la pestaña Watch del repo si tienes activadas las notificaciones de "All Activity"

## Correr manualmente

Si quieres forzar una actualización sin esperar al lunes:

1. Ve a tu repo en GitHub → pestaña **Actions**
2. Selecciona el workflow **"Actualizar leyes fiscales"** en el panel izquierdo
3. Clic en **"Run workflow"** (botón gris a la derecha) → **Run workflow**
4. En 1-2 minutos termina y verás el resultado

## Cambiar el horario

El cron está en formato UTC. Editá `.github/workflows/actualizar-leyes.yml` línea con `cron`:

```yaml
- cron: '0 15 * * 1'   # Lunes 9 AM México (15 UTC)
```

Formato: `minuto hora día_mes mes día_semana`. Ejemplos útiles:

- `'0 13 * * *'` → diario 7 AM México
- `'0 15 * * 1,4'` → lunes y jueves 9 AM México
- `'0 17 1 * *'` → día 1 de cada mes 11 AM México

> Nota: el cron de GitHub Actions tiene tolerancia de hasta 5 minutos. Si pones 9:00 AM, puede correr a 9:03. Para nuestro caso es irrelevante.

## Mensajes de commit

El bot genera commits así:

```
update: 2 ley(es) actualizada(s) — 2026-08-15

Actualización automática semanal.

Archivos modificados:
  - cff/CFF.pdf
  - rmf/RMF_2026.pdf

Verifica con: python3 scripts/verificar_vigencia.py
```

## Costos

GitHub Actions es **gratis** para repos privados hasta 2,000 minutos/mes.
Cada corrida de este workflow toma ~30 segundos. Aunque corra diario serían ~15 min/mes. Sin riesgo de costo.

## Si algo falla

GitHub te manda email cuando un workflow falla. Las causas más comunes:

| Falla | Solución |
|---|---|
| URL del SAT cambió de nombre | Edita `scripts/actualizar.sh` con la nueva URL |
| Diputados.gob.mx temporalmente caído | Espera al siguiente lunes, suele restablecerse |
| Hash del PDF cambia pero el contenido no (metadatos) | Es normal — el bot commitea aunque sea cambio cosmético |

Para revisar el log de un fallo, ve a la pestaña **Actions** del repo y entra al run con ❌.

## Desactivar temporalmente

Si quieres pausar la automatización un tiempo (ej. vacaciones), ve a:
**Actions** → **Actualizar leyes fiscales** → menú **"..."** → **Disable workflow**

Para reactivar, mismo lugar → **Enable workflow**.
