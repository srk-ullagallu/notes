# HELM

Helm is a **package manager for Kubernetes** that helps templatize, deploy, and manage applications efficiently.  

#### **Why Use Helm?**  

✅ **Templatized Manifests** – No need to write YAML files repeatedly  
✅ **Reusable & Shareable** – Version-controlled and easy to modify  
✅ **Customizable** – Use `values.yaml` for configuration flexibility  
✅ **Simplifies Deployment** – Automates Kubernetes manifest creation  
✅ **Easy Upgrades & Rollbacks** – Seamless version management  

Just **pass required values** and deploy your application effortlessly! 🎯

# Helm Templating Notes

## Commonly Used Helm Functions in `deployment.yaml`

### 1. **`toYaml`**
- Converts an object to YAML format.
- Preserves indentation when used with `nindent`.
- Example:
  ```yaml
  labels:
    {{- toYaml .Values.labels | nindent 4 }}
  ```
  **Output:**
  ```yaml
  labels:
    app: my-app
    env: production
  ```

### 2. **`nindent`**
- Indents multi-line content with a specified number of spaces.
- Used with `toYaml` to maintain correct indentation.
- Example:
  ```yaml
  labels:
    {{- toYaml .Values.labels | nindent 6 }}
  ```
  **Output:**
  ```yaml
    labels:
      app: my-app
      env: production
  ```

### 3. **`if`** (Conditional Rendering)
- Conditionally renders YAML blocks.
- Example:
  ```yaml
  {{- if .Values.probes.enabled }}
  livenessProbe:
    httpGet:
      path: {{ .Values.health_check.path }}
      port: {{ .Values.service.port }}
  {{- end }}
  ```
  **Output if `probes.enabled: true`:**
  ```yaml
  livenessProbe:
    httpGet:
      path: /healthz
      port: 8080
  ```

### 4. **`eq`** (Equality Check)
- Compares values for equality.
- Example:
  ```yaml
  {{- if eq .Values.name "frontend" }}
  volumes:
    - name: nginx-config
      configMap:
        name: frontend-config
  {{- end }}
  ```
  **Output if `name: frontend`:**
  ```yaml
  volumes:
    - name: nginx-config
      configMap:
        name: frontend-config
  ```

### 5. **`range`** (Looping Over Lists)
- Iterates over a list or map.
- Example:
  ```yaml
  {{- range .Values.secrets.list }}
  apiVersion: v1
  kind: Secret
  metadata:
    name: {{ $.Values.env }}-{{ $.Values.name }}
  data:
    {{- range $key, $value := .data }}
    {{ $key }}: {{ $value | b64enc }}
    {{- end }}
  {{- end }}
  ```
  **Output if multiple secrets exist:**
  ```yaml
  apiVersion: v1
  kind: Secret
  metadata:
    name: dev-backend
  data:
    PASSWORD: c2VjcmV0
  ```

### 6. **`b64enc`**
- Encodes a value in Base64.
- Example:
  ```yaml
  data:
    password: {{ .Values.db.password | b64enc }}
  ```
  **Output if password is `mypassword`:**
  ```yaml
  data:
    password: bXlwYXNzd29yZA==
  ```

### 7. **`contains`**
- Checks if a substring exists in a string.
- Example:
  ```yaml
  {{- if contains "nginx" .Values.image.name }}
  extraConfig: enabled
  {{- end }}
  ```
  **Output if `image.name` contains `nginx`:**
  ```yaml
  extraConfig: enabled
  ```

### 8. **`quote`**
- Wraps a value in double quotes.
- Example:
  ```yaml
  image: "{{ .Values.image.repository }}/{{ .Values.image.name }}:{{ .Values.image.tag }}"
  ```
  **Output:**
  ```yaml
  image: "myrepo/nginx:latest"
  ```

---

These Helm functions help in creating flexible and reusable templates.