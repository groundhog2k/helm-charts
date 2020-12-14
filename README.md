# helm-charts
Helm charts for some famous open source projects - ready to use in your Kubernetes environment

## TL;DR

```bash
$ helm repo add groundhog2k https://groundhog2k.github.io/helm-charts/
$ helm repo update
```

## Introduction

This repository contains various helm charts for some famous open source projects.
Goal was to create some universal charts that use the original docker images from [Docker Hub](https://hub.docker.com) instead of the modified version which Bitnami offers.

The advantage is that most of these charts are platform independent and will run on x64/amd64 and arm64v8 (Raspberry Pi 3/4) Kubernetes clusters.

## Prerequisites

- Helm 3.x

## Adding this helm repository

To add this repository to the helm configuration:

```bash
$ helm repo add groundhog2k https://groundhog2k.github.io/helm-charts/
```

## Using this helm repository

To install a chart from this repository (example with Redis):

```bash
$ helm install my-redis groundhog2k/redis
```

## Removing this helm repository

To remove the helm repository from helm configuration:

```bash
$ helm repo remove groundhog2k
```
