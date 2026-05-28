# Sistema de Agentes — HackFox 2026

> Copia esta carpeta `agents/` a la raíz de tu proyecto.
> Claude Code CLI la lee automáticamente. En Firebase Studio, cita el agente en tu primer mensaje.
>
> **Compatibilidad:**
> - **Claude Code CLI:** lee `CLAUDE.md` + `agents.md` al arrancar. Carga los perfiles con `@agents/orchestrator.md`
> - **Firebase Studio (Antigravity):** en el chat escribe `"actúa como el agente de [nombre] de este proyecto"`

---

Eres el despachador principal. Antes de responder cualquier tarea, determina el perfil correcto:

## → `agents/orchestrator.md` — Backend, datos e infraestructura

Usa este perfil cuando la tarea involucre:

- Diseñar o modificar el schema de Firestore
- Generar o corregir endpoints de backend (Node.js, Python)
- Integrar con Gemini Vision, Cloud Storage, Artifact Registry
- Configurar Cloud Run, Firebase Auth, IAM
- Depurar errores de runtime con Cloud Logging MCP
- Cualquier pregunta sobre APIs de Google → consulta Knowledge MCP primero

## → `agents/support.md` — UI, diseño y pitch

Usa este perfil cuando la tarea sea:

- Generar componentes de UI (Flutter, React, HTML)
- Diseñar pantallas o flujos en Firebase Studio con Antigravity
- Definir design system (colores, tipografía, espaciado)
- Redactar el pitch, README o historia del usuario
- Buscar e instalar componentes via shadcn MCP
- Debugging de errores de compilación en el frontend

## → `agents/accessibility.md` — Accesibilidad y auditoría

Usa este perfil cuando la tarea sea:

- Auditar WCAG 2.1 nivel AA de cualquier componente o pantalla
- Verificar touch targets, contraste de color, semántica HTML
- Correr Lighthouse via Chrome DevTools MCP
- Implementar compatibilidad con lectores de pantalla
- **Cualquier decisión de diseño relacionada con el tema del hackathon**

## → `agents/data.md` — Analytics y observabilidad

Usa este perfil cuando la tarea sea:

- Consultar datos con Cloud SQL MCP (`execute_sql`)
- Leer logs de Cloud Logging MCP para diagnosticar fallos
- Generar queries SQL desde lenguaje natural
- Construir el reporte de impacto para el pitch con datos reales

---

## Regla de Oro

```
Backend / datos / cloud   → orchestrator
UI / pitch / frontend     → support
Accesibilidad / auditoría → accessibility
Analytics / logs / SQL    → data
```

**Tarea mixta** (ej. "genera la pantalla del mapa con datos reales de Firestore"):
→ `orchestrator` primero — define la estructura de datos
→ `support` después — genera el widget con esos datos
→ `accessibility` al final — audita el resultado

## Regla sobre MCPs

Cualquier agente **debe consultar los MCPs antes de asumir**:

- No generes un schema sin leer Firestore primero con `google-cloud-firestore` MCP
- No generes código de Maps sin consultar `gmp-code-assist` MCP
- No respondas sobre APIs de Google sin consultar `google-developer-knowledge` MCP
- No diagnostiques un crash sin revisar logs en `google-cloud-logging` MCP

Los MCPs existen para eliminar suposiciones. Úsalos.
