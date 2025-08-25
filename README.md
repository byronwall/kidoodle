# KiddoDraw (PWA)

Installable drawing app that works offline via a service worker.

## Local quickstart

- Start a local server (prefer Node):

  - `./scripts/serve.sh` serves the repo root with caching disabled.

    - Env: `PORT` (default 8080), `HOST` (default 127.0.0.1)
    - Flag: `--open` to open the browser automatically
    - Example:

      ```bash
      HOST=0.0.0.0 PORT=5173 ./scripts/serve.sh --open
      ```

  - Alternative (no script): `npx http-server . -p 5173 -a 127.0.0.1 -c-1` and open `http://127.0.0.1:5173`
  - Legacy alternative: `python3 -m http.server 5173` and open `http://localhost:5173`

- Accept the install prompt in the browser.
- Go offline and it should still load.

## Deploy to Coolify (1‑click)

- Create an Application from this repo.
- Build Pack: Dockerfile
- Exposed Port: 80
- Deploy. The Nginx container serves the PWA with correct headers.

Notes:

- No icons are referenced in the manifest.
- `sw.js` is no‑cache; other static files are long‑cached.
