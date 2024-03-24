# MariaDB

![Version: 3.1.0](https://img.shields.io/badge/Version-3.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 10.11.7](https://img.shields.io/badge/AppVersion-10.11.7-informational?style=flat-square)

## Changelog

see [RELEASENOTES.md](RELEASENOTES.md)

A Helm chart for MariaDB on Kubernetes

## TL;DR

```bash
helm repo add groundhog2k https://groundhog2k.github.io/helm-charts/
helm install my-release groundhog2k/mariadb
```

## Introduction

This chart uses the original [MariaDB image from Docker Hub](https://hub.docker.com/_/mariadb) to deploy a stateful MariaDB instance in a Kubernetes cluster.

It fully supports deployment of the multi-architecture docker image.

## Prerequisites

- Kubernetes 1.12+
- Helm 3.x
- PV provisioner support in the underlying infrastructure

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
helm install my-release groundhog2k/mariadb
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
| image.repository | string | `"mariadb"` | Image name |
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
| initResources | object | `{}` | Resource limits and requests for the default init container |
| nodeSelector | object | `{}` | Deployment node selector |
| customLabels | object | `{}` | Additional labels for Deployment or StatefulSet |
| customAnnotations | object | `{}` | Additional annotations for Deployment or StatefulSet |
| podAnnotations | object | `{}` | Additional pod annotations |
| podLabels | object | `{}` | Additional pod labels |
| podSecurityContext | object | `see values.yaml` | Pod security context |
| securityContext | object | `see values.yaml` | Container security context |
| env | list | `[]` | Additional container environmment variables |
| serviceAccount.annotations | object | `{}` | Additional service account annotations |
| serviceAccount.create | bool | `false` | Enable service account creation |
| serviceAccount.name | string | `""` | Name of the service account |
| affinity | object | `{}` | Affinity for pod assignment |
| tolerations | list | `[]` | Tolerations for pod assignment |
| topologySpreadConstraints | object | `{}` | Topology spread constraints for pods |
| podManagementPolicy | string | `"OrderedReady"` | Pod management policy |
| updateStrategyType | string | `"RollingUpdate"` | Pod update strategy |
| revisionHistoryLimit | int | `nil` | Maximum number of revisions maintained in revision history

## Service paramters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| service.type | string | `"ClusterIP"` | Service type |
| service.port | int | `3306` | MariaDB service port |
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
| storage.volumeName | string | `"db-volume"` | Internal volume name and prefix of a created PVC |
| storage.requestedSize | string | `nil` | Size for new PVC, when no existing PVC is used |
| storage.className | string | `nil` | Storage class name |
| storage.keepPvc | bool | `false` | Keep a created Persistent volume claim when uninstalling the helm chart (only for option `useDeployment: true`) |
| storage.annotations | object | `{}` | Additional storage annotations |
| storage.labels | object | `{}` | Additional storage labels |
| extraStorage | list | `[]` | A list of additional existing PVC that will be mounted into the container |
| extraStorage[].name | string | `nil` | Internal name of the volume |
| extraStorage[].pvcName | string | `nil` | Name of the existing PVC |
| extraStorage[].mountPath | string | `nil` | Mount path where the PVC should be mounted into the container |

## MariaDB parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| useDeployment | bool | `false` | Use Kubernetes Deployment instead of StatefulSet |
| userDatabase | object | `{}` | Optional MariaDB user database |
| userDatabase.existingSecret | string | `nil` | Optional existing secret with database name, user and password |
| userDatabase.name.secretKey | string | `""` | Key of the existingSecret with database name |
| userDatabase.name.value | string | `""` | Name of the user database (if no existingSecret was specified) |
| userDatabase.user.secretKey | string | `""` | Key of the existingSecret with database user |
| userDatabase.user.value | string | `""` | User name with full access to user database (if no existingSecret was specified) |
| userDatabase.password.secretKey | string | `""` | Key of the existingSecret with password of created user |
| userDatabase.password.value | string | `""` | Password of created user (if no existingSecret was specified) |
| settings.existingSecret | string | `nil` | Optional existing secret for the root password |
| settings.rootPassword.secretKey | string | `nil` | Key of existingSecret for the MariaDB root password |
| settings.rootPassword.value | string | `nil` | MariaDB root password (if no existingSecret was specified) |
| settings.allowEmptyRootPassword | bool | `false` | Set true to allow an empty root password |
| settings.skipTZInfo | bool | `false` | Set true to skip loading timezone data during init |
| settings.arguments | list | `[]` | Additional arguments for mysqld (entrypoint process) |
| customConfig | string | `nil` | Additional MariaDB custom configuration mounted as `/etc/mysql/custom.cnf` |
| extraEnvSecrets | list | `[]` | A list of existing secrets that will be mounted into the container as environment variables |
| extraSecretConfigs | string | `nil` | An existing secret with files that will be mounted into the container as custom MariaDB configuration files (`*.cnf`) in `/etc/mysql/conf.d` |
| customScripts | object | `nil` | Optional custom scripts that can be defined inline and will be mounted as files in `/docker-entrypoint-initdb.d` |
| extraScripts | string | `nil` | An existing configMap with files that will be mounted into the container as script files (`*.sql`, `*.sh`) in `/docker-entrypoint-initdb.d` |
| extraSecrets | list | `[]` | A list of additional existing secrets that will be mounted into the container |
| extraSecrets[].name | string | `nil` | Name of the existing K8s secret |
| extraSecrets[].defaultMode | int | `0440` | Mount default access mode |
| extraSecrets[].mountPath | string | `nil` | Mount path where the secret should be mounted into the container (f.e. /mysecretfolder) |
| extraConfigs | list | `[]` | A list of additional existing configMaps that will be mounted into the container |
| extraConfigs[].name | string | `nil` | Name of the existing K8s configMap |
| extraConfigs[].defaultMode | int | `0440` | Mount default access mode |
| extraConfigs[].mountPath | string | `nil` | Mount path where the configMap should be mounted into the container (f.e. /myconfigfolder) |
