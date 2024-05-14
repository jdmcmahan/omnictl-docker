# `omnictl` Docker Image

This repository defines a Docker image for running [`omnictl` commands](https://omni.siderolabs.com/docs/reference/cli/)
in a container. Use this image to execute any `omnictl` command as part of a containerized workflow.

## Usage

### Getting Started

Before running this Docker image, you must create an Omni service account to authenticate with Sidero Omni.
See https://omni.siderolabs.com/docs/how-to-guides/how-to-create-a-service-account/ for more information about creating
a service account.

### Running the container

#### Required parameters

| Parameter                     | Description                                                                                                                                                                                                 |
|:------------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `-e OMNI_ENDPOINT`            | The Omni endpoint URL generated for your service account. See https://omni.siderolabs.com/docs/how-to-guides/how-to-create-a-service-account/ for more information about creating a service account.        |
| `-e OMNI_SERVICE_ACCOUNT_KEY` | The Omni service account key generated for your service account. See https://omni.siderolabs.com/docs/how-to-guides/how-to-create-a-service-account/ for more information about creating a service account. |

#### Examples

##### Docker CLI

```shell
$ docker run -it --rm -e OMNI_ENDPOINT=https://my.omni.siderolabs.io:443 -e OMNI_SERVICE_ACCOUNT_KEY=blah mcmahan/omnictl:latest omnictl cluster status mycluster
```

##### Docker Compose

```yaml
services:
  omnictl:
    image: mcmahan/omnictl:latest
    stdin_open: true
    tty: true
    environment:
      - OMNI_ENDPOINT=https://my.omni.siderolabs.io:443
      - OMNI_SERVICE_ACCOUNT_KEY=blah
    command:
      - /bin/sh
      - -c
      - omnictl cluster status mycluster
```

## Building the image

This repository uses Docker Buildx to generate multi-platform images. Images for the `linux/amd64` and `linux/arm64`
platforms are published to Docker Hub.

A number of Docker build arguments are available to customize the image if desired:

| Argument                  | Description                                                                                                                                                                                                                                                           |
|:--------------------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `TARGETOS`                | The target operating system to build against as specified by https://docs.docker.com/build/guide/multi-platform/#platform-build-arguments.<br/><br/>Defaults to the value provided by the Buildx builder, if applicable.                                              |
| `TARGETARCH`              | The target architecture to build against as specified by https://docs.docker.com/build/guide/multi-platform/#platform-build-arguments.<br/><br/>Defaults to the value provided by the Buildx builder, if applicable.                                                  |
| `OMNICTL_VERSION_TAG`     | The version of `omnictl` to download and include as part of the image. This is used to compose the download URL for `omnictl`.                                                                                                                                        |
| `OMNICTL_EXECUTABLE_NAME` | The full name of the platform-specific `omnictl` executable as packaged in the [Sidero Omni releases](https://github.com/siderolabs/omni/releases). This is used to compose the download URL for `omnictl`.<br/><br/>Defaults to `omnictl-${TARGETOS}-${TARGETARCH}`. |
| `OMNICTL_DOWNLOAD_URL`    | The full download URL for `omnictl`.<br/><br/>Defaults to `https://github.com/siderolabs/omni/releases/download/${OMNICTL_VERSION_TAG}/${OMNICTL_EXECUTABLE_NAME}`.                                                                                                   |
| `TARGET_EXECUTABLE_PATH`  | The file location at which to save the `omnictl` executable in the target image.<br/><br/>Defaults to `/usr/local/bin`.                                                                                                                                               |
