{{/*
Expand the name of the chart.
*/}}
{{- define "graylog.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "graylog.fullname" -}}
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

{{- define "elasticsearch.servicename" -}}
{{- if .Values.elasticsearch.fullnameOverride }}
{{- .Values.elasticsearch.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default "elasticsearch" .Values.elasticsearch.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{- define "mongodb.servicename" -}}
{{- if .Values.mongodb.fullnameOverride }}
{{- .Values.mongodb.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default "mongodb" .Values.mongodb.nameOverride }}
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
{{- define "graylog.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "graylog.labels" -}}
helm.sh/chart: {{ include "graylog.chart" . }}
{{ include "graylog.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "graylog.selectorLabels" -}}
app.kubernetes.io/name: {{ include "graylog.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "graylog.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "graylog.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Graylog settings via environment variables
*/}}
{{- define "graylog.environment" -}}
{{- if .Values.elasticsearch.enabled }}
- name: GRAYLOG_ELASTICSEARCH_HOSTS
  value: http://{{ include "elasticsearch.servicename" . }}:{{ .Values.elasticsearch.service.httpPort }}
{{- else }}
{{- if .Values.settings.elastic.hosts }}
- name: GRAYLOG_ELASTICSEARCH_HOSTS
  value: {{ .Values.settings.elastic.hosts | quote }}
{{- end }}
{{- end }}   
{{- if .Values.settings.javaOpts }}
- name: GRAYLOG_SERVER_JAVA_OPTS
  value: {{ .Values.settings.javaOpts | quote }}
{{- end }}
{{- if .Values.settings.http.externalUri }}
- name: GRAYLOG_HTTP_EXTERNAL_URI
  value: {{ .Values.settings.http.externalUri | quote }}
{{- end }}
{{- if .Values.settings.http.publishUri }}
- name: GRAYLOG_HTTP_PUBLISH_URI
  value: {{ .Values.settings.http.publishUri | quote }}
{{- end }}
{{- if .Values.settings.rootUser.email }}
- name: GRAYLOG_ROOT_EMAIL
  value: {{ .Values.settings.rootUser.email | quote }}
{{- end }}
{{- if .Values.settings.rootUser.timezone }}
- name: GRAYLOG_ROOT_TIMEZONE
  value: {{ .Values.settings.rootUser.timezone | quote }}
{{- end }}
{{- if .Values.settings.elastic.indexPrefix }}
- name: GRAYLOG_ELASTICSEARCH_INDEX_PREFIX
  value: {{ .Values.settings.elastic.indexPrefix | quote }}
{{- end }}
{{- if .Values.settings.journal.maxAge }}
- name: GRAYLOG_MESSAGE_JOURNAL_MAX_AGE
  value: {{ .Values.settings.journal.maxAge | quote }}
{{- end }}
{{- if .Values.settings.journal.maxSize }}
- name: GRAYLOG_MESSAGE_JOURNAL_MAX_SIZE
  value: {{ .Values.settings.journal.maxSize | quote }}
{{- end }}
{{- if .Values.settings.smtp.enabled }}
{{- if .Values.settings.smtp.host }}
- name: GRAYLOG_TRANSPORT_EMAIL_HOSTNAME
  value: {{ .Values.settings.smtp.host | quote }}
{{- end }}
{{- if .Values.settings.smtp.port }}
- name: GRAYLOG_TRANSPORT_EMAIL_PORT
  value: {{ .Values.settings.smtp.port | quote }}
{{- end }}
{{- if .Values.settings.smtp.useAuth }}
- name: GRAYLOG_TRANSPORT_EMAIL_USE_AUTH
  value: {{ .Values.settings.smtp.useAuth | quote }}
{{- end }}
{{- if .Values.settings.smtp.useTls }}
- name: GRAYLOG_TRANSPORT_EMAIL_USE_TLS
  value: {{ .Values.settings.smtp.useTls | quote }}
{{- end }}
{{- if .Values.settings.smtp.useSsl }}
- name: GRAYLOG_TRANSPORT_EMAIL_USE_SSL
  value: {{ .Values.settings.smtp.useSsl | quote }}
{{- end }}
{{- if .Values.settings.smtp.subjectPrefix }}
- name: GRAYLOG_TRANSPORT_EMAIL_SUBJECT_PREFIX
  value: {{ .Values.settings.smtp.subjectPrefix | quote }}
{{- end }}
{{- if .Values.settings.smtp.emailFrom }}
- name: GRAYLOG_TRANSPORT_EMAIL_FROM_EMAIL
  value: {{ .Values.settings.smtp.emailFrom | quote }}
{{- end }}
{{- end }}
{{- if .Values.initGeoIPDatabase.enabled }}
{{- if .Values.initGeoIPDatabase.host }}
- name: GEOIPUPDATE_HOST
  value: {{ .Values.initGeoIPDatabase.host | quote }}
{{- end }}
{{- if .Values.initGeoIPDatabase.proxy }}
- name: GEOIPUPDATE_PROXY
  value: {{ .Values.initGeoIPDatabase.proxy | quote }}
{{- end }}
{{- end }}
{{- end }}
