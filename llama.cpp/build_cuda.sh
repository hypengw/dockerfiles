#!/bin/bash

podman build --security-opt label=disable --device nvidia.com/gpu=all -f Dockerfile.cuda -t llama.cpp:cuda
