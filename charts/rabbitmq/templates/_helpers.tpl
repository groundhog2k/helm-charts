{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "rabbitmq.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "rabbitmq.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "rabbitmq.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "rabbitmq.labels" -}}
helm.sh/chart: {{ include "rabbitmq.chart" . }}
{{ include "rabbitmq.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "rabbitmq.selectorLabels" -}}
app.kubernetes.io/name: {{ include "rabbitmq.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "rabbitmq.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "rabbitmq.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return the number of bytes given a value
following a base 2 o base 10 number system.
Usage:
{{ include "rabbitmq.toBytes" .Values.path.to.the.Value }}
*/}}
{{- define "rabbitmq.toBytes" -}}
{{- $value := int (regexReplaceAll "([0-9]+).*" . "${1}") }}
{{- $unit := regexReplaceAll "[0-9]+(.*)" . "${1}" }}
{{- if eq $unit "Ki" }}
    {{- mul $value 1024 }}
{{- else if eq $unit "Mi" }}
    {{- mul $value 1024 1024 }}
{{- else if eq $unit "Gi" }}
    {{- mul $value 1024 1024 1024 }}
{{- else if eq $unit "Ti" }}
    {{- mul $value 1024 1024 1024 1024 }}
{{- else if eq $unit "Pi" }}
    {{- mul $value 1024 1024 1024 1024 1024 }}
{{- else if eq $unit "Ei" }}
    {{- mul $value 1024 1024 1024 1024 1024 1024 }}
{{- else if eq $unit "K" }}
    {{- mul $value 1000 }}
{{- else if eq $unit "M" }}
    {{- mul $value 1000 1000 }}
{{- else if eq $unit "G" }}
    {{- mul $value 1000 1000 1000 }}
{{- else if eq $unit "T" }}
    {{- mul $value 1000 1000 1000 1000 }}
{{- else if eq $unit "P" }}
    {{- mul $value 1000 1000 1000 1000 1000 }}
{{- else if eq $unit "E" }}
    {{- mul $value 1000 1000 1000 1000 1000 1000 }}
{{- end }}
{{- end -}}

{{/*
Management UI plugin options (when plugin is enabled)
*/}}
{{- define "rabbitmq.managementPluginOptions" -}}
{{- if .Values.managementPlugin.enabled }}
## Management UI plugin options
management.tcp.port = {{ .Values.managementPlugin.tcp.port }}
{{- end }}
{{- end -}}

{{/*
K8 peer discovery cluster plugin options (when plugin is enabled)
*/}}
{{- define "rabbitmq.k8sPeerDiscoveryPluginOptions" -}}
{{- if .Values.k8sPeerDiscoveryPlugin.enabled }}
## Clustering with K8s peer discovery plugin
cluster_formation.peer_discovery_backend = rabbit_peer_discovery_k8s
cluster_formation.k8s.host = kubernetes.default.svc.{{ .Values.clusterDomain }}
cluster_formation.k8s.address_type = {{ .Values.k8sPeerDiscoveryPlugin.addressType }}
cluster_formation.k8s.service_name = {{ template "rabbitmq.fullname" . }}-internal
cluster_formation.k8s.hostname_suffix = .{{ template "rabbitmq.fullname" . }}-internal.{{ .Release.Namespace }}.svc.{{ .Values.clusterDomain }}
{{- end }}
{{- end -}}

{{/*
Prometheus plugin options (when plugin is enabled)
*/}}
{{- define "rabbitmq.prometheusPluginOptions" -}}
{{- if .Values.prometheusPlugin.enabled }}
## Prometheus plugin options
prometheus.tcp.port = {{ .Values.prometheusPlugin.tcp.port }}
{{- end }}
{{- end -}}

{{/*
Main RabbitMQ options
*/}}
{{- define "rabbitmq.options" -}}
## Initial login user
{{- if and ((.Values.authentication).user).value ((.Values.authentication).password).value }}
default_user = {{ .Values.authentication.user.value }}
default_pass = {{ .Values.authentication.password.value }}
{{- end }}
loopback_users.guest = false
## RabbitMQ options
listeners.tcp.default = {{ .Values.options.tcp.port }}
{{- with .Values.options.ssl }}
{{- if .enabled }}
## SSL options
listeners.ssl.default = {{ .port }}
{{- if .verify }}
ssl_options.verify = verify_peer
{{- else }}
ssl_options.verify = verify_none
{{- end }}
ssl_options.fail_if_no_peer_cert = {{ .failIfNoPeerCert }}
{{- if .depth }}
ssl_options.depth = {{ .depth }}
{{- end }}
{{- with .certPaths }}
{{- if .cacert }}
ssl_options.cacertfile = {{ .cacert }}
{{- end }}
{{- if .cert }}
ssl_options.certfile = {{ .cert }}
{{- end }}
{{- if .key }}
ssl_options.keyfile = {{ .key }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}
## Memory options
{{- if ((.Values.options).memory).calculationStrategy }}
vm_memory_calculation_strategy = {{ .Values.options.memory.calculationStrategy }}
{{- end}}
{{- if ((.Values.options).memory).totalAvailableOverrideValue }}
total_memory_available_override_value = {{ .Values.options.memory.totalAvailableOverrideValue }}
{{- else }}
{{- $memLimit := ((.Values.resources).limits).memory -}}
{{- if $memLimit }}
total_memory_available_override_value = {{ include "rabbitmq.toBytes" $memLimit }}
{{- end }}
{{- end }}
{{- with .Values.options.memoryHighWatermark }}
{{- if .enabled }}
## Memory Threshold
vm_memory_high_watermark.{{ .type }} = {{ .value }}
{{- if .pagingRatio }}
vm_memory_high_watermark_paging_ratio = {{ .pagingRatio }}
{{- end }}
{{- end }}
{{- end }}
{{- end -}}
