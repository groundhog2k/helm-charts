# MongoDB

![Version: 0.6.6](https://img.shields.io/badge/Version-0.6.6-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 7.0.11](https://img.shields.io/badge/AppVersion-7.0.11-informational?style=flat-square)

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
| image.registry | string | `"docker.io"` | Image registry |
| image.repository | string | `"mongo"` | Image name |
| image.tag | string | `""` | Image tag |
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
| serviceAccount.annotations | object | `{}` | Additional service account annotations |
| serviceAccount.create | bool | `false` | Enable service account creation |
| serviceAccount.name | string | `""` | Name of the service account |
| affinity | object | `{}` | Pod affinity |
| tolerations | list | `[]` | Pod tolerations |
| topologySpreadConstraints | object | `{}` | Topology spread constraints for pods |
| podManagementPolicy | string | `OrderedReady` | Pod management policy |
| updateStrategyType | string | `RollingUpdate` | Update strategy |
| revisionHistoryLimit | int | `nil` | Maximum number of revisions maintained in revision history |

## Service paramters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| service.type | string | `"ClusterIP"` | Service type |
| service.port | int | `27017` | MongoDB service port |
| service.nodePort | int | `nil` | The node port (only relevant for type LoadBalancer or NodePort) |
| service.clusterIP | string | `nil` | The cluster ip address (only relevant for type LoadBalancer or NodePort) |
| service.loadBalancerIP | string | `nil` | The load balancer ip address (only relevant for type LoadBalancer) |
| service.annotations | object | `{}` | Additional service annotations |
| service.labels | object | `{}` | Additional service labels |

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
| storage.persistentVolumeClaimName | string | `nil` | PVC name when existing storage volume should be used |
| storage.volumeName | string | `"mongodb-volume"` | Internal volume name and prefix of a created PVC |
| storage.requestedSize | string | `nil` | Size for new PVC, when no existing PVC is used |
| storage.className | string | `nil` | Storage class name |
| storage.keepPvc | bool | `false` | Keep a created Persistent volume claim when uninstalling the helm chart (only for `useDeploymentWhenNonHA`) |
| storage.annotations | object | `{}` | Additional storage annotations |
| storage.labels | object | `{}` | Additional storage labels |

## MongoDB parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| extraInit.retries | int | `10` | Number of retries to detect whether mongod is fully up and running in background |
| extraInit.delay | int | `3` | Seconds to wait between retries |
| extraInit.initDelay | int | `5` | Seconds to wait after mongod is running to give it time for internal initialization |
| shutdown.delay | int | `10` | Delay until termination request is forwarded to mongod process to give ReplicaSet time for electing a new primary instance |
| settings.rootUsername | string | `admin` | The root username |
| settings.rootPassword | string | `{}` | The root users password |
| userDatabase | object | `{}` | Optional MongoDB user database |
| userDatabase.name | string | `nil` | Name of the user database |
| userDatabase.user | string | `nil` | User name with full access to user database|
| userDatabase.password | string | `nil` | Password of created user |
| customConfig | string | `nil` | Custom MongoDB configuration block that will be mounted as file in `/etc/mongo/custom.conf` |
| extraEnvSecrets | list | `[]` | A list of existing secrets that will be mounted into the container as environment variables |
| extraSecretConfigs | string | `nil` | An existing secret with files that will be added to the mongodb configuration in addition to `/etc/mongo/custom.conf` |
| customScripts | object | `nil` | Optional custom scripts that can be defined inline and will be mounted as files in `/docker-entrypoint-initdb.d` |
| extraScripts | string | `nil` | An existing configMap with files that will be mounted into the container as script files (`*.js`, `*.sh`) in `/docker-entrypoint-initdb.d` |
| extraSecrets | list | `[]` | A list of additional existing secrets that will be mounted into the container |
| extraSecrets[].name | string | `nil` | Name of the existing K8s secret |
| extraSecrets[].mountPath | string | `nil` | Mount path where the secret should be mounted into the container (f.e. /mysecretfolder) |
| useDeploymentWhenNonHA | bool | `false` | Use Deployment instead of StatefulSet for Non-HA deployments |
| replicaSet.enabled | bool | `false` | Enables MongoDB ReplicaSet deployment (HA mode) |
| replicaSet.name | string | `nil` | Name of this MongoDB ReplicaSet |
| replicaSet.key | string | `nil` | Base 64-encoded string with 6-1024 characters used as authentication key for internal communication |
| replicaSet.keySecretName | string | `nil` | Alternative to `key` - Name of an existing secret with a file named "keyfile" containing the base64 encoded key string |
| replicaSet.clusterDomain | string | `"cluster.local"` | Default Kubernetes cluster domain |
| replicaSet.secondaries | int | `2` | Number of secondary instances (should be at least 2 - or - one secondary and an arbiter) |
| replicaSet.hiddenSecondaries.instances | int | `0` | Number of hidden secondary instances |
| replicaSet.hiddenSecondaries.headlessServiceSuffix | string | `"hidden"` | Suffix of the headless service name for hidden secondary instances |
| replicaSet.hiddenSecondaries.nodeSelector | object | `{}` | Deployment node selector |
| replicaSet.hiddenSecondaries.tolerations | list | `[]` | Pod tolerations |
| replicaSet.hiddenSecondaries.topologySpreadConstraints | object | `{}` | Topology spread constraints for pods |
| replicaSet.hiddenSecondaries.affinity | object | `{}` | Pod affinity |
| replicaSet.hiddenSecondaries.volumeName | string | `"mongodb-hidden-volume"` | Internal volume name and prefix of created PVC |
| replicaSet.arbiter.enabled | bool | `false` | Enables arbiter deployment |
| replicaSet.arbiter.headlessServiceSuffix | string | `"arbiter"` | Suffix of the arbiters headless service name |
| replicaSet.arbiter.resources | object | `{}` | Resource limits and requests for the arbiter |
| replicaSet.arbiter.nodeSelector | object | `{}` | Deployment node selector |
| replicaSet.arbiter.tolerations | list | `[]` | Pod tolerations |
| replicaSet.arbiter.topologySpreadConstraints | object | `{}` | Topology spread constraints for pods |
| replicaSet.arbiter.affinity | object | `{}` | Pod affinity |
| replicaSet.arbiter.storage.accessModes[0] | string | `"ReadWriteOnce"` | Storage access mode |
| replicaSet.arbiter.storage.persistentVolumeClaimName | string | `nil` | PVC name when existing storage volume should be used |
| replicaSet.arbiter.storage.volumeName | string | `"mongodb-arbiter-volume"` | Internal volume name and prefix of a created PVC |
| replicaSet.arbiter.storage.requestedSize | string | `nil` | Size for new PVC, when no existing PVC is used |
| replicaSet.arbiter.storage.className | string | `nil` | Storage class name |
| replicaSet.arbiter.storage.annotations | object | `{}` | Additional storage annotations |
| replicaSet.arbiter.storage.labels | object | `{}` | Additional storage labels |
