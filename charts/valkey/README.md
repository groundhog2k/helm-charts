# Valkey

![Version: 2.1.1](https://img.shields.io/badge/Version-2.1.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 8.1.2](https://img.shields.io/badge/AppVersion-8.1.2-informational?style=flat-square)

## Changelog

see [RELEASENOTES.md](RELEASENOTES.md)

A Helm chart for Valkey on Kubernetes

## TL;DR

```bash
helm repo add groundhog2k https://groundhog2k.github.io/helm-charts/
helm install my-release groundhog2k/valkey
```

### Basic setup without high availability

`haMode.enabled: false`

This will create one standalone Valkey instance which can be reached based on the `service:` configuration (ClusterIP & Port 6379 by default)

```draw
+-------------------+
| Valkey standalone  |
+-------------------+
```

### Advanced setup with high availability support

`haMode.enabled: true`

This will create 3 pods by default, with 1 Valkey master (M1) and 2 Valkey replications (R1/R2). Every pod has 2 containers, one for the Valkey server and one for the Valkey sentinel (S1/S2/S3).
The default quorom to decide for a new master is set to 2. Have a look at all configurable parameters in values section `haMode:`

A Sentinal instance can be reached based on the `service:` configuration (ClusterIP & Sentinel port 26379 by default).

```draw
       +----+
       | M1 |
       | S1 |
       +----+
          |
+----+    |    +----+
| V2 |----+----| V3 |
| S2 |         | S3 |
+----+         +----+
```

## Introduction

This chart uses the original [Valkey image from Docker Hub](https://hub.docker.com/r/valkey/valkey) to deploy a stateful Valkey instance in a Kubernetes cluster.

It fully supports deployment of the multi-architecture docker image.

## Prerequisites

- Kubernetes 1.12+
- Helm 3.x
- PV provisioner support in the underlying infrastructure

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
helm install my-release groundhog2k/valkey
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
| image.registry | string | `"docker.io"` | Image registry |
| image.repository | string | `"valkey/valkey"` | Image name |
| image.tag | string | `""` | Image tag |
| imagePullSecrets | list | `[]` | Image pull secrets |
| extraInitContainers | list | `[]` | Extra init containers |
| extaContainers | list | `[]` | Extra containers for usage as sidecars |
| livenessProbe | object | `see values.yaml` | Liveness probe configuration |
| startupProbe | object | `see values.yaml` | Startup probe configuration |
| readinessProbe | object | `see values.yaml` | Readiness probe configuration |
| customLivenessProbe | object | `{}` | Custom liveness probe (overwrites default liveness probe configuration) |
| customStartupProbe | object | `{}` | Custom startup probe (overwrites default startup probe configuration) |
| customReadinessProbe | object | `{}` | Custom readiness probe (overwrites default readiness probe configuration) |
| initResources | object | `{}` | Resource limits and requests for the default init container |
| resources | object | `{}` | Resource limits and requests |
| sentinelResources | object | `{}` | Resource limits and requests (for Valkey Sentinel - only when haMode is enabled) |
| nodeSelector | object | `{}` | Deployment node selector |
| customLabels | object | `{}` | Additional labels for Deployment or StatefulSet |
| customAnnotations | object | `{}` | Additional annotations for Deployment or StatefulSet |
| podAnnotations | object | `{}` | Additional pod annotations |
| podLabels | object | `{}` | Additional pod labels |
| podSecurityContext | object | `see values.yaml` | Pod security context |
| securityContext | object | `see values.yaml` | Container security context |
| env | list | `[]` | Additional container environmment variables (Valkey server, Sentinel and Init container) |
| args | list | `[]` | Additional container command arguments (Valkey server) |
| sentinelArgs | list | `[]` | Arguments for the container entrypoint process (Sentinel) |
| serviceAccount.annotations | object | `{}` | Additional service account annotations |
| serviceAccount.create | bool | `false` | Enable service account creation |
| serviceAccount.name | string | `""` | Name of the service account |
| affinity | object | `{}` | Affinity for pod assignment |
| tolerations | list | `[]` | Tolerations for pod assignment |
| topologySpreadConstraints | object | `{}` | Topology spread constraints for pods |
| podManagementPolicy | string | `"OrderedReady"` | Pod management policy |
| updateStrategyType | string | `"RollingUpdate"` | Pod update strategy |
| revisionHistoryLimit | int | `nil` | Maximum number of revisions maintained in revision history
| podDisruptionBudget | object | `{}` | Pod disruption budget |
| podDisruptionBudget.minAvailable | int | `nil` | Minimum number of pods that must be available after eviction |
| podDisruptionBudget.maxUnavailable | int | `nil` | Maximum number of pods that can be unavailable after eviction |

## Metrics support parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| metrics.enabled | bool | `false` | Enable metrics support  |
| metrics.exporter.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| metrics.exporter.image.registry | string | `"docker.io"` | Image registry |
| metrics.exporter.image.repository | string | `"oliver006/redis_exporter"` | Image name |
| metrics.exporter.image.tag | string | `"v1.59.0"` | Image tag |
| metrics.exporter.resources | object | `{}` | Resource limits and requests |
| metrics.exporter.livenessProbe | object | `see values.yaml` | Liveness probe configuration |
| metrics.exporter.startupProbe | object | `see values.yaml` | Startup probe configuration |
| metrics.exporter.readinessProbe | object | `see values.yaml` | Readiness probe configuration |
| metrics.exporter.customLivenessProbe | object | `{}` | Custom liveness probe (overwrites default liveness probe configuration) |
| metrics.exporter.customStartupProbe | object | `{}` | Custom startup probe (overwrites default startup probe configuration) |
| metrics.exporter.customReadinessProbe | object | `{}` | Custom readiness probe (overwrites default readiness probe configuration) |
| metrics.exporter.env | list | `[]` | Additional container environmment variables (Exporter only) |
| metrics.exporter.args | list | `[]` | Additional container command arguments (Exporter only) |
| metrics.exporter.extraExporterEnvSecrets | list | `[]` | A list of existing secrets that will be mounted into the exporter container as environment variables |
| metrics.exporter.extraExporterSecrets | list | `[]` | A list of additional existing secrets that will be mounted into the exporter container |
| metrics.exporter.extraExporterSecrets[].name | string | `nil` | Name of the existing K8s secret |
| metrics.exporter.extraExporterSecrets[].defaultMode | int | `0440` | Mount default access mode |
| metrics.exporter.extraExporterSecrets[].mountPath | string | `nil` | Mount path where the secret should be mounted into the container (f.e. /mysecretfolder) |
| metrics.exporter.extraExporterConfigs[].name | string | `nil` | Name of the existing K8s configMap |
| metrics.exporter.extraExporterConfigs[].defaultMode | int | `0440` | Mount default access mode |
| metrics.exporter.extraExporterConfigs[].mountPath | string | `nil` | Mount path where the configMap should be mounted into the container (f.e. /myconfigfolder) |
| metrics.service.type | string | `"ClusterIP"` | Service type (not available when haMode is enabled) |
| metrics.service.servicePort | int | `9121` | Valkey metrics exporter service port |
| metrics.service.containerPort | int | `9121` | Valkey metrics exporter container port |
| metrics.service.nodePort | int | `nil` | The node port (only relevant for type LoadBalancer or NodePort - not available when haMode is enabled) |
| metrics.service.clusterIP | string | `nil` | The cluster ip address (only relevant for type LoadBalancer or NodePort) |
| metrics.service.loadBalancerIP | string | `nil` | The load balancer ip address (only relevant for type LoadBalancer - not available when haMode is enabled) |
| metrics.service.annotations | object | `{}` | Additional service annotations |
| metrics.service.lables | object | `{}` | Additional service labels |
| metrics.serviceMonitor.additionalLabels | object | `{}` | Additional labels for the service monitor object |
| metrics.serviceMonitor.annotations | object | `{}` | Annotations for the service monitor object |
| metrics.serviceMonitor.interval | Duration | `nil` | Scrape interval for prometheus |
| metrics.serviceMonitor.scrapeTimeout | Duration | `nil` | Scrape timeout value |
| metrics.serviceMonitor.extraEndpointParameters | object | `nil` | Extra parameters rendered to the [service monitor endpoint](https://github.com/prometheus-operator/prometheus-operator/blob/main/Documentation/api.md#endpoint) |
| metrics.serviceMonitor.extraParameters | object | `nil` | Extra parameters rendered to the [service monitor object](https://github.com/prometheus-operator/prometheus-operator/blob/main/Documentation/api.md#servicemonitorspec) |

## Service parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| service.type | string | `"ClusterIP"` | Service type (not available when haMode is enabled) |
| service.serverPort | int | `6379` | Valkey server service port |
| service.sentinelPort | int | `26379` | Valkey sentinel service port |
| service.nodePort | int | `nil` | The node port (only relevant for type LoadBalancer or NodePort - not available when haMode is enabled) |
| service.clusterIP | string | `nil` | The cluster ip address (only relevant for type LoadBalancer or NodePort) |
| service.loadBalancerIP | string | `nil` | The load balancer ip address (only relevant for type LoadBalancer - not available when haMode is enabled) |
| service.annotations | object | `{}` | Additional service annotations |
| service.lables | object | `{}` | Additional service labels |

## Storage parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| storage.accessModes[0] | string | `"ReadWriteOnce"` | Storage access mode |
| storage.persistentVolumeClaimName | string | `nil` | PVC name when existing storage volume should be used |
| storage.volumeName | string | `"valkey-data"` | Internal volume name and prefix of a created PVC |
| storage.requestedSize | string | `nil` | Size for new PVC, when no existing PVC is used |
| storage.className | string | `nil` | Storage class name |
| storage.keepPvc | bool | `false` | Keep a created Persistent volume claim when uninstalling the helm chart (only for `useDeploymentWhenNonHA`) |
| storage.annotations | object | `{}` | Additional storage annotations |
| storage.labels | object | `{}` | Additional storage labels |
| extraStorage | list | `[]` | A list of additional existing PVC that will be mounted into the container |
| extraStorage[].name | string | `nil` | Internal name of the volume |
| extraStorage[].pvcName | string | `nil` | Name of the existing PVC |
| extraStorage[].mountPath | string | `nil` | Mount path where the PVC should be mounted into the container |

## Network policies

Allows to define optional network policies for [ingress and egress](https://kubernetes.io/docs/concepts/services-networking/network-policies/)
The policyTypes will be automatically set

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| networkPolicy.annotations | object | `{}` | Additional network policy annotations |
| networkPolicy.labels | object | `{}` | Additional network policy labels |
| networkPolicy.ingress | object | `{}` | Ingress network policies |
| networkPolicy.egress | object | `{}` | Egress network policies |

## Valkey parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| extraInitEnvSecrets | list | `[]` | A list of existing secrets that will be mounted into the default init container as environment variables |
| extraValkeyEnvSecrets | list | `[]` | A list of existing secrets that will be mounted into the valkey container as environment variables |
| valkeyConfig | string | `nil` | Additional valkey.conf |
| extraSecretValkeyConfigs | string | `nil` | An existing secret with files that will be added to the `valkey.conf` |
| extraValkeySecrets | list | `[]` | A list of additional existing secrets that will be mounted into the valkey container |
| extraValkeySecrets[].name | string | `nil` | Name of the existing K8s secret |
| extraValkeySecrets[].defaultMode | int | `0440` | Mount default access mode |
| extraValkeySecrets[].mountPath | string | `nil` | Mount path where the secret should be mounted into the container (f.e. /mysecretfolder) |
| extraValkeyConfigs[].name | string | `nil` | Name of the existing K8s configMap |
| extraValkeyConfigs[].defaultMode | int | `0440` | Mount default access mode |
| extraValkeyConfigs[].mountPath | string | `nil` | Mount path where the configMap should be mounted into the container (f.e. /myconfigfolder) |
| extraSentinelEnvSecrets | list | `[]` | A list of existing secrets that will be mounted into the sentinel container as environment variables |
| sentinelConfig | string | `nil` | Additional sentinel.conf (only when haMode is enabled) |
| extraSecretSentinelConfigs | string | `nil` | An existing secret with files that will be added to the `sentinel.conf` |
| extraSentinelSecrets | list | `[]` | A list of additional existing secrets that will be mounted into the sentinel container |
| extraSentinelSecrets[].name | string | `nil` | Name of the existing K8s secret |
| extraSentinelSecrets[].defaultMode | int | `0440` | Mount default access mode |
| extraSentinelSecrets[].mountPath | string | `nil` | Mount path where the secret should be mounted into the container (f.e. /mysecretfolder) |
| extraSentinelConfigs[].name | string | `nil` | Name of the existing K8s configMap |
| extraSentinelConfigs[].defaultMode | int | `0440` | Mount default access mode |
| extraSentinelConfigs[].mountPath | string | `nil` | Mount path where the configMap should be mounted into the container (f.e. /myconfigfolder) |
| useDeploymentWhenNonHA | bool | `true` | Use Deployment instead of StatefulSet for Non-HA deployments |
| haMode.enabled | bool | `false` | Enable Valkey high availibility mode with master-slave replication and sentinel |
| haMode.useDnsNames | bool | `false` | Use DNS names instead of Pod IPs to build the cluster |
| haMode.masterGroupName | string | `"valkeyha"` | Mandatory valkey HA-master group name |
| haMode.replicas | int | `3` | Number of replicas (minimum should be 3) |
| haMode.quorum | int | `2` | Quorum of sentinels that need to agree that a master node is not available |
| haMode.downAfterMilliseconds | int | `30000` | Number of milliseconds after the master should be declared as unavailable |
| haMode.failoverTimeout | int | `180000` | Timeout for a failover in milliseoncds |
| haMode.parallelSyncs | int | `1` | Number of parallel reconfigurations |
| haMode.masterAliveTestTimeout | int | `2` | Timeout in seconds to detect if Valkey master is alive |
| haMode.failoverWait | int | `35` | Assumed wait time in seconds until failover should be finished and before failover will be forced (should be greater than value of downAfterMilliseconds) |
| haMode.dnsFailureWait | int | `15` | Wait time in seconds before restart will be forced after a DNS failure during initialization |
| haMode.keepOldLogs | bool | `false` | Keep old init logs in /data/init.log after a successful initialization (use only for debugging) |
