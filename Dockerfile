FROM debian:10

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

RUN apt-get update \
 && apt-get install -y gnupg curl libgetopt-long-descriptive-perl make \
      libdigest-perl-md5-perl wget python3-pygments fontconfig \
      librsvg2-bin zip inkscape

ARG TEXLIVE=2021
ARG SCHEME=scheme-full
ENV PATH=/usr/local/texlive/${TEXLIVE}/bin/x86_64-linux:$PATH
RUN curl -sL https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz | tar zxf - \
 && mv install-tl-20* install-tl \
 && cd install-tl \
 && echo "selected_scheme ${SCHEME}" > profile \
 && echo "tlpdbopt_install_docfiles 0" >> profile \
 && echo "tlpdbopt_install_srcfiles 0" >> profile \
 && ./install-tl -profile profile \
 && cd .. \
 && rm -rf install-tl

ARG PANDOC=2.14.1
RUN wget -O pandoc.deb https://github.com/jgm/pandoc/releases/download/${PANDOC}/pandoc-${PANDOC}-1-amd64.deb \
 && apt-get install -y ./pandoc.deb

ARG IPE=7.2.24
RUN wget -O ipe.deb    https://download.opensuse.org/repositories/home:/otfried13/Debian_10/amd64/ipe_${IPE}-1_amd64.deb \
 && apt-get install -y ./ipe.deb

RUN rm -rf /var/lib/apt/lists/* ./install-tl /usr/local/texlive/${TEXLIVE}/install-tl.log ./pandoc.deb ./ipe.deb

RUN tlmgr update --self && tlmgr update --all

CMD ["tlmgr", "--version"]
