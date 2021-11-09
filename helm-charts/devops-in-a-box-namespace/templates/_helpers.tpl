{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "devops-in-a-box-namespace.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "devops-in-a-box-namespace.fullname" -}}
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
Common annotations
*/}}
{{- define "devops-in-a-box-namespace.annotations" -}}
app.openshift.io/vcs-ref: {{ .Values.git.branch }}
app.openshift.io/vcs-uri: {{ .Values.git.url | quote }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "devops-in-a-box-namespace.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "devops-in-a-box-namespace.labels" -}}
helm.sh/chart: {{ include "devops-in-a-box-namespace.chart" . }}
{{ include "devops-in-a-box-namespace.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Pull secret helper
*/}}
{{- define "imagePullSecret" }}
{{- with .Values.container }}
{{- printf "{\"auths\":{\"%s\":{\"username\":\"%s\",\"password\":\"%s\",\"auth\":\"%s\"}}}" .registry .username .password (printf "%s:%s" .username .password | b64enc) | b64enc }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "devops-in-a-box-namespace.selectorLabels" -}}
app.kubernetes.io/name: {{ include "devops-in-a-box-namespace.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}