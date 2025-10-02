# Wordpress

![Version: 0.14.4](https://img.shields.io/badge/Version-0.14.4-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 6.8.3-apache](https://img.shields.io/badge/AppVersion-6.8.3--apache-informational?style=flat-square)

## Changelog

see [RELEASENOTES.md](RELEASENOTES.md)

A Helm chart for Wordpress on Kubernetes

## TL;DR

```bash
helm repo add groundhog2k https://groundhog2k.github.io/helm-charts/
helm install my-release groundhog2k/wordpress
```

## Introduction

This chart uses the original [Wordpress from Docker](https://hub.docker.com/_/wordpress) to deploy Wordpress in Kubernetes.

It fully supports deployment of the multi-architecture docker image.

## Prerequisites

- Kubernetes 1.12+
- Helm 3.x
- PV provisioner support in the underlying infrastructure

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
helm install my-release groundhog2k/wordpress
```

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
helm uninstall my-release
```

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| @groundhog2k | mariadb | 0.3.14 |

## Common parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| fullnameOverride | string | `""` | Fully override the deployment name |
| nameOverride | string | `""` | Partially override the deployment name |

## Deployment parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| image.registry | string | `"docker.io"` | Image registry |
| image.repository | string | `"wordpress"` | Image name |
| image.tag | string | `""` | Image tag |
| imagePullSecrets | list | `[]` | Image pull secrets |
| extraInitContainers | list | `[]` | Extra init containers |
| extaContainers | list | `[]` | Extra containers for usage as sidecars |
| strategy | object | `{}` | Pod deployment strategy |
| livenessProbe | object | `see values.yaml` | Liveness probe configuration |
| startupProbe | object | `see values.yaml` | Startup probe configuration |
| readinessProbe | object | `see values.yaml` | Readiness probe configuration |
| customLivenessProbe | object | `{}` | Custom liveness probe (overwrites default liveness probe configuration) |
| customStartupProbe | object | `{}` | Custom startup probe (overwrites default startup probe configuration) |
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
| args | list | `[]` | Arguments for the container entrypoint process |
| serviceAccount.create | bool | `false` | Enable service account creation |
| serviceAccount.name | string | `""` | Optional name of the service account |
| serviceAccount.annotations | object | `{}` | Additional service account annotations |
| affinity | object | `{}` | Affinity for pod assignment |
| tolerations | list | `[]` | Tolerations for pod assignment |
| topologySpreadConstraints | object | `{}` | Topology spread constraints for pods |
| containerPort | int | `8000` | Internal http container port |
| replicaCount | int | `1` | Number of replicas (ignored when autoscaling is enabled) |
| revisionHistoryLimit | int | `nil` | Maximum number of revisions maintained in revision history
| podDisruptionBudget | object | `{}` | Pod disruption budget |
| podDisruptionBudget.minAvailable | int | `nil` | Minimum number of pods that must be available after eviction |
| podDisruptionBudget.maxUnavailable | int | `nil` | Maximum number of pods that can be unavailable after eviction |
| autoscaling.enabled | bool | `false` | Enable horizontal pod autoscaler |
| autoscaling.minReplicas | int | `1` | Minimum number of replicas |
| autoscaling.maxReplicas | int | `10` | Maximum number of replicas |
| autoscaling.targetCPUUtilizationPercentage | int | `80` | Target CPU utilization percentage |
| autoscaling.targetMemoryUtilizationPercentage | int | `nil` | Target memory utilization percentage |
| autoscaling.annotations | object | `{}` | Additional HPA annotations |
| autoscaling.behavior | object | `{}` | HPA behavior configuration |

## Service paramters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| service.port | int | `80` | Wordpress HTTP service port |
| service.type | string | `"ClusterIP"` | Service type |
| service.nodePort | int | `nil` | The node port (only relevant for type LoadBalancer or NodePort) |
| service.clusterIP | string | `nil` | The cluster ip address (only relevant for type LoadBalancer or NodePort) |
| service.loadBalancerIP | string | `nil` | The load balancer ip address (only relevant for type LoadBalancer) |
| service.loadBalancerSourceRanges | list | `[]` | The list of IP CIDR ranges that are allowed to access the load balancer (only relevent for type LoadBalancer) |
| service.annotations | object | `{}` | Additional service annotations |
| service.labels | object | `{}` | Additional service labels |

## Ingress parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| ingress.enabled | bool | `false` | Enable ingress for Wordpress service |
| ingress.className | string | `nil` | Optional ingress class name |
| ingress.annotations | object | `{}` | Additional annotations for ingress |
| ingress.labels | object | `{}` | Additional ingress lables |
| ingress.hosts[0].host | string | `""` | Hostname for the ingress endpoint |
| ingress.hosts[0].host.paths[0].path | string | `"/"` | Default root path |
| ingress.hosts[0].host.paths[0].pathType | string | `ImplementationSpecific` | Ingress path type (ImplementationSpecific, Prefix, Exact) |
| ingress.tls | list | `[]` | Ingress TLS parameters |
| ingress.maxBodySize | string | `"64m"` | Maximum body size for post requests |

## Network policies

Allows to define optional network policies for [ingress and egress](https://kubernetes.io/docs/concepts/services-networking/network-policies/)
The policyTypes will be automatically set

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| networkPolicy.ingress | object | `{}` | Ingress network policies |
| networkPolicy.egress | object | `{}` | Egress network policies |

## Database settings

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| externalDatabase.host | string | `nil` | External database host |
| externalDatabase.name | string | `"wordpress"` | External database name |
| externalDatabase.user | string | `nil` | External database user name |
| externalDatabase.password | string | `nil` | External database user password |
| mariadb.enabled | bool | `false` | Enable MariaDB deployment (will disable external database settings) |
| mariadb.settings.rootPassword | string | `nil` | MariaDB root user password |
| mariadb.storage | string | `nil` | MariaDB storage settings |
| mariadb.userDatabase.name | string | `nil` | MariaDB wordpress database name |
| mariadb.userDatabase.password | string | `nil` | MariaDB wordpress database user |
| mariadb.userDatabase.user | string | `nil` | MariaDB wordpress database user password |

## Wordpress parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| apacheDefaultSiteConfig | string | `""` | Overwrite default apache 000-default.conf |
| apachePortsConfig | string | `""` | Overwrite default apache ports.conf |
| customPhpConfig | string | `""` | Additional PHP custom.ini |
| settings.tablePrefix | string | `nil` | Database table name prefix |
| settings.maxFileUploadSize | string | `64M` | Maximum file upload size |
| settings.memoryLimit | string | `128M` | PHP memory limit |
| settings.configExtra | string | `nil` | Extra values embedded inside wp-config.php |
| extraEnvSecrets | list | `[]` | A list of existing secrets that will be mounted into the container as environment variables |
| extraEnvConfigs | list | `[]` | A list of existing configmaps that will be mounted into the container as environment variables |
| extraSecrets | list | `[]` | A list of additional existing secrets that will be mounted into the container |

## Storage parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| storage.accessModes[0] | string | `"ReadWriteOnce"` | Storage access mode |
| storage.persistentVolumeClaimName | string | `nil` | PVC name when existing storage volume should be used |
| storage.requestedSize | string | `nil` | Size for new PVC, when no existing PVC is used |
| storage.className | string | `nil` | Storage class name |
| storage.keepPvc | bool | `false` | Keep a created Persistent volume claim when uninstalling the helm chart |
| storage.annotations | object | `{}` | Additional storage annotations |
| storage.labels | object | `{}` | Additional storage labels |
