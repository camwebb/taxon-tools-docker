FROM archlinux:latest

# RUN pacman -Syyu

RUN pacman -Sy

RUN pacman --noconfirm -S fakeroot binutils gcc make
RUN pacman --noconfirm -S tre diffutils
RUN pacman --noconfirm -S git

RUN useradd -m arch

USER arch

RUN cd /home/arch && \
 curl -LO https://aur.archlinux.org/cgit/aur.git/snapshot/gawkextlib.tar.gz && \
 tar xvzf gawkextlib.tar.gz && \
 cd gawkextlib && \
 makepkg

USER root

RUN pacman --noconfirm -U /home/arch/gawkextlib/gawkextlib*.zst

USER arch

RUN cd /home/arch && \
 curl -LO https://aur.archlinux.org/cgit/aur.git/snapshot/gawk-aregex.tar.gz && \
 tar xvzf gawk-aregex.tar.gz && \
 cd gawk-aregex && \
 makepkg

USER root

RUN pacman --noconfirm -U /home/arch/gawk-aregex/*.zst

USER arch

RUN cd /home/arch && \
 git clone https://github.com/camwebb/taxon-tools.git && \
 cd taxon-tools && \
 cp matchnames matchnames.ori && \
 sed -i -E 's/#@> //g' matchnames && \
 sed -i -E 's/^(.*#@<)/#\1/g' matchnames && \ 
 make check

USER root

RUN cd /home/arch/taxon-tools && \
  mkdir -p /usr/local/bin && \
  cp -f matchnames parsenames /usr/local/bin/. && \
  mkdir -p /usr/local/share/awk && \
  cp -f share/taxon-tools.awk /usr/local/share/awk/.

# does not shrink the image... 
# RUN pacman --noconfirm -Rs fakeroot binutils gcc make diffutils git && \
#  pacman --noconfirm -Scc

# WORKDIR /home/arch/
ENTRYPOINT ["/usr/local/bin/matchnames"]
# CMD ["-a"] ["listA"] ["-b"] ["listB"]

# EXPOSE 3000

