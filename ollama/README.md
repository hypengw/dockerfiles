## build
```bash
./build.sh v0.5.8-rc6
```

## use
```bash
podman kube play ./ollama_webui.kube.yaml --replace

# open http://localhost:3000
```

## import model
### pull
```bash
podman exec ollama-pod-ollama ollama pull <model>
```

### create from local
```bash
podman volume inspect ollama-models
cd <Mountpoint>
cp <model> <Mountpoint>/
echo 'From <model>' > /models/Modelfile
podman exec ollama-pod-ollama ollama create -f /models/Modelfile
podman exec ollama-pod-ollama ollama rm /models/<model>
```
