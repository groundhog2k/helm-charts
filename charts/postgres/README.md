# PostgreSQL

![Version: 0.1.1](https://img.shields.io/badge/Version-0.1.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 13.0](https://img.shields.io/badge/AppVersion-13.0-informational?style=flat-square)

A Helm chart for PostgreSQL on Kubernetes

## TL;DR

```bash
$ helm repo add groundhog2k https://groundhog2k.github.io/helm-charts/
$ helm install my-release groundhog2k/postgres
```

## Introduction

This chart uses the original [PostgreSQL image from Docker Hub](https://hub.docker.com/_/postgres/) to deploy a stateful PostgreSQL instance in a Kubernetes cluster.

It allows fully supports the deployment of the [ARM64v8 image of PostgreSQL](https://hub.docker.com/r/arm64v8/postres/) on a ARM64 based Kubernetes cluster just by exchanging the existing `image.repository` value.


## Prerequisites

- Kubernetes 1.12+
- Helm 3.x
- PV provisioner support in the underlying infrastructure

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install my-release groundhog2k/postgres
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
| image.repository | string | `"postgres"` | Image name |
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
| serviceAccount.annotations | object | `{}` | Additional service account annotations |
| serviceAccount.create | bool | `false` | Enable service account creation |
| serviceAccount.name | string | `""` | Name of the service account |
| affinity | object | `{}` |  |
| tolerations | list | `[]` |  |

## Service paramters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| service.port | int | `5432` | PostreSQL service port |

## Storage parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| storage.accessModes[0] | string | `"ReadWriteOnce"` | Storage access mode |
| storage.persistentVolumeClaimName | string | `""` | PVC name when existing storage volume should be used |
| storage.requestedSize | string | `""` | Size for new PVC, when no existing PVC is used |
| storage.className | string | `""` | Storage class name |

## PostgreSQL parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| arguments | string | `nil` | Arguments for the container entrypoint process |
| customConfig | string | `""` | Optional custom configuration block that will be mounted as file in /etc/postgresql/postgresql.conf |
| settings.authMethod | string | `"md5"` | Postgres database authentication method |
| settings.initDbArgs | string | `nil` | Optional init database arguments |
| settings.superuserPassword | string | `nil` | Password of superuser (Random value if not specified) |
| userDatabase | object | `{}` | Optional PostgreSQL user database |
| userDatabase.name | string | `""` | Name of the user database |
| userDatabase.user | string | `""` | User name with full access to user database|
| userDatabase.password | string | `""` | Password of created user (Random value if not specified) |
