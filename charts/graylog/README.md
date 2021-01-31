# Graylog

![Version: 0.1.3](https://img.shields.io/badge/Version-0.1.3-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 4.0.2](https://img.shields.io/badge/AppVersion-4.0.2-informational?style=flat-square)

A Helm chart for Graylog on Kubernetes

## TL;DR

```bash
$ helm repo add groundhog2k https://groundhog2k.github.io/helm-charts/
$ helm install my-release groundhog2k/graylog
```

## Introduction

This chart uses the original [Graylog image from Docker Hub](https://hub.docker.com/r/graylog/graylog/) to deploy a stateful Graylog instance in a Kubernetes cluster.

## Prerequisites

- Kubernetes 1.12+
- Helm 3.x
- PV provisioner support in the underlying infrastructure

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install my-release groundhog2k/graylog
```

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm uninstall my-release
```

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| @groundhog2k | mongodb | 0.2.9 |
| @groundhog2k | elasticsearch | 0.1.1 |

## Common parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| fullnameOverride | string | `""` | Fully override the deployment name |
| nameOverride | string | `""` | Partially override the deployment name |

## Deployment parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| image.repository | string | `"graylog/graylog"` | Image name |
| image.tag | string | `""` | Image tag |
| initImage.pullPolicy | string | `"IfNotPresent"` | Init container image pull policy |
| initImage.repository | string | `"busybox"` | Default init container image |
| initImage.tag | string | `"latest"` | Init container image tag |
| imagePullSecrets | list | `[]` | Image pull secrets |
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
| args | list | `[]` | Additional container command arguments |
| serviceAccount.annotations | object | `{}` | Additional service account annotations |
| serviceAccount.create | bool | `false` | Enable service account creation |
| serviceAccount.name | string | `""` | Name of the service account |
| affinity | object | `{}` | Pod affinity |
| tolerations | list | `[]` | Pod tolerations |
| podManagementPolicy | string | `OrderedReady` | Pod management policy |
| updateStrategyType | string | `RollingUpdate` | Update strategy |
| replicaCount | int | `1` | Number of replicas (Not supported - Don't change in this chart version) |

## Service paramters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| service.type | string | `"ClusterIP"` | Service type |
| service.http | int | `80` | Graylog http service port |
| service.nodePort | int | `nil` | The http node port (only relevant for type LoadBalancer or NodePort) |
| service.clusterIP | string | `nil` | The cluster ip address (only relevant for type LoadBalancer or NodePort) |
| service.loadBalancerIP | string | `nil` | The load balancer ip address (only relevant for type LoadBalancer) |

## Extra service parameters

Section to define all additional UDP/TCP inputs for Graylog

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| extraServices[].name | string | `nil` | Unique name of the input service |
| extraServices[].type | string | `nil` | Service type (ClusterIP / NodePort / LoadBalancer) |
| extraServices[].protocol | string | `nil` | Protocol type (TCP / UDP) |
| extraServices[].containerPort | int | `nil` | Container port |
| extraServices[].port | int | `nil` | Service port |
| extraServices[].nodePort | int | `nil` | The http node port (only relevant for type LoadBalancer or NodePort) |
| extraServices[].clusterIP | string | `nil` | The cluster ip address (only relevant for type LoadBalancer or NodePort) |
| extraServices[].loadBalancerIP | string | `nil` | The load balancer ip address (only relevant for type LoadBalancer) |


## Ingress parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| ingress.enabled | bool | `false` | Enable ingress for Gitea service |
| ingress.annotations | string | `nil` | Additional annotations for ingress |
| ingress.hosts[].host | string | `nil` | Hostname for the ingress endpoint |
| ingress.hosts[].host.paths[] | string | `nil` | Path routing for the ingress endpoint host |
| ingress.tls | list | `[]` | Ingress TLS parameters |

## Database settings

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| externalDatabase.host | string | `nil` | External MongoDB database host |
| externalDatabase.name | string | `"graylog"` | External database name |
| externalDatabase.user | string | `nil` | External database user name |
| externalDatabase.password | string | `nil` | External database user password |
| mongodb.enabled | bool | `false` | Enable MongoDB deployment (will disable external database settings) |
| mongodb.settings.rootUsername | string | `admin` | The root username |
| mongodb.settings.rootPassword | string | `{}` | The root users password (Random value if not specified) |
| mongodb.userDatabase | object | `{}` | Optional MongoDB user database |
| mongodb.userDatabase.name | string | `nil` | Name of the user database |
| mongodb.userDatabase.user | string | `nil` | User name with full access to user database|
| mongodb.userDatabase.password | string | `nil` | Password of created user (Random value if not specified) |
| mongodb.storage | object | `see values.yaml` | MongoDB storage settings |
| elasticsearch.enabled | bool | `false` | Enable Elasticsearch deployment (will disable `elastic.hosts` setting) |
| elasticsearch.javaOpts | string | `"-Xms512m -Xmx512m"` | Additional JVM options for Elasticsearch |
| elasticsearch.clusterName | string | `"graylog"` | Elasticsearch cluster name |
| elasticsearch.storage | object | `see values.yaml` | Elasticsearch storage settings |

## MaxMind GeoIP2 database
| Key | Type | Default | Description |
|-----|------|---------|-------------|
| initGeoIPDatabase.enabled | bool | `false` | Enable GeoIP database download |
| initGeoIPDatabase.accountId | string | `""` | MaxMind UserId / AccountId |
| initGeoIPDatabase.licenseKey | string | `""` | MaxMind license key |
| initGeoIPDatabase.editionId | string | `"GeoLite2-City"` | Default database edition Id (https://www.maxmind.com/en/accounts/473747/geoip/downloads) |
| initGeoIPDatabase.host | string | `""` | The MaxMind download host (not necessary to change that - default updates.maxmind.com)|
| initGeoIPDatabase.proxy | string | `""` | A valid proxy if internet access is running through a proxy |
| initGeoIPDatabase.proxyUserPassword | string | `""` | Proxy username and password in format "username:password" |

## Storage parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| storage.accessModes[0] | string | `"ReadWriteOnce"` | Storage access mode |
| storage.persistentVolumeClaimName | string | `nil` | PVC name when existing storage volume should be used |
| storage.requestedSize | string | `nil` | Size for new PVC, when no existing PVC is used |
| storage.className | string | `nil` | Storage class name |

## Graylog parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| settings.http.externalUri | string | `http://127.0.0.1:9000/` | External URI for Graylog |
| settings.http.publishUri | string | `nil` | Graylog publish URI |
| settings.clusterName | string | `singlenode-cluster` | Cluster name |
| settings.javaOpts | string | `nil` | Additional JVM options for Graylog |
| settings.passwordSecret | string | `somepasswordpepper` | Secret for password encryption and salting |
| settings.rootUser.username | string | `"admin"` | Graylog root user name |
| settings.rootUser.sha2password | string | `"8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918"` | Graylog root user password SHA2 (default: "admin") |
| settings.rootUser.email | string | `""` | Graylog root user email address |
| settings.rootUser.timezone | string | `"UTC"` | Graylog root user timezone |
| settings.journal.maxAge | string | `"12h"` | Graylog max. journal age |
| settings.journal.maxSize | string | `"5gb"` | Graylog max. journal size |
| settings.elastic.hosts | string | `"http://127.0.0.1:9200"` | Comma separated list of Elasticsearch hosts (only used when `elasticsearch.enabled` is false) |
| settings.elastic.indexPrefix | string | `"graylog"` | Elasticsearch index prefix |
| settings.smtp.enabled | bool | `false` | Enable/Disable SMTP |
| settings.smtp.host | string | `"mail.example.com"` | SMTP host name |
| settings.smtp.port | int | `587` | SMTP port |
| settings.smtp.useAuth | bool | `true` | Use SMTP authentication |
| settings.smtp.useTls | bool | `true` | Use SMTP with STARTTLS |
| settings.smtp.useSsl | bool | `false` | Enable SMTP over SSL (SMTPS) |
| settings.smtp.username | string | `"you@example.com"` | SMTP username |
| settings.smtp.password | string | `"secret"` | SMTP password |
| settings.smtp.emailFrom | string | `"you@example.com"` | Mail from address |
| settings.smtp.subjectPrefix | string | `"[graylog]"` | Mail subject prefix |

Further Graylog parameter can be set via environment variables (see Deployment parameter: env)
