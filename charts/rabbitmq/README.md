# RabbitMQ

![Version: 0.7.12](https://img.shields.io/badge/Version-0.7.12-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 3.12.11](https://img.shields.io/badge/AppVersion-3.12.11-informational?style=flat-square)

A Helm chart for a RabbitMQ HA-cluster on Kubernetes

## Changelog

see [RELEASENOTES.md](RELEASENOTES.md)

### ⚠️ Please make sure all feature flags are enabled before upgrading to RabbitMQ 3.12.x

## TL;DR

```bash
helm repo add groundhog2k https://groundhog2k.github.io/helm-charts/
helm install my-release groundhog2k/rabbitmq
```

## Introduction

This chart uses the original [RabbitMQ image from Docker Hub](https://hub.docker.com/_/rabbitmq) to deploy a stateful RabbitMQ cluster in Kubernetes.

It fully supports deployment of the multi-architecture docker image.

## Prerequisites

- Kubernetes 1.12+
- Helm 3.x
- PV provisioner support in the underlying infrastructure

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
helm install my-release groundhog2k/rabbitmq
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
| image.repository | string | `"rabbitmq"` | Image name |
| image.tag | string | `""` | Image tag |
| initImage.pullPolicy | string | `"IfNotPresent"` | Init image pull policy |
| initImage.registry | string | `"docker.io"` | Image registry |
| initImage.repository | string | `"busybox"` | Init image name |
| initImage.tag | string | `"latest"` | Init image tag |
| imagePullSecrets | list | `[]` | Image pull secrets |
| extraInitContainers | list | `[]` | Extra init containers |
| extaContainers | list | `[]` | Extra containers for usage as sidecars |
| startupProbe | object | `see values.yaml` | Startup probe configuration |
| livenessProbe | object | `see values.yaml` | Liveness probe configuration |
| readinessProbe | object | `see values.yaml` | Readiness probe configuration |
| customStartupProbe | object | `{}` | Custom startup probe (overwrites default startup probe configuration) |
| customLivenessProbe | object | `{}` | Custom liveness probe (overwrites default liveness probe configuration) |
| customReadinessProbe | object | `{}` | Custom readiness probe (overwrites default readiness probe configuration) |
| initResources | object | `{}` | Resource limits and requests for the default init container |
| resources | object | `{}` | Resource limits and requests |
| nodeSelector | object | `{}` | Deployment node selector |
| statefulsetLabels | object | `{}` | Additional StatefulSet labels |
| statefulsetAnnotations | object | `{}` | Additional StatefulSet annotations |
| podAnnotations | object | `{}` | Additional pod annotations |
| podSecurityContext | object | `see values.yaml` | Pod security context |
| securityContext | object | `see values.yaml` | Container security context |
| env | list | `[]` | Additional container environmment variables |
| args | list | `[]` | Additional container command arguments |
| terminationGracePeriodSeconds | int | `60` | Container termination grace period in seconds |
| rbac.create | bool | `true` | Enable creation of RBAC |
| serviceAccount.annotations | object | `{}` | Additional service account annotations |
| serviceAccount.create | bool | `true` | Enable service account creation |
| serviceAccount.name | string | `""` | Optional name of the service account |
| affinity | object | `{}` | Affinity for pod assignment |
| tolerations | list | `[]` | Tolerations for pod assignment |
| podManagementPolicy | string | `"OrderedReady"` | Pod management policy |
| updateStrategyType | string | `"RollingUpdate"` | Pod update strategy |
| replicaCount | int | `1` | Number of replicas |
| revisionHistoryLimit | int | `nil` | Maximum number of revisions maintained in revision history
| podDisruptionBudget | object | `{}` | Pod disruption budget |
| podDisruptionBudget.minAvailable | int | `nil` | Minimum number of pods that must be available after eviction |
| podDisruptionBudget.maxUnavailable | int | `nil` | Maximum number of pods that can be unavailable after eviction |

## Service parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| service.type | string | `"ClusterIP"` | Service type |
| service.clusterIP | string | `nil` | The cluster ip address (only relevant for type LoadBalancer or NodePort) |
| service.loadBalancerIP | string | `nil` | The load balancer ip address (only relevant for type LoadBalancer) |
| service.amqp.port | int | `5672` | AMQP service port |
| service.amqp.nodePort | int | `nil` | Service node port (only relevant for type LoadBalancer or NodePort)|
| service.amqps.port | int | `5671` | Secure AMQP service port |
| service.amqps.nodePort | int | `nil` | Service node port (only relevant for type LoadBalancer or NodePort)|
| service.mgmt.port | int | `15672` | Management UI service port |
| service.mgmt.nodePort | int | `nil` | Service node port (only relevant for type LoadBalancer or NodePort) |
| service.prometheus.port | int | `15692` | Prometheus service port |
| service.prometheus.nodePort | int | `nil` | Service node port (only relevant for type LoadBalancer or NodePort) |
| service.annotations | object | `{}` | Additional service annotations |
| service.labels | object | `{}` | Additional service labels |

## Extra services parameters

Section to define custom services

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| extraServices[].name | string | `nil` | Unique name of the input service |
| extraServices[].type | string | `nil` | Service type (ClusterIP / NodePort / LoadBalancer) |
| extraServices[].protocol | string | `nil` | Protocol type (TCP / UDP) |
| extraServices[].containerPort | int | `nil` | Container port |
| extraServices[].port | int | `nil` | Service port |
| extraServices[].nodePort | int | `nil` | The node port (only relevant for type LoadBalancer or NodePort) |
| extraServices[].clusterIP | string | `nil` | The cluster ip address (only relevant for type LoadBalancer or NodePort) |
| extraServices[].loadBalancerIP | string | `nil` | The load balancer ip address (only relevant for type LoadBalancer) |
| extraServices[].annotations | object | `{}` | Additional service annotations |
| extraServices[].labels | object | `{}` | Additional service labels |

## Service monitor parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| serviceMonitor.enabled | bool | `false` | Enable service monitor |
| serviceMonitor.additionalLabels | object | `{}` | Additional labels for the service monitor object |
| serviceMonitor.annotations | object | `{}` | Annotations for the service monitor object |
| serviceMonitor.interval | Duration | `nil` | Scrape interval for prometheus |
| serviceMonitor.scrapeTimeout | Duration | `nil` | Scrape timeout value |
| serviceMonitor.extraEndpointParameters | object | `nil` | Extra parameters rendered to the [service monitor endpoint](https://github.com/prometheus-operator/prometheus-operator/blob/main/Documentation/api.md#endpoint) |
| serviceMonitor.extraParameters | object | `nil` | Extra parameters rendered to the [service monitor object](https://github.com/prometheus-operator/prometheus-operator/blob/main/Documentation/api.md#servicemonitorspec) |

## Storage parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| storage.accessModes[0] | string | `"ReadWriteOnce"` | Storage access mode |
| storage.persistentVolumeClaimName | string | `nil` | PVC name when existing storage volume should be used |
| storage.requestedSize | string | `nil` | Size for new PVC, when no existing PVC is used |
| storage.className | string | `nil` | Storage class name |

## Ingress parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| ingress.enabled | bool | `false` | Enable ingress for the Management UI service |
| ingress.annotations | string | `nil` | Additional annotations for ingress |
| ingress.hosts[0].host: | string | `""` | Hostname for the ingress endpoint |
| ingress.hosts[0].host.paths[0] | string | `"/"` | Path for the RabbitMQ Management UI |
| ingress.tls | list | `[]` | Ingress TLS parameters |

## Network policies

Allows to define optional network policies for [ingress and egress](https://kubernetes.io/docs/concepts/services-networking/network-policies/)
The policyTypes will be automatically set

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| networkPolicy.ingress | object | `{}` | Ingress network policies |
| networkPolicy.egress | object | `{}` | Egress network policies |

## RabbitMQ base parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| clusterDomain | string | `"cluster.local"` | Kubernetes cluster domain (DNS) suffix |
| plugins | list | `[]` | List of additional RabbitMQ plugins that should be activated (see: [RabbitMQ plugins](https://www.rabbitmq.com/plugins.html)) |
| authentication.user | string | `nil` | Initial user name (guest) (Alternative: Set environment variable RABBITMQ_DEFAULT_USER) |
| authentication.password | string | `nil` | Initial password (guest) (Alternative: set environment variable RABBITMQ_DEFAULT_PASS) |
| authentication.erlangCookie | string | `nil` | Erlang cookie (MANDATORY) (Alternative: Set the environment variable ERLANG_COOKIE) |
| clustering.rebalance | bool | `false` | Enable rebalance queues with master when new replica is created |
| clustering.forceBoot | bool | `false` | Force boot in case cluster peers are not available |
| clustering.useLongName | bool | `true` | Use FQDN for RabbitMQ node names |

## RabbitMQ memory parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| options.memoryHighWatermark.enabled | bool | `false` | Enables high memory watermark configuration |
| options.memoryHighWatermark.type | string | `"relative"` | Type of watermark value (relative or absolute) |
| options.memoryHighWatermark.value | float | `0.4` | Watermark value (default: 40%) |
| options.memoryHighWatermark.pagingRatio | float | `nil` | Paging threshold when RabbitMQ starts paging queue content before high memory watermark is reached |
| options.memory.totalAvailableOverrideValue | int | `nil` | Overwrites the value that is automatically calculated from resource.limits.memory |
| options.memory.calculationStrategy | string | `nil` | Strategy for memory usage report (rss or allocated) |

## RabbitMQ communication and SSL parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| options.tcp.port | int | `5672` | AMQP tcp port |
| options.ssl.enabled | bool | `false` | Enable secure AMQP (amqps) (see `values.yaml` for more details) |
| options.ssl.port | int | `5671` | AMQPS tcp port |
| options.ssl.verify | bool | `false` | Enables or disables peer verification |
| options.ssl.failIfNoPeerCert | bool | `false` | Reject TLS connection when client fails to provide a certificate |
| options.ssl.depth | int | `nil` | Client certificate verification depth |
| options.ssl.certPaths | object | `{}` | Pathes of the certificate files |
| options.ssl.certPaths.cacert | string | `nil` | Path to the CA certificate(s) file |
| options.ssl.certPaths.cert | string | `nil` | Path to the server certificate file |
| options.ssl.certPaths.key | string | `nil` | Path to the private key file (Hint: ssl_options.password configuration needs to be provided as `extraSecretConfig:`) |

## RabbitMQ plugin base parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| managementPlugin.enabled | bool | `true` | Enable management UI plugin with default configuration |
| managementPlugin.tcp.port | int | `15672` | Management UI port |
| prometheusPlugin.enabled | bool | `true` | Enable prometheus monitoring plugin with default configuration |
| prometheusPlugin.tcp.port | int | `15692` | Prometheus plugin TCP port |
| k8sPeerDiscoveryPlugin.enabled | bool | `true` | Enable K8s peer discovery plugin for a RabbitMQ HA-cluster with default configuration |
| k8sPeerDiscoveryPlugin.addressType | string | `"hostname"` | K8s peer discovery plugin address type (hostname or ip) |

## RabbitMQ custom configuration parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| customConfig | string | `nil` | Custom inline configuration entries for rabbitmq.conf (see [RabbitMQ config](https://www.rabbitmq.com/configure.html#config-file)) |
| extraSecretConfigs | string | `nil` | An existing secret with files that will be added to the `rabbitmq.conf` |
| customAdvancedConfig | string | `nil` | Custom inline advanced configuration entries for advanced.config (see [RabbitMQ advanced config](https://www.rabbitmq.com/configure.html#advanced-config-file)) |
| extraSecretAdvancedConfigs | string | `nil` | An existing secret with files that will be added to the `advanced.conf` |
| extraEnvSecrets | list | `[]` | A list of existing secrets that will be mounted into the container as environment variables |
| extraSecrets | list | `[]` | A list of additional existing secrets that will be mounted into the container |
| extraSecrets[].name | string | `nil` | Name of the existing Kubernetes secret |
| extraSecrets[].mountPath | string | `nil` | Mount path where the secret should be mounted into the container (f.e. /mysecretfolder) |
