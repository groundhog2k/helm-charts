# Remark42

![Version: 0.5.3](https://img.shields.io/badge/Version-0.5.3-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v1.11.2](https://img.shields.io/badge/AppVersion-v1.11.2-informational?style=flat-square)

A Helm chart for Remark42 on Kubernetes

## TL;DR

```bash
helm repo add groundhog2k https://groundhog2k.github.io/helm-charts/
helm install my-release groundhog2k/remark42
```

## Introduction

This chart uses the original [Remark42 from Gitlab](https://hub.docker.com/r/umputun/remark42) to deploy Remark42 in Kubernetes.

## Limitations

The Remark42 image supports amd64 architecture only!

## Prerequisites

- Kubernetes 1.12+
- Helm 3.x
- PV provisioner support in the underlying infrastructure

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
helm install my-release groundhog2k/remark42
```

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
helm uninstall my-release
```

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| @groundhog2k | redis | 0.6.0 |

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
| image.repository | string | `"umputun/remark42"` | Image name |
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
| revisionHistoryLimit | int | `nil` | Maximum number of revisions maintained in revision history

## Service paramters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| service.port | int | `80` | Remark42 HTTP service port |
| service.type | string | `"ClusterIP"` | Service type |
| service.nodePort | int | `nil` | The node port (only relevant for type LoadBalancer or NodePort) |
| service.clusterIP | string | `nil` | The cluster ip address (only relevant for type LoadBalancer or NodePort) |
| service.loadBalancerIP | string | `nil` | The load balancer ip address (only relevant for type LoadBalancer) |
| service.annotations | object | `{}` | Additional service annotations |

## Ingress parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| ingress.enabled | bool | `false` | Enable ingress for Remark42 service |
| ingress.annotations | string | `nil` | Additional annotations for ingress |
| ingress.host | string | `nil` | Hostname for the ingress endpoint |
| ingress.path | string | `/` | Ingress endpoint path
| ingress.tls | object | `{}` | Ingress TLS parameters |
| ingress.tls.secretName | string | `nil` | Ingress TLS secret name |

## Redis cache

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| externalCache.enabled | bool | `false` | Enable external Redis cache |
| externalCache.host | string | `nil` | External Redis host |
| externalCache.port | int | `6379` | External Redis port |
| redis.enabled | bool | `false` | Enable Redis cache deployment (will disable external cache settings) |
| redis.storage | string | `nil` | Redis storage settings |

## Remark42 parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| settings.url | string | `nil` | URL to this Remark42 site |
| settings.site | string | `"remark"` | Site Id |
| settings.secretKey | string | `nil` | Secret key |
| settings.timeZone | string | `"GTC"` | Time zone (f.e. Europe/Berlin) |
| settings.maxBackupFiles | int | `10` | Maximum number of nightly backup files to keep |
| settings.maxCommentSize | int | `2048` | Comment size limit |
| settings.maxVotes | int | `-1` | Vote limits per comment (-1 for unlimited) |
| settings.votesIp | bool | `false` | Restrict votes from same IP address |
| settings.anonymousVote | bool | `false` | Allow votes from anonymous users |
| settings.votesIpTime | string | `"5m"` | Restriction time for votes from same IP address |
| settings.lowScoreThreshold | int | `-5` | Low score threshold |
| settings.criticalScoreThresold | int | `-10` | Critical score threshold |
| settings.positiveScore | bool | `false` | Restrict comments score to be only positive |
| settings.restrictedWords | string | `nil` | Words banned in comments |
| settings.restrictedNames | string | `nil` | Names prohibited to use by a user |
| settings.editTime | string | `5m` | Edit time window |
| settings.readonlyAge | int | `nil` | Read-only age of comments in days |
| settings.imageProxyhttp2https | bool | `false` | Enable http to https proxy for images |
| settings.proxyExternalCache | bool | `false` | Enable caching of external images |
| settings.emoji | bool | `false` | Enable emoji support |
| settings.simpleView | bool | `false` | Minimized UI with basic information |
| settings.proxyCors | bool | `false` | Disable internal CORS and delegate it to proxy |
| settings.allowedHosts | string | `nil` | Limit hosts allowed to embed comments |
| settings.updateLimit | string | `0.5` | Updates/sec limit |

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| settings.smtp.enabled | bool | `false` | Enable SMTP |
| settings.smtp.from | string | `nil` | SMTP from address |
| settings.smtp.host | string | `nil` | SMTP host |
| settings.smtp.port | int | `465` | SMTP port |
| settings.smtp.tls | bool | `true` | Use TLS |
| settings.smtp.name | string | `nil` | SMTP user name |
| settings.smtp.password | string | `nil` | SMTP password |
| settings.smtp.timeout | string | `10s` | SMTP timeout |

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| settings.admin.sharedId | string | `nil` | Admin Ids |
| settings.admin.sharedEmail | string | `"admin@${REMARK_URL}"` | Admin Email addresses |
| settings.admin.password | string | `nil` | Password for admin (Basic auth) |

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| settings.cache.maxItems | int | `1000` | Maximum number of cached items |
| settings.cache.maxValue | int | `65536` | Maximum size of cached value |
| settings.cache.maxSize | int | `"50000000"` | Maximum size of all caches values |

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| settings.avatar.type | string | `"fs"` | Avatar storage type (fs, bolt, uri) |
| settings.avatar.resizeLimit | int | `0`| Maximum image size for resizing avatars (0 = disabled) |

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| settings.image.type | string | `"fs"` | Image storage type (fs, bolt, uri) |
| settings.image.maxSize | int | `"5000000"` | Maximum image size |
| settings.image.partitions | int | `10` | Number of image partitions |
| settings.image.resize.width | int | `2400` | Width of resized image |
| settings.image.resize.height | int | `900` | Height of resized image |

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| settings.auth.ttl.jwt | string | `"5m"` | JWT TTL |
| settings.auth.ttl.cookie | string | `"200h"` | Cookie TTL |
| settings.auth.sentJwtHeader | bool | `false` | Send JWT as header instead of cookie |
| settings.auth.sameSite | string | `"default"` | Set same site policy for cookies (default, none, lax, strict) |
| settings.auth.anonymous | bool | `false` | Enable anonymous login |
| settings.auth.email.enable | bool | `false` | Enable authentication via email |
| settings.auth.email.from | string | `nil` | Email from |
| settings.auth.email.subject | string | `"remark42 confirmation"` | Email subject |
| settings.auth.email.contentType | string | `"text/html"` | Email content type |
| settings.auth.email.template | string | `nil` | Custom email message template file |

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| settings.notify.type.user | string | `"none"` | User notification type (none, telegram, slack, email) |
| settings.notify.type.admin | string | `"none"` | Admin notification type (none, telegram, slack, email, webhook) |
| settings.notify.queue | int | `100` | Size of notification queue |
| settings.notify.telegram.token | string | `nil` | Telegram token |
| settings.notify.telegram.channel | string | `nil` | Telegram channel |
| settings.notify.telegram.timeout | string | `"5s"` | Telegram timeout |
| settings.notify.slack.token | string | `nil` | Slack token |
| settings.notify.slack.channel | string | `"general"` | Slack channel |
| settings.notify.email.fromAddress | string | `nil` | Email from address |
| settings.notify.email.verificationSubject | string | `"Email verification"` | Verification message subject |
| settings.notify.email.emailAdmin | bool | `false` | Notify admin on new comments via admin.sharedEmail (DEPRECATED OPTION - use `settings.notify.type.admin` = `"email"` instead) - This setting will overwrite `settings.notify.type.admin` |
| settings.notify.webhook.url | string | `nil` | Webhook notification URL for admin notifications |
| settings.notify.webhook.template | string | `{"text": ""}` | Webhook payload template |
| settings.notify.webhook.headers | string | `nil` | HTTP header in format Header1:Value1,Header2:Value2,... |
| settings.notify.webhook.timeout | string | `5s` | Webhook request timeout |

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| settings.oauth.github.enabled | bool | `false` | Enable Github OAuth |
| settings.oauth.github.key | string | `nil` | Github OAuth key |
| settings.oauth.github.secret | string | `nil` | Github OAuth secret |
| settings.oauth.facebook.enabled | bool | `false` | Enable Facebook OAuth |
| settings.oauth.facebook.key | string | `nil` | Facebook OAuth key |
| settings.oauth.facebook.secret | string | `nil` | Facebook OAuth secret |
| settings.oauth.google.enabled | bool | `false` | Enable Google OAuth |
| settings.oauth.google.key | string | `nil` | Google OAuth key |
| settings.oauth.google.secret | string | `nil` | Google OAuth secret |
| settings.oauth.twitter.enabled | bool | `false` | Enable Twitter OAuth |
| settings.oauth.twitter.key | string | `nil` | Twitter OAuth key |
| settings.oauth.twitter.secret | string | `nil` | Twitter OAuth secret |
| settings.oauth.microsoft.enabled | bool | `false` | Enable Microsoft OAuth |
| settings.oauth.microsoft.key | string | `nil` | Microsoft OAuth key |
| settings.oauth.microsoft.secret | string | `nil` | Microsoft OAuth secret |
| settings.oauth.yandex.enabled | bool | `false` | Enable Yandex OAuth |
| settings.oauth.yandex.key | string | `nil` | Yandex OAuth key |
| settings.oauth.yandex.secret | string | `nil` | Yandex OAuth secret |

## Storage parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| storage | object | `{}` | Remark42 data storage |
| storage.accessModes[0] | string | `"ReadWriteOnce"` | Storage access mode |
| storage.persistentVolumeClaimName | string | `nil` | PVC name when existing storage volume should be used |
| storage.requestedSize | string | `nil` | Size for new PVC, when no existing PVC is used |
| storage.className | string | `nil` | Storage class name |
| storage.keepPvc | bool | `false` | Keep a created Persistent volume claim when uninstalling the helm chart |
