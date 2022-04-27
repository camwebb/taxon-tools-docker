


# docker pull archlinux

docker build -t matchnames .

# Not working!
docker run -v $(pwd):$(pwd) -w /home/arch --rm -i -t matchnames -a /home/arch/listA -b /home/arch/listB


# Cool:
#   docker run -i -t archlinux /bin/bash
# docker images
