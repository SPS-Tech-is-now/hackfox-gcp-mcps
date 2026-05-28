#!/usr/bin/env bash
# =============================================================================
# HackFox 2026 — GCP Setup Script
# =============================================================================
#
# INSTRUCCIONES:
#   1. Edita las variables en la sección CONFIGURACIÓN (justo abajo)
#   2. Lee cada sección, descomenta los comandos que necesitas
#   3. Ejecuta sección por sección, o el archivo completo:
#        bash scripts/setup-gcp.sh
#
# WINDOWS: Usa Git Bash, no PowerShell ni CMD.
#   Descarga Git for Windows en: https://gitforwindows.org
#   Los scripts .sh y los pipes de este archivo no funcionan en PowerShell.
#
# ORDEN OBLIGATORIO: Cada sección depende de la anterior.
#   Auth → Billing → APIs → Service Account → Keys → Recursos
#   No saltes pasos — los errores más comunes vienen de saltarse billing o auth.
#
# =============================================================================

set -euo pipefail

# =============================================================================
# CONFIGURACIÓN — edita estos valores antes de ejecutar cualquier sección
# =============================================================================

PROJECT_ID="TU_PROJECT_ID"          # Tu GCP project ID (ej. mi-proyecto-hackfox)
REGION="us-central1"                # Región para Cloud Run y Artifact Registry
SA_NAME="hackfox-demo-sa"           # Nombre del service account (puedes cambiarlo)
DATASET_ID="hackfox_analytics"      # Nombre del dataset de BigQuery
REPO_NAME="hackfox-repo"            # Nombre del Artifact Registry repository
KEY_PATH="/tmp/hackfox-sa-key.json" # Ruta local de la credencial temporal


# =============================================================================
# SECCIÓN 1: AUTENTICACIÓN
# Requerida antes de cualquier otra sección.
# =============================================================================

# gcloud auth login
# gcloud auth application-default login
# gcloud config set project "$PROJECT_ID"

# Verificación — debe imprimir TU_PROJECT_ID:
# gcloud config get-value project


# =============================================================================
# SECCIÓN 2: BILLING
# Sin billing activo las APIs no se pueden habilitar.
# Puedes vincular la cuenta en la consola web o con el comando de abajo.
# =============================================================================

# echo "▶ Vincula billing en: https://console.cloud.google.com/billing/projects"
# echo "  Proyecto: $PROJECT_ID"
# read -rp "  Presiona ENTER cuando el billing esté configurado..."

# Alternativa por CLI (requiere tener una cuenta de billing existente):
# BILLING_ACCOUNT=$(gcloud beta billing accounts list --format="value(name)" --limit=1)
# gcloud beta billing projects link "$PROJECT_ID" --billing-account="$BILLING_ACCOUNT"


# =============================================================================
# SECCIÓN 3: APIS
# Descomenta SOLO las APIs que tu proyecto va a usar.
# Cada comentario indica para qué MCP o servicio se necesita.
# Nota: habilitar una API tarda ~30 segundos — espera el prompt de regreso.
# =============================================================================

# gcloud services enable \
#
#   # --- Infraestructura (Cloud Run, Build, Registry) ---
#   run.googleapis.com \                      # Cloud Run: deploy de tu backend
#   cloudbuild.googleapis.com \               # Build automático de containers
#   artifactregistry.googleapis.com \         # Registry de imágenes Docker
#   secretmanager.googleapis.com \            # Guardar API keys de forma segura
#
#   # --- Firebase MCP ---
#   firebase.googleapis.com \                 # Firebase base (Auth, hosting)
#   firestore.googleapis.com \               # Firestore: base de datos NoSQL
#
#   # --- Gemini Vision / Vertex AI ---
#   aiplatform.googleapis.com \              # Gemini Vision API, Vertex AI
#
#   # --- Google Maps MCP ---
#   maps-backend.googleapis.com \            # Maps SDK base (requerido por el MCP)
#   geocoding-backend.googleapis.com \       # Geocoding: dirección ↔ coordenadas
#   directions-backend.googleapis.com \      # Rutas y navegación (avoid=steps)
#   places-backend.googleapis.com \          # Buscar lugares/POIs cercanos
#
#   # --- BigQuery MCP ---
#   bigquery.googleapis.com \               # Analytics y datos estructurados
#
#   # --- Cloud Storage (opcional) ---
#   storage.googleapis.com \               # Subir fotos e imágenes del backend
#
#   # --- Pub/Sub (opcional — mensajería async entre servicios) ---
#   pubsub.googleapis.com \               # Solo si usas mensajería entre servicios
#
#   # --- Knowledge MCP ---
#   developerknowledge.googleapis.com     # Documentación oficial de Google en tiempo real


# =============================================================================
# SECCIÓN 4: API KEYS
# Algunos MCPs autentican por API key, no por OAuth.
# El "keyString" del output es lo que va en claude_desktop_config.json y .env
# =============================================================================

# --- Knowledge MCP ---
# gcloud services api-keys create \
#   --display-name="Knowledge MCP Key" \
#   --allowed-api=developerknowledge.googleapis.com
# # ↑ Copia el "keyString" del output → va en claude_desktop_config.json

# --- Google Maps MCP ---
# gcloud services api-keys create \
#   --display-name="Maps MCP Key" \
#   --allowed-api=maps-backend.googleapis.com \
#   --allowed-api=geocoding-backend.googleapis.com \
#   --allowed-api=directions-backend.googleapis.com \
#   --allowed-api=places-backend.googleapis.com
# # ↑ Copia el "keyString" del output → va en claude_desktop_config.json y .env


