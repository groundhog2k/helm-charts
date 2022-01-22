# Commento

![Version: 0.1.22](https://img.shields.io/badge/Version-0.1.22-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v1.8.0](https://img.shields.io/badge/AppVersion-v1.8.0-informational?style=flat-square)

## Changelog

see [RELEASENOTES.md](RELEASENOTES.md)

A Helm chart for Commento on Kubernetes

## TL;DR

```bash
helm repo add groundhog2k https://groundhog2k.github.io/helm-charts/
helm install my-release groundhog2k/commento
```

## Introduction

This chart uses the original [Commmento from Gitlab](https://gitlab.com/commento/commento/container_registry) to deploy Commento in Kubernetes.

## Limitations

The Commento image only supports amd64 architecture!

## Prerequisites

- Kubernetes 1.12+
- Helm 3.x
- PV provisioner support in the underlying infrastructure

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
helm install my-release groundhog2k/commento
```

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
helm uninstall my-release
```

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| @groundhog2k | postgres | 0.2.15 |

## Common parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| fullnameOverride | string | `""` | Fully override the deployment name |
| nameOverride | string | `""` | Partially override the deployment name |

## Deployment parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| image.repository | string | `"registry.gitlab.com/commento/commento"` | Image name |
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
| nodeSelector."kubernetes.io/arch" | string | `"amd64"` | Deployment node selector |
| podAnnotations | object | `{}` | Additional pod annotations |
| podSecurityContext | object | `see values.yaml` | Pod security context |
| securityContext | object | `see values.yaml` | Container security context |
| env | list | `[]` | Additional container environmment variables |
| serviceAccount.create | bool | `false` | Enable service account creation |
| serviceAccount.name | string | `""` | Optional name of the service account |
| serviceAccount.annotations | object | `{}` | Additional service account annotations |
| affinity | object | `{}` | Affinity for pod assignment |
| tolerations | list | `[]` | Tolerations for pod assignment |
| containerPort | int | `8080` | Internal http container port |
| replicaCount | int | `1` | Number of replicas |
| revisionHistoryLimit | int | `nil` | Maximum number of revisions maintained in revision history
| podDisruptionBudget | object | `{}` | Pod disruption budget |
| podDisruptionBudget.minAvailable | int | `nil` | Minimum number of pods that must be available after eviction |
| podDisruptionBudget.maxUnavailable | int | `nil` | Maximum number of pods that can be unavailable after eviction |

## Service paramters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| service.port | int | `80` | Commento HTTP service port |
| service.type | string | `"ClusterIP"` | Service type |
| service.nodePort | int | `nil` | The node port (only relevant for type LoadBalancer or NodePort) |
| service.clusterIP | string | `nil` | The cluster ip address (only relevant for type LoadBalancer or NodePort) |
| service.loadBalancerIP | string | `nil` | The load balancer ip address (only relevant for type LoadBalancer) |
| service.annotations | object | `{}` | Additional service annotations |

## Ingress parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| ingress.enabled | bool | `false` | Enable ingress for Commento service |
| ingress.annotations | string | `nil` | Additional annotations for ingress |
| ingress.host | string | `nil` | Hostname for the ingress endpoint |
| ingress.tls | object | `{}` | Ingress TLS parameters |

## Commento parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| postgres.enabled | bool | `false` | Enables PostgreSQL deployment (and switches off externalDatabase section) |
| postgres.settings.superuserPassword | string | `nil` | PostgreSQL superuser password |
| postgres.userDatabase.name | string | `nil` | Name of the Commento database |
| postgres.userDatabase.password | string | `nil` | User name of the commento database |
| postgres.userDatabase.user | string | `nil` | Password of the commento database user |
| postgres.storage | string | `nil` | PostegreSQL storage parameter (see storage parameters) |
| externalDatabase.host | string | `nil` | External PostgreSQL database host |
| externalDatabase.port | int | `5432` | External PostgreSQL database port |
| externalDatabase.name | string | `"commento"` | External PostgreSQL database name |
| externalDatabase.user | string | `nil` | External database user |
| externalDatabase.password | string | `nil` | External database password |
| settings.akismetKey | string | `nil` | Optional Akismet key |
| settings.forbidNewOwners | bool | `false` | Forbid new user self registrations |
| settings.gzipStaticContent | bool | `false` | Enable serve static content GZIP compressed to client |
| settings.protocol | string | `"https"` | Protocol for generated origin URL (when ingress is enabled) |
| settings.origin | string | `nil` | Alternative Commento origin URL which is prefered over generated URL |
| settings.oauth.github.enabled | bool | `false` | Enable Github OAuth |
| settings.oauth.github.key | string | `nil` | Github OAuth key |
| settings.oauth.github.secret | string | `nil` | Github OAuth secret |
| settings.oauth.gitlab.enabled | bool | `false` | Enable Gitlab OAuth |
| settings.oauth.gitlab.key | string | `nil` | Gitlab OAuth key |
| settings.oauth.gitlab.secret | string | `nil` | Gitlab OAuth secret |
| settings.oauth.google.enabled | bool | `false` | Enable Google OAuth |
| settings.oauth.google.key | string | `nil` | Google OAuth key |
| settings.oauth.google.secret | string | `nil` | Google OAuth secret |
| settings.oauth.twitter.enabled | bool | `false` | Enable Twitter OAuth |
| settings.oauth.twitter.key | string | `nil` | Twitter OAuth key |
| settings.oauth.twitter.secret | string | `nil` | Twitter OAuth secret |
| settings.smtp.enabled | bool | `false` | Enable SMTP |
| settings.smtp.from | string | `nil` | SMTP from address |
| settings.smtp.host | string | `nil` | SMTP host |
| settings.smtp.port | int | `465` | SMTP port |
| settings.smtp.name | string | `nil` | SMTP user name |
| settings.smtp.password | string | `nil` | SMTP password |
