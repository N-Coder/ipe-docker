FROM sumankhanal/texlive-2019

RUN wget -O ipe.deb \
    https://download.opensuse.org/repositories/home:/otfried13/Debian_Unstable/amd64/ipe_7.2.13-1_amd64.deb && \
    wget -O libipe.deb \
    https://download.opensuse.org/repositories/home:/otfried13/Debian_Unstable/amd64/libipe_7.2.13-1_amd64.deb && \
    apt-get clean && apt-get update && apt-get install -y ./ipe.deb ./libipe.deb librsvg2-bin && \
    rm -rf /var/lib/apt/lists/

COPY ./latexmkrc /root/.latexmkrc