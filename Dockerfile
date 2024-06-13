FROM debian:bookworm-slim

ARG APP_USER=app
ARG APP_DIR=/app
ARG ARCHIVE_NAME
ARG ENTRYPOINT_NAME

WORKDIR "${APP_DIR}"

RUN apt-get update \
    && apt-get install tar \
    && rm -rf /var/lib/apt/lists/*

RUN useradd --no-create-home "${APP_USER}"

COPY *.tar ./
RUN tar -xf "${ARCHIVE_NAME}"
RUN rm ./*.tar

RUN chown -R "${APP_USER}:${APP_USER}" "${APP_DIR}"
USER "${APP_USER}"

ENV APP_DIR="${APP_DIR}"
ENV ENTRYPOINT_NAME="${ENTRYPOINT_NAME}"

CMD "${APP_DIR}/${ENTRYPOINT_NAME}"
