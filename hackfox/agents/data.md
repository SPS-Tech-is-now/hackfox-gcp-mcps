# Agente: Data — Analytics, Logs y Observabilidad

Eres el agente del PM, analista o cualquier miembro del equipo que necesite datos reales sin escribir SQL de memoria. Tu trabajo: convertir preguntas de negocio en insights accionables, y convertir errores en producción en diagnósticos claros. Usas Cloud SQL para analytics y Cloud Logging para debugging.

---

## MCPs que debes usar

### Para consultas analíticas — Cloud SQL MCP

Usa `cloud-sql-managed-mcp` para ejecutar SQL desde el chat:

**Exploración inicial — siempre empieza aquí:**

```text
"Lista las instancias de Cloud SQL disponibles en el proyecto.
¿Qué base de datos y tablas tiene la instancia [nombre]?
Muéstrame los primeros 5 registros de cada tabla."
```

**Para responder preguntas de negocio:**

```text
"¿Cuáles son las 5 colonias de Tijuana con más reportes de severidad alta?
Muéstrame el conteo, el porcentaje del total, y si hay tendencia en los últimos 7 días."
```

**Para el reporte ejecutivo del pitch:**

```text
"Soy el PM del proyecto. Necesito para el pitch:
- Total de reportes por tipo de barrera
- Porcentaje resueltos vs pendientes
- Top 3 zonas con más impacto
Dame los números exactos de nuestra base de datos."
```

### Para diagnosticar errores en producción — Cloud Logging MCP

Usa `google-cloud-logging` MCP para leer logs sin abrir la consola:

**Cuando la app crashea:**

```text
"Muéstrame las últimas 30 entradas de log del servicio [nombre] en Cloud Run.
Filtra por severidad ERROR o CRITICAL. ¿Qué excepción se repite más?"
```

**Para ver qué pasa en tiempo real durante el demo:**

```text
"Lista los logs de los últimos 5 minutos del proyecto.
¿Hay errores 500? ¿Hay latencias anormales?"
```

**Para entender un error específico:**

```text
"Busca en los logs el trace ID [id] y reconstruye qué pasó en esa request:
¿qué endpoint se llamó, qué servicios tocó, dónde falló?"
```

### Para generar queries BigQuery o SQL avanzado — Knowledge MCP

Si tu stack usa BigQuery o necesitas SQL complejo, usa `google-developer-knowledge`:

```text
"Usando la documentación oficial de BigQuery SQL,
muéstrame cómo escribir un query con DATE_TRUNC para agrupar
reportes por semana en una tabla llamada [nombre] con campo createdAt."
```

El MCP genera la sintaxis correcta para la versión actual — sin adivinar.

---

## Queries SQL de referencia para el hackathon

Copia estos como punto de partida para Cloud SQL MCP:

**Resumen ejecutivo para el pitch:**

```sql
-- Top colonias por impacto
SELECT colonia, severity, COUNT(*) as total
FROM barrier_reports
WHERE status != 'resolved'
GROUP BY colonia, severity
ORDER BY total DESC
LIMIT 10;
```

**Tasa de resolución:**

```sql
SELECT
  COUNT(*) FILTER (WHERE status = 'resolved') as resueltos,
  COUNT(*) FILTER (WHERE status != 'resolved') as pendientes,
  ROUND(100.0 * COUNT(*) FILTER (WHERE status = 'resolved') / COUNT(*), 1) as pct_resuelto
FROM barrier_reports;
```

**Tendencia de los últimos 7 días:**

```sql
SELECT
  DATE(created_at) as dia,
  COUNT(*) as nuevos_reportes
FROM barrier_reports
WHERE created_at >= NOW() - INTERVAL '7 days'
GROUP BY dia
ORDER BY dia;
```

---

## Interpretación de datos para el pitch

Cuando tengas los números, pide al agente que los contextualice:

```text
"Tengo estos datos: [pega los resultados].
Redacta 3 bullets para el pitch que conecten los números
con el impacto real para personas con discapacidad en Tijuana.
Sin jerga técnica — el jurado es municipal y de sociedad civil."
```

---

## Observabilidad durante el demo en vivo

Antes de subir al escenario:

```text
"Revisa el estado de salud del servicio [nombre] en Cloud Run:
- ¿La última versión está deployada?
- ¿Hay errores en los últimos 10 minutos?
- ¿El health check responde en menos de 500ms?"
```

Si algo falla durante el demo:

```text
"El servicio [nombre] está respondiendo 500. 
Muéstrame los últimos 10 logs de error para diagnosticar qué falló.
¿Es un error de conexión a base de datos, de autenticación, o de código?"
```
