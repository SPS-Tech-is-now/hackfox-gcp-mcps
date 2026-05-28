# Demo: Firebase Studio — Generación de UI con Agente Nativo

## Qué es esto (y qué NO es)

Firebase Studio (conocido internamente como Antigravity) NO es un servidor MCP separado que se instala con `npx`. Es un **IDE web de Google** que tiene los MCPs de Google integrados como plugins nativos.

Acceso: [studio.firebase.google.com](https://studio.firebase.google.com)

La generación de UI (lo que antes era "Antigravity Stitch") es una capacidad del agente dentro de Firebase Studio, activada cuando tienes los plugins **Google Antigravity SDK** y **Firebase** habilitados.

---

## Prerrequisitos

1. Cuenta de Google con acceso a Firebase Studio
2. Plugins activos en tu workspace (ver `assets/img/3.png`):
   - Google Antigravity SDK ✅
   - Firebase ✅
   - Modern Web Guidance ✅
   - Chrome DevTools ✅
3. Modelo seleccionado: **Claude Sonnet 4.6 (Thinking)** (ver `assets/img/gemini.png`)
4. Modo del agente: **Agent-driven development** (ver `assets/img/2.png`)

---

## Por qué Firebase Studio para UI

Con los plugins activos, el agente puede:

- Leer el schema real de Firestore **sin que se lo dictes**
- Generar componentes que usan esos datos exactos
- Aplicar las guías de diseño de Google (Modern Web Guidance)
- Hacer debugging visual directo con Chrome DevTools
- Iterar conversacionalmente sin perder el contexto

Esto es el diferenciador frente a VS Code o Cursor: el IDE ya tiene contexto de tu proyecto.

---

## Prompts de Demo

### Demo 1 — Componente con datos reales de Firestore

```text
Basado en el schema de Firestore de este proyecto, genera un widget Flutter
que muestre una lista de reportes de accesibilidad.
Cada item debe mostrar: foto (thumbnail), tipo de barrera, severidad con un
badge de color (rojo=alta, amarillo=media, gris=baja), y dirección.
Incluye estado de carga y estado vacío con mensaje en español.
```

El agente leerá Firestore directamente — no tienes que pegarle el schema.

---

### Demo 2 — Pantalla completa de mapa

```text
Genera la pantalla principal de la app: un Google Map que ocupa el 70%
de la pantalla con marcadores de color según la severidad de las barreras.
Abajo del mapa, una lista horizontal scrollable con las barreras cercanas.
En la esquina inferior derecha, un FAB rojo con ícono de cámara.
Todos los elementos deben tener semanticLabel para screen readers.
Colores: primario #1A73E8, peligro #EA4335, advertencia #FBBC04.
```

---

### Demo 3 — Iteración conversacional

```text
Modifica el widget anterior:
- El FAB debe tener una animación de pulso cuando hay nuevos reportes en el área
- Agrega una barra de filtros bajo el mapa: chips "Todos", "Alta", "Media", "Baja"
- Cuando se selecciona un filtro, los marcadores del mapa deben actualizarse
```

El agente modifica lo que generó antes sin reescribir todo desde cero.

---

### Demo 4 — Design system desde cero

```text
Crea un design system básico para una app de accesibilidad ciudadana.
Paleta: azul Google (#1A73E8) como primario, verde (#34A853) para resuelto,
rojo (#EA4335) para barrera crítica.
Asegura contraste WCAG AA (mínimo 4.5:1) en todos los textos.
Genera los tokens en formato que pueda usar directamente en Flutter y en CSS.
```

---

## Flujo de Demo Efectivo en Vivo

1. **El antes (15 seg):** "Antes de Firebase Studio, para generar esto necesitaría abrir Figma, diseñar el componente, exportarlo, escribir el código, conectar los datos..."
2. **El prompt (30 seg):** Escribe despacio. Explica en voz alta cada parte del prompt mientras escribes.
3. **El wait (variable):** No digas nada mientras el agente trabaja. Deja que la audiencia vea el proceso en tiempo real.
4. **El resultado (30 seg):** Muestra el componente generado. Pausa. "¿Cuánto les habría tomado hacer esto manualmente?"

---

## Puntos Clave para la Audiencia

- Firebase Studio no reemplaza al diseñador — lo convierte en director
- La clave está en tener CLAUDE.md bien configurado antes de pedir UI — el agente necesita saber qué está construyendo
- El código generado es un punto de partida, siempre revisa accesibilidad y edge cases
- Chrome DevTools plugin te permite debuggear el resultado directo en el IDE
