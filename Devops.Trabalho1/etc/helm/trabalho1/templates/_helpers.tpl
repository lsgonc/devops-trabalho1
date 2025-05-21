{{- define "trabalho1.hosts.httpapi" -}}
{{- print "https://" (.Values.global.hosts.httpapi | replace "[RELEASE_NAME]" .Release.Name) -}}
{{- end -}}
{{- define "trabalho1.hosts.angular" -}}
{{- print "https://" (.Values.global.hosts.angular | replace "[RELEASE_NAME]" .Release.Name) -}}
{{- end -}}
{{- define "trabalho1.hosts.authserver" -}}
{{- print "https://" (.Values.global.hosts.authserver | replace "[RELEASE_NAME]" .Release.Name) -}}
{{- end -}}
