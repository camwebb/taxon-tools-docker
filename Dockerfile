FROM alpine:latest

WORKDIR /opt
RUN  apk add gawk
RUN  apk add alpine-sdk

RUN  curl -LO http://laurikari.net/tre/tre-0.8.0.zip
RUN  unzip tre-0.8.0.zip 
RUN  cd tre-0.8.0/ && ./configure --prefix=/usr/local && make && make install

# SF downloads are timing out :-(
# RUN  curl -LO https://downloads.sourceforge.net/gawkextlib/gawkextlib-1.0.4.tar.gz
COPY sf/gawkextlib-1.0.4.tar.gz .
RUN  tar xvzf gawkextlib-1.0.4.tar.gz 
RUN  cd gawkextlib-1.0.4/ && \
     ./configure --prefix=/usr/local && make && make install

# RUN  curl -LO https://downloads.sourceforge.net/gawkextlib/gawk-aregex-1.1.0.tar.gz
COPY sf/gawk-aregex-1.1.0.tar.gz .
RUN  tar xvzf gawk-aregex-1.1.0.tar.gz 
RUN  cd gawk-aregex-1.1.0/ && \
     ./configure --prefix=/usr/local && make && make install

RUN  git clone https://github.com/camwebb/taxon-tools.git
RUN  cd taxon-tools/ && \
  sed -i -E 's/#@> //g' matchnames && \
  sed -i -E 's/^(.*#@<)/#\1/g' matchnames && \
  sed -i -E 's|/bin/gawk|/usr/bin/gawk|g' matchnames && \
  sed -i -E 's|/bin/gawk|/usr/bin/gawk|g' parsenames && \
  sed -i 's|@load "aregex"|@load "/usr/local/lib/gawk/aregex.so"|g' \
  matchnames && mkdir -p /usr/local/bin && \
  cp -f matchnames parsenames /usr/local/bin/

# ENTRYPOINT ["/usr/local/bin/matchnames"]

FROM alpine:latest

RUN  apk add gawk
RUN mkdir -p /usr/local/lib/gawk
RUN mkdir -p /usr/local/bin
COPY --from=0 /usr/local/lib/libtre.so* /usr/local/lib/
COPY --from=0 /usr/local/lib/libgawkextlib.so* /usr/local/lib/
COPY --from=0 /usr/local/lib/gawk/aregex.so /usr/local/lib/gawk/
COPY --from=0 /usr/local/bin/matchnames /usr/local/bin/
COPY --from=0 /usr/local/bin/parsenames /usr/local/bin/

ENV PATH=/usr/local/bin


