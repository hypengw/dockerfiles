#!/bin/bash

ARGS=(
--security-opt label=disable 
-f Dockerfile.vulkan
-t ollama:vulkan
--env OLLAMA_TAG=vulkanV3
)

if [ -n "$1" ];then
    ARGS+=(--env OLLAMA_TAG=$1)
fi

podman build "${ARGS[@]}"
