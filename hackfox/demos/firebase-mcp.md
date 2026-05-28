# Demo: Firestore + Firebase MCP

## Dos MCPs distintos, roles distintos

El ecosistema Firebase usa **dos servidores MCP separados** — es importante distinguirlos:

| MCP | Nombre en catálogo | Para qué |
|---|---|---|
| **google-cloud-firestore** | `google-cloud-firestore` | R/W de datos: leer, crear, actualizar, eliminar documentos |
| **Firebase MCP Server** | `firebase-mcp-server` | Gestión del proyecto: deploy, SDK config, security rules, environments |

Para leer y escribir datos en Firestore durante el hackathon, usa **`google-cloud-firestore`**.

---

## Herramientas de `google-cloud-firestore`

- `list_collections` — lista las colecciones raíz o subcolecciones de un documento
- `list_documents` — consulta los documentos de una colección (con filtros)
- `get_document` — obtiene el contenido de un documento específico
- `add_document` — crea un nuevo documento en una colección
- `update_document` — modifica campos de un documento existente
- `delete_document` — elimina un documento
- `create_index` / `list_indexes` / `delete_index` — gestión de índices compuestos

## Herramientas de `firebase-mcp-server`

- `firebase_get_project` / `firebase_list_projects` — inspecciona proyectos
- `firebase_get_sdk_config` — obtiene la config de inicialización (web/android/ios)
- `firebase_get_security_rules` — consulta las reglas de seguridad activas
- `firebase_deploy` / `firebase_deploy_status` — despliega y verifica estado
- `firebase_get_environment` / `firebase_update_environment` — variables de entorno

---

## Prerrequisitos

- Claude Desktop con MCP `google-cloud-firestore` activo
- Proyecto GCP con Firestore en modo Native (no Datastore)
- Credenciales con rol `roles/datastore.user` (mínimo para R/W)

```bash
gcloud services enable firestore.googleapis.com
gcloud firestore databases create --location=us-central1 --type=firestore-native
```

---

## Prompts de Demo

### Demo 1 — Explorar la base de datos existente

```text
Revisa las colecciones de Firestore en mi proyecto TU_PROJECT_ID.
¿Cuántas hay? ¿Qué documentos tiene la colección "barriers"?
```

**Qué pasa:** Claude llama a `list_collections` para descubrir la estructura, luego `list_documents` en la colección indicada.

---

### Demo 2 — Crear seed data con documentos coherentes

```text
Crea en Firestore los documentos de seed para el hackathon.
Colección "barriers": 3 documentos con type, severity (alta/media/baja),
coords (lat/lng), status (open/resolved) y reportedBy.
Usa datos reales de Tijuana.
```

**Qué pasa:** Claude llama a `add_document` para cada documento, respetando los tipos correctos de Firestore (incluye timestamps y geopoints en el formato adecuado).

**Resultado:**

```
✓ barriers/bar_001  { type: 'broken_sidewalk', severity: 'alta',
                       coords: { lat: 32.5149, lng: -117.0382 },
                       status: 'open', reportedBy: 'usr_001' }
✓ barriers/bar_002  { type: 'missing_ramp', severity: 'media', ... }
✓ barriers/bar_003  { type: 'blocked_path', severity: 'alta', ... }
```

---

### Demo 3 — Query con filtros

```text
Muéstrame todos los documentos de la colección "barriers"
donde severity sea "alta" y status sea "open".
```

**Qué pasa:** Claude usa `list_documents` con los parámetros de filtro correspondientes. Firestore aplica los filtros compuestos.

---

### Demo 4 — Schema discovery (el killer feature)

```text
No tengo documentación de mi base de datos.
Revisa la colección "barriers" y dime exactamente qué campos tiene,
qué tipos de datos son, y qué índices compuestos conviene crear
para los filtros más comunes (severity + status, status + createdAt).
```

**Qué pasa:** Claude llama a `list_collections`, `list_documents` y `get_document` para inspeccionar documentos reales, infiere el schema y llama a `create_index` para generar los índices sugeridos.

---

### Demo 5 — Configurar el proyecto con Firebase MCP Server

```text
Muéstrame la configuración del SDK de Firebase para inicializar
la app web del hackathon. Y revisa las security rules actuales.
```

**Qué pasa:** Claude usa `firebase_get_sdk_config` (el objeto de config que va en `initializeApp`) y `firebase_get_security_rules` para revisar las reglas de seguridad activas.

---

## Puntos clave para la audiencia

- **google-cloud-firestore** es la herramienta de datos — usa las tools correctas (`add_document`, no `firestore_add`)
- **firebase-mcp-server** es la herramienta de gestión — deploy, config, reglas
- Schema discovery en tiempo real: el agente entiende tu base de datos sin que se lo expliques
- En producción: usa `roles/datastore.user` con mínimos privilegios, nunca owner/editor
