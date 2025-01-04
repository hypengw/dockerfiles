#!/bin/bash

podman build --security-opt label=disable -f Dockerfile.sycl -t llama.cpp:sycl -v /opt/intel:/opt/intel:ro
podman build --security-opt label=disable -f Dockerfile.vulkan -t llama.cpp:vulkan
