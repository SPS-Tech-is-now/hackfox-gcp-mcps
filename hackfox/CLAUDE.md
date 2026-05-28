# [NOMBRE DE TU PROYECTO] — HackFox 2026

> **Instrucción para el equipo:** Reemplaza todo lo que está entre corchetes `[...]` con los datos de su proyecto.
> Este archivo le dice a Claude quiénes son, qué construyen, y cómo comportarse.
> Colócalo en la raíz de tu repositorio. Claude lo leerá automáticamente al iniciar.

---

## Identidad del Proyecto

**Nombre:** [Nombre del proyecto]
**Evento:** HackFox 2026 — "Tijuana Sin Barreras" | 28-29 mayo 2026
**Tema:** [Describe en 1-2 oraciones qué problema resuelve tu proyecto para personas con discapacidad o adultos mayores en Tijuana]
**Stack principal:** [Flutter / React / Next.js / Node.js / Python — lo que usen]

## Problema que Resolvemos

[Describe el problema específico: quién lo sufre, dónde ocurre, por qué importa.
Ejemplo: "170,000 residentes de Tijuana con discapacidad no tienen forma de saber si una ruta es accesible antes de salir de casa."]

## Qué Construimos (MVP en 26 horas)

[Lista las 3-4 funcionalidades core, en orden de prioridad para el demo:
1. [Feature más importante — sin esto no hay demo]
2. [Segunda prioridad]
3. [Tercera prioridad — solo si sobra tiempo]
]

## Herramientas MCP Disponibles en este Entorno

Antes de generar código o arquitectura, consulta estas herramientas para obtener contexto real:

- **`google-developer-knowledge`** — Documentación oficial de Google en tiempo real. Úsalo antes de generar código que consuma APIs de Google.
- **`google-maps`** — Rutas, geocoding, Street View, Places. Úsalo para diseñar features de mapa o validar coordenadas.
- **`firebase`** — Lee y escribe en Firestore directamente. Úsalo para explorar el schema real antes de generar queries o endpoints.
- **`bigquery`** — Consultas al dataset de analytics. Úsalo para generar insights sin escribir SQL manualmente.
- **`cloudrun`** — Permite interactuar con proyectos, listar servicios y desplegar código directamente a Google Cloud Run desde el chat.
- **`shadcn`** — Permite explorar, buscar e instalar componentes visuales desde los registros de shadcn, y auditar la calidad del código/TypeScript.

## Criterios de Evaluación (en orden de peso)

1. **Impacto social (30%)** — ¿El proyecto realmente ayuda a alguien en Tijuana?
2. **Funcionalidad técnica (25%)** — ¿Funciona en el demo?
3. **Innovación (20%)** — ¿Hay algo que no hayas visto en otro proyecto?
4. **Calidad de código (15%)** — Estructura clara, no espagueti
5. **Pitch (10%)** — Historia centrada en el usuario real

## Reglas de Trabajo para el Agente

- **Funcional > Perfecto.** Si algo no funciona en el demo, nada más importa.
- **Flujo secuencial.** Setup de GCP va en orden: Auth → Billing → APIs → Recursos → Deploy. No saltarse pasos.
- **Consulta antes de asumir.** Antes de generar un schema de Firestore o una query de BigQuery, usa el MCP correspondiente para ver el estado real.
- **Scope agresivo.** Si una feature no aparece en el demo de 3 minutos, no la construyas.
- **Sin secrets en código.** API keys en `.env` o Secret Manager. Nunca en el repositorio.

## Enrutamiento

Antes de responder cualquier tarea, lee `agents.md` para saber qué perfil de agente aplicar.
