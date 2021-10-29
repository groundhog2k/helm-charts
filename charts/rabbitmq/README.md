# RabbitMQ

![Version: 0.4.0](https://img.shields.io/badge/Version-0.4.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 3.9.8](https://img.shields.io/badge/AppVersion-3.9.8-informational?style=flat-square)

A Helm chart for a RabbitMQ cluster on Kubernetes

## TL;DR

```bash
$ helm repo add groundhog2k https://groundhog2k.github.io/helm-charts/
$ helm install my-release groundhog2k/rabbitmq
```

## Introduction

This chart uses the original [RabbitMQ image from Docker Hub](https://hub.docker.com/_/rabbitmq) to deploy a stateful RabbitMQ cluster in Kubernetes.

It fully supports deployment of the multi-architecture docker image.

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
| image.repository | string | `"rabbitmq"` | Image name |
| image.tag | string | `""` | Image tag |
| imagePullSecrets | list | `[]` | Image pull secrets |
| livenessProbe | object | `see values.yaml` | Liveness probe configuration |
| readinessProbe | object | `see values.yaml` | Readiness probe configuration |
| customLivenessProbe | object | `{}` | Custom liveness probe (overwrites default liveness probe configuration) |
| customReadinessProbe | object | `{}` | Custom readiness probe (overwrites default readiness probe configuration) |
| resources | object | `{}` | Resource limits and requests |
| nodeSelector | object | `{}` | Deployment node selector |
| podAnnotations | object | `{}` | Additional pod annotations |
| podSecurityContext | object | `see values.yaml` | Pod security context |
| securityContext | object | `see values.yaml` | Container security context |
| env | list | `[]` | Additional container environmment variables |
| args | list | `[]` | Additional container command arguments |
| rbac.create | bool | `true` | Enable creation of RBAC |
| serviceAccount.annotations | object | `{}` | Additional service account annotations |
| serviceAccount.create | bool | `true` | Enable service account creation |
| serviceAccount.name | string | `""` | Optional name of the service account |
| affinity | object | `{}` | Affinity for pod assignment |
| tolerations | list | `[]` | Tolerations for pod assignment |
| podManagementPolicy | string | `"OrderedReady"` | Pod management policy |
| updateStrategyType | string | `"RollingUpdate"` | Pod update strategy |
| replicaCount | int | `1` | Number of replicas |
| revisionHistoryLimit | int | `nil` | Maximum number of revisions maintained in revision history
| podDisruptionBudget | object | `{}` | Pod disruption budget |
| podDisruptionBudget.minAvailable | int | `nil` | Minimum number of pods that must be available after eviction |
| podDisruptionBudget.maxUnavailable | int | `nil` | Maximum number of pods that can be unavailable after eviction |

## Service paramters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| service.type | string | `"ClusterIP"` | Service type |
| service.clusterIP | string | `nil` | The cluster ip address (only relevant for type LoadBalancer or NodePort) |
| service.loadBalancerIP | string | `nil` | The load balancer ip address (only relevant for type LoadBalancer) |
| service.amqp.port | int | `5672` | AMQP port |
| service.amqp.nodePort | int | `nil` | Service node port (only relevant for type LoadBalancer or NodePort)|
| service.mgmt.port | int | `15672` | Management UI port |
| service.mgmt.nodePort | int | `nil` | Service node port (only relevant for type LoadBalancer or NodePort) |

## Storage parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| storage.accessModes[0] | string | `"ReadWriteOnce"` | Storage access mode |
| storage.persistentVolumeClaimName | string | `nil` | PVC name when existing storage volume should be used |
| storage.requestedSize | string | `nil` | Size for new PVC, when no existing PVC is used |
| storage.className | string | `nil` | Storage class name |

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
| authentication.password | string | `"guest"` | Initial password |
| authentication.user | string | `"guest"` | Initial user name |
| clusterDomain | string | `"cluster.local"` | Kubernetes cluster domain (DNS) suffix |
| clustering.addressType | string | `"hostname"` | Address type for cluster usage (hostname or ip) |
| clustering.rebalance | bool | `true` | Enable rebalance queues with master when new replica is created |
| options.memoryHighWatermark.enabled | bool | `false` | Enable high memory watermark |
| options.memoryHighWatermark.type | string | `"relative"` | Type of watermark (relative or absolute) |
| options.memoryHighWatermark.value | float | `0.4` | Watermark value (default: 40%) |
| plugins | list | `[]` | List of additional RabbitMQ plugins that should be activated |
