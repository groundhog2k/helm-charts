# RabbitMQ

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 3.8.5](https://img.shields.io/badge/AppVersion-3.8.5-informational?style=flat-square)

A Helm chart for a RabbitMQ cluster on Kubernetes

## TL;DR

```bash
$ helm repo add groundhog2k https://groundhog2k.github.io/helm-charts/
$ helm install my-release groundhog2k/rabbitmq
```

## Introduction

This chart uses the original [RabbitMQ image from Docker Hub](https://hub.docker.com/_/rabbitmq) to deploy a stateful RabbitMQ cluster in Kubernetes.

It allows fully supports the deployment of the [ARM64v8 image of RabbitMQ](https://hub.docker.com/r/arm64v8/rabbitmq) on a ARM64 based Kubernetes cluster just by exchanging the existing `image.repository` value.


## Prerequisites

- Kubernetes 1.12+
- Helm 3.x
- PV provisioner support in the underlying infrastructure

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install my-release groundhog2k/rabbitmq
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
| rbac.create | bool | `true` | Enable creation of RBAC |
| serviceAccount.create | bool | `false` | Enable service account creation |
| serviceAccount.name | string | `""` | Optional name of the service account |
| affinity | object | `{}` | Affinity for pod assignment |
| tolerations | list | `[]` | Tolerations for pod assignment |
| podManagementPolicy | string | `"OrderedReady"` | Pod management policy |
| updateStrategyType | string | `"RollingUpdate"` | Pod update strategy |
| replicaCount | int | `1` | Number of replicas |

## Service paramters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| service.amqp.port | int | `5672` | AMQP port |
| service.mgmt.port | int | `15672` | Management UI port |

## Storage parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| storage.accessModes[0] | string | `"ReadWriteOnce"` | Storage access mode |
| storage.persistentVolumeClaimName | string | `""` | PVC name when existing storage volume should be used |
| storage.requestedSize | string | `""` | Size for new PVC, when no existing PVC is used |
| storage.className | string | `""` | Storage class name |

## Ingress parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| ingress.enabled | bool | `false` | Enable ingress for the Management UI service |
| ingress.annotations | string | `nil` | Additional annotations for ingress |
| ingress.hosts[0].host: | string | `""` | Hostname for the ingress endpoint |
| ingress.hosts[0].host.paths[0] | string | `"/"` | Path for the RabbitMQ Management UI |

## RabbitMQ parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| authentication.erlangCookie | string | `nil` | Erlang cookie (default: Random base64 value) |
| authentication.password | string | `nil` | Initial password (default: random alphanumeric 10 characters) |
| authentication.user | string | `"admin"` | Initial user name |
| clusterDomain | string | `"cluster.local"` | Kubernetes cluster domain (DNS) suffix |
| clustering.addressType | string | `"hostname"` | Address type for cluster usage (hostname or ip) |
| clustering.rebalance | bool | `true` | Enable rebalance queues with master when new replica is created |
| options.memoryHighWatermark.enabled | bool | `false` | Enable high memory watermark |
| options.memoryHighWatermark.type | string | `"relative"` | Type of watermark (relative or absolute) |
| options.memoryHighWatermark.value | float | `0.4` | Watermark value (default: 40%) |
| plugins | string | `"rabbitmq_management,rabbitmq_peer_discovery_k8s"` | RabbitMQ plugins (Remove rabbitmq_peer_discovery_k8s to disable cluster replication mode) |
