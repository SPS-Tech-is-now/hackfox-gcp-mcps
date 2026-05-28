# Ecosistema de Servidores MCP y Herramientas Disponibles

Este documento cataloga los servidores de **Model Context Protocol (MCP)** configurados y activos en este entorno de desarrollo para **HackFox 2026**. Proporciona a Claude y a otros agentes de IA las herramientas necesarias para interactuar directamente con Google Cloud, Firebase, Chrome DevTools y otras utilidades clave de desarrollo.

---

## Índice de Servidores MCP

1. [Google Developer Knowledge (`google-developer-knowledge`)](#1-google-developer-knowledge-google-developer-knowledge)
2. [Google Maps Platform Code Assist (`gmp-code-assist`)](#2-google-maps-platform-code-assist-gmp-code-assist)
3. [Firebase MCP Server (`firebase-mcp-server`)](#3-firebase-mcp-server-firebase-mcp-server)
4. [Google Cloud Firestore (`google-cloud-firestore`)](#4-google-cloud-firestore-google-cloud-firestore)
5. [Cloud Run (`cloudrun`)](#5-cloud-run-cloudrun)
6. [Cloud SQL Managed MCP (`cloud-sql-managed-mcp`)](#6-cloud-sql-managed-mcp-cloud-sql-managed-mcp)
7. [Google Compute Engine (`google-compute-engine`)](#7-google-compute-engine-google-compute-engine)
8. [Google Cloud Logging (`google-cloud-logging`)](#8-google-cloud-logging-google-cloud-logging)
9. [Google Cloud Monitoring (`google-cloud-monitoring`)](#9-google-cloud-monitoring-google-cloud-monitoring)
10. [Google Cloud Resource Manager (`google-cloud-resource-manager`)](#10-google-cloud-resource-manager-google-cloud-resource-manager)
11. [Chrome DevTools MCP (`chrome-devtools-mcp`)](#11-chrome-devtools-mcp-chrome-devtools-mcp)
12. [Shadcn UI (`shadcn`)](#12-shadcn-ui-shadcn)

---

## Detalle de Servidores y Herramientas

### 1. Google Developer Knowledge (`google-developer-knowledge`)
Permite consultar la documentación oficial de productos para desarrolladores de Google, incluyendo guías, especificaciones de APIs y ejemplos de código.
*   **Herramientas disponibles:**
    *   `search_documents`: Busca fragmentos y artículos de documentación relevante en base a consultas en lenguaje natural.
    *   `answer_query`: Sintetiza una respuesta documentada y fundamentada sobre preguntas técnicas.
    *   `get_documents`: Recupera el contenido completo de un documento usando su identificador jerárquico.

---

### 2. Google Maps Platform Code Assist (`gmp-code-assist`)
Asistente técnico especializado en la integración de mapas, cálculo de rutas, geolocalización y datos geoespaciales.
*   **Herramientas disponibles:**
    *   `retrieve-instructions`: Proporciona contexto fundamental e instrucciones sobre las APIs de Google Maps Platform.
    *   `retrieve-google-maps-platform-docs`: Obtiene fragmentos de documentación y especificaciones de las APIs de mapas.

---

### 3. Firebase MCP Server (`firebase-mcp-server`)
Herramienta de control y despliegue para gestionar proyectos de Firebase en tiempo real.
*   **Herramientas disponibles:**
    *   `firebase_login` / `firebase_logout`: Gestión de la sesión de autenticación.
    *   `firebase_get_project` / `firebase_list_projects` / `firebase_list_apps`: Inspección de la consola y recursos de Firebase.
    *   `firebase_get_sdk_config`: Recupera la configuración de inicialización para aplicaciones Web, Android o iOS.
    *   `firebase_create_project` / `firebase_create_app` / `firebase_create_android_sha`: Aprovisionamiento de nuevos recursos.
    *   `firebase_get_environment` / `firebase_update_environment`: Gestión de variables de entorno.
    *   `firebase_init`: Inicializa un directorio local para Firebase.
    *   `firebase_get_security_rules`: Consulta las reglas activas de seguridad.
    *   `firebase_read_resources`: Lee archivos locales de configuración de Firebase.
    *   `firebase_deploy` / `firebase_deploy_status`: Realiza despliegues en producción y consulta su estado actual.
    *   `developerknowledge_search_documents` / `developerknowledge_answer_query` / `developerknowledge_get_documents`: Acceso a la base de conocimiento especializada de Firebase.

---

### 4. Google Cloud Firestore (`google-cloud-firestore`)
Proporciona control directo sobre bases de datos NoSQL de Firestore para inspeccionar colecciones, crear datos de prueba y depurar.
*   **Herramientas disponibles:**
    *   `list_collections`: Lista colecciones raíz o subcolecciones de un documento.
    *   `list_documents`: Consulta los documentos de una colección.
    *   `get_document`: Obtiene el contenido de un documento específico.
    *   `add_document` / `update_document` / `delete_document`: Operaciones CRUD sobre documentos.
    *   `create_database` / `get_database` / `list_databases` / `update_database` / `delete_database`: Gestión de bases de datos.
    *   `create_index` / `get_index` / `list_indexes` / `delete_index`: Gestión de índices de base de datos.

---

### 5. Cloud Run (`cloudrun`)
Permite inspeccionar, desplegar y monitorizar contenedores en la plataforma serverless Cloud Run.
*   **Herramientas disponibles:**
    *   `list_projects`: Lista proyectos GCP disponibles.
    *   `create_project`: Inicializa un proyecto de nube.
    *   `list_services` / `get_service`: Muestra los microservicios desplegados.
    *   `get_service_log`: Obtiene los logs de ejecución y depuración de un contenedor.
    *   `deploy_local_folder`: Empaqueta y despliega un directorio local a Cloud Run.
    *   `deploy_file_contents`: Despliega código directamente desde el contexto de un archivo.
    *   `deploy_container_image`: Despliega una imagen de contenedor existente en Artifact Registry.

---

### 6. Cloud SQL Managed MCP (`cloud-sql-managed-mcp`)
Gestión y consulta de instancias administradas de bases de datos relacionales (PostgreSQL, MySQL, SQL Server).
*   **Herramientas disponibles:**
    *   `list_instances` / `get_instance` / `create_instance` / `update_instance` / `clone_instance`: Aprovisionamiento.
    *   `execute_sql` / `execute_sql_readonly`: Ejecución directa de queries SQL en bases de datos gestionadas.
    *   `list_users` / `create_user` / `update_user`: Administración de usuarios y accesos.
    *   `create_backup` / `restore_backup`: Respaldo y recuperación de datos.
    *   `import_data`: Importación de esquemas y volcados.
    *   `get_operation`: Consulta de procesos en ejecución.
    *   `postgres_upgrade_precheck`: Validación de compatibilidad para actualizaciones de versión de PostgreSQL.

---

### 7. Google Compute Engine (`google-compute-engine`)
Inspección y gestión de máquinas virtuales e infraestructura de cómputo tradicional.
*   **Herramientas disponibles:**
    *   `list_instances` / `create_instance` / `get_instance_basic_info` / `delete_instance`: Gestión de VMs.
    *   `start_instance` / `stop_instance` / `reset_instance`: Ciclo de vida de instancias.
    *   `set_instance_machine_type`: Escalado vertical de máquinas virtuales.
    *   `list_instance_attached_disks` / `get_disk_basic_info` / `list_disks` / `get_disk_performance_config`: Gestión de almacenamiento persistente.
    *   `list_images`: Consulta de sistemas operativos y plantillas de disco.
    *   `list_machine_types` / `list_accelerator_types` (GPUs): Consulta de recursos físicos en diferentes zonas.
    *   `list_instance_group_managers` / `list_managed_instances` / `list_instance_templates`: Control de autoescalado.
    *   `list_reservations` / `list_commitments`: Optimización de costes de infraestructura.
    *   `list_snapshots`: Gestión de respaldos de discos.

---

### 8. Google Cloud Logging (`google-cloud-logging`)
Lectura e inspección de logs centrales de la organización y aplicaciones en Google Cloud (Cloud Logging).
*   **Herramientas disponibles:**
    *   `list_log_entries`: Recupera entradas de log de servicios específicos utilizando filtros avanzados.
    *   `list_log_names`: Lista los nombres de los logs almacenados en el proyecto.
    *   `list_buckets` / `get_bucket`: Inspección de almacenamiento persistente de registros.
    *   `list_views` / `get_view`: Visualización de consultas y vistas de logs.

---

### 9. Google Cloud Monitoring (`google-cloud-monitoring`)
Permite monitorizar el rendimiento, consultar métricas, configurar alertas y ver dashboards del estado de la infraestructura.
*   **Herramientas disponibles:**
    *   `list_timeseries` / `query_range`: Consulta datos de series temporales de métricas de GCP.
    *   `list_alert_policies` / `get_alert_policy` / `list_alerts` / `get_alert`: Gestión y consulta de sistemas de alerta.
    *   `list_metric_descriptors`: Muestra las métricas disponibles en el sistema.
    *   `list_dashboards` / `get_dashboard`: Recupera definiciones de tableros de control.

---

### 10. Google Cloud Resource Manager (`google-cloud-resource-manager`)
Gestión a nivel organizativo de proyectos de nube.
*   **Herramientas disponibles:**
    *   `search_projects`: Busca proyectos de Google Cloud dentro de la estructura de recursos.

---

### 11. Chrome DevTools MCP (`chrome-devtools-mcp`)
Permite controlar un navegador Chromium en segundo plano para realizar pruebas de UI automáticas, capturas de pantalla, auditorías web y depuración de frontend en vivo.
*   **Herramientas disponibles:**
    *   `new_page` / `close_page` / `list_pages` / `select_page` / `navigate_page`: Navegación y pestañas.
    *   `click` / `hover` / `drag` / `type_text` / `press_key` / `fill` / `fill_form` / `upload_file`: Simulación de interacciones de usuario.
    *   `take_screenshot` / `take_snapshot` / `take_heapsnapshot`: Captura visual y de datos en memoria.
    *   `evaluate_script`: Ejecución directa de código JavaScript en la página.
    *   `list_console_messages` / `get_console_message`: Lectura de logs de consola del navegador.
    *   `list_network_requests` / `get_network_request`: Inspección de llamadas API y red.
    *   `lighthouse_audit`: Generación de auditorías web de rendimiento, accesibilidad, SEO y buenas prácticas.
    *   `performance_analyze_insight` / `performance_start_trace` / `performance_stop_trace`: Análisis profundo de rendimiento de frontend.
    *   `resize_page` / `emulate`: Pruebas de diseño responsivo.
    *   `wait_for`: Sincronización en base a elementos del DOM.

---

### 12. Shadcn UI (`shadcn`)
Automatiza la búsqueda, inspección y adición de componentes de interfaz basados en Shadcn UI.
*   **Herramientas disponibles:**
    *   `get_project_registries`: Obtiene los repositorios y registros disponibles de componentes.
    *   `list_items_in_registries`: Lista los componentes en los registros.
    *   `search_items_in_registries`: Búsqueda semántica de componentes.
    *   `view_items_in_registries`: Inspecciona el código de un componente.
    *   `get_item_examples_from_registries`: Muestra ejemplos prácticos de uso.
    *   `get_add_command_for_items`: Proporciona el comando exacto de CLI para instalar un componente.
    *   `get_audit_checklist`: Genera una lista de auditoría para asegurar la calidad de la implementación de componentes.

---

## Cómo configurar y activar los MCP en este IDE (Firebase Studio)

A diferencia de editores tradicionales como VS Code o Cursor (que requieren la instalación manual de dependencias y la edición manual del archivo de configuración `claude_desktop_config.json`), **Firebase Studio simplifica este proceso mediante una interfaz visual integrada**:

### 1. Activación con Checkbox (Sin Configuración JSON)
1. En la barra lateral derecha de **Firebase Studio**, navega a la pestaña de **Plugins / MCPs**.
2. Verás la lista de servidores de Google pre-integrados (como **Firebase**, **Chrome DevTools** y **Google Antigravity SDK**).
3. Simplemente **marca la casilla (checkbox)** junto al servidor MCP que quieres habilitar.
4. **Eso es todo:** no necesitas escribir rutas de archivos ni configurar puertos. El agente AI del chat tendrá acceso inmediato a las herramientas asociadas.

### 2. Configuración en caliente (Hot Reload)
* No requieres cerrar ni reiniciar Firebase Studio cuando activas o desactivas un MCP. La IA recarga sus capacidades en tiempo real y puedes empezar a pedirle tareas con las nuevas herramientas inmediatamente en el chat activo.

### 3. Selección de Modelos Inteligentes
* Justo arriba de la barra de chat de Firebase Studio, cuentas con el selector de modelos. Asegúrate de tener seleccionado **Claude Sonnet 4.6 (con Thinking mode activado)** para sacar el máximo rendimiento del razonamiento lógico al usar estos MCPs.
