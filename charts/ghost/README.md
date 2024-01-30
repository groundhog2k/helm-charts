# Ghost

![Version: 0.118.0](https://img.shields.io/badge/Version-0.118.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 5.77.0](https://img.shields.io/badge/AppVersion-5.77.0-informational?style=flat-square)

## Changelog

### ⚠️ An upgrade to Ghost 4.46.x, Ghost 4.47.x or Ghost 4.48.x with MariaDB as database will fail - Upgrading to Ghost 5.0.0 with MariaDB as database backend works only with Ghost >=4.46.2 - Using MySQL as database backend is highly recommended and will support the full upgrade path

see [RELEASENOTES.md](RELEASENOTES.md)

A Helm chart for Ghost blog on Kubernetes

## TL;DR

```bash
helm repo add groundhog2k https://groundhog2k.github.io/helm-charts/
helm install my-release groundhog2k/ghost
```

## Introduction

This chart uses the original [Ghost image from Docker Hub](https://hub.docker.com/_/ghost) to deploy a Ghost blog in Kubernetes.

It fully supports deployment of the multi-architecture docker image.

## Prerequisites

- Kubernetes 1.12+
- Helm 3.x
- PV provisioner support in the underlying infrastructure

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
helm install my-release groundhog2k/ghost
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
| @groundhog2k | mysql | 0.2.0 |

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
| image.repository | string | `"ghost"` | Image name |
| image.tag | string | `""` | Image tag |
| imagePullSecrets | list | `[]` | Image pull secrets |
| strategy | object | `{}` | Pod deployment strategy |
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
| rbac.create | bool | `true` | Enable creation of RBAC |
| serviceAccount.create | bool | `false` | Enable service account creation |
| serviceAccount.name | string | `""` | Optional name of the service account |
| serviceAccount.annotations | object | `{}` | Additional service account annotations |
| affinity | object | `{}` | Affinity for pod assignment |
| tolerations | list | `[]` | Tolerations for pod assignment |
| topologySpreadConstraints | object | `{}` | Topology spread constraints for pods |
| revisionHistoryLimit | int | `nil` | Maximum number of revisions maintained in revision history

## Service paramters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| service.port | int | `80` | Ghost HTTP service port |
| service.type | string | `"ClusterIP"` | Service type |
| service.nodePort | int | `nil` | The node port (only relevant for type LoadBalancer or NodePort) |
| service.clusterIP | string | `nil` | The cluster ip address (only relevant for type LoadBalancer or NodePort) |
| service.loadBalancerIP | string | `nil` | The load balancer ip address (only relevant for type LoadBalancer) |
| service.annotations | object | `{}` | Additional service annotations |
| service.labels | object | `{}` | Additional service labels |

## Ingress parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| ingress.enabled | bool | `false` | Enable ingress for Ghost service |
| ingress.className | object | `{}` | Optional ingress class name |
| ingress.annotations | object | `{}` | Additional annotations for ingress |
| ingress.labels | object | `{}` | Additional ingress lables |
| ingress.hosts[0].host | string | `""` | Hostname for the ingress endpoint |
| ingress.hosts[0].host.paths[0].path | string | `"/"` | Path of the Ghost UI |
| ingress.hosts[0].host.paths[0].pathType | string | `"ImplementationSpecific"` | Ingress path type (ImplementationSpecific, Prefix, Exact) |
| ingress.tls | list | `[]` | Ingress TLS parameters |
| ingress.maxBodySize | string | `"2m"` | Maximum body size for post requests |

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
| storage.requestedSize | string | `nil` | Size for new PVC, when no existing PVC is used |
| storage.className | string | `nil` | Storage class name |
| storage.keepPvc | bool | `false` | Keep a created Persistent volume claim when uninstalling the helm chart |
| storage.annotations | object | `{}` | Additional storage annotations |
| storage.labels | object | `{}` | Additional storage labels |

## Ghost parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| mariadb.enabled | bool | `false` | Enables MariaDB deployment (and switches off externalDatabase section) |
| mariadb.settings.rootPassword | string | `nil` | MariaDB root password |
| mariadb.userDatabase.name | string | `nil` | Name of the Ghost database |
| mariadb.userDatabase.user | string | `nil` | User name with full access to ghost database |
| mariadb.userDatabase.password | string | `nil` | Password of the ghost database user |
| mysql.storage | string | `nil` | MySQL storage parameter (see storage parameters) |
| mysql.enabled | bool | `false` | Enables MySQL deployment (and switches off externalDatabase section) |
| mysql.settings.rootPassword | string | `nil` | MySQL root password |
| mysql.userDatabase.name | string | `nil` | Name of the Ghost database |
| mysql.userDatabase.user | string | `nil` | User name with full access to ghost database |
| mysql.userDatabase.password | string | `nil` | Password of the ghost database user |
| mysql.storage | string | `nil` | MySQL storage parameter (see storage parameters) |
| externalDatabase.type | string | `"sqlite"` | External database type (mysql or mariadb - default: sqlite) |
| externalDatabase.sqliteDatabaseFile | string | `"content/data/ghost.db"` | Path to default SQLite database (only sqlite) |
| externalDatabase.host | string | `nil` | External database host (only mysql/mariadb) |
| externalDatabase.name | string | `"ghost"` | External database name (only mysql/mariadb) |
| externalDatabase.user | string | `nil` | External database user (only mysql/mariadb) |
| externalDatabase.password | string | `nil` | External database password (only mysql/mariadb) |
| settings.mode | string | `"production"` | Ghost mode (production or development) |
| settings.url | string | `nil` | URL of Ghost blog |
| settings.logToStdout | bool | `true`| Log to stdout by default (otherwise logging will go to stdout and file) |
| settings.mail.from | string | `nil` | Mail from address |
| settings.mail.transport | string | `SMTP` | Mail transport type (SMTP, Sendmail, Direct) |
| settings.mail.host | string | `nil` | Mail host for transport |
| settings.mail.port | int | `nil` | Mail port  for transport |
| settings.mail.service | string | `nil` | Service for mail transport (Mailgun, Sendgrid, Gmail, SES) |
| settings.mail.user | string | `nil` | Mail auth user |
| settings.mail.passwort | string | `nil` | Mail auth password |
