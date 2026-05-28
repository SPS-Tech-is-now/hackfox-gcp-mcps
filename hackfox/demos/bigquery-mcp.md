# Analytics de Datos — Cloud SQL MCP + alternativas BigQuery

## Estado en el entorno actual

**BigQuery MCP no está en el catálogo de este entorno.** No existe un servidor MCP configurado que llame directamente a la API de BigQuery.

Para analytics SQL en el hackathon hay dos rutas reales:

| Ruta | MCP disponible | Caso de uso |
|---|---|---|
| **Cloud SQL MCP** | `cloud-sql-managed-mcp` ✅ | SQL directo sobre PostgreSQL/MySQL gestionado |
| **Knowledge MCP** | `google-developer-knowledge` ✅ | Genera queries BigQuery correctas desde docs oficiales |
| BigQuery nativo | no disponible en catálogo | Requiere MCP de terceros (ver sección al final) |

---

## Opción A — Cloud SQL MCP (recomendado para hackathon)

`cloud-sql-managed-mcp` permite ejecutar SQL directamente sobre instancias de Cloud SQL (PostgreSQL, MySQL, SQL Server) desde el chat.

### Herramientas disponibles

- `list_instances` — lista las instancias de Cloud SQL disponibles
- `execute_sql` — ejecuta queries SQL (lectura y escritura)
- `execute_sql_readonly` — ejecuta queries de solo lectura (seguro para demos)
- `list_users` / `create_user` — gestión de accesos

### Prerrequisitos

```bash
gcloud services enable sqladmin.googleapis.com
# Crear instancia PostgreSQL (la más rápida para hackathon)
gcloud sql instances create hackfox-db \
  --database-version=POSTGRES_15 \
  --tier=db-f1-micro \
  --region=us-central1
```

### Prompts de Demo

**Demo 1 — Exploración inicial**

```text
Lista las instancias de Cloud SQL disponibles en el proyecto TU_PROJECT_ID.
¿Qué bases de datos tiene la instancia "hackfox-db"?
```

**Qué pasa:** Claude llama a `list_instances`, luego `execute_sql_readonly` con `SELECT datname FROM pg_database`.

---

**Demo 2 — Análisis de impacto**

```text
Tengo una tabla "barrier_reports" con columnas: colonia, severity, status, created_at.
¿Cuáles son las 3 colonias de Tijuana con más reportes de severidad alta?
```

**Qué pasa:** Claude escribe y ejecuta via `execute_sql_readonly`:

```sql
SELECT colonia, COUNT(*) as total
FROM barrier_reports
WHERE severity = 'alta'
GROUP BY colonia
ORDER BY total DESC
LIMIT 3;
```

---

**Demo 3 — Reporte ejecutivo desde el chat**

```text
Dame un resumen ejecutivo: total de reportes por tipo,
porcentaje de cada uno, y cuál tipo tiene más reportes sin resolver.
```

**Qué pasa:** Claude genera varias queries con GROUP BY, LEFT JOIN y subconsultas — el director municipal obtiene insights sin saber SQL.

---

## Opción B — Knowledge MCP para escribir queries BigQuery

Si tu app sí usa BigQuery, el MCP `google-developer-knowledge` puede generar queries BigQuery correctas desde la documentación oficial.

```text
Usando el Knowledge MCP, dame el query BigQuery para contar reportes
agrupados por colonia y severity, usando la tabla
`hackfox.barriers.reports`. ¿Qué sintaxis específica es diferente a SQL estándar?
```

**Resultado:** Claude consulta la documentación de BigQuery SQL Syntax y genera el query con la sintaxis correcta (backticks en nombres de tabla, funciones específicas de BQ como DATE_TRUNC).

---

## Opción C — BigQuery MCP de terceros (setup adicional)

Si necesitas BigQuery directamente como MCP, existe un servidor de la comunidad. Requiere setup manual fuera del entorno actual:

```json
{
  "mcpServers": {
    "bigquery": {
      "command": "uvx",
      "args": ["mcp-bigquery-server"],
      "env": {
        "GOOGLE_APPLICATION_CREDENTIALS": "/ruta/a/sa-key.json",
        "BIGQUERY_PROJECT": "TU_PROJECT_ID"
      }
    }
  }
}
```

Instalar: `pip install mcp-bigquery-server` o buscar en [modelcontextprotocol.io](https://modelcontextprotocol.io).

**Nota:** Este servidor no está validado en el catálogo del entorno — úsalo bajo tu propio criterio en el hackathon.

---

## Puntos clave para la audiencia

- **Para el hackathon:** Cloud SQL MCP (`execute_sql_readonly`) es la ruta más rápida y está en el catálogo
- **Para analytics de BigQuery:** usa Knowledge MCP para generar los queries y ejecútalos tú manualmente en la consola o desde código
- **La democratización del dato** sigue siendo real — el PM puede pedir el análisis en lenguaje natural aunque el back end sea Cloud SQL en lugar de BigQuery
