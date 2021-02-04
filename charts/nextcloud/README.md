#  Nextcloud

![Version: 0.4.3](https://img.shields.io/badge/Version-0.4.3-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 20.0.6-apache](https://img.shields.io/badge/AppVersion-20.0.6-informational?style=flat-square)

A Helm chart for Nextcloud on Kubernetes

## TL;DR

```bash
$ helm repo add groundhog2k https://groundhog2k.github.io/helm-charts/
$ helm install my-release groundhog2k/nextcloud
```

## Introduction

This chart uses the original [Nextcloud from Docker](https://hub.docker.com/_/nextcloud) to deploy Nextcloud in Kubernetes.

It fully supports deployment of the multi-architecture docker image.

## Prerequisites

- Kubernetes 1.12+
- Helm 3.x
- PV provisioner support in the underlying infrastructure

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install my-release groundhog2k/nextcloud
```

## Upgrading the Chart[](#upgrade)

To upgrade the chart or Nextcloud version with the release name `my-release`:

```bash
$ helm upgrade my-release groundhog2k/nextcloud
```

## Post-upgrade steps

After some Nextcloud version upgrades it's necessary to update database indicies of Nextcloud too. Therefor an optional post-upgrade step was prepared in this helm chart.

The post upgrade can be started manually after the Nextcloud/chart upgrade (like described in ['Upgrading the chart'](#upgrade) section) or both can be done in one step.
In the latter case the postUpgradeHookDelay should be set to a higher value. (f.i. 120 seconds)

```bash
$ helm upgrade my-release groundhog2k/nextcloud --set enablePostUpgradeHook=true,postUpgradeHookDelay=120
```

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm uninstall my-release
```

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| @groundhog2k | mariadb | 0.2.9 |
| @groundhog2k | postgres | 0.2.8 |
| @groundhog2k | redis | 0.2.9 |

## Common parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| fullnameOverride | string | `""` | Fully override the deployment name |
| nameOverride | string | `""` | Partially override the deployment name |

## Deployment parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| image.repository | string | `"nextcloud"` | Image name |
| image.tag | string | `""` | Image tag |
| imagePullSecrets | list | `[]` | Image pull secrets |
| strategy.type | object | `"RollingUpdate"` | Pod deployment strategy |
| livenessProbe | object | `see values.yaml` | Liveness probe configuration |
| startupProbe | object | `see values.yaml` | Startup probe configuration |
| customLivenessProbe | object | `{}` | Custom liveness probe (overwrites default liveness probe configuration) |
| customStartupProbe | object | `{}` | Custom startup probe (overwrites default startup probe configuration) |
| resources | object | `{}` | Resource limits and requests |
| nodeSelector | object | `{}` | Deployment node selector |
| podAnnotations | object | `{}` | Additional pod annotations |
| podSecurityContext | object | `see values.yaml` | Pod security context |
| securityContext | object | `see values.yaml` | Container security context |
| env | list | `[]` | Additional container environmment variables |
| args | list | `[]` | Additional container command arguments |
| serviceAccount.create | bool | `false` | Enable service account creation |
| serviceAccount.name | string | `""` | Optional name of the service account |
| serviceAccount.annotations | object | `{}` | Additional service account annotations |
| affinity | object | `{}` | Affinity for pod assignment |
| tolerations | list | `[]` | Tolerations for pod assignment |
| containerPort | int | `8000` | Internal http container port |
| replicaCount | int | `1` | Number of replicas |
| initImage.pullPolicy | string | `"IfNotPresent"` | Init container image pull policy |
| initImage.repository | string | `"busybox"` | Default init container image |
| initImage.tag | string | `"latest"` | Init container image tag |
| postUpgradeHook | bool | `false` | Enable post upgrade hook |
| postUpgradeHookDelay | int | `10` | Delay in seconds before post-upgrade steps are initiated |
| postUpgradeSteps | list | `see values.yaml` | Script with post upgrade steps |

## Cron jobs

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| defaultCronJobs | list | '[1]' | Internal planned default cron job |
| defaultCronJobs[1].name | string | `"cronphp"` | Name of the default cron job |
| defaultCronJobs[1].schedule | string | `"*/5 * * * *"` | Schedule for the default cron job (5 minutes) |
| defaultCronJobs[1].command | string | `"php -f /var/www/html/cron.php"` | Command for default cron.php job |
| cronJobs | list | `[]` | List of additional planned cron jobs |
| cronJobs[].name | string | `nil` | Name of the cron job |
| cronJobs[].schedule | string | `nil` | Schedule for the cron job |
| cronJobs[].command | string | `nil` | Command for planned execution |
| cronJobs[].affinity | object | `{}` | Affinity for pod assignment |
| cronJobs[].tolerations | list | `[]` | Tolerations for pod assignment |
| cronJobs[].nodeSelector | object | `{}` | Deployment node selector |
| cronJobs[].resources | object | `{}` | Resource limits and requests |

## Service paramters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| service.port | int | `80` | Commento HTTP service port |
| service.type | string | `"ClusterIP"` | Service type |
| service.nodePort | int | `nil` | The node port (only relevant for type LoadBalancer or NodePort) |
| service.clusterIP | string | `nil` | The cluster ip address (only relevant for type LoadBalancer or NodePort) |
| service.loadBalancerIP | string | `nil` | The load balancer ip address (only relevant for type LoadBalancer) |

## Ingress parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| ingress.enabled | bool | `false` | Enable ingress for Nextcloud service |
| ingress.annotations | string | `nil` | Additional annotations for ingress |
| ingress.hosts[0].host | string | `""` | Hostname for the ingress endpoint |
| ingress.tls | list | `[]` | Ingress TLS parameters |
| ingress.maxBodySize | string | `"64m"` | Maximum body size for post requests |

## Redis session cache

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| externalCache.enabled | bool | `false` | Enable external Redis cache |
| externalCache.host | string | `nil` | External Redis host |
| externalCache.password | string | `nil` | External Redis password |
| externalCache.port | int | `6379` | External Redis port |
| redis.enabled | bool | `false` | Enable Redis cache deployment (will disable external cache settings) |
| redis.storage | string | `nil` | Redis storage settings |

## Database settings

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| externalDatabase.host | string | `nil` | External database host |
| externalDatabase.name | string | `"nextcloud"` | External database name |
| externalDatabase.user | string | `nil` | External database user name |
| externalDatabase.password | string | `nil` | External database user password |
| externalDatabase.type | string | `"sqlite"` | External database type (mariadb/mysql or postgres - default: sqlite) |
| mariadb.enabled | bool | `false` | Enable MariaDB deployment (will disable external database settings) |
| mariadb.settings.arguments[0] | string | `"--character-set-server=utf8mb4"` | Enable MariaDB UTF8MB4 character set|
| mariadb.settings.arguments[1] | string | `"--collation-server=utf8mb4_unicode_ci"` | Enable UTF8MB4 unicode |
| mariadb.settings.rootPassword | string | `nil` | MariaDB root user password |
| mariadb.storage | string | `nil` | MariaDB storage settings |
| mariadb.userDatabase.name | string | `nil` | MariaDB nextcloud database name |
| mariadb.userDatabase.password | string | `nil` | MariaDB nextcloud database user |
| mariadb.userDatabase.user | string | `nil` | MariaDB nextcloud database user password |
| postgres.enabled | bool | `false` | Enable PostgreSQL deployment (will disable external database settings) |
| postgres.settings.superuserPassword | string | `nil` | PostgreSQL superuser password |
| postgres.storage | string | `nil` | PostgreSQL storage settings |
| postgres.userDatabase.name | string | `nil` | PostgreSQL nextcloud database name |
| postgres.userDatabase.user | string | `nil` | PostgreSQL nextcloud database user |
| postgres.userDatabase.password | string | `nil` | PostgreSQL nextcloud database user password |

## Nextcloud parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| apacheDefaultSiteConfig | string | `nil` | Overwrite default apache 000-default.conf |
| apachePortsConfig | string | `nil` | Overwrite default apache ports.conf |
| customPhpConfig | string | `nil` | Additional PHP custom.ini |
| memoryLimitConfig | string | `nil` | Additional PHP memory-limit.ini |
| settings.admin.name | string | `nil` | Nextcloud administrator user |
| settings.admin.password | string | `nil` | Nextcloud admin user password |
| settings.update | bool | `false` | Enable update (Only necessary if custom command is used) |
| settings.maxFileUploadSize | string | `64M` | Maximum file upload size |
| settings.memoryLimit | string | `512M` | PHP memory limit |
| settings.disableRewriteIP | bool | `false` | Disable rewriting IP address |
| settings.trustedDomains | string | `""` | List of trusted domains separated by blank space |
| settings.trustedProxies | string | `"10.0.0.0/8"` | Trusted proxies |
| settings.smtp.enabled | bool | `false` | Enable SMTP |
| settings.smtp.authType | string | `"LOGIN"` | SMTP auth type (default: LOGIN) |
| settings.smtp.domain | string | `nil` | SMTP domain |
| settings.smtp.from | string | `nil` | SMTP from address |
| settings.smtp.host | string | `nil` | SMTP host |
| settings.smtp.port | int | `465` | SMTP port |
| settings.smtp.name | string | `nil` | SMTP user name |
| settings.smtp.password | string | `nil` | SMTP password |
| settings.smtp.secure | bool | `true` | Use secure SMTP |

## Storage parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| storage.nextcloud | object | `{}` | Nextcloud internal storage |
| storage.nextcloud.accessModes[0] | string | `"ReadWriteOnce"` | Storage access mode |
| storage.nextcloud.persistentVolumeClaimName | string | `nil` | PVC name when existing storage volume should be used |
| storage.nextcloud.requestedSize | string | `nil` | Size for new PVC, when no existing PVC is used |
| storage.nextcloud.className | string | `nil` | Storage class name |
| storage.nextcloudData | object | `{}` | Nextcloud user data storage |
| storage.nextcloudData.accessModes[0] | string | `"ReadWriteOnce"` | Storage access mode |
| storage.nextcloudData.persistentVolumeClaimName | string | `nil` | PVC name when existing storage volume should be used |
| storage.nextcloudData.requestedSize | string | `nil` | Size for new PVC, when no existing PVC is used |
| storage.nextcloudData.className | string | `nil` | Storage class name |
