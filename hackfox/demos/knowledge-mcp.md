# Demo: Google Developer Knowledge MCP

## Qué es
Servidor MCP remoto (gestionado por Google) que permite a Claude acceder a la documentación oficial de Google en tiempo real.  
Cubre: Firebase, Google Cloud, Android, Google Maps Platform, Gemini API, y más.

**Documentación oficial:** [developers.google.com/knowledge/mcp](https://developers.google.com/knowledge/mcp)

## Herramientas que expone
- `search_documents` — busca fragmentos relevantes en la documentación
- `get_documents` — obtiene el contenido completo de una página
- `answer_query` — respuesta sintetizada (preview)

## Instalación

### Paso 1 — Habilitar la API y crear key

```bash
gcloud config set project TU_PROJECT_ID

# Habilitar la API
gcloud services enable developerknowledge.googleapis.com

# Crear API key
gcloud services api-keys create \
  --display-name="Knowledge MCP Key" \
  --project=TU_PROJECT_ID
# Guarda el valor de keyString del output
```

Alternativa con OAuth (sin API key):
```bash
gcloud auth application-default login --project=TU_PROJECT_ID
```

### Paso 2.1 — Configurar Claude Desktop (Local)

Archivo de config:
- **Windows:** `%APPDATA%\Claude\claude_desktop_config.json`
- **macOS:** `~/Library/Application Support/Claude/claude_desktop_config.json`

```json
{
  "mcpServers": {
    "google-developer-knowledge": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-google-knowledge"],
      "env": {
        "GOOGLE_API_KEY": "TU_API_KEY_AQUI"
      }
    }
  }
}
```

### Paso 2.2 — Configurar en Firebase Studio / Antigravity (Web IDE)

1. Abre el panel de agentes en Firebase Studio.
2. Abre las opciones (menú de tres puntos) → **Manage MCP Servers**.
3. Haz clic en **View raw config** para editar el archivo `mcp_config.json`.
4. Agrega el servidor de documentación:

```json
{
  "mcpServers": {
    "google-developer-knowledge": {
      "serverUrl": "https://developerknowledge.googleapis.com/mcp"
    }
  }
}
```

Reinicia Claude Desktop. Las herramientas `search_documents`, `get_documents` y `answer_query` deben aparecer en la barra lateral.

### Paso 3 — Configurar Claude Code CLI

```bash
# En el proyecto, agrega el MCP al config local
claude mcp add google-developer-knowledge \
  --transport http \
  --url https://developerknowledge.googleapis.com/mcp \
  --header "X-Goog-Api-Key=TU_API_KEY_AQUI"

# Verificar
claude mcp list
```

---

## Prompts de Demo

### Demo 1 — Lookup de documentación técnica
```
Busca en la documentación oficial cómo usar Gemini Vision API 
para analizar imágenes desde Node.js. 
Muéstrame el código de ejemplo y los parámetros de configuración.
```

### Demo 2 — Firebase Firestore rules
```
¿Cuáles son las mejores prácticas actuales para Firestore Security Rules 
en una app donde los usuarios anónimos pueden crear documentos 
pero solo los admins pueden eliminarlos?
Muéstrame ejemplos de reglas.
```

### Demo 3 — Google Maps Directions API
```
Según la documentación oficial de Google Maps Directions API,
¿cuál es el parámetro correcto para evitar escaleras en rutas a pie?
¿Hay alguna limitación documentada para rutas de accesibilidad?
```

### Demo 4 — Combo killer para hackathon
```
Soy un participante de hackathon y tengo 20 horas para construir una app con:
- Flutter para mobile
- Firebase para la base de datos  
- Gemini API para análisis de imágenes

Busca en la documentación oficial los quickstarts de cada tecnología
y dame un plan de implementación ordenado por dependencias.
```

---

## Puntos clave para la audiencia
- El Knowledge MCP convierte a Claude en un experto con **documentación siempre actualizada**
- Elimina el loop de "busco en Google → copio en Claude → pregunto → vuelvo a Google"
- Es especialmente poderoso para APIs que cambian frecuentemente (Gemini, Firebase)
- La documentación que consulta es la misma que leen los ingenieros de Google internamente
- **Sin API key hardcodeada:** en producción usa OAuth con Application Default Credentials

## Limitaciones
- Solo documentación pública de productos Google (no GitHub, blogs, YouTube)
- Contenido principalmente en inglés
- Requiere conectividad a servicios de Google Cloud
