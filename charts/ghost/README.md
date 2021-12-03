# Ghost

![Version: 0.27.0](https://img.shields.io/badge/Version-0.27.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 4.25.0](https://img.shields.io/badge/AppVersion-4.25.0-informational?style=flat-square)

A Helm chart for Ghost blog on Kubernetes

## TL;DR

```bash
$ helm repo add groundhog2k https://groundhog2k.github.io/helm-charts/
$ helm install my-release groundhog2k/ghost
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
$ helm install my-release groundhog2k/ghost
```

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm uninstall my-release
```

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| @groundhog2k | mariadb | 0.2.15 |

## Common parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| fullnameOverride | string | `""` | Fully override the deployment name |
| nameOverride | string | `""` | Partially override the deployment name |

## Deployment parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| image.repository | string | `"ghost"` | Image name |
| image.tag | string | `""` | Image tag |
| imagePullSecrets | list | `[]` | Image pull secrets |
| strategy | object | `{}` | Pod deployment strategy |
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
| args | list | `[]` | Arguments for the container entrypoint process |
| rbac.create | bool | `true` | Enable creation of RBAC |
| serviceAccount.create | bool | `false` | Enable service account creation |
| serviceAccount.name | string | `""` | Optional name of the service account |
| serviceAccount.annotations | object | `{}` | Additional service account annotations |
| affinity | object | `{}` | Affinity for pod assignment |
| tolerations | list | `[]` | Tolerations for pod assignment |
| revisionHistoryLimit | int | `nil` | Maximum number of revisions maintained in revision history

## Service paramters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| service.port | int | `80` | Ghost HTTP service port |
| service.type | string | `"ClusterIP"` | Service type |
| service.nodePort | int | `nil` | The node port (only relevant for type LoadBalancer or NodePort) |
| service.clusterIP | string | `nil` | The cluster ip address (only relevant for type LoadBalancer or NodePort) |
| service.loadBalancerIP | string | `nil` | The load balancer ip address (only relevant for type LoadBalancer) |

## Ingress parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| ingress.enabled | bool | `false` | Enable ingress for Ghost service |
| ingress.annotations | string | `nil` | Additional annotations for ingress |
| ingress.hosts[0].host | string | `""` | Hostname for the ingress endpoint |
| ingress.hosts[0].host.paths[0] | string | `"/"` | Path of the Ghost UI |
| ingress.tls | list | `[]` | Ingress TLS parameters |
| ingress.maxBodySize | string | `"2m"` | Maximum body size for post requests |

## Storage parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| storage.accessModes[0] | string | `"ReadWriteOnce"` | Storage access mode |
| storage.persistentVolumeClaimName | string | `nil` | PVC name when existing storage volume should be used |
| storage.requestedSize | string | `nil` | Size for new PVC, when no existing PVC is used |
| storage.className | string | `nil` | Storage class name |
| storage.keepPvc | bool | `false` | Keep a created Persistent volume claim when uninstalling the helm chart |

## Ghost parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| mariadb.enabled | bool | `false` | Enables MariaDB deployment (and switches off externalDatabase section) |
| mariadb.settings.rootPassword | string | `nil` | MariaDB root password |
| mariadb.userDatabase.name | string | `nil` | Name of the Ghost database |
| mariadb.userDatabase.user | string | `nil` | User name with full access to ghost database |
| mariadb.userDatabase.password | string | `nil` | Password of the ghost database user |
| mariadb.storage | string | `nil` | MariaDB storage parameter (see storage parameters) |
| externalDatabase.host | string | `nil` | External database host |
| externalDatabase.name | string | `"ghost"` | External database name |
| externalDatabase.type | string | `"sqlite"` | External database type (mysql or mariadb - default: sqlite) |
| externalDatabase.user | string | `nil` | External database user |
| externalDatabase.password | string | `nil` | External database password |
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
