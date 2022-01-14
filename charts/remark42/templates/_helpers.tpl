{{/*
Expand the name of the chart.
*/}}
{{- define "remark42.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "remark42.fullname" -}}
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
{{- define "remark42.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "remark42.labels" -}}
helm.sh/chart: {{ include "remark42.chart" . }}
{{ include "remark42.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "remark42.selectorLabels" -}}
app.kubernetes.io/name: {{ include "remark42.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "remark42.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "remark42.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Commento settings via environment variables
*/}}
{{- define "remark42.environment" -}}
- name: REMARK_URL
  value: {{ (required ".settings.url must contain valid URL " .Values.settings.url) | quote }}
- name: SITE
  value: {{ (required ".settings.site must contain a Site Id" .Values.settings.site) | quote }}
- name: REMARK_PORT
  value: {{ .Values.containerPort | quote }}
- name: TIME_ZONE
  value: {{ .Values.settings.timeZone | quote }}
{{- with .Values.settings.smtp }}
  {{- if .enabled }}
- name: SMTP_HOST
  value: {{ .host | quote }}
- name: SMTP_PORT
  value: {{ .port | quote }}
- name: SMTP_TLS
  value: {{ .tls | quote }}
- name: SMTP_TIMEOUT
  value: {{ .timeout | quote }}
  {{- end }}
{{- end }}
- name: ADMIN_SHARED_EMAIL
  value: {{ .Values.settings.admin.sharedEmail | quote }}
- name: CACHE_MAX_ITEMS
  value: {{ .Values.settings.cache.maxItems | quote }}
- name: CACHE_MAX_VALUE
  value: {{ .Values.settings.cache.maxValue | quote }}
- name: CACHE_MAX_SIZE
  value: {{ .Values.settings.cache.maxSize | quote }}
- name: AVATAR_TYPE
  value: {{ .Values.settings.avatar.type | quote }}
- name: AVATAR_RSZ_LMT
  value: {{ .Values.settings.avatar.resizeLimit | quote }}
- name: IMAGE_TYPE
  value: {{ .Values.settings.image.type | quote }}
- name: IMAGE_MAX_SIZE
  value: {{ .Values.settings.image.maxSize | quote }}
- name: IMAGE_FS_PARTITIONS
  value: {{ .Values.settings.image.partitions | quote }}
- name: IMAGE_RESIZE_WIDTH
  value: {{ .Values.settings.image.resize.width | quote }}
- name: IMAGE_RESIZE_HEIGHT
  value: {{ .Values.settings.image.resize.height | quote }}
- name: AUTH_TTL_JWT
  value: {{ .Values.settings.auth.ttl.jwt | quote }}
- name: AUTH_TTL_COOKIE
  value: {{ .Values.settings.auth.ttl.cookie | quote }}
- name: AUTH_SEND_JWT_HEADER
  value: {{ .Values.settings.auth.sentJwtHeader | quote }}
- name: AUTH_SAME_SITE
  value: {{ .Values.settings.auth.sameSite | quote }}
- name: AUTH_ANON
  value: {{ .Values.settings.auth.anonymous | quote }}
- name: AUTH_EMAIL_ENABLE
  value: {{ .Values.settings.auth.email.enable | quote }}
{{- if .Values.settings.auth.email.from }}
- name: AUTH_EMAIL_FROM
  value: {{ .Values.settings.auth.email.from | quote }}
{{- end }}
- name: AUTH_EMAIL_SUBJ
  value: {{ .Values.settings.auth.email.subject | quote }}
- name: AUTH_EMAIL_CONTENT_TYPE
  value: {{ .Values.settings.auth.email.contentType | quote }}
{{- if .Values.settings.auth.email.template }}
- name: AUTH_EMAIL_TEMPLATE
  value: {{ .Values.settings.auth.email.template | quote }}
{{- end }}
{{- if .Values.settings.notify.type.user }}
- name: NOTIFY_USERS
  value: {{ .Values.settings.notify.type.user | quote }}
{{- end }}
{{- if .Values.settings.notify.email.emailAdmin }}
- name: NOTIFY_ADMINS
  value: "email"
{{- else }}
{{- if .Values.settings.notify.type.admin }}
- name: NOTIFY_ADMINS
  value: {{ .Values.settings.notify.type.admin | quote }}
{{- end }}
{{- end }}
- name: NOTIFY_QUEUE
  value: {{ .Values.settings.notify.queue | quote }}
{{- if .Values.settings.notify.telegram.token }}
- name: NOTIFY_TELEGRAM_TOKEN
  value: {{ .Values.settings.notify.telegram.token | quote }}
{{- end }}
{{- if .Values.settings.notify.telegram.channel }}
- name: NOTIFY_TELEGRAM_CHAN
  value: {{ .Values.settings.notify.telegram.channel | quote }}
{{- end }}
- name: NOTIFY_TELEGRAM_TIMEOUT
  value: {{ .Values.settings.notify.telegram.timeout | quote }}
{{- if .Values.settings.notify.slack.token }}
- name: NOTIFY_SLACK_TOKEN
  value: {{ .Values.settings.notify.slack.token | quote }}
{{- end }}
{{- if .Values.settings.notify.slack.channel }}
- name: NOTIFY_SLACK_CHAN
  value: {{ .Values.settings.notify.slack.channel | quote }}
{{- end }}
{{- if .Values.settings.notify.email.fromAddress }}
- name: NOTIFY_EMAIL_FROM
  value: {{ .Values.settings.notify.email.fromAddress | quote }}
{{- end }}
{{- with .Values.settings.notify.webhook }}
{{- if .url }}
- name: NOTIFY_WEBHOOK_URL
  value: {{ .url | quote }}
{{- end }}
{{- if .template }}
- name: NOTIFY_WEBHOOK_TEMPLATE
  value: {{ .template | quote }}
{{- end }}
{{- if .headers }}
- name: NOTIFY_WEBHOOK_HEADERS
  value: {{ .headers | quote }}
{{- end }}
{{- if .timeout }}
- name: NOTIFY_WEBHOOK_TIMEOUT
  value: {{ .timeout | quote }}
{{- end }}
{{- end }}
- name: NOTIFY_EMAIL_VERIFICATION_SUBJ
  value: {{ .Values.settings.notify.email.verificationSubject | quote }}
- name: MAX_BACKUP_FILES
  value: {{ .Values.settings.maxBackupFiles | quote }}
- name: MAX_COMMENT_SIZE
  value: {{ .Values.settings.maxCommentSize | quote }}
- name: MAX_VOTES
  value: {{ .Values.settings.maxVotes | quote }}
- name: VOTES_IP
  value: {{ .Values.settings.votesIp | quote }}  
- name: ANON_VOTE
  value: {{ .Values.settings.anonymousVote | quote }}
- name: VOTES_IP_TIME
  value: {{ .Values.settings.votesIpTime | quote }}
- name: LOW_SCORE
  value: {{ .Values.settings.lowScoreThreshold | quote }}
- name: CRITICAL_SCORE
  value: {{ .Values.settings.criticalScoreThresold | quote }}
- name: POSITIVE_SCORE
  value: {{ .Values.settings.positiveScore | quote}}
{{- if .Values.settings.restrictedWords }}
- name: RESTRICTED_WORDS
  value: {{ .Values.settings.restrictedWords | quote }}
{{- end }}
{{- if .Values.settings.restrictedNames }}
- name: RESTRICTED_NAMES
  value: {{ .Values.settings.restrictedNames | quote }}
{{- end }}
- name: EDIT_TIME
  value: {{ .Values.settings.editTime | quote }}
{{- if .Values.settings.readonlyAge }}
- name: READONLY_AGE
  value: {{ .Values.settings.readonlyAge | quote }}
{{- end }}
- name: IMAGE_PROXY_HTTP2HTTPS
  value: {{ .Values.settings.imageProxyhttp2https | quote }}
- name: IMAGE_PROXY_CACHE_EXTERNAL
  value: {{ .Values.settings.proxyExternalCache | quote }}
- name: EMOJI
  value: {{ .Values.settings.emoji | quote }}
- name: SIMPLE_VIEW
  value: {{ .Values.settings.simpleView | quote }}
- name: PROXY_CORS
  value: {{ .Values.settings.proxyCors | quote }}
{{- if .Values.settings.allowedHosts }}
- name: ALLOWED_HOSTS
  value: {{ .Values.settings.allowedHosts | quote }}
{{- end }}
- name: UPDATE_LIMIT
  value: {{ .Values.settings.updateLimit | quote }}
{{- if or (.Values.redis.enabled) (.Values.externalCache.enabled) }}
- name: CACHE_TYPE
  value: "redis_pub_sub"
{{- if .Values.redis.enabled }}
- name: CACHE_REDIS_ADDR
  value: "{{ include "redis.servicename" . }}:{{ .Values.redis.service.serverPort }}"
{{- else }}
- name: CACHE_REDIS_ADDR
  value: "{{ .Values.externalCache.host }}:{{ .Values.externalCache.port }}"
{{- end }}
{{- end }}
{{- end }}