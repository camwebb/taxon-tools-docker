# docker pull archlinux
docker build -t matchnames .

docker run --rm -it -v `pwd`:`pwd` -w `pwd` matchnames -a listA -b listB -o output

# Manual, interactive:
# docker run --rm -it -v `pwd`:`pwd` -w `pwd` matchnames -a listA -b listB -o output -f

# ----
# Cool:
#   docker run -i -t archlinux /bin/bash
