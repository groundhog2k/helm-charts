# Redis

![Version: 0.6.0](https://img.shields.io/badge/Version-0.6.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 7.0.7](https://img.shields.io/badge/AppVersion-7.0.7-informational?style=flat-square)

## Changelog

see [RELEASENOTES.md](RELEASENOTES.md)

A Helm chart for Redis on Kubernetes

## TL;DR

```bash
helm repo add groundhog2k https://groundhog2k.github.io/helm-charts/
helm install my-release groundhog2k/redis
```

### Basic setup without high availability

`haMode.enabled: false`

This will create one standalone Redis instance which can be reached based on the `service:` configuration (ClusterIP & Port 6379 by default)

```draw
+-------------------+
| Redis standalone  |
+-------------------+
```

### Advanced setup with high availability support

`haMode.enabled: true`

This will create 3 pods by default, with 1 Redis master (M1) and 2 Redis replications (R1/R2). Every pod has 2 containers, one for the Redis server and one for the Redis sentinel (S1/S2/S3).
The default quorom to decide for a new master is set to 2. Have a look at all configurable parameters in values section `haMode:`

A Sentinal instance can be reached based on the `service:` configuration (ClusterIP & Sentinel port 26379 by default).

```draw
       +----+
       | M1 |
       | S1 |
       +----+
          |
+----+    |    +----+
| R2 |----+----| R3 |
| S2 |         | S3 |
+----+         +----+
```

## Introduction

This chart uses the original [Redis image from Docker Hub](https://hub.docker.com/_/redis/) to deploy a stateful Redis instance in a Kubernetes cluster.

It fully supports deployment of the multi-architecture docker image.

## Prerequisites

- Kubernetes 1.12+
- Helm 3.x
- PV provisioner support in the underlying infrastructure

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
helm install my-release groundhog2k/redis
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
| image.repository | string | `"redis"` | Image name |
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
| sentinelResources | object | `{}` | Resource limits and requests (for Redis Sentinel - only when haMode is enabled) |
| nodeSelector | object | `{}` | Deployment node selector |
| podAnnotations | object | `{}` | Additional pod annotations |
| podSecurityContext | object | `see values.yaml` | Pod security context |
| securityContext | object | `see values.yaml` | Container security context |
| env | list | `[]` | Additional container environmment variables (Redis server and Sentinel) |
| args | list | `[]` | Additional container command arguments (Redis server) |
| sentinelArgs | list | `[]` | Arguments for the container entrypoint process (Sentinel) |
| serviceAccount.annotations | object | `{}` | Additional service account annotations |
| serviceAccount.create | bool | `false` | Enable service account creation |
| serviceAccount.name | string | `""` | Name of the service account |
| affinity | object | `{}` | Affinity for pod assignment |
| tolerations | list | `[]` | Tolerations for pod assignment |
| podManagementPolicy | string | `"OrderedReady"` | Pod management policy |
| updateStrategyType | string | `"RollingUpdate"` | Pod update strategy |
| revisionHistoryLimit | int | `nil` | Maximum number of revisions maintained in revision history
| podDisruptionBudget | object | `{}` | Pod disruption budget |
| podDisruptionBudget.minAvailable | int | `nil` | Minimum number of pods that must be available after eviction |
| podDisruptionBudget.maxUnavailable | int | `nil` | Maximum number of pods that can be unavailable after eviction |

## Service parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| service.type | string | `"ClusterIP"` | Service type (not available when haMode is enabled) |
| service.serverPort | int | `6379` | Redis server service port |
| service.sentinelPort | int | `26379` | Redis sentinel service port |
| service.nodePort | int | `nil` | The node port (only relevant for type LoadBalancer or NodePort - not available when haMode is enabled) |
| service.clusterIP | string | `nil` | The cluster ip address (only relevant for type LoadBalancer or NodePort) |
| service.loadBalancerIP | string | `nil` | The load balancer ip address (only relevant for type LoadBalancer - not available when haMode is enabled) |
| service.annotations | object | `{}` | Additional service annotations |

## Storage parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| storage.accessModes[0] | string | `"ReadWriteOnce"` | Storage access mode |
| storage.persistentVolumeClaimName | string | `nil` | PVC name when existing storage volume should be used |
| storage.requestedSize | string | `nil` | Size for new PVC, when no existing PVC is used |
| storage.className | string | `nil` | Storage class name |

## Redis parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| extraRedisEnvSecrets | list | `[]` | A list of existing secrets that will be mounted into the redis container as environment variables |
| redisConfig | string | `nil` | Additional redis.conf |
| extraSecretRedisConfigs | string | `nil` | An existing secret with files that will be added to the `redis.conf` |
| extraRedisSecrets | list | `[]` | A list of additional existing secrets that will be mounted into the redis container |
| extraRedisSecrets[].name | string | `nil` | Name of the existing K8s secret |
| extraRedisSecrets[].mountPath | string | `nil` | Mount path where the secret should be mounted into the container (f.e. /mysecretfolder) |
| extraSentinelEnvSecrets | list | `[]` | A list of existing secrets that will be mounted into the sentinel container as environment variables |
| sentinelConfig | string | `nil` | Additional sentinel.conf (only when haMode is enabled) |
| extraSecretSentinelConfigs | string | `nil` | An existing secret with files that will be added to the `sentinel.conf` |
| extraSentinelSecrets | list | `[]` | A list of additional existing secrets that will be mounted into the sentinel container |
| extraSentinelSecrets[].name | string | `nil` | Name of the existing K8s secret |
| extraSentinelSecrets[].mountPath | string | `nil` | Mount path where the secret should be mounted into the container (f.e. /mysecretfolder) |
| haMode.enabled | bool | `false` | Enable Redis high availibility mode with master-slave replication and sentinel |
| haMode.useDnsNames | bool | `false` | Use DNS names instead of Pod IPs to build the cluster |
| haMode.masterGroupName | string | `"redisha"` | Mandatory redis HA-master group name |
| haMode.replicas | int | `3` | Number of replicas (minimum should be 3) |
| haMode.quorum | int | `2` | Quorum of sentinels that need to agree that a master node is not available |
| haMode.downAfterMilliseconds | int | `30000` | Number of milliseconds after the master should be declared as unavailable |
| haMode.failoverTimeout | int | `180000` | Timeout for a failover in milliseoncds |
| haMode.parallelSyncs | int | `1` | Number of parallel reconfigurations
| haMode.masterAliveTestTimeout | int | `2` | Timeout in seconds to detect if Redis master is alive |
| haMode.failoverWait | int | `35` | Assumed wait time in seconds until failover should be finished and before failover will be forced (should be greater than value of downAfterMilliseconds) |
| haMode.keepOldLogs | bool | `false` | Keep old init logs in /data/init.log after a successful initialization (use only for debugging) |
