# Hackeando el Tiempo: MCP, Claude y Google Cloud en 26 Horas

Bienvenido a este repositorio de acompañamiento y mentoría técnica para **HackFox 2026 — GDG Tijuana** ("Tijuana Sin Barreras"). 

El propósito de este espacio es servir como **plataforma de coaching y playbook de referencia** para los participantes del hackathon. Aquí encontrarás plantillas, guías y demostraciones prácticas para estructurar flujos de desarrollo ágiles utilizando agentes de Inteligencia Artificial, el **Model Context Protocol (MCP)**, y la infraestructura de **Google Cloud / Firebase AI Logic**.

---

## 🎯 Propósito del Repositorio

En un hackathon de 26 horas, la velocidad de ejecución y la precisión del contexto lo son todo. Este repositorio busca coachear a los desarrolladores bajo la premisa de:

> **"La IA es el motor. Tú eres el arquitecto."**

En lugar de perder tiempo en tareas repetitivas (copy-paste de documentación, setup manual propenso a errores, etc.), este material te enseña a orquestar herramientas de IA para que actúen con contexto real y actualizado del proyecto en tiempo real.

---

## 📂 Contenido del Proyecto

Este espacio está organizado de la siguiente manera:

*   **[talk.md](file:///c:/Users/ArturoGonz%C3%A1lez/Documents/AI_Test/gcp-mcps-talk/talk.md):** Guía y estructura oficial de la charla de coaching, incluyendo las notas del presentador, tiempos, preguntas frecuentes y el flujo de los demos en vivo.
*   **[mcp_catalog.md](file:///c:/Users/ArturoGonz%C3%A1lez/Documents/AI_Test/gcp-mcps-talk/mcp_catalog.md):** Catálogo de servidores MCP listos para conectar tu modelo de IA a servicios de Google (Maps, Cloud Run, Cloud SQL, etc.).
*   **📁 [hackfox/](file:///c:/Users/ArturoGonz%C3%A1lez/Documents/AI_Test/gcp-mcps-talk/hackfox):** Kit de herramientas público para los equipos. Contiene:
    *   **`CLAUDE.md` / `agents.md`:** Plantillas para definir el comportamiento y las instrucciones del agente del equipo.
    *   **`agents/`:** Configuración de agentes especializados (Orquestador de Backend/Infraestructura y Soporte de UI/Accesibilidad WCAG).
    *   **`demos/`:** Ejemplos reales de prompts e interacciones paso a paso para usar con Maps MCP, Firebase MCP, BigQuery MCP, Cloud Run MCP, Stitch MCP, etc.
    *   **`config/`:** Plantillas de configuración local para conectar Claude Desktop.
    *   **`scripts/`:** Herramientas de automatización para preparar entornos de GCP rápidamente.

---

## 🛠️ Cómo Utilizar este Material para Coachear a tu Equipo

1.  **Establece las reglas del juego:** Utiliza las directrices de [talk.md](file:///c:/Users/ArturoGonz%C3%A1lez/Documents/AI_Test/gcp-mcps-talk/talk.md) para estructurar el plan de batalla de tu equipo en las primeras horas.
2.  **Configura el contexto de tu agente:** Copia las plantillas de `CLAUDE.md` y `agents.md` a la raíz de tu propio repositorio de hackathon y personalízalas. Esto guiará a los asistentes conversacionales a generar código preciso basado en tu stack técnico.
3.  **Habilita integraciones en tiempo real:** Configura tu cliente (Claude Desktop, Firebase Studio, etc.) usando los ejemplos de la carpeta `config/` para habilitar el uso de APIs directamente desde el chat de IA.

---

## 👥 Facilitador y Mentoría

*   **Coached by:** Arturo González Romero (*Director of Presales & Solutions*)
*   **Evento:** GDG Tijuana — HackFox 2026
