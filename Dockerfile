FROM sumankhanal/texlive-2020:full

RUN wget -O ipe.deb \
    https://download.opensuse.org/repositories/home:/otfried13/Debian_Testing/amd64/ipe_7.2.21-1_amd64.deb && \
    wget -O libipe.deb \
    https://download.opensuse.org/repositories/home:/otfried13/Debian_Testing/amd64/libipe_7.2.21-1_amd64.deb && \
    apt-get clean && apt-get update && apt-get install -y ./ipe.deb ./libipe.deb librsvg2-bin zip && \
    rm -rf /var/lib/apt/lists/

COPY ./latexmkrc /root/.latexmkrc
