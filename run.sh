
# # Archlinux. Final build is ~350MB
# docker build -t matchnames -f archlinux/Dockerfile .
# docker run --rm -it -v `pwd`:`pwd` -w `pwd` matchnames -a listA -b listB -o output
# # Manual, interactive:
# docker run --rm -it -v `pwd`:`pwd` -w `pwd` matchnames -a listA -b listB -o output -f

# Alpinelinux. Final build is ~10MB
# docker run -it alpine:latest   # Easy as that!!
docker build -t taxon-tools:v1.3.0 .

# Run matchnames
docker run --rm -it -v `pwd`:`pwd` -w `pwd` taxon-tools:v1.3.0 matchnames -a listA -b listB -o output
# Manual, interactive:
# docker run --rm -it -v `pwd`:`pwd` -w `pwd` taxon-tools:v1.3.0 matchnames -a listA -b listB -o output -f

# Run parsenames
docker run --rm -it -v `pwd`:`pwd` -w `pwd` taxon-tools:v1.3.0 parsenames names

# Push to Docker Hub
# docker login
# docker tag taxon-tools:v1.3.0 camwebb/taxon-tools:v1.3.0
# docker push camwebb/taxon-tools:v1.3.0

# Clean
# docker images -a -q | xargs docker rmi -f
