# Dockerfile for Archlinux

This use the Archlinux bootstrap to create an Archlinux Docker image.
This is NOT an official image, though it verifies the official signature.

This is advantageous if you want to control as much as the build pipeline as possible when using Archlinux.

# Build

Just use make: `make build` and wait for the magic to happen

## Build signed images

This is really why this cruft is here, so that you can sign your images, made by you, verified by you.

```
export DOCKER_CONTENT_TRUST=1
make build
```
