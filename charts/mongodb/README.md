# MongoDB

![Version: 0.2.0](https://img.shields.io/badge/Version-0.2.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 4.2.11](https://img.shields.io/badge/AppVersion-4.2.11-informational?style=flat-square)

A Helm chart for MongoDB on Kubernetes

## TL;DR

```bash
$ helm repo add groundhog2k https://groundhog2k.github.io/helm-charts/
$ helm install my-release groundhog2k/mongodb
```

## Introduction

This chart uses the original [MongoDB image from Docker Hub](https://hub.docker.com/_/mongo/) to deploy a stateful MongoDB instance in a Kubernetes cluster.

It fully supports deployment of arm64v8 and amd64 multi-architecture docker image. Just set the `nodeSelector` value to `kubernetes.io/arch: "arm64"` (default is `"amd64"`)

## Prerequisites

- Kubernetes 1.12+
- Helm 3.x
- PV provisioner support in the underlying infrastructure

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install my-release groundhog2k/mongodb
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
| image.repository | string | `"mongo"` | Image name |
| image.tag | string | `""` | Image tag |
| imagePullSecrets | list | `[]` | Image pull secrets |
| livenessProbe | object | `see values.yaml` | Liveness probe configuration |
| readinessProbe | object | `see values.yaml` | Readiness probe configuration |
| resources | object | `{}` | Resource limits and requests |
| nodeSelector."kubernetes.io/arch" | string | `"amd64"` | Deployment node selector |
| podAnnotations | object | `{}` | Additional pod annotations |
| podSecurityContext | object | `see values.yaml` | Pod security context |
| securityContext | object | `see values.yaml` | Container security context |
| env | list | `[]` | Additional container environmment variables |
| args | object | `{}` | Additional container command arguments |
| serviceAccount.annotations | object | `{}` | Additional service account annotations |
| serviceAccount.create | bool | `false` | Enable service account creation |
| serviceAccount.name | string | `""` | Name of the service account |
| affinity | object | `{}` | Pod affinity |
| tolerations | list | `[]` | Pod tolerations |
| podManagementPolicy | string | `OrderedReady` | Pod management policy |
| updateStrategyType | string | `RollingUpdate` | Update strategy |
| replicaCount | int | `1` | Number of replicas (Not supported - Don't change in this chart version) |

## Service paramters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| service.port | int | `27017` | MongoDB service port |

## Storage parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| storage.accessModes[0] | string | `"ReadWriteOnce"` | Storage access mode |
| storage.persistentVolumeClaimName | string | `""` | PVC name when existing storage volume should be used |
| storage.requestedSize | string | `""` | Size for new PVC, when no existing PVC is used |
| storage.className | string | `""` | Storage class name |

## MongoDB parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| settings.customConfig | string | `""` | Custom MongoDB configuration block that will be mounted as file in /etc/mongo/custom.conf |
| settings.rootUsername | string | `admin` | The root username |
| settings.rootPassword | string | `{}` | The root users password (Random value if not specified) |
| initUserDatabase | object | `{}` | Optional user database initialization script support |
| initUserDatabase.dbName | string | `""` | Name of the user database |
| initUserDatabase.script | string | `""` | Javascript block to initialize the user database |
