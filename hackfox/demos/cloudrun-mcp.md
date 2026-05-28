# Demo: Cloud Run MCP — Despliegue e Inspección sin salir del chat

## Qué muestra este demo
Claude interactúa directamente con Google Cloud Run a través de llamadas de herramientas nativas, lo que le permite listar tus servicios activos, revisar configuraciones, consultar logs de ejecución y desplegar código directamente (desde carpetas locales, archivos en contexto o imágenes de contenedor) de manera conversacional.

**Herramientas que expone:**
- `list_projects` — Lista los proyectos GCP disponibles.
- `list_services` — Lista los servicios de Cloud Run en un proyecto y región.
- `get_service` — Obtiene metadatos y configuraciones detalladas de un servicio.
- `get_service_log` — Recupera logs de ejecución del servicio (útil para debugging rápido).
- `deploy_local_folder` — Despliega una carpeta local completa de tu sistema a Cloud Run.
- `deploy_file_contents` — Despliega archivos pasándole su contenido directo en el chat.
- `deploy_container_image` — Despliega una imagen de contenedor existente (por ejemplo, desde Artifact Registry).

---

## Prompts de Demo

### Demo 1 — Descubrimiento del entorno y servicios activos
```text
Muestra la lista de proyectos en mi cuenta GCP y lista los servicios de Cloud Run activos en el proyecto [TU_PROYECTO_ID].
Dame sus URLs públicas y sus estados de salud actuales.
```
**Qué pasa:** Claude utiliza `list_projects` y luego `list_services` para mostrar una tabla formateada de tus microservicios desplegados en Cloud Run.

---

### Demo 2 — Despliegue de un backend Node.js local
```text
Tengo mi backend listo en la carpeta local "./backend". Despliégalo a Cloud Run en el proyecto [TU_PROYECTO_ID], en la región us-central1 con el nombre de servicio "hackfox-api".
```
**Qué pasa:** Claude invoca `deploy_local_folder` con la ruta absoluta de la carpeta, empaqueta el contenido y realiza el build/despliegue de forma autónoma.

---

### Demo 3 — Despliegue rápido de un archivo estático o script en contexto
```text
Crea y despliega un servidor express básico en Node.js directamente desde esta conversación. 
El servidor solo debe devolver un JSON indicando {"status": "ok", "message": "Demo de HackFox 2026"}.
Despliégalo al servicio "hackfox-static-demo" en el proyecto [TU_PROYECTO_ID].
```
**Qué pasa:** Claude utiliza `deploy_file_contents` enviando el código del archivo `index.js` y el `package.json` definidos en el prompt para desplegarlo en un instante.

---

### Demo 4 — Inspección y Debugging de fallos (logs en vivo)
```text
El servicio "hackfox-api" está respondiendo con errores 500. Consulta los logs de ejecución más recientes del servicio en el proyecto [TU_PROYECTO_ID] para identificar cuál es el error de runtime o base de datos que está ocurriendo.
```
**Qué pasa:** Claude llama a `get_service_log` para recuperar las últimas líneas de log de la consola de GCP y realiza un diagnóstico preciso de la excepción de código o error de conexión.

---

## Puntos clave para la audiencia
- **Cero fricción de consola:** No requieres escribir comandos complejos de `gcloud run deploy ...` con decenas de flags de variables de entorno y secrets. El agente se encarga de estructurar el despliegue.
- **Acceso a logs inmediato:** Cuando el despliegue falla o crashea en frío, el agente puede leer los logs directamente para corregir el bug y volver a desplegar de manera inmediata.
- **Flujo DevOps Conversacional:** Puedes pedirle al agente que optimice la configuración (por ejemplo, escalar a 0 instancias o aumentar la RAM) y él ejecutará la actualización directamente.
