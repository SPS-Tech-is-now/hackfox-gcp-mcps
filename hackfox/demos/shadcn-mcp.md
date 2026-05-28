# Demo: shadcn MCP — Diseño visual de UI y Auditoría de código

## Qué muestra este demo
Claude interactúa directamente con el ecosistema de componentes de UI de `shadcn/ui` y registros similares. Permite buscar componentes (como tablas de datos, diálogos, formularios), ver su código fuente, instalar dependencias y, lo más importante, correr una auditoría de calidad post-generación para verificar la accesibilidad y correcta sintaxis del código generado.

**Herramientas que expone:**
- `get_project_registries` — Obtiene los registros configurados en el proyecto.
- `list_items_in_registries` — Lista todos los componentes, bloques o hooks disponibles en el registro.
- `search_items_in_registries` — Busca componentes específicos (ej. "dialog", "accordion").
- `view_items_in_registries` — Muestra los detalles de código, dependencias y estilos de un componente.
- `get_item_examples_from_registries` — Recupera fragmentos de ejemplo sobre cómo integrar el componente en tu app.
- `get_add_command_for_items` — Obtiene el comando CLI exacto de instalación.
- `get_audit_checklist` — Ejecuta un checklist de calidad en componentes creados (importaciones, TypeScript, etc.).

---

## Prompts de Demo

### Demo 1 — Descubrir componentes UI disponibles
```text
Busca en los registros de shadcn componentes que sirvan para crear un selector de fecha accesible (date-picker).
Dime qué dependencias tiene y cómo se integra.
```
**Qué pasa:** Claude utiliza `search_items_in_registries` y luego `view_items_in_registries` para presentarte las dependencias de NPM, Tailwind (si aplica) y la anatomía del código del selector de fecha.

---

### Demo 2 — Instalar un componente e ilustrar su uso
```text
Quiero instalar el componente "data-table" en mi proyecto de frontend.
Dame el comando de instalación CLI correcto y genera un ejemplo práctico de cómo usarlo en mi aplicación React/Next.js con datos simulados de barreras físicas de Tijuana.
```
**Qué pasa:** Claude utiliza `get_add_command_for_items` para darte el comando exacto (ej: `npx shadcn@latest add data-table`) y `get_item_examples_from_registries` para proporcionarte un componente listo para producción adaptado semánticamente a tu proyecto.

---

### Demo 3 — Correr una auditoría de código recién generado
```text
Acabo de crear un nuevo componente de UI en el archivo "./src/components/AccessibilityMap.tsx".
Ejecuta la herramienta de auditoría de shadcn para validar si hay algún problema común de importaciones, TypeScript o estándares que debamos corregir antes del commit.
```
**Qué pasa:** Claude invoca `get_audit_checklist` para ofrecerte los puntos claves a validar (importaciones correctas, dependencias registradas en package.json, TypeScript types y accesibilidad).

---

## Puntos clave para la audiencia
- **UI de nivel Premium sin perder tiempo:** Te permite encontrar bloques de UI prediseñados y probados directamente desde la conversación, acelerando drásticamente el desarrollo del frontend.
- **Auditorías automáticas:** Al finalizar la generación de código, puedes solicitar al agente que autoverifique su propio trabajo usando las herramientas de calidad.
- **Diseño consistente:** Asegura que todos los componentes agregados usen el mismo sistema de tokens de CSS/Tailwind configurados en el proyecto.
