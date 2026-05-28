# HackFox 2026 — MCP con Claude y Google Cloud

> **Charla:** Habilitando Model Context Protocol con Firebase Studio, Claude y Google APIs
> **Evento:** HackFox 2026 — "Tijuana Sin Barreras" | Pixeland Arcade, Tijuana BC
> **Proyecto demo:** `hackfox-mcp-demos`
> **MCP servers de Google:** [github.com/google/mcp](https://github.com/google/mcp)

Sigue los pasos **en el orden que aparecen**. Saltarse uno rompe los siguientes.

---

## Parte 1 — Tus Herramientas de IA

Hay tres herramientas que vas a usar. No son lo mismo y cada una tiene un rol:

| Herramienta | Qué es | Para qué |
|---|---|---|
| **Firebase Studio** | IDE web de Google (sin instalación) | Desarrollar con MCPs nativos de Google, generar UI |
| **Claude Desktop** | App de escritorio de Anthropic | Ejecutar MCP servers locales, demos interactivos |
| **Claude Code** | CLI de terminal de Anthropic | Agente en tu proyecto, leer CLAUDE.md y agents/ |

No necesitas instalar las tres. Para el hackathon: **Firebase Studio + Claude Desktop** cubren el 90%.

---

## Parte 2 — Firebase Studio (Antigravity)

Firebase Studio es el IDE web de Google con IA nativa. Se abre en el browser — sin instalar nada.

### 2.1 Acceso

Abre en tu browser: [studio.firebase.google.com](https://studio.firebase.google.com)

Inicia sesión con tu cuenta de Google. Tienes **3 workspaces gratuitos** durante el preview.

### 2.2 Crear un Workspace

1. Clic en **"New workspace"**
2. Elige una plantilla (Node.js, Flutter, o en blanco)
3. Conecta tu proyecto de GCP: `TU_PROJECT_ID`

### 2.3 Configurar el Modo del Agente

Durante el wizard de configuración inicial verás esta pantalla:

![Modos del agente de Firebase Studio](assets/img/2.png)

Elige según el momento:

| Modo | Cuándo usarlo |
|---|---|
| **Strict Mode** | Nunca — solo sugiere, no escribe código |
| **Review-driven** *(recomendado por Google)* | Cuando quieres revisar cada cambio antes de aplicar |
| **Agent-driven** *(recomendado para hackathon)* | Cuando confías en el contexto y necesitas velocidad — el agente trabaja sin interrupciones |
| **Custom** | Para configuraciones avanzadas de equipo |

Para las 26 horas del HackFox: selecciona **Agent-driven development**.

> La diferencia clave: Review-driven te pide confirmación constantemente ("¿Aplico este cambio?"). Agent-driven trabaja sin preguntarte. Con tu CLAUDE.md bien configurado, Agent-driven es más rápido y igual de preciso.

### 2.4 Activar Plugins de Google ("Build with Google")

La siguiente pantalla del wizard muestra los plugins disponibles:

![Plugins de Google en Firebase Studio](assets/img/3.png)

Activa exactamente estos (deja los demás desactivados):

- **SecureCoder** ✅ — detecta vulnerabilidades en el código generado
- **Modern Web Guidance** ✅ — mejores prácticas para web moderna
- **Google Antigravity SDK** ✅ — acceso nativo a MCPs de Google desde el IDE
- **Firebase** ✅ — lee Firestore, Auth y Storage directamente desde el IDE
- **Chrome DevTools** ✅ — debugging de UI en tiempo real
- Android — solo si tu proyecto es mobile nativo
- Science — solo si tu proyecto usa ML avanzado

> **Por qué esto importa:** Estos plugins son los servidores MCP integrados de Firebase Studio. No necesitas configurar JSON ni instalar npm packages — los plugins YA son los MCPs, activados con un checkbox.

### 2.5 Seleccionar el Modelo de IA

En Settings → Model verás esta lista:

![Selección de modelos en Firebase Studio](assets/img/gemini.png)

Para el hackathon:

| Modelo | Cuándo |
|---|---|
| **Claude Sonnet 4.6 (Thinking)** | Tu default. Código, arquitectura, integraciones GCP |
| Gemini 3.5 Flash | Autocompletado rápido, tareas simples |
| Claude Opus 4.6 (Thinking) | Solo si estás bloqueado en algo muy complejo |

Selecciona **Claude Sonnet 4.6 (Thinking)** y déjalo ahí durante todo el hackathon.

> Firebase Studio es de los pocos IDEs que tiene Claude con Thinking mode activado nativamente — sin extensiones ni APIs keys adicionales.

---

## Parte 3 — Claude Desktop

Claude Desktop es la app de escritorio que te permite conectar servidores MCP externos (Google Maps, Firebase, BigQuery) y usarlos directamente en conversación.

### 3.1 Instalación

- **Windows / macOS:** [claude.ai/download](https://claude.ai/download)

Instala, abre, e inicia sesión con tu cuenta de Anthropic (o créala gratis).

### 3.2 Configurar MCP Servers

Los MCP servers se configuran en un archivo JSON. Ubica el archivo según tu sistema:

**Windows:**

```text
%APPDATA%\Claude\claude_desktop_config.json
```

**macOS:**

```text
~/Library/Application Support/Claude/claude_desktop_config.json
```

Copia el contenido de [`config/claude_desktop_config.example.json`](config/claude_desktop_config.example.json) como punto de partida. **Reemplaza los placeholders con tus valores reales. Nunca pongas API keys reales en el archivo si va a estar en tu repositorio.**

Reinicia Claude Desktop después de cada cambio al archivo. Los servidores activos aparecen en el panel lateral izquierdo.

### 3.3 Verificar que los MCP Servers están activos

1. Abre Claude Desktop
2. En la barra lateral, busca el ícono de herramientas (wrench)
3. Deben aparecer: `google-developer-knowledge`, `google-maps`, `firebase`, `bigquery`
4. Si no aparecen, revisa los logs:
   - Windows: `%APPDATA%\Claude\logs\`
   - macOS: `~/Library/Logs/Claude/`

---

## Parte 4 — Claude Code CLI

Claude Code es el agente de terminal. Vive dentro de tu proyecto, lee tu `CLAUDE.md` automáticamente, y puede editar código, correr comandos y responder preguntas — todo desde la terminal.

### 4.1 Instalación

Requiere Node.js >= 18 ([nodejs.org](https://nodejs.org)):

```bash
npm install -g @anthropic-ai/claude-code
claude auth login
```

### 4.2 Iniciar en tu proyecto

```bash
cd tu-proyecto/
claude
# Claude leerá CLAUDE.md y agents.md automáticamente
```

### 4.3 Configurar MCP servers en Claude Code

```bash
# Agregar el Knowledge MCP de Google
claude mcp add google-developer-knowledge \
  --transport http \
  --url https://developerknowledge.googleapis.com/mcp \
  --header "X-Goog-Api-Key=TU_API_KEY"

# Verificar
claude mcp list
```

### 4.4 Configurar el modelo

```bash
claude config set model claude-sonnet-4-6
```

---

## Parte 5 — VS Code y Cursor (alternativas)

Si prefieres un IDE descargable sobre Firebase Studio:

**VS Code:** [code.visualstudio.com/download](https://code.visualstudio.com/download)

```bash
# Instalar extensión de Claude Code
code --install-extension anthropic.claude-code
```

MCP servers en VS Code se configuran en `.mcp.json` en la raíz del proyecto:

```json
{
  "mcpServers": {
    "google-developer-knowledge": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-google-knowledge"],
      "env": { "GOOGLE_API_KEY": "TU_KEY" }
    }
  }
}
```

**Cursor:** [cursor.com/download](https://cursor.com/download)

MCP en Cursor: Settings → MCP → Add server (interfaz gráfica) o edita `~/.cursor/mcp.json`.

> **Nota:** VS Code y Cursor no tienen los plugins nativos de Google que tiene Firebase Studio. Para el demo de "Build with Google", Firebase Studio es la opción correcta.

---

## Parte 6 — Modelos de Claude: Cuál Usar Cuándo

| Modelo | ID para código | Velocidad | Úsalo para |
|---|---|---|---|
| **Haiku 4.5** | `claude-haiku-4-5-20251001` | Muy rápido | Clasificaciones simples, stubs, autocompletado |
| **Sonnet 4.6** | `claude-sonnet-4-6` | Rápido | **Tu default.** Todo el desarrollo del hackathon |
| **Opus 4.7** | `claude-opus-4-7` | Lento | Arquitectura compleja, cuando Sonnet se equivoca repetido |

Regla simple: **usa Sonnet 4.6 todo el tiempo**. Si algo no sale bien después de 3 intentos, pregunta una vez a Opus 4.7 para entender por qué, y regresa a Sonnet.

---

## Parte 7 — GCP CLI (gcloud)

Todo el setup de infraestructura se hace desde la terminal. Instala `gcloud` antes de continuar.

### Windows — usa Git Bash, no PowerShell

Los scripts `.sh` de este repo y varios comandos con pipes (`|`, `&&`) no funcionan correctamente en PowerShell ni CMD. En Windows hay dos opciones:

| Opción | Cuándo usarla |
|---|---|
| **Git Bash** (recomendado) | Si tienes Git for Windows instalado, ya lo tienes. Busca "Git Bash" en el menú de inicio. Corre los scripts `.sh` directamente. |
| **WSL2** | Si usas Linux regularmente o necesitas un entorno completo. Más potente pero requiere más setup. |

Instala Git for Windows (incluye Git Bash): [gitforwindows.org](https://gitforwindows.org)

**Instalar gcloud en Windows (desde Git Bash o PowerShell):**

```powershell
winget install Google.CloudSDK
```

Cierra y abre la terminal después de la instalación. Verifica:

```bash
gcloud --version
```

**macOS:**

```bash
brew install --cask google-cloud-sdk
gcloud --version
```

**Linux (Debian/Ubuntu):**

```bash
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg \
  | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" \
  | sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list
sudo apt-get update && sudo apt-get install google-cloud-cli
```

> **Tip:** En cualquier sistema operativo, ejecuta `gcloud init` la primera vez para configurar la cuenta y el proyecto por defecto.

---

## Parte 8 — Setup del Proyecto GCP

Todo el setup está en el script [`scripts/setup-gcp.sh`](scripts/setup-gcp.sh). Cada sección está comentada por defecto — descomenta solo lo que necesitas.

### Cómo usarlo

**Paso 1:** Abre el script y edita las variables al inicio:

```bash
PROJECT_ID="TU_PROJECT_ID"    # Tu GCP project ID
SA_NAME="hackfox-demo-sa"     # Nombre del service account
DATASET_ID="hackfox_analytics" # Dataset de BigQuery
```

**Paso 2:** Descomenta las secciones que necesitas. Lee el comentario de cada bloque — cada línea de API explica para qué sirve.

**Paso 3:** Ejecuta desde Git Bash (Windows) o terminal (macOS/Linux):

```bash
bash scripts/setup-gcp.sh
```

> Para ejecutar solo una sección, copia esos comandos y pégalos directamente en la terminal.

### Orden de las secciones

El script tiene 11 secciones en el orden correcto. **No saltes secciones** — cada una es prerequisito de la siguiente:

| Sección | Qué hace | Requerida |
|---|---|---|
| 1 — Autenticación | `gcloud auth login` + `application-default login` | Siempre |
| 2 — Billing | Vincula cuenta de facturación | Para habilitar APIs |
| 3 — APIs | Habilita las APIs por MCP/servicio | Siempre (antes de crear recursos) |
| 4 — API Keys | Crea keys para Maps MCP y Knowledge MCP | Si usas esos MCPs |
| 5 — Service Account | Crea SA con permisos mínimos | Para demos locales y Cloud Run |
| 6 — Credencial local | Genera JSON de credencial temporal | Para desarrollo local |
| 7 — Artifact Registry | Crea registry de Docker | Solo si usas Cloud Run |
| 8 — BigQuery | Crea dataset y tabla de ejemplo | Si usas BigQuery MCP |
| 9 — Firebase | Instrucciones para la consola web | Si usas Firebase MCP |
| 10 — Limpieza | Elimina keys temporales al terminar | Al finalizar el hackathon |
| 11 — Verificación | Confirma que todo está activo | Siempre, al final |

---

## Parte 9 — Configurar el Knowledge MCP de Google

El Knowledge MCP da a Claude acceso a la documentación oficial de Google en tiempo real — Firebase, Maps, Gemini, Android, Cloud. Es el MCP más importante para el hackathon.

**Prerequisitos (ya cubiertos en el script):**
- API `developerknowledge.googleapis.com` habilitada (Sección 3 del script)
- API key creada (Sección 4 del script) — guarda el `keyString` del output

La configuración varía según la herramienta que uses:

### Claude Desktop

Claude Desktop usa un puente local via `npx` para conectarse al Knowledge MCP:

```json
{
  "mcpServers": {
    "google-developer-knowledge": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-google-knowledge"],
      "env": {
        "GOOGLE_API_KEY": "TU_KEY_AQUI"
      }
    }
  }
}
```

Archivo de config:
- **Windows:** `%APPDATA%\Claude\claude_desktop_config.json`
- **macOS:** `~/Library/Application Support/Claude/claude_desktop_config.json`

Reinicia Claude Desktop después de guardar. El MCP aparece en la barra lateral.

### Firebase Studio

Firebase Studio se conecta directamente al endpoint remoto. La autenticación la maneja el proyecto GCP conectado — no necesitas API key explícita.

1. Panel de agentes → menú de tres puntos → **Manage MCP Servers**
2. **View raw config** y agrega:

```json
{
  "mcpServers": {
    "google-developer-knowledge": {
      "serverUrl": "https://developerknowledge.googleapis.com/mcp"
    }
  }
}
```

### Cursor / Windsurf / VS Code

Estos editores usan conexión HTTP/SSE directa con API key en el header:

```json
{
  "mcpServers": {
    "google-developer-knowledge": {
      "url": "https://developerknowledge.googleapis.com/mcp",
      "headers": {
        "X-Goog-Api-Key": "TU_KEY_AQUI"
      }
    }
  }
}
```

Edita `~/.cursor/mcp.json` (Cursor), `~/.codeium/windsurf/mcp_config.json` (Windsurf), o `.mcp.json` en la raíz del proyecto (VS Code con extensión Claude Code).

### Prueba de verificación

Escribe esto en la herramienta que configuraste:

```text
Usando el Knowledge MCP, busca cómo usar Gemini Vision API
desde Node.js para analizar imágenes. Muéstrame el código de ejemplo.
```

✅ Responde con código de la documentación oficial (menciona el MCP en la respuesta)
❌ Responde de memoria — el MCP no está activo

---

## Parte 10 — Arquitectura de Agentes para tu Proyecto

Copia estos tres archivos a la raíz de tu repositorio del hackathon. Claude los leerá automáticamente al iniciar.

```text
tu-proyecto/
├── CLAUDE.md        ← Quién eres, qué construyes, qué MCPs tienes disponibles
├── agents.md        ← Enrutador: cuándo usar orchestrator vs support
└── agents/
    ├── orchestrator.md  ← Reglas para backend, datos y GCP
    └── support.md       ← Reglas para UI, pitch y decisiones rápidas
```

Los archivos de este repo son una plantilla lista para copiar y adaptar. Edita solo los campos entre corchetes `[...]` en `CLAUDE.md`.

Ver ejemplos: [CLAUDE.md](CLAUDE.md) · [agents.md](agents.md) · [agents/orchestrator.md](agents/orchestrator.md) · [agents/support.md](agents/support.md)

---

## Parte 11 — Guías de Demo por MCP

| Demo | Guía | Qué muestra |
|---|---|---|
| Knowledge MCP | [demos/knowledge-mcp.md](demos/knowledge-mcp.md) | Documentación oficial de Google en tiempo real |
| Google Maps MCP | [demos/maps-mcp.md](demos/maps-mcp.md) | Rutas accesibles, geocoding, Street View |
| Firebase MCP | [demos/firebase-mcp.md](demos/firebase-mcp.md) | Leer/escribir Firestore conversacionalmente |
| Firebase Studio (Stitch) | [demos/stitch-mcp.md](demos/stitch-mcp.md) | Generar UI desde lenguaje natural con plugins nativos |
| BigQuery MCP | [demos/bigquery-mcp.md](demos/bigquery-mcp.md) | Analytics sin escribir SQL |
| Cloud Run MCP | [demos/cloudrun-mcp.md](demos/cloudrun-mcp.md) | Despliegue de servicios y consulta de logs desde el chat |
| shadcn MCP | [demos/shadcn-mcp.md](demos/shadcn-mcp.md) | Explorar e instalar componentes UI y auditar calidad/TypeScript |

---

## Parte 12 — Verificación Rápida: ¿Todo Funciona?

Antes de tu primera sesión de desarrollo, verifica cada punto. No empieces a codear hasta tener un ✅ en todo.

### GCP y autenticación

```bash
# Confirma el proyecto activo
gcloud config get-value project
# Debe responder con TU_PROJECT_ID

# Confirma autenticación de aplicación
gcloud auth application-default print-access-token | head -c 20
# Debe imprimir un token — si da error: gcloud auth application-default login

# Confirma que las APIs están habilitadas
gcloud services list --enabled \
  --filter="name:(developerknowledge OR maps-backend OR firebase OR bigquery OR run)" \
  --format="table(name)"
# Deben aparecer las 5 APIs
```

### Claude Desktop

1. Abre Claude Desktop — en la barra lateral busca el ícono de herramientas (wrench)
2. `google-developer-knowledge` debe aparecer entre los servidores activos
3. Prueba de humo:
   ```
   Usando el Knowledge MCP, busca cómo habilitar Firestore en un proyecto GCP desde la CLI.
   ```
   - ✅ Responde con pasos concretos citando la documentación oficial
   - ❌ Responde de memoria sin mencionar el MCP — el servidor no está activo

Si el MCP no aparece: revisa los logs de Claude Desktop (`%APPDATA%\Claude\logs\` en Windows, `~/Library/Logs/Claude/` en macOS) y reinicia la app después de cualquier cambio al config.

### Claude Code CLI

```bash
claude --version                  # Debe mostrar la versión instalada
claude mcp list                   # Debe listar los MCPs configurados

cd tu-proyecto/
claude
# Claude debe leer CLAUDE.md automáticamente. Lo confirmas cuando menciona
# el nombre de tu proyecto en los primeros tokens de la respuesta.
```

### Firebase Studio

- [ ] `studio.firebase.google.com` carga con tu cuenta de Google
- [ ] El workspace está conectado al proyecto correcto
- [ ] Plugins activos: Firebase ✅, Google Antigravity SDK ✅, Modern Web Guidance ✅, Chrome DevTools ✅
- [ ] Modelo seleccionado: **Claude Sonnet 4.6 (Thinking)**
- [ ] Modo: **Agent-driven development**
- [ ] Prueba: escribe `¿qué proyecto GCP tienes conectado?` — debe responder con el ID correcto

### Reset de autenticación (cuando algo falla)

El 90% de los problemas son de autenticación. Secuencia completa de reset:

```bash
gcloud auth revoke --all
gcloud auth login
gcloud auth application-default login
gcloud config set project TU_PROJECT_ID
# Luego reinicia Claude Desktop completamente (no solo recargar)
```

---

## Parte 13 — Tokens, Contexto y Costos

Entender cómo funciona el contexto te permite trabajar más rápido y gastar menos créditos en 26 horas.

### El contexto es una ventana, no una memoria infinita

Claude procesa todo lo que está en la conversación activa. Cuando esa ventana se llena, el contexto más antiguo desaparece. Dos consecuencias directas:

**Tu CLAUDE.md es la mejor inversión de tokens.** Se lee al iniciar la sesión — defines el contexto una vez, no lo repites en cada mensaje. Un CLAUDE.md bien escrito vale por 20 prompts de "recuerda que estamos construyendo...".

**Contexto viejo = tokens pagados por nada.** Si llevas 30 mensajes y cambiaste de tema, abre una conversación nueva. En Claude Code CLI usa `/clear` para limpiar el contexto sin cerrar la sesión.

### Cuándo usar cada modelo

| Modelo | Velocidad | Costo | Úsalo para |
|---|---|---|---|
| **Haiku 4.5** | Muy rápido | ~1x | Clasificar datos, generar stubs, preguntas simples |
| **Sonnet 4.6** | Rápido | ~4x | **Tu default. Todo el desarrollo del hackathon.** |
| **Opus 4.7** | Lento | ~12x | Solo cuando Sonnet falla 3 veces seguidas en algo complejo |

**Regla de hackathon:** Si algo no sale en 3 intentos con Sonnet, pídele a Opus que te *explique por qué falla* — no que lo genere. Con esa explicación como contexto, regresa a Sonnet.

### Thinking Mode — cuándo vale el costo extra

Thinking Mode hace que Claude razone antes de responder. Usa más tokens pero comete menos errores en tareas complejas.

**Úsalo para:**
- Diseñar la arquitectura de datos desde cero
- Debuggear un error que llevas 20 minutos sin entender
- Integrar sistemas que nunca has conectado (ej. Gemini Vision + Firestore + Maps en un endpoint)

**No lo uses para:**
- Generar un componente de UI con especificaciones claras
- Escribir un query de Firestore que ya conoces

En Firebase Studio: **Claude Sonnet 4.6 (Thinking)** ya tiene Thinking activado nativamente. En Claude Code CLI: el modelo activa Thinking automáticamente cuando detecta que la tarea lo requiere — no hay que configurar nada.

### Prompt Caching — gratis en Claude Code CLI

Claude Code CLI cachea automáticamente el CLAUDE.md y los archivos leídos en la sesión. No pagas por re-procesarlos en cada mensaje. Por eso no pegues archivos en el chat — pídele a Claude que los lea solo.

### Reglas de contexto para las 26 horas

| ✅ Haz esto | ❌ No hagas esto |
|---|---|
| `claude` dentro del directorio del proyecto | Pegar 200 líneas de código en el chat |
| Un terminal de Claude Code por área (backend / frontend) | Mezclar backend y frontend en la misma sesión |
| `/clear` al cambiar de área de trabajo | Acumular contexto irrelevante de conversaciones anteriores |
| "Lee el archivo `routes/reports.js` y dime qué le falta" | Copiar y pegar el archivo completo |
| Configurar el CLAUDE.md **antes** de pedir código | Pedir código y después explicar qué es el proyecto |

---

## Parte 14 — Cómo Escribir Prompts que Funcionan

Un buen prompt no es el más largo — es el más preciso. Estos patrones funcionan en Firebase Studio, Claude Desktop y Claude Code CLI.

### La estructura de un prompt efectivo

```
[CONTEXTO]       Lo que Claude necesita saber sobre el estado actual del proyecto
[TAREA]          Exactamente qué quieres que haga
[RESTRICCIONES]  Qué NO debe tocar o cambiar
[FORMATO]        Cómo quieres la respuesta
```

**Malo:**
```
necesito código para el mapa
```

**Bueno:**
```
[CONTEXTO] Tengo MapScreen en Flutter con marcadores generados desde una lista
de objetos BarrierReport con campos lat, lng, y severity (String: "alta"|"media"|"baja").

[TAREA] Modifica el método que construye el BitmapDescriptor del marcador para que
use colores distintos según severity: rojo (#EA4335) alta, amarillo (#FBBC04) media,
gris (#9AA0A6) baja.

[RESTRICCIONES] No cambies la estructura del widget ni el provider de datos. Solo el color.

[FORMATO] Solo el método modificado, sin el widget completo.
```

### Patrones por caso de uso

**Generar código nuevo:**
```
Necesito [qué] que haga [función específica].
Recibe [inputs con tipos] y devuelve [output con tipo].
Usa [librería o patrón] si está disponible en el proyecto.
Maneja el caso donde [edge case más probable].
```

**Debuggear un error:**
```
Este código produce el error exacto:
[pega el stacktrace completo]

El comportamiento esperado es: [qué debería pasar].
Antes de arreglarlo, explícame en una oración por qué está fallando.
```

**Iterar sobre código ya generado (no reinicies la conversación):**
```
Del código que acabas de generar, modifica únicamente [parte específica]:
- [cambio 1]
- [cambio 2]
No toques [partes que funcionan].
```

**Decisión de arquitectura rápida:**
```
Necesito elegir entre [opción A] y [opción B] para [problema concreto].
Contexto: [stack, tiempo disponible, experiencia del equipo].
Dame una recomendación directa con el razonamiento en máximo 3 líneas.
```

**Pitch (agente de soporte):**
```
Escribe la apertura del pitch en primera persona, en español mexicano conversacional.
El problema: [descripción en una línea].
El usuario real: [persona específica — no "personas con discapacidad",
sino "mi abuela de 72 años que vive en Zona Centro y..."].
Máximo 30 segundos cuando se lee en voz alta.
```

### Anti-patrones — lo que NO funciona

| ❌ En vez de esto | ✅ Haz esto |
|---|---|
| "Genera toda la app" | Divide en tareas de 15-20 min cada una |
| "Arregla el error" (sin pegar el error) | Pega el stacktrace completo + la línea que falla |
| "Mejora el código" | "Reduce el número de lecturas a Firestore en este método" |
| Reiniciar la conversación cuando algo falla | Corrige en el mismo contexto: "eso no funciona porque X, intenta Y" |
| "Hazlo bonito" | "Material 3, primario #1A73E8, bordes redondeados 12dp, texto Body Medium" |

### El prompt de desbloqueo

Si llevas 3 intentos y el mismo error persiste:

```
Para. No intentes arreglarlo todavía.
En máximo 3 líneas, explícame por qué crees que está fallando.
¿Qué asumiste al generar el código original que podría estar equivocado?
```

Esto fuerza a Claude a reconsiderar el approach antes de generar más código. Funciona el 80% de las veces porque el error estaba en el razonamiento inicial, no en la implementación.

### Prompt de inicio de sesión recomendado

Cuando abres Claude Code en tu proyecto por primera vez:

```
Leíste el CLAUDE.md. Antes de que te pida código, dame:
1. Los 3 riesgos técnicos más grandes del proyecto según lo que describes
2. El orden en que construirías las features para que el demo funcione en 20 horas
3. Qué MCP deberías consultar primero antes de generar cualquier endpoint
```

Esta inversión de 2 minutos al inicio ahorra 2 horas de refactoring al final.

---

## Seguridad — Checklist antes de `git push`

- [ ] `.env` está en `.gitignore` y no existe en el repo
- [ ] El archivo de service account key (`/tmp/hackfox-demo-sa-key.json`) no está en el repo
- [ ] No hay valores `AIza...` ni `-----BEGIN PRIVATE KEY-----` en ningún archivo
- [ ] La key de Google Maps tiene restricciones de IP o referrer
- [ ] `PRESENTER_GUIDE.md` está en `.gitignore` si estás usando este repo como base

```bash
# Escaneo rápido antes de hacer push
grep -r "AIza" . --include="*.json" --include="*.md" --include="*.js" --include="*.ts"
grep -r "BEGIN PRIVATE KEY" .
```

Al terminar el hackathon, elimina la credencial temporal (también está en la Sección 10 del script):

```bash
# Ver las keys activas
gcloud iam service-accounts keys list \
  --iam-account=TU_SA_NAME@TU_PROJECT_ID.iam.gserviceaccount.com

# Eliminar (reemplaza KEY_ID con el valor de la columna KEY_ID del comando anterior)
gcloud iam service-accounts keys delete KEY_ID \
  --iam-account=TU_SA_NAME@TU_PROJECT_ID.iam.gserviceaccount.com

# Eliminar el archivo local
rm -f /tmp/hackfox-sa-key.json
```
