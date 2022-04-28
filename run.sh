
# # Archlinux. Final build is ~350MB
# docker build -t matchnames -f archlinux/Dockerfile .
# docker run --rm -it -v `pwd`:`pwd` -w `pwd` matchnames -a listA -b listB -o output
# # Manual, interactive:
# docker run --rm -it -v `pwd`:`pwd` -w `pwd` matchnames -a listA -b listB -o output -f

# Alpinelinux. Final build is ~10MB
# docker run -it alpine:latest   # Easy as that!!
docker build -t matchnames:alpine .
docker run --rm -it -v `pwd`:`pwd` -w `pwd` matchnames:alpine -a listA -b listB -o output
# Manual, interactive:
docker run --rm -it -v `pwd`:`pwd` -w `pwd` matchnames:alpine -a listA -b listB -o output -f

# Clean
# docker images -a -q | xargs docker rmi -f
