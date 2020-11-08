FROM debian:10

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    PANDOC=2.11.1.1 \
    IPE=7.2.21
    
ENV PATH=/usr/local/texlive/2020/bin/x86_64-linux:$PATH
ARG scheme=scheme-full

RUN apt-get update \
  && apt-get install -y gnupg curl libgetopt-long-descriptive-perl make \
     libdigest-perl-md5-perl wget python3-pygments fontconfig \
     librsvg2-bin zip \
  && curl -sL http://ctan.math.washington.edu/tex-archive/systems/texlive/tlnet/install-tl-unx.tar.gz | tar zxf - \
  && mv install-tl-20* install-tl \
  && cd install-tl \
  && echo "selected_scheme ${scheme}" > profile \
  && echo "tlpdbopt_install_docfiles 0" >> profile \
  && echo "tlpdbopt_install_srcfiles 0" >> profile \
  && ./install-tl -repository http://ctan.math.washington.edu/tex-archive/systems/texlive/tlnet/ -profile profile \
  && cd .. \
  && rm -rf install-tl \
  && wget -O pandoc.deb https://github.com/jgm/pandoc/releases/download/${PANDOC}/pandoc-${PANDOC}-1-amd64.deb \
  && wget -O libipe.deb https://download.opensuse.org/repositories/home:/otfried13/Debian_10/amd64/libipe_${IPE}-1_amd64.deb \
  && wget -O ipe.deb    https://download.opensuse.org/repositories/home:/otfried13/Debian_10/amd64/ipe_${IPE}-1_amd64.deb \
  && apt-get install -y ./ipe.deb ./libipe.deb ./pandoc.deb \
  && rm ./ipe.deb ./libipe.deb ./pandoc.deb \
  && rm -rf /var/lib/apt/lists/*

CMD ["tlmgr", "--version"]
