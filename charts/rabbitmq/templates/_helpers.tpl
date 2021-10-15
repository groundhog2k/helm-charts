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
Managemenmt UI plugin options (when plugin is enabled)
*/}}
{{- define "rabbitmq.managementPluginOptions" -}}
{{- if contains "rabbitmq_management" (join "," .Values.plugins) }}
{{- with .Values.management }}
## Management UI plugin options
management.tcp.port = {{ .tcp.port | default 15672 }}
{{- if .compress }}
management.tcp.compress = {{ .tcp.compress }}
{{- end }}
{{- if .idleTimeout }}
management.tcp.idle_timeout = {{ .tcp.idleTimeout }}
{{- end }}
{{- if .inactivityTimeout }}
management.tcp.inactivity_timeout  = {{ .tcp.inactivityTimeout }}
{{- end }}
{{- if .requestTimeout }}
management.tcp.request_timeout = {{ .tcp.requestTimeout }}
{{- end }}
{{- if .general.loginSessionTimeout }}
management.login_session_timeout = {{ .general.loginSessionTimeout }}
{{- end }}
{{- if .general.ratesMode }}
management.rates_mode = {{ .general.ratesMode }}
{{- end }}
{{- if .general.disableStatistics }}
management.disable_stats = {{ .general.disableStatistics }}
{{- end }}
{{- if .general.enableQueueTotals }}
management.enable_queue_total = {{ .general.enableQueueTotals }}
{{- end }}
{{- if .general.pathPrefix }}
management.path_prefix = {{ .general.pathPrefix }}
{{- end }}
{{- if .authentication.disableBasicAuth }}
management.disable_basic_auth = {{ .authentication.disableBasicAuth }}
{{- end }}
{{- if .authentication.enableUaa }}
management.enable_uaa = {{ .authentication.enableUaa }}
{{- end }}
{{- if .authentication.uaaClientId }}
management.uaa_client_id = {{ .authentication.uaaClientId }}
{{- end }}
{{- if .authentication.uaaLocation }}
management.uaa_location = {{ .authentication.uaaLocation }}
{{- end }}
{{- end }}
{{- end }}
{{- end -}}

{{/*
K8 Peer cluster plugin options (when plugin is enabled)
*/}}
{{- define "rabbitmq.k8sPluginOptions" -}}
{{- if contains "rabbitmq_peer_discovery_k8s" (join "," .Values.plugins) }}
## Clustering with K8s peer discovery plugin
cluster_formation.peer_discovery_backend = rabbit_peer_discovery_k8s
cluster_formation.k8s.host = kubernetes.default.svc.{{ .Values.clusterDomain }}
cluster_formation.k8s.address_type = {{ .Values.clustering.addressType | default "hostname" }}
cluster_formation.k8s.service_name = {{ template "rabbitmq.fullname" . }}-internal
cluster_formation.k8s.hostname_suffix = .{{ template "rabbitmq.fullname" . }}-internal.{{ .Release.Namespace }}.svc.{{ .Values.clusterDomain }}
{{- with .Values.clustering }}
{{- if .formation.nodeCleanupInterval }}
cluster_formation.node_cleanup.interval = {{ .formation.nodeCleanupInterval }}
{{- end }}
{{- if .formation.nodeCleanupOnlyLogWarnings }}
cluster_formation.node_cleanup.only_log_warning = {{ .formation.nodeCleanupOnlyLogWarnings }}
{{- end }}
{{- if .clusterPartitionHandling }}
cluster_partition_handling = {{ .clusterPartitionHandling }}
{{- end }}
{{- if .clusterKeepAliveInterval }}
cluster_keepalive_interval = {{ .clusterKeepAliveInterval }}
{{- end }}
{{- if .queueMasterLocator }}
queue_master_locator = {{ .queueMasterLocator }}
{{- end }}
{{- end }}
{{- end }}
{{- end -}}

{{/*
Options for the RabbitMQ management agent
*/}}
{{- define "rabbitmq.managementAgentOptions" -}}
{{- with .Values.managementAgent }}
## Management agent plugin options
management_agent.disable_metrics_collector = {{ .disableMetricsCollector | default false }}
{{- end }}
{{- end -}}

{{/*
Memory options
*/}}
{{- define "rabbitmq.memoryOptions" -}}
{{- $memLimit := ((.Values.resources).limits).memory -}}
{{- with .Values.options.memory }}
## Memory options
{{- if .calculationStrategy }}
vm_memory_calculation_strategy = {{ .calculationStrategy }}
{{- end}}
{{- if .totalAvailableOverrideValue }}
total_memory_available_override_value = {{ .totalAvailableOverrideValue }}
{{- else }}
{{- if $memLimit }}
total_memory_available_override_value = {{ include "rabbitmq.toBytes" $memLimit }}
{{- end }}
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

{{/*
Main RabbitMQ options
*/}}
{{- define "rabbitmq.options" -}}
## Initial login user
default_user = {{ .Values.authentication.user | default "guest" }}
default_pass = {{ .Values.authentication.password | default "guest" }}
loopback_users.guest = false
{{- with .Values.options }}
## RabbitMQ options
listeners.tcp.default = {{ .tcp.listeners | default 5672 }}
{{- if .tcp.handshakeTimeout }}
handshake_timeout = {{ .tcp.handshakeTimeout }}
{{- end }}
{{- if .tcp.numOfAcceptors }}
num_acceptors.tcp = {{ .tcp.numOfAcceptors }}
{{- end }}
{{- if .channel.channelMax }}
channel_max = {{ .channel.channelMax }}
{{- end }}
{{- if .channel.channelOperationTimeout }}
channel_operation_timeout = {{ .channel.channelOperationTimeout }}
{{- end }}
{{- if .mnesia.tableLoadingRetryTimeout }}
mnesia_table_loading_retry_timeout = {{ .mnesia.tableLoadingRetryTimeout }}
{{- end }}
{{- if .mnesia.tableLoadingRetryLimit }}
mnesia_table_loading_retry_limit = {{ .mnesia.tableLoadingRetryLimit }}
{{- end }}
{{- if .statistics.collectStatisticsInterval }}
collect_statistics_interval = {{ .statistics.collectStatisticsInterval }}
{{- end }}
{{- if .statistics.collectStatistics }}
collect_statistics = {{ .statistics.collectStatistics }}
{{- end }}
{{- if .general.maxMessageSize }}
max_message_size = {{ .general.maxMessageSize }}
{{- end }}
{{- if .general.heartbeat }}
heartbeat = {{ .general.heartbeat }}
{{- end }}
{{- if .general.managementDbCacheMultiplier }}
management_db_cache_multiplier = {{ .general.managementDbCacheMultiplier }}
{{- end }}
{{- if .general.reverseDnsLookups }}
reverse_dns_lookups = {{ .general.reverseDnsLookups }}
{{- end }}
{{- if .general.queueIndexEmbedMessagesBelow }}
queue_index_embed_msgs_below = {{ .general.queueIndexEmbedMessagesBelow }}
{{- end }}
{{- if .general.mirroringSyncBatchSize }}
mirroring_sync_batch_size = {{ .general.mirroringSyncBatchSize }}
{{- end }}
{{- if .general.proxyProtocol }}
proxy_protocol = {{ .general.proxyProtocol }}
{{- end }}
{{- end }}
{{- end -}}

{{/*
Custom options
*/}}
{{- define "rabbitmq.customOptions" -}}
{{- if .Values.customOptions }}
## Custom options
{{- range .Values.customOptions }}
{{ . }}
{{- end }}
{{- end }}
{{- end -}}
