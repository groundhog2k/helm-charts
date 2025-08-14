# Gitea

![Version: 0.13.7](https://img.shields.io/badge/Version-0.13.7-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.24.5](https://img.shields.io/badge/AppVersion-1.24.5-informational?style=flat-square)

## Changelog

see [RELEASENOTES.md](RELEASENOTES.md)

A Helm chart for Gitea on Kubernetes

## TL;DR

```bash
helm repo add groundhog2k https://groundhog2k.github.io/helm-charts/
helm install my-release groundhog2k/gitea
```

## Introduction

This chart uses the original [Gitea from Docker](https://hub.docker.com/r/gitea/gitea) to deploy Gitea in Kubernetes.

It fully supports deployment of the multi-architecture docker image.

## Prerequisites

- Kubernetes 1.12+
- Helm 3.x
- PV provisioner support in the underlying infrastructure

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
helm install my-release groundhog2k/gitea
```

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
helm uninstall my-release
```

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| @groundhog2k | mariadb | 0.2.28 |
| @groundhog2k | postgres | 0.2.26 |
| @groundhog2k | redis | 0.6.14 |

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
| image.repository | string | `"gitea/gitea"` | Image name |
| image.tag | string | `""` | Image tag |
| imagePullSecrets | list | `[]` | Image pull secrets |
| strategy.type | object | `Recreate` | Pod deployment strategy |
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
| args | list | `[]` | Arguments for the container entrypoint process |
| serviceAccount.create | bool | `false` | Enable service account creation |
| serviceAccount.name | string | `""` | Optional name of the service account |
| serviceAccount.annotations | object | `{}` | Additional service account annotations |
| affinity | object | `{}` | Affinity for pod assignment |
| tolerations | list | `[]` | Tolerations for pod assignment |
| topologySpreadConstraints | object | `{}` | Topology spread constraints for pods |
| containerHttpPort | int | `8000` | Internal http container port |
| containerSshPort | int | `8022` | Internal ssh container port |
| revisionHistoryLimit | int | `nil` | Maximum number of revisions maintained in revision history

## Service paramters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| services.http.type | string | `"ClusterIP"` | Service type |
| services.http.port | int | `80` | Gitea HTTP service port |
| services.http.nodePort | int | `nil` | Gitea HTTP NodePort (only relevant for type LoadBalancer or NodePort) |
| services.http.clusterIP | int | `nil` | Gitea HTTP ClusterIP (only relevant for type LoadBalancer or NodePort) |
| services.http.loadBalancerIP | string | `nil` | The load balancer ip address (only relevant for type LoadBalancer) |
| services.http.loadBalancerSourceRanges | list | `[]` | The list of IP CIDR ranges that are allowed to access the load balancer (only relevent for type LoadBalancer) |
| services.http.annotations | object | `{}` | Additional service annotations |
| services.http.labels | object | `{}` | Additional service labels |
| services.ssh.type | string | `"ClusterIP"` | Service type |
| services.ssh.port | int | `22` | Gitea SSH service port |
| services.ssh.nodePort | int | `nil` | Gitea SSH NodePort (only relevant for type LoadBalancer or NodePort) |
| services.ssh.clusterIP | int | `nil` | Gitea SSH ClusterIP (only relevant for type LoadBalancer or NodePort)  |
| services.ssh.loadBalancerIP | string | `nil` | The load balancer ip address (only relevant for type LoadBalancer) |
| services.ssh.loadBalancerSourceRanges | list | `[]` | The list of IP CIDR ranges that are allowed to access the load balancer (only relevent for type LoadBalancer) |
| services.ssh.annotations | object | `{}` | Additional service annotations |
| services.ssh.labels | object | `{}` | Additional service labels |

## Ingress parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| ingress.enabled | bool | `false` | Enable ingress for Gitea service |
| ingress.className | string | `nil` | Optional ingress class name |
| ingress.annotations | object | `{}` | Additional annotations for ingress |
| ingress.labels | object | `{}` | Additional ingress lables |
| ingress.hosts[0].host | string | `""` | Hostname for the ingress endpoint |
| ingress.hosts[0].host.paths[0].path | string | `"/"` | Path of the Gitea UI |
| ingress.hosts[0].host.paths[0].pathType | string | `"ImplementationSpecific"` | Ingress path type (ImplementationSpecific, Prefix, Exact) |
| ingress.tls | list | `[]` | Ingress TLS parameters |
| ingress.maxBodySize | string | `"64m"` | Maximum body size for post requests |

## Network policies

Allows to define optional network policies for [ingress and egress](https://kubernetes.io/docs/concepts/services-networking/network-policies/)
The policyTypes will be automatically set

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| networkPolicy.ingress | object | `{}` | Ingress network policies |
| networkPolicy.egress | object | `{}` | Egress network policies |

## Redis session cache

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| externalCache.enabled | bool | `false` | Enable external Redis cache |
| externalCache.host | string | `nil` | External Redis host and port (host:port) |
| redis.enabled | bool | `false` | Enable Redis cache deployment (will disable external cache settings) |
| redis.storage | string | `nil` | Redis storage settings |

**Hint:** When no cache configuration is enabled, then all cache settings have to be provided manually in the `gitea.config` section. See [Gitea Config Cheat Sheet](https://docs.gitea.io/en-us/config-cheat-sheet/) for description of all settings.

## Database settings

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| fallbackToSqlite | bool | `true` | Falls back to internal SQLite when no database is configured |
| externalDatabase.enabled | bool | `false` | Enable usage of external database |
| externalDatabase.type | string | `nil` | External database type ("mysql", "postgres" are supported) |
| externalDatabase.charset | string | `"utf8mb4"` | Database charset to use (only relevant for mysql/mariadb) |
| externalDatabase.host | string | `nil` | External database host |
| externalDatabase.name | string | `nil` | External database name |
| externalDatabase.user | string | `nil` | External database user name |
| externalDatabase.password | string | `nil` | External database user password |
| mariadb.enabled | bool | `false` | Enable MariaDB deployment (will disable external database settings) |
| mariadb.settings.arguments[0] | string | `"--character-set-server=utf8mb4"` | Enable MariaDB UTF8MB4 character set|
| mariadb.settings.arguments[1] | string | `"--collation-server=utf8mb4_unicode_ci"` | Enable UTF8MB4 unicode |
| mariadb.settings.rootPassword | string | `nil` | MariaDB root user password |
| mariadb.storage | string | `nil` | MariaDB storage settings |
| mariadb.userDatabase.name | string | `nil` | MariaDB Gitea database name |
| mariadb.userDatabase.password | string | `nil` | MariaDB Gitea database user |
| mariadb.userDatabase.user | string | `nil` | MariaDB Gitea database user password |
| postgres.enabled | bool | `false` | Enable PostgreSQL deployment (will disable external database settings) |
| postgres.settings.superuserPassword | string | `nil` | PostgreSQL superuser password |
| postgres.storage | string | `nil` | PostgreSQL storage settings |
| postgres.userDatabase.name | string | `nil` | PostgreSQL Gitea database name |
| postgres.userDatabase.user | string | `nil` | PostgreSQL Gitea database user |
| postgres.userDatabase.password | string | `nil` | PostgreSQL Gitea database user password |

**Hint:** When no database configuration is enabled and fallbackToSqlite is set `false`, then all database settings have to be provided manually in the `gitea.config` section. See [Gitea Config Cheat Sheet](https://docs.gitea.io/en-us/config-cheat-sheet/) for description of all settings.

## Gitea parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| settings.postInstallDelay | int | `60` | Delay after installation before adminstrative user gets created (Database must be ready and connected) |
| settings.defaultAdmin.name | string | `root` | Gitea administrator user |
| settings.defaultAdmin.password | string | `admin` | Gitea admin user password (Must be changed during first login) |
| settings.defaultAdmin.email | string | `root@admin.local` | Gitea administrator users email |
| gitea.config | object | `see values.yaml` | Gitea specific configuration as described in the [Gitea Config Cheat Sheet](https://docs.gitea.io/en-us/config-cheat-sheet/) - More values and sections can be added |

It's recommended to set the following Gitea configuration parameters:

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| gitea.config.server.LFS_JWT_SECRET | string | `nil` |  LFS authentication secret, must be unique string |
| gitea.config.security.SECRET_KEY | string | `nil` | Global secret key |
| gitea.config.security.INTERNAL_TOKEN | string | `nil` | Secret used to validate communication within Gitea binary |
| gitea.config.oauth2.JWT_SECRET | string | `nil` | OAuth2 authentication secret for access and refresh tokens, must be a unique string |

## Storage parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| storage | object | `{}` | Gitea data storage |
| storage.accessModes[0] | string | `"ReadWriteOnce"` | Storage access mode |
| storage.persistentVolumeClaimName | string | `nil` | PVC name when existing storage volume should be used |
| storage.requestedSize | string | `nil` | Size for new PVC, when no existing PVC is used |
| storage.className | string | `nil` | Storage class name |
| storage.keepPvc | bool | `false` | Keep a created Persistent volume claim when uninstalling the helm chart |
| storage.annotations | object | `{}` | Additional storage annotations |
| storage.labels | object | `{}` | Additional storage labels |
