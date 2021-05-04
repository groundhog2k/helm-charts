# Elasticsearch

![Version: 0.1.102](https://img.shields.io/badge/Version-0.1.102-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 7.10.2](https://img.shields.io/badge/AppVersion-7.10.2-informational?style=flat-square)

A Helm chart for Elasticsearch on Kubernetes

## TL;DR

```bash
$ helm repo add groundhog2k https://groundhog2k.github.io/helm-charts/
$ helm install my-release groundhog2k/elasticsearch
```

## Introduction

This chart uses the original [Elasticsearch image from Docker Hub](https://hub.docker.com/_/elasticsearch/) to deploy a stateful Elasticsearch instance in a Kubernetes cluster.

It fully supports deployment of the multi-architecture docker image.

## Limitations

The actual chart version only supports a single-node Elasticsearch cluster (replicaset = 1). Future upgrades will allow to span a multi-node cluster.

## Prerequisites

- Kubernetes 1.12+
- Helm 3.x
- PV provisioner support in the underlying infrastructure

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install my-release groundhog2k/elasticsearch
```

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm uninstall my-release
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
| image.repository | string | `"elasticsearch"` | Image name |
| image.tag | string | `""` | Image tag |
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
| service.httpPort | int | `9200` | Elasticsearch http service port |
| service.transportPort | int | `9300` | Elasticsearch transport service port |
| service.httpNodePort | int | `nil` | The http node port (only relevant for type LoadBalancer or NodePort) |
| service.transportNodePort | int | `nil` | The transport node port (only relevant for type LoadBalancer or NodePort) |
| service.clusterIP | string | `nil` | The cluster ip address (only relevant for type LoadBalancer or NodePort) |
| service.loadBalancerIP | string | `nil` | The load balancer ip address (only relevant for type LoadBalancer) |

## Ingress parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| ingress.enabled | bool | `false` | Enable ingress for Gitea service |
| ingress.annotations | string | `nil` | Additional annotations for ingress |
| ingress.hosts[].host | string | `nil` | Hostname for the ingress endpoint |
| ingress.hosts[].host.paths[] | string | `nil` | Path routing for the ingress endpoint host |
| ingress.tls | list | `[]` | Ingress TLS parameters |

## Storage parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| storage.accessModes[0] | string | `"ReadWriteOnce"` | Storage access mode |
| storage.persistentVolumeClaimName | string | `nil` | PVC name when existing storage volume should be used |
| storage.requestedSize | string | `nil` | Size for new PVC, when no existing PVC is used |
| storage.className | string | `nil` | Storage class name |

## Elasticsearch parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| settings.discoveryType | string | `single-node` | The cluster discovery type |
| settings.javaOpts | string | `-Xms512m -Xmx512m` | Additional JVM options |
| settings.clusterName | string | `singlenode-cluster` | Cluster name |

Further Elasticsearch parameters can be set via environment variables (see Deployment parameter: env)
