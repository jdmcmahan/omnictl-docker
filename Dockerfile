FROM dhi.io/alpine-base:3.23-dev AS builder

ARG TARGETOS
ARG TARGETARCH

ARG OMNICTL_VERSION_TAG=v1.4.7
ARG OMNICTL_EXECUTABLE_NAME=omnictl-${TARGETOS}-${TARGETARCH}
ARG OMNICTL_DOWNLOAD_URL=https://github.com/siderolabs/omni/releases/download/${OMNICTL_VERSION_TAG}/${OMNICTL_EXECUTABLE_NAME}

WORKDIR /staging

ADD ${OMNICTL_DOWNLOAD_URL} omnictl

FROM dhi.io/alpine-base:3.23

ARG TARGET_EXECUTABLE_PATH=/usr/local/bin

COPY --from=builder --chown=nonroot:nonroot --chmod=u+x /staging/omnictl ${TARGET_EXECUTABLE_PATH}/omnictl

ENV OMNI_ENDPOINT=
ENV OMNI_SERVICE_ACCOUNT_KEY=

ENTRYPOINT ["omnictl"]
CMD ["--help"]
