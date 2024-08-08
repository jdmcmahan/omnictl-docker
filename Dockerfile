FROM alpine:3.20.2
ARG TARGETOS
ARG TARGETARCH

ARG OMNICTL_VERSION_TAG=v0.40.2
ARG OMNICTL_EXECUTABLE_NAME=omnictl-${TARGETOS}-${TARGETARCH}
ARG OMNICTL_DOWNLOAD_URL=https://github.com/siderolabs/omni/releases/download/${OMNICTL_VERSION_TAG}/${OMNICTL_EXECUTABLE_NAME}

ARG TARGET_EXECUTABLE_PATH=/usr/local/bin

RUN apk add --update --no-cache wget
RUN wget -q -O ${TARGET_EXECUTABLE_PATH}/omnictl ${OMNICTL_DOWNLOAD_URL} && chmod u+x ${TARGET_EXECUTABLE_PATH}/omnictl

ENV OMNI_ENDPOINT=
ENV OMNI_SERVICE_ACCOUNT_KEY=

CMD ["omnictl", "--version"]
