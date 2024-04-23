# Etcd

![Version: 0.1.10](https://img.shields.io/badge/Version-0.1.10-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v3.5.13](https://img.shields.io/badge/AppVersion-v3.5.13-informational?style=flat-square)

## Changelog

see [RELEASENOTES.md](RELEASENOTES.md)

A Helm chart for a Etcd HA-cluster on Kubernetes

## TL;DR

```bash
helm repo add groundhog2k https://groundhog2k.github.io/helm-charts/
helm install my-release groundhog2k/etcd
```

## Introduction

This chart uses the original [Etcd image from Quay.io](https://quay.io/repository/coreos/etcd) to deploy a stateful Etcd cluster in Kubernetes.

It fully supports deployment of the multi-architecture docker image.

## Prerequisites

- Kubernetes 1.12+
- Helm 3.x
- PV provisioner support in the underlying infrastructure

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
helm install my-release groundhog2k/etcd
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
| image.registry | string | `"quay.io/coreos"` | Image registry |
| image.repository | string | `"etcd"` | Image name |
| image.tag | string | `""` | Image tag |
| initImage.pullPolicy | string | `"IfNotPresent"` | Init image pull policy |
| initImage.registry | string | `"docker.io"` | Image registry |
| initImage.repository | string | `"busybox"` | Init image name |
| initImage.tag | string | `"latest"` | Init image tag |
| imagePullSecrets | list | `[]` | Image pull secrets |
| extraInitContainers | list | `[]` | Extra init containers |
| extaContainers | list | `[]` | Extra containers for usage as sidecars |
| startupProbe | object | `see values.yaml` | Startup probe configuration |
| livenessProbe | object | `see values.yaml` | Liveness probe configuration |
| readinessProbe | object | `see values.yaml` | Readiness probe configuration |
| customStartupProbe | object | `{}` | Custom startup probe (overwrites default startup probe configuration) |
| customLivenessProbe | object | `{}` | Custom liveness probe (overwrites default liveness probe configuration) |
| customReadinessProbe | object | `{}` | Custom readiness probe (overwrites default readiness probe configuration) |
| resources | object | `{}` | Resource limits and requests |
| nodeSelector | object | `{}` | Deployment node selector |
| customLabels | object | `{}` | Additional labels for Deployment or StatefulSet |
| customAnnotations | object | `{}` | Additional annotations for Deployment or StatefulSet |
| podAnnotations | object | `{}` | Additional pod annotations |
| podLabels | object | `{}` | Additional pod labels |
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
| topologySpreadConstraints | object | `{}` | Topology spread constraints for pods |
| podManagementPolicy | string | `"Parallel"` | Pod management policy |
| updateStrategyType | string | `"RollingUpdate"` | Pod update strategy |
| replicas | int | `1` | Number of replicas (Due to the nature of etcd cluster initialization this value must be set before deploying the cluster) |
| revisionHistoryLimit | int | `nil` | Maximum number of revisions maintained in revision history
| podDisruptionBudget | object | `{}` | Pod disruption budget |
| podDisruptionBudget.minAvailable | int | `nil` | Minimum number of pods that must be available after eviction |
| podDisruptionBudget.maxUnavailable | int | `nil` | Maximum number of pods that can be unavailable after eviction |
| clusterDomain | string | `"cluster.local"` | Kubernetes cluster domain (DNS) suffix |

## Service parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| service.type | string | `"ClusterIP"` | Service type |
| service.clusterIP | string | `nil` | The cluster ip address (only relevant for type LoadBalancer or NodePort) |
| service.loadBalancerIP | string | `nil` | The load balancer ip address (only relevant for type LoadBalancer) |
| service.client.port | int | `2379` | Client service port |
| service.client.nodePort | int | `nil` | Service node port (only relevant for type LoadBalancer or NodePort)|
| service.peer.port | int | `2380` | Peer service port |
| service.peer.nodePort | int | `nil` | Service node port (only relevant for type LoadBalancer or NodePort)|
| service.annotations | object | `{}` | Additional service annotations |
| service.labels | object | `{}` | Additional service labels |

## Service monitor parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| serviceMonitor.enabled | bool | `false` | Enable service monitor |
| serviceMonitor.additionalLabels | object | `{}` | Additional labels for the service monitor object |
| serviceMonitor.annotations | object | `{}` | Annotations for the service monitor object |
| serviceMonitor.interval | Duration | `nil` | Scrape interval for prometheus |
| serviceMonitor.scrapeTimeout | Duration | `nil` | Scrape timeout value |
| serviceMonitor.extraEndpointParameters | object | `nil` | Extra parameters rendered to the [service monitor endpoint](https://github.com/prometheus-operator/prometheus-operator/blob/main/Documentation/api.md#endpoint) |
| serviceMonitor.extraParameters | object | `nil` | Extra parameters rendered to the [service monitor object](https://github.com/prometheus-operator/prometheus-operator/blob/main/Documentation/api.md#servicemonitorspec) |

## Network policies

Allows to define optional network policies for [ingress and egress](https://kubernetes.io/docs/concepts/services-networking/network-policies/)
The policyTypes will be automatically set

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| networkPolicy.ingress | object | `{}` | Ingress network policies |
| networkPolicy.egress | object | `{}` | Egress network policies |

## Storage parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| storage.accessModes[0] | string | `"ReadWriteOnce"` | Storage access mode |
| storage.volumeName | string | `"etcd-data"` | Internal volume name and prefix of a created PVC |
| storage.persistentVolumeClaimName | string | `nil` | PVC name when existing storage volume should be used |
| storage.requestedSize | string | `nil` | Size for new PVC, when no existing PVC is used |
| storage.className | string | `nil` | Storage class name |
| storage.annotations | object | `{}` | Additional storage annotations |
| storage.labels | object | `{}` | Additional storage labels |

## Etcd settings

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| settings.clusterToken | bool | `"etcd-cluster-0"` | Unique cluser token |
| settings.https.enabled | bool | `false` | Enable HTTPS |
| settings.https.autoTls | bool | `false` | Automatic TLS mode of etcd (TLS certs. created automaically) |
| settings.shutdownDelay | int | `3` | Delay after termination request to give etcd process time for graceful shutdown |
  
## Etcd secrets configuration

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| extraSecrets | list | `[]` | A list of additional existing secrets that will be mounted into the container |
| extraSecrets[].name | string | `nil` | Name of the existing K8s secret |
| extraSecrets[].mountPath | string | `nil` | Mount path where the secret should be mounted into the container (f.e. /mysecretfolder) |
| extraEnvSecrets | list | `[]` | A list of existing secrets that will be mounted into the container as environment variables |
