{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "nextcloud.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "nextcloud.fullname" -}}
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

{{- define "mariadb.servicename" -}}
{{- if .Values.mariadb.fullnameOverride }}
{{- .Values.mariadb.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default "mariadb" .Values.mariadb.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{- define "postgres.servicename" -}}
{{- if .Values.postgres.fullnameOverride }}
{{- .Values.postgres.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default "postgres" .Values.postgres.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{- define "redis.servicename" -}}
{{- if .Values.redis.fullnameOverride }}
{{- .Values.redis.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default "redis" .Values.redis.nameOverride }}
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
{{- define "nextcloud.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "nextcloud.labels" -}}
helm.sh/chart: {{ include "nextcloud.chart" . }}
{{ include "nextcloud.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "nextcloud.selectorLabels" -}}
app.kubernetes.io/name: {{ include "nextcloud.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "nextcloud.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "nextcloud.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Nextcloud specific environment variables
*/}}
{{- define "nextcloud.environment" -}}
{{- $internal := include "nextcloud.fullname" . }}
{{- with .Values.settings }}
{{- if .maxFileUploadSize }}
- name: PHP_UPLOAD_LIMIT
  value: {{ .maxFileUploadSize | quote }}
{{- end}}
{{- if .memoryLimit }}
- name: PHP_MEMORY_LIMIT
  value: {{ .memoryLimit | quote }}
{{- end }}
- name: NEXTCLOUD_TRUSTED_DOMAINS
  {{- if .trustedDomains }}
  value: {{ (printf "%s %s" $internal .trustedDomains) | quote }} 
  {{- else }}
  value: {{ $internal | quote }} 
  {{- end }}
{{- if .disableRewriteIP }}
- name: APACHE_DISABLE_REWRITE_IP
  value: {{ .disableRewriteIP | quote }}
{{- end }}
{{- if .trustedProxies }}
- name: TRUSTED_PROXIES
  value: {{ .trustedProxies | quote }}
{{- end }}
{{- if .overwriteHost }}
- name: OVERWRITEHOST
  value: {{ .overwriteHost | quote }}
{{- end }}
{{- if .overwriteProtocol }}
- name: OVERWRITEPROTOCOL
  value: {{ .overwriteProtocol | quote }}
{{- end }}
{{- if .overwriteWebRoot }}
- name: OVERWRITEWEBROOT
  value: {{ .overwriteWebRoot | quote }}
{{- end }}
{{- if .overwriteCondAddr }}
- name: OVERWRITECONDADDR
  value: {{ .overwriteCondAddr | quote }}
{{- end }}
{{- end }}
{{- with .Values.settings.smtp }}
  {{- if .enabled }}
- name: SMTP_HOST 
  value: {{ .host | quote }}
- name: SMTP_PORT 
  value: {{ .port | quote }}
  {{- if .secure }}
- name: SMTP_SECURE
  value: "ssl"
  {{- end }}
- name: SMTP_AUTHTYPE
  value: {{ .authType | quote }}
  {{- if .from }}
- name: MAIL_FROM_ADDRESS
  value: {{ .from | quote }}
  {{- end }}
  {{- if .domain }}
- name: MAIL_DOMAIN
  value: {{ .domain | quote }}
  {{- end }}
  {{- end }}
{{- end }}
{{- end }}
