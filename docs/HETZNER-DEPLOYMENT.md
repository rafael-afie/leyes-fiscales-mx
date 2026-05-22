# Deployment a Hetzner · Repo git interno para apps

Guía para subir este proyecto como repo git en tu VPS de Hetzner y que las apps de **CBP** (aduana US) y **conta** lo consuman como referencia compartida.

## Arquitectura propuesta

```
Hetzner VPS
├── git-server (Forgejo o Gitea por Tailscale)
│   └── rafa/leyes-fiscales-historico.git
├── app-cbp/
│   └── submódulo → leyes-fiscales-historico
└── app-conta/
    └── submódulo → leyes-fiscales-historico
```

Cada app referencia el repo como **git submódulo**. Eso significa que cada app está "pinned" a una versión específica del repo de leyes — si publican una reforma DOF que rompe algo, las apps no se rompen hasta que tú decidas actualizar el submódulo.

## Pasos

### 1. Levanta un git server en el VPS (si aún no tienes)

Si no tienes git server, las opciones son:

**A) Forgejo (recomendado — fork comunitario de Gitea, más liviano)**

```bash
# En el VPS, vía SSH
docker run -d --name forgejo \
  -p 3000:3000 -p 2222:22 \
  -v forgejo-data:/data \
  codeberg.org/forgejo/forgejo:8
```

Después accedes a `http://<ip-vps>:3000` (o vía Tailscale al hostname) para crear tu usuario y repo.

**B) Bare git via SSH (mínimo)**

Si solo quieres el repo sin UI web:

```bash
# En el VPS
sudo mkdir -p /srv/git
sudo useradd -m -s /bin/bash git
sudo -u git mkdir -p /srv/git/leyes-fiscales-historico.git
sudo -u git git init --bare /srv/git/leyes-fiscales-historico.git
```

Tu URL será: `ssh://git@<ip-vps>:22/srv/git/leyes-fiscales-historico.git`

### 2. En tu Mac, inicializa y haz primer push

```bash
cd "~/Documents/Clientes/00 Sinube y excel/leyes-fiscales 2020 a 2025"

# Edita el script con tu URL Hetzner
nano scripts/setup-git-hetzner.sh
# Cambia la línea HETZNER_GIT_URL="ssh://..." por tu URL real

# Corre el script
./scripts/setup-git-hetzner.sh

# Después del primer commit que crea el script:
git push -u origin main
```

### 3. En la app de CBP, agrega como submódulo

```bash
cd ~/path/a/tu/app-cbp

git submodule add ssh://git@<ip-vps>:22/srv/git/leyes-fiscales-historico.git data/leyes-fiscales
git commit -m "feat: agregar referencia a leyes fiscales históricas"
```

### 4. En la app de conta, igual

```bash
cd ~/path/a/tu/app-conta
git submodule add ssh://git@<ip-vps>:22/srv/git/leyes-fiscales-historico.git data/leyes-fiscales
git commit -m "feat: agregar referencia a leyes fiscales históricas"
```

### 5. Cómo las apps leen el contenido

Desde dentro de las apps, los archivos están en `data/leyes-fiscales/`. Por ejemplo:

```python
# Python (app-conta o app-cbp)
from pathlib import Path
import yaml

base = Path(__file__).parent / "data" / "leyes-fiscales"

# Leer la tabla maestra de vigencias
vigencias_md = (base / "00-indices" / "vigencias-por-ano.md").read_text()

# O leer las vigencias específicas de un año
vig_2024 = (base / "2024" / "01-leyes" / "vigencias.md").read_text()
```

```javascript
// Node.js
const fs = require('fs');
const path = require('path');

const base = path.join(__dirname, 'data', 'leyes-fiscales');
const vigencias = fs.readFileSync(
  path.join(base, '00-indices', 'vigencias-por-ano.md'),
  'utf-8'
);
```

### 6. Actualizar el submódulo cuando publiques una reforma

```bash
# En tu Mac, en el repo de leyes
cd "~/Documents/Clientes/00 Sinube y excel/leyes-fiscales 2020 a 2025"
# ...edita archivos, agrega nueva reforma...
git add . && git commit -m "feat: reforma DOF dd-mm-aaaa"
git push

# En las apps (en el VPS o en tu Mac)
cd ~/path/a/app-cbp
git submodule update --remote data/leyes-fiscales
git add data/leyes-fiscales && git commit -m "chore: bump leyes-fiscales"
```

## Alternativa: API HTTP en lugar de submódulo

Si prefieres que las apps consulten vía HTTP en lugar de tener los archivos en disco:

```bash
# En el VPS, montar un servidor estático con los .md
docker run -d --name leyes-static \
  -v /srv/git/leyes-fiscales-historico.git/.../:/usr/share/nginx/html:ro \
  -p 8080:80 nginx
```

Y las apps consultan `http://leyes.tudominio.com/2024/01-leyes/vigencias.md`. Es menos elegante para apps que necesitan los archivos crudos, pero útil si quieres acceso desde el navegador también.

## ¿Submódulo o copia?

| Estrategia | Pros | Contras |
|------------|------|---------|
| **Submódulo** | Versionado claro, apps pinneadas a versión específica de leyes | Workflow git un poco más complejo |
| **Subtree** | Más simple para consumidores, todo está en el repo de la app | Cambios bidireccionales son raros |
| **API HTTP** | Cero acoplamiento, fácil de cachear | Latencia, dependencia de servicio |
| **Copia manual** | Cero infraestructura | Se desincroniza, hay que recordar actualizar |

**Recomendación para apps fiscales:** submódulo. Garantiza que la versión de la ley con que se calculó algo quede registrada en el commit de la app.

## Privacidad

- El repo `leyes-fiscales-historico` debe ser **interno** (no público) si vas a meter ahí papeles de trabajo. Por ahora solo tiene legislación pública, así que técnicamente podría ser público, pero recomiendo mantenerlo privado por hábito.
- **NO subas RFCs, importes ni nombres de clientes** al repo. El `.gitignore` ya bloquea las rutas comunes (`_papeles-de-trabajo/`, `*.xml`, `cfdi/`, etc.) pero la responsabilidad final es tuya antes de cada `git add`.
- Si en algún momento metes papeles por error y haces push, ese commit queda en el historial — hay que limpiar con `git filter-repo` o `BFG Repo-Cleaner`. Mejor prevenir.

## Tailscale + git

Si tu VPS Hetzner está en tu tailnet, la URL del repo debería usar el hostname Tailscale en lugar de IP pública:

```bash
git remote set-url origin ssh://git@<vps-tailscale-name>:22/srv/git/leyes-fiscales-historico.git
```

Eso evita exponer puertos SSH a internet y mantiene todo dentro de tu red privada. Combinado con `tsnet` o ACLs Tailscale, puedes restringir qué dispositivos pueden clonar el repo.
