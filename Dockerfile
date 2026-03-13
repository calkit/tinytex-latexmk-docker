FROM ubuntu:24.04

WORKDIR /var/local

RUN apt-get update && apt-get install -y \
    perl wget libfontconfig1 xz-utils ca-certificates && \
    wget -qO- "https://yihui.org/tinytex/install-bin-unix.sh" | sh && \
    apt-get clean

ENV PATH="${PATH}:/root/bin"

RUN fmtutil-sys --all

RUN tlmgr option repository "https://mirror.ctan.org/systems/texlive/tlnet" && \
    i=1; \
    until [ "$i" -gt 3 ]; do \
        tlmgr update --self && \
        tlmgr install fancyhdr \
            fontawesome \
            pgf \
            lastpage \
            latexmk \
            synctex \
            texcount \
            latexindent \
            titlesec \
            marvosym \
            enumitem \
            preprint \
            opensans \
            revtex \
            revtex4-1 \
            textcase \
            fontaxes && break; \
        echo "tlmgr failed on attempt ${i}/3, retrying in 15s..." >&2; \
        i=$((i + 1)); \
        sleep 15; \
    done && \
    [ "$i" -le 3 ]
