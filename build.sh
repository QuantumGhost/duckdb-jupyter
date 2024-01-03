#!/usr/bin/env bash

set -ex

function install_python_deps() {
    PIP_ARGS=( --no-cache-dir )
    python -m venv "${VIRTUAL_ENV}"
    source "${VIRTUAL_ENV}/bin/activate"
    pip install "${PIP_ARGS[*]}" -U pip setuptools wheel
    pip install "${PIP_ARGS[*]}" pdm
    pdm install
    pdm cache clear
}

function setup_system() {
    adduser --disabled-password --gecos "" nonroot
    DIRS=( /data /src )

    for dir in "${DIRS[@]}"; do
        mkdir -p "${dir}"
        chown nonroot:nonroot "${dir}"
    done
}

function main() {
    setup_system
    install_python_deps
}

main
