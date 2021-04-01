# docker-multiarch-hello

This repository demonstrates how to create a multi-arch Docker image supporting multiple platforms, e.g. both `x86_64` and ARM, but building all images on an `x86_64` platform. It is primarily for personal use for reference on how to build manifests and how they work.

This example also only relies on Docker Hub to build all images, including the ARM variants, and does not rely on separate build servers or environments to build non-amd64 images.

## Automated builds via Docker Hub

The Docker Hub [Custom build phase hooks](https://docs.docker.com/docker-hub/builds/advanced/#custom-build-phase-hooks) allow in combination with [QEMU](https://www.qemu.org) an entirely automated build of the Docker images via Docker Hub for all major platforms.

To see how it's done in this repository, see

- Prepare QEMU in a custom build phase hook, [hooks/pre_build](./hooks/pre_build) and [hooks/post_checkout](./hooks/post_checkout)
- Dockerfile to build an `arm32v7` image on `x86_64` (Docker Hub), [Dockerfile.arm32v7](./Dockerfile.arm32v7)
- Dockerfile to build an `arm64v8` image on `x86_64` (Docker Hub), [Dockerfile.arm64v8](./Dockerfile.arm64v8)

## ref

- [Advanced options for Autobuild and Autotest](https://docs.docker.com/docker-hub/builds/advanced/)
- [/usr/bin/qemu-*-static](https://github.com/multiarch/qemu-user-static)
- [Manifest tool for manifest list object creation/query](https://github.com/estesp/manifest-tool)
- [Docker Multi-Architecture Images by Davide Mauri](https://medium.com/@mauridb/docker-multi-architecture-images-365a44c26be6)
- <https://github.com/agonbar/docker-multi-arch-example>
