# Remark42

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v1.7.1](https://img.shields.io/badge/AppVersion-v1.7.1-informational?style=flat-square)

A Helm chart for Remark42 on Kubernetes

## TL;DR

```bash
$ helm repo add groundhog2k https://groundhog2k.github.io/helm-charts/
$ helm install my-release groundhog2k/remark42
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
$ helm install my-release groundhog2k/remark42
```

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm uninstall my-release
```

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| @groundhog2k | redis | 0.4.0 |

## Common parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| fullnameOverride | string | `""` | Fully override the deployment name |
| nameOverride | string | `""` | Partially override the deployment name |

## Deployment parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| image.repository | string | `"umputun/remark42"` | Image name |
| image.tag | string | `""` | Image tag |
| imagePullSecrets | list | `[]` | Image pull secrets |
| strategy | object | `{}` | Pod deployment strategy |
| livenessProbe | object | `see values.yaml` | Liveness probe configuration |
| readinessProbe | object | `see values.yaml` | Readiness probe configuration |
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

## Service paramters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| service.port | int | `80` | Remark42 HTTP service port |
| service.type | string | `"ClusterIP"` | Service type |
| service.nodePort | int | `nil` | The node port (only relevant for type LoadBalancer or NodePort) |
| service.clusterIP | string | `nil` | The cluster ip address (only relevant for type LoadBalancer or NodePort) |
| service.loadBalancerIP | string | `nil` | The load balancer ip address (only relevant for type LoadBalancer) |

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
| settings.votesIp | string | `"false"` | Restrict votes from same IP address |


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

| settings.smtp.enabled | bool | `false` | Enable SMTP |
| settings.smtp.from | string | `nil` | SMTP from address |
| settings.smtp.host | string | `nil` | SMTP host |
| settings.smtp.port | int | `465` | SMTP port |
| settings.smtp.name | string | `nil` | SMTP user name |
| settings.smtp.password | string | `nil` | SMTP password |




## ??  ## Restrict votes from same IP address
## ??  votesIp: "false"
  
  ## Allow votes from anonymous users
  anonymousVote: "false"

  ## Restriction time for votes from same IP address
  votesIpTime: "5m"

  ## Low score threshold
  lowScoreThreshold: -5
  ## Critical c´score threshold
  criticalScoreThresold: -10
  ## Restrict comments score to be only positive
  positiveScore: "false"

  ## Words banned in comments
  restrictedWords:
  ## Names prohibited to use by a user
  restrictedNames:

  ## Edit time window
  editTime: "5m"

  # Read-only age of comments in days
  readonlyAge:

  ## Enable http to https proxy for images
  imageProxyhttp2https: "false"
  ## Enable caching of external images
  proxyExternalCache: "false"
  ## Enable emoji support
  emoji: "false"
  ## Minimized UI with basic information
  simpleView: "false"
  ## Disable internal CORS and delegate it to proxy
  proxyCors: "false"
  ## Limit hosts allowed to embed comments
  allowedHosts:
  ## Updates/sec limit
  updateLimit: "0.5"

  ## SMTP configuration
  smtp:
    ## Enable SMTP (default: false)
    enabled: false

    ## SMTP host
    host:

    ## SMTP port (default: 465)
    port: 465

    ## Enable SMTP TLS
    tls: true

    ## SMTP user name
    name:

    ## SMTP password
    password:

    ## SMTP timeout
    timeout: "10s"

  admin:
    ## Admin Ids
    sharedId:

    ## Admin Email addresses
    sharedEmail: "admin@${REMARK_URL}"

    # Password for admin (Basic auth)
    password:

  cache:
    ## Maximum number of cached items
    maxItems: 1000
    ## Maximum size of cached value
    maxValue: 65536
    ## Maximum size of all caches values
    maxSize: 50000000

  avatar:
    ## Avatar storage type (fs, bolt, uri)
    type: "fs"
    ## Maximum image size for resizing avatars
    resizeLimit: 0

  image:
    ## Image storage type (fs, bolt, uri)
    type: "fs"
    ## Maximum image size
    maxSize: 5000000
    ## Number of image partitions
    partitions: 100
    ## Image resizing
    resize:
      ## Width of resized image
      width: 2400
      ## Height of resized image
      height: 900

  auth:
    ttl:
      ## JWT TTL
      jwt: "5m"
      ## Cookie TTL
      cookie: "200h"
    ## Send JWT as header instead of cookie
    sentJwtHeader: "false"
    ## Set same site policy for cookies (default, none, lax, strict)
    sameSite: "default"
    ## Enable anonymous login
    anonymous: "false"
    email:
      ## Enable authentication via email
      enable: "false"
      ## Email from
      from:
      ## Email subject
      subject: "remark42 confirmation"
      ## Email content type
      contentType: "text/html"
      ## Custom email message template file
      template:
    
  notify:
    ## Notification type (telegram, slack, email)
    type: "none"
    ## Size of notification queue
    queue: 100
    telegram:
      ## Telegram token
      token:
      ## Telegram channel
      channel:
      ## Telegram timeout
      timeout: "5s"
    slack:
      ## Slack token
      token:
      ## Slack channel
      channel: "general"
    ## Email from address
    fromAddress:
    ## Verification message subject
    verificationSubject: "Email verification"
    ## Notify admin on new comments via admin.sharedEmail
    emailAdmin: "false"