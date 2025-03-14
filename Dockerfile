# syntax=docker/dockerfile:1
# Best practices: https://docs.docker.com/build/building/best-practices/

FROM ghcr.io/actions/actions-runner:2.322.0

# Information.
LABEL maintainer="Julien Breux <julien.breux@gmail.com>" \
    org.opencontainers.image.authors="Julien Breux <julien.breux@gmail.com>" \
    org.opencontainers.image.title="Cloud Run runner for Github" \
    org.opencontainers.image.description="Cloud Run runner for Github is a runner container." \
    org.opencontainers.image.licenses="Apache-2.0" \
    org.opencontainers.image.documentation="https://github.com/JulienBreux/cloud-run-github-runner" \
    io.artifacthub.package.readme-url="https://raw.githubusercontent.com/JulienBreux/cloud-run-github-runner/main/README.md"

# Add scripts with right permissions.
USER root
ADD scripts/start.sh start.sh
RUN chmod +x start.sh

# Add start entrypoint with right permissions.
USER runner
ENTRYPOINT ["./start.sh"]
