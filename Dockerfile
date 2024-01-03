ARG BASE_IMAGE=python:3.11
FROM $BASE_IMAGE AS builder
ENV VIRTUAL_ENV="/opt/python/venv"
WORKDIR /opt/python
COPY pdm.lock pyproject.toml build.sh .
RUN ./build.sh
USER nonroot
ENV PATH="$VIRTUAL_ENV/bin:$PATH" PYTHONPATH="/src:$PYTHONPATH"
WORKDIR /data
ENTRYPOINT ["jupyter", "lab"]
