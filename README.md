# Docker-Opengrok : Host opengrok on Docker.

## How to build opengrok on ubuntu container
```
$ docker build -t ranjithum/opengrok-ubuntu -f Dockerfile.ubuntu .
```

## How to build opengrok on centos8 container
```
$ docker build -t ranjithum/opengrok-centos -f Dockerfile.centos .
```

## How to tag a image
```
$ docker tag <Iamge-Id> ranjithum/opengrok:centos8
$ docker tag <Iamge-Id> ranjithum/opengrok:ubuntu18
```

## Push the image to docker hub
```
$ docker login docker.io
$ docker push ranjithum/opengrok:centos8
$ docker push ranjithum/opengrok:ubuntu18
```
