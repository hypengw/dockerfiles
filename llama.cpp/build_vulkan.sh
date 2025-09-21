#!/bin/bash

podman build --security-opt label=disable -f Dockerfile.vulkan -t llama.cpp:vulkan
