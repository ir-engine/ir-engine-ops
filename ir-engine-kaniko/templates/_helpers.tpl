{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
# {{- define "ir-engine.name" -}}
# {{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
# {{- end -}}

{{- define "ir-engine.builder.kaniko.name" -}}
{{- default .Chart.Name .Values.builder.kaniko.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ir-engine.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "ir-engine.builder.fullname" -}}
{{- if .Values.builder.fullnameOverride -}}
{{- .Values.builder.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-builder-ir-engine-builder" .Values.release.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{- define "ir-engine.builder.kaniko.fullname" -}}
{{- if .Values.builder.kaniko.fullnameOverride -}}
{{- .Values.builder.kaniko.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name .Values.builder.kaniko.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}


{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "ir-engine.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "ir-engine.builder.kaniko.labels" -}}
helm.sh/chart: {{ include "ir-engine.chart" . }}
{{ include "ir-engine.builder.kaniko.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "ir-engine.builder.kaniko.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ir-engine.builder.kaniko.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: builder
{{- end -}}

{{- define "ir-engine.builder.serviceAccountName" -}}
{{- if .Values.builder.kaniko.serviceAccount.create -}}
    {{ default (include "ir-engine.builder.fullname" .) }}
{{- else -}}
    {{ default "default" .Values.builder.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "ir-engine.builder.kaniko.serviceAccountName" -}}
{{- if .Values.builder.kaniko.serviceAccount.create -}}
    {{ default (include "ir-engine.builder.kaniko.fullname" .) .Values.builder.kaniko.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.builder.kaniko.serviceAccount.name }}
{{- end -}}
{{- end -}}
