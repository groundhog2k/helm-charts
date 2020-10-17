# Redis

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 6.0.8](https://img.shields.io/badge/AppVersion-6.0.8-informational?style=flat-square)

A Helm chart for Redis on Kubernetes

## TL;DR

```bash
$ helm repo add groundhog2k https://groundhog2k.github.io/helm-charts/
$ helm install my-release groundhog2k/redis
```

## Introduction

This chart uses the original [Redis image from Docker Hub](https://hub.docker.com/_/redis/) to deploy a stateful Redis instance in a Kubernetes cluster.

It allows fully supports the deployment of the [ARM64v8 image of Redis](https://hub.docker.com/r/arm64v8/redis/) on a ARM64 based Kubernetes cluster just by exchanging the existing `image.repository` value.


## Prerequisites

- Kubernetes 1.12+
- Helm 3.x
- PV provisioner support in the underlying infrastructure

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install my-release groundhog2k/redis
```

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm uninstall my-release
```

## Common parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| fullnameOverride | string | `""` | Fully override the deployment name |
| nameOverride | string | `""` | Partially override the deployment name |

## Deployment parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| image.repository | string | `"mariadb"` | Image name |
| image.tag | string | `""` | Image tag |
| imagePullSecrets | list | `[]` | Image pull secrets |
| livenessProbe | object | `see values.yaml` | Liveness probe configurationm |
| readinessProbe | object | `see values.yaml` | Readiness probe configuration |
| resources | object | `{}` | Resource limits and requests |
| nodeSelector."kubernetes.io/arch" | string | `"amd64"` | Deployment node selector |
| podAnnotations | object | `{}` | Additional pod annotations |
| podSecurityContext | object | `{}` | Pod security context |
| securityContext | object | `see values.yaml` | Container security context |
| env | object | `[]` | Additional container environmment variables |
| serviceAccount.annotations | object | `{}` | Additional service account annotations |
| serviceAccount.create | bool | `false` | Enable service account creation |
| serviceAccount.name | string | `""` | Name of the service account |
| affinity | object | `{}` | Affinity for pod assignment |
| tolerations | list | `[]` | Tolerations for pod assignment |

## Service paramters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| service.port | int | `6379` | Redis service port |

## Storage parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| storage.accessModes[0] | string | `"ReadWriteOnce"` | Storage access mode |
| storage.persistentVolumeClaimName | string | `""` | PVC name when existing storage volume should be used |
| storage.requestedSize | string | `""` | Size for new PVC, when no existing PVC is used |
| storage.className | string | `""` | Storage class name |

## Redis parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| arguments | string | `nil` | Arguments for the container entrypoint process |
| redisConfig | string | `""` | Custom redis.conf |