# =============================================================================
# SECCIÓN 5: SERVICE ACCOUNT
# Una identidad de servicio con permisos mínimos — no uses tu cuenta personal
# para producción ni para Cloud Run.
# =============================================================================

# gcloud iam service-accounts create "$SA_NAME" \
#   --display-name="HackFox Demo Service Account"

# Descomenta solo los roles que tu proyecto necesita:

# gcloud projects add-iam-policy-binding "$PROJECT_ID" \
#   --member="serviceAccount:$SA_NAME@$PROJECT_ID.iam.gserviceaccount.com" \
#   --role="roles/aiplatform.user"        # Gemini Vision API

# gcloud projects add-iam-policy-binding "$PROJECT_ID" \
#   --member="serviceAccount:$SA_NAME@$PROJECT_ID.iam.gserviceaccount.com" \
#   --role="roles/datastore.user"         # Firestore lectura y escritura

# gcloud projects add-iam-policy-binding "$PROJECT_ID" \
#   --member="serviceAccount:$SA_NAME@$PROJECT_ID.iam.gserviceaccount.com" \
#   --role="roles/bigquery.dataViewer"    # BigQuery solo lectura (demos y analytics)

# gcloud projects add-iam-policy-binding "$PROJECT_ID" \
#   --member="serviceAccount:$SA_NAME@$PROJECT_ID.iam.gserviceaccount.com" \
#   --role="roles/storage.objectAdmin"    # Cloud Storage (subir fotos)

# gcloud projects add-iam-policy-binding "$PROJECT_ID" \
#   --member="serviceAccount:$SA_NAME@$PROJECT_ID.iam.gserviceaccount.com" \
#   --role="roles/run.invoker"            # Invocar servicios de Cloud Run autenticados


# =============================================================================
# SECCIÓN 6: CREDENCIAL LOCAL TEMPORAL
# Genera un JSON con las credenciales del service account para desarrollo local.
# IMPORTANTE: Nunca commitees este archivo. Agrégalo al .gitignore.
# Elimínalo al terminar el hackathon (ver Sección 10).
# =============================================================================

# gcloud iam service-accounts keys create "$KEY_PATH" \
#   --iam-account="$SA_NAME@$PROJECT_ID.iam.gserviceaccount.com"

# Configura la variable de entorno en la sesión actual:
# Linux / macOS / Git Bash:
#   export GOOGLE_APPLICATION_CREDENTIALS="$KEY_PATH"
# PowerShell:
#   $env:GOOGLE_APPLICATION_CREDENTIALS = "$KEY_PATH"

# Para hacerlo persistente en Git Bash, agrega la línea export a ~/.bashrc


# =============================================================================
# SECCIÓN 7: ARTIFACT REGISTRY
# Solo si vas a publicar imágenes Docker para Cloud Run.
# =============================================================================

# gcloud artifacts repositories create "$REPO_NAME" \
#   --repository-format=docker \
#   --location="$REGION" \
#   --description="HackFox Docker images"

# Configura Docker para autenticar con el registry:
# gcloud auth configure-docker "${REGION}-docker.pkg.dev"


# =============================================================================
# SECCIÓN 8: BIGQUERY — DATASET Y TABLA DE EJEMPLO
# Edita los campos de la tabla según el schema de tu proyecto.
# =============================================================================

# bq mk --dataset \
#   --description "HackFox Analytics" \
#   --location US \
#   "$PROJECT_ID:$DATASET_ID"

# Tabla de ejemplo — reemplaza los campos con los de tu proyecto:
# bq mk --table \
#   "$PROJECT_ID:$DATASET_ID.tu_tabla" \
#   campo1:STRING,campo2:FLOAT,campo3:TIMESTAMP
#
# Alternativa: crea la tabla con SQL en BigQuery Studio para más control.


# =============================================================================
# SECCIÓN 9: FIREBASE
# Firebase no se puede habilitar completamente por CLI — requiere un paso en
# la consola web para configurar Firestore, Auth y Storage por primera vez.
# =============================================================================

# echo "▶ Abre https://console.firebase.google.com"
# echo "  1. Clic en 'Add Firebase to a Google Cloud project'"
# echo "  2. Selecciona: $PROJECT_ID"
# echo "  3. Habilita: Firestore (Native mode), Authentication, Storage"
# read -rp "  Presiona ENTER cuando Firebase esté configurado..."


# =============================================================================
# SECCIÓN 10: LIMPIEZA AL TERMINAR
# Elimina la credencial temporal cuando ya no la necesites.
# =============================================================================

# # Ver las keys activas del service account:
# gcloud iam service-accounts keys list \
#   --iam-account="$SA_NAME@$PROJECT_ID.iam.gserviceaccount.com"

# # Eliminar una key por su ID (KEY_ID aparece en la lista anterior):
# # gcloud iam service-accounts keys delete KEY_ID \
# #   --iam-account="$SA_NAME@$PROJECT_ID.iam.gserviceaccount.com"

# # Eliminar el archivo local:
# rm -f "$KEY_PATH"


# =============================================================================
# SECCIÓN 11: VERIFICACIÓN FINAL
# =============================================================================

# echo "=== Proyecto activo ==="
# gcloud config get-value project

# echo ""
# echo "=== APIs habilitadas ==="
# gcloud services list --enabled \
#   --filter="name:(developerknowledge OR maps-backend OR firebase OR bigquery OR run OR aiplatform)" \
#   --format="table(name,state)"

# echo ""
# echo "=== Service account ==="
# gcloud iam service-accounts describe "$SA_NAME@$PROJECT_ID.iam.gserviceaccount.com" \
#   --format="table(email,disabled)"

# echo ""
# echo "✅ Setup verificado. Siguiente: configura .env y claude_desktop_config.json"
