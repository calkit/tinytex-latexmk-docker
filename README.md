# tinytex-latexmk-docker

A Docker image that includes TinyTeX and latexmk.

Based on https://github.com/carteakey/tinytex-docker.

## Run the image locally

Example command to:

- Mount your current local project directory into the container
- Mount a local TinyTeX cache directory so auto-installed TeX packages persist across runs

```sh
mkdir -p "$HOME/.cache/tinytex"

docker run --rm -it \
	-v "$PWD":/work \
	-v "$HOME/.cache/tinytex":/root/.TinyTeX \
	-w /work \
	ghcr.io/calkit/tinytex-latexmk-docker:latest \
	texliveonfly --compiler "latexmk -pdf" main.tex
```

Change `main.tex` to your document entrypoint.
