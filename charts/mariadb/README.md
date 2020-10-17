# MariaDB

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 10.4.14](https://img.shields.io/badge/AppVersion-10.4.14-informational?style=flat-square)

A Helm chart for MariaDB on Kubernetes

## TL;DR

```bash
$ helm repo add groundhog2k https://groundhog2k.github.io/helm-charts/
$ helm install my-release groundhog2k/mariadb
```

## Introduction

This chart uses the original [MariaDB image from Docker Hub](https://hub.docker.com/_/mariadb) to deploy a stateful MariaDB instance in a Kubernetes cluster.

It allows fully supports the deployment of the [ARM64v8 image of MariaDB](https://hub.docker.com/r/arm64v8/mariadb) on a ARM64 based Kubernetes cluster just by exchanging the existing `image.repository` value.


## Prerequisites

- Kubernetes 1.12+
- Helm 3.x
- PV provisioner support in the underlying infrastructure

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install my-release groundhog2k/mariadb
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
| livenessProbe | object | `see values.yaml` | Liveness probe configuration |
| readinessProbe | object | `see values.yaml` | Readiness probe configuration |
| resources | object | `{}` | Resource limits and requests |
| nodeSelector."kubernetes.io/arch" | string | `"amd64"` | Deployment node selector |
| podAnnotations | object | `{}` | Additional pod annotations |
| podSecurityContext | object | `{}` | Pod security context |
| securityContext | object | `see values.yaml` | Container security context |
| env | list | `[]` | Additional container environmment variables |
| serviceAccount.annotations | object | `{}` | Additional service account annotations |
| serviceAccount.create | bool | `false` | Enable service account creation |
| serviceAccount.name | string | `""` | Name of the service account |
| affinity | object | `{}` | Affinity for pod assignment |
| tolerations | list | `[]` | Tolerations for pod assignment |

## Service paramters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| service.port | int | `3306` | MariaDB service port |

## Storage parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| storage.accessModes[0] | string | `"ReadWriteOnce"` | Storage access mode |
| storage.persistentVolumeClaimName | string | `""` | PVC name when existing storage volume should be used |
| storage.requestedSize | string | `""` | Size for new PVC, when no existing PVC is used |
| storage.className | string | `""` | Storage class name |

## MariaDB parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| userDatabase | object | `{}` | Optional MariaDB user database |
| userDatabase.name | string | `""` | Name of the user database |
| userDatabase.user | string | `""` | User name with full access to user database|
| userDatabase.password | string | `""` | Password of created user (Random value if not specified) |
| settings.rootPassword | string | `nil` | MariaDB root password (Random value if not specified) |
| settings.arguments | string | `nil` | Additional arguments for mysqld (entrypoint process) |
| customConfig | string | `""` | Additional MariaDB custom configuration mounted as custom.cnf |
