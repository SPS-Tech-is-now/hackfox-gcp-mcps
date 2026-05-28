# Demo: Google Maps Platform Code Assist MCP

## Qué es (y qué NO es)

El MCP `gmp-code-assist` es un **asistente técnico de código**, no un cliente de API.  
Tiene acceso a la documentación oficial de Google Maps Platform y la usa para generar código de integración correcto desde el primer intento.

**No hace llamadas directas a Directions, Geocoding ni Places** — para eso, tu app necesita las API keys y llama a los endpoints directamente. Lo que este MCP hace es que Claude genere ese código **perfectamente** en lugar de adivinarlo.

**Herramientas que expone:**
- `retrieve-instructions` — proporciona contexto e instrucciones fundamentales sobre Maps Platform
- `retrieve-google-maps-platform-docs` — obtiene fragmentos de documentación actualizada de APIs específicas

---

## Prerrequisitos
- Claude Desktop con el MCP `gmp-code-assist` activo
- API Key de Google Maps con las APIs habilitadas que vayas a usar: Maps JavaScript, Directions, Geocoding, Places

---

## Por qué importa este MCP

Sin él, Claude genera código de Maps desde memoria de entrenamiento — que puede estar desactualizado, usar parámetros deprecados o mezclar versiones incompatibles de SDK. Con `gmp-code-assist`, Claude consulta la documentación oficial **antes de escribir una sola línea**.

---

## Prompts de Demo

### Demo 1 — Ruta accesible (genera el código correcto)
```
Necesito integrar rutas peatonales accesibles en mi app de Node.js.
¿Qué parámetro de Directions API evita escaleras?
¿Hay alguna limitación documentada para rutas de accesibilidad?
Genera el código de llamada con el parámetro correcto y manejo de errores.
```
**Qué pasa:** Claude usa `retrieve-google-maps-platform-docs` para consultar Directions API, confirma que el parámetro es `avoid=steps` en `mode=walking`, y genera el snippet correcto con autenticación por API key.

**Resultado:**
```js
const params = new URLSearchParams({
  origin: '32.5149,-117.0382',
  destination: '32.5261,-117.0181',  // CECUT
  mode: 'walking',
  avoid: 'steps',                    // parámetro confirmado en docs
  key: process.env.MAPS_API_KEY
});
const res = await fetch(`https://maps.googleapis.com/maps/api/directions/json?${params}`);
```

---

### Demo 2 — Geocoding inverso
```
¿Cómo hago geocoding inverso (coordenadas → dirección legible) desde el SDK de JavaScript de Maps?
Dame el código completo con manejo del caso en que la respuesta no tenga resultados.
```
**Qué pasa:** Claude consulta la documentación del Geocoding API, distingue entre `geocode()` y `reverseGeocode()`, y genera el snippet con tipado correcto.

---

### Demo 3 — Places Nearby con filtros
```
Necesito buscar centros de salud en un radio de 2 km de una coordenada.
Estoy usando Maps JavaScript API v3. Genera el código con Places API nearby search.
¿Qué campo de la respuesta contiene las reseñas de accesibilidad?
```
**Qué pasa:** Claude revisa la documentación de Places API para confirmar el campo correcto (`wheelchair_accessible_entrance` en Place Details), genera el código de `nearbySearch` con el type correcto.

---

### Demo 4 — Validar integración existente
```
Tengo este código de Maps que está fallando silenciosamente:
[pega tu código]

¿Está usando la versión correcta del SDK? ¿Hay parámetros deprecados?
Corrige los problemas desde la documentación oficial.
```
**Qué pasa:** Claude usa el MCP para validar el código contra la documentación actual y detecta parámetros deprecados o versiones incompatibles.

---

## Puntos clave para la audiencia
- **Code assist, no API caller:** el MCP no consume cuota de Maps APIs — genera el código que tú usarás
- **Documentación siempre actualizada:** elimina el riesgo de usar `DirectionsService` deprecado o params de v2
- **Errores de integración son el cuello de botella real** en hackathons — este MCP los elimina
- Para hacer llamadas reales en producción: añade tu API key en `.env` y llama los endpoints directamente

## Limitaciones
- No ejecuta llamadas en vivo a Maps APIs — solo genera el código
- No muestra mapas interactivos ni rutas visualizadas (eso lo hace tu app con la API key)
- Requiere conectividad a la documentación de Google
