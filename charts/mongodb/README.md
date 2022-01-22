# MongoDB

![Version: 0.4.1](https://img.shields.io/badge/Version-0.4.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 5.0.5](https://img.shields.io/badge/AppVersion-5.0.5-informational?style=flat-square)

## Changelog

see [RELEASENOTES.md](RELEASENOTES.md)

A Helm chart for MongoDB on Kubernetes

## TL;DR

```bash
helm repo add groundhog2k https://groundhog2k.github.io/helm-charts/
helm install my-release groundhog2k/mongodb
```

## Introduction

This chart uses the original [MongoDB image from Docker Hub](https://hub.docker.com/_/mongo/) to deploy a stateful MongoDB instance in a Kubernetes cluster.

It fully supports deployment of the multi-architecture docker image.

## Prerequisites

- Kubernetes 1.12+
- Helm 3.x
- PV provisioner support in the underlying infrastructure

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
helm install my-release groundhog2k/mongodb
```

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
helm uninstall my-release
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
| startupProbe | object | `see values.yaml` | Startup probe configuration |
| livenessProbe | object | `see values.yaml` | Liveness probe configuration |
| readinessProbe | object | `see values.yaml` | Readiness probe configuration |
| customStartupProbe | object | `{}` | Custom startup probe (overwrites default startup probe configuration) |
| customLivenessProbe | object | `{}` | Custom liveness probe (overwrites default liveness probe configuration) |
| customReadinessProbe | object | `{}` | Custom readiness probe (overwrites default readiness probe configuration) |
| resources | object | `{}` | Resource limits and requests |
| nodeSelector | object | `{}` | Deployment node selector |
| podAnnotations | object | `{}` | Additional pod annotations |
| podSecurityContext | object | `see values.yaml` | Pod security context |
| securityContext | object | `see values.yaml` | Container security context |
| env | list | `[]` | Additional container environmment variables |
| args | list | `[]` | Additional container command arguments |
| serviceAccount.annotations | object | `{}` | Additional service account annotations |
| serviceAccount.create | bool | `false` | Enable service account creation |
| serviceAccount.name | string | `""` | Name of the service account |
| affinity | object | `{}` | Pod affinity |
| tolerations | list | `[]` | Pod tolerations |
| podManagementPolicy | string | `OrderedReady` | Pod management policy |
| updateStrategyType | string | `RollingUpdate` | Update strategy |
| revisionHistoryLimit | int | `nil` | Maximum number of revisions maintained in revision history

## Service paramters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| service.type | string | `"ClusterIP"` | Service type |
| service.port | int | `27017` | MongoDB service port |
| service.nodePort | int | `nil` | The node port (only relevant for type LoadBalancer or NodePort) |
| service.clusterIP | string | `nil` | The cluster ip address (only relevant for type LoadBalancer or NodePort) |
| service.loadBalancerIP | string | `nil` | The load balancer ip address (only relevant for type LoadBalancer) |
| service.annotations | object | `{}` | Additional service annotations |

## Storage parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| storage.accessModes[0] | string | `"ReadWriteOnce"` | Storage access mode |
| storage.persistentVolumeClaimName | string | `nil` | PVC name when existing storage volume should be used |
| storage.requestedSize | string | `nil` | Size for new PVC, when no existing PVC is used |
| storage.className | string | `nil` | Storage class name |

## MongoDB parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| customConfig | string | `nil` | Custom MongoDB configuration block that will be mounted as file in /etc/mongo/custom.conf |
| settings.rootUsername | string | `admin` | The root username |
| settings.rootPassword | string | `{}` | The root users password (Random value if not specified) |
| userDatabase | object | `{}` | Optional MongoDB user database |
| userDatabase.name | string | `nil` | Name of the user database |
| userDatabase.user | string | `nil` | User name with full access to user database|
| userDatabase.password | string | `nil` | Password of created user (Random value if not specified) |
