

## Shell

```bash 
docker run --rm -it \
  --user vscode \
  -v $HOME/.cache:/home/vscode/.cache \
  -v $HOME/.config:/home/vscode/.config \
  -v $HOME/.vscode-insdiers:/home/vscode/.vscode-insdiers \
  -v $HOME/.codeium:/home/vscode/.codeium \
  huodon/cuda-devel
```
