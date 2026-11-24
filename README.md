# CokePuter static website

This site is based on a project originally hosted on a 386 computer running inside a Coke machine. Switches attached to a keyboard controller detected when sodas were dispensed and kept track of the machine's contents.

Plain HTML, CSS, and JavaScript served by nginx. There is no application build step or runtime dependency.

## Project layout

- `*.html`, `style.css`, `site.js`, and `assets/` are the static site.
- `Dockerfile` and `nginx.conf` package and serve the site.
- `scripts/` contains local preview, build, deployment, and smoke-test commands.
- `k3s/cokeputer.yaml` declares the Namespace, Deployment, Service, HTTPS redirect, and ingresses.

## Preview

```sh
./scripts/preview.sh
```

This builds and runs the container at `http://127.0.0.1:8088/`. Press Ctrl-C to stop it. The same files can also be served directly by a static web server.

## Build for k3spi

```sh
./scripts/build.sh
```

The script uses Docker Buildx to create an ARM64 image tagged
`docker.io/library/cokeputer-static:latest` and export it to
`/tmp/cokeputer-static-arm64.tar`. Set `COKEPUTER_ARM64_TAR` to change the archive path.

## Apply Kubernetes configuration

```sh
./scripts/apply-k3s.sh
```

The script defaults to the `k3spi` kubectl context. Override it with:

```sh
K3SPI_CONTEXT=my-context ./scripts/apply-k3s.sh
```

## Build and deploy

```sh
./scripts/deploy-k3spi.sh
```

This builds and exports the ARM64 image, transfers and imports it on `k3spi`, updates the Deployment, waits for rollout, and runs the public smoke test.

Optional environment variables:

- `K3SPI_HOST`: SSH host name, default `k3spi`
- `K3SPI_CONTEXT`: kubectl context, default `k3spi`
- `COKEPUTER_ARM64_TAR`: local image archive path
- `COKEPUTER_URL`: public URL used by the smoke test

## Smoke test

```sh
./scripts/smoke-test.sh
```

It checks `/healthz` and the public homepage. Use `COKEPUTER_URL` to test another environment.

## Container configuration

The nginx container listens on port `8080` and runs as the unprivileged `nginx` user. The k3s probes use `/healthz`. The Deployment keeps the root filesystem read-only and uses an emptyDir mounted at `/tmp` for nginx temporary files.

## Restoration notes

The May 26, 2003 homepage was recovered from the Wayback archive. Other pages and outage material came from local saved files. Original text is retained, frames and Wayback playback scripts were removed, and reused graphics remain in `assets/`. Missing photos are labeled in their original locations. See `about.html` for missing-asset details.
