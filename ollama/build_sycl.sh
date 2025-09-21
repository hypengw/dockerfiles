#!/bin/bash

ARGS=(
--security-opt label=disable 
-f Dockerfile.sycl 
-t ollama:sycl 
-v /opt/intel:/opt/intel:ro
)

if [ -n "$1" ];then
    ARGS+=(--env OLLAMA_TAG=$1)
fi

podman build "${ARGS[@]}"
