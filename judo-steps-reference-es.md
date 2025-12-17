# Referencia Completa de Pasos - Judo Framework (Español)

Esta es la referencia completa de todos los pasos **VERIFICADOS** disponibles en Judo Framework v1.3.40 en español.

**⚠️ IMPORTANTE**: Esta documentación ha sido verificada contra el código fuente del framework. Solo incluye pasos que realmente existen y funcionan.

**💡 Nota**: Todos los pasos usan el decorador `@step()`, lo que significa que funcionan con cualquier keyword (Given, When, Then, And, But, Dado, Cuando, Entonces, Y, Pero). Esto proporciona máxima flexibilidad al escribir tus escenarios de prueba.

## 📋 Índice

- [Configuración](#configuración)
- [Autenticación](#autenticación)
- [Peticiones HTTP](#peticiones-http)
- [Validación de Respuestas](#validación-de-respuestas)
- [Extracción de Datos](#extracción-de-datos)
- [Variables](#variables)
- [Arrays y Colecciones](#arrays-y-colecciones)
- [Utilidades](#utilidades)
- [Logging](#logging)

---

## Configuración

### `Dado que tengo un cliente Judo API`
Inicializa el contexto de Judo Framework para comenzar las pruebas de API.

**Ejemplos:**
```gherkin
Dado que tengo un cliente Judo API
```

### `Dado que la URL base es "{url}"`
Establece la URL base que se usará para todas las peticiones HTTP subsecuentes.

**Ejemplos:**
```gherkin
Dado que la URL base es "https://api.example.com"
Dado que la URL base es "https://jsonplaceholder.typicode.com"
Dado que la URL base es "http://localhost:3000"
```

### `Dado que establezco la variable "{nombre}" a "{valor}"`
Crea o actualiza una variable de tipo string que puede ser reutilizada en otros pasos.

**Ejemplos:**
```gherkin
Dado que establezco la variable "userId" a "123"
Dado que establezco la variable "apiVersion" a "v1"
Dado que establezco la variable "environment" a "production"
```

### `Dado que establezco la variable "{nombre}" a {valor:d}`
Crea o actualiza una variable de tipo numérico (entero).

**Ejemplos:**
```gherkin
Dado que establezco la variable "maxRetries" a 3
Dado que establezco la variable "timeout" a 5000
Dado que establezco la variable "pageSize" a 10
```

### `obtengo el valor "{nombre_var_env}" desde env y lo almaceno en "{nombre_variable}"`
Obtiene el valor de una variable de entorno (.env) y lo almacena en una variable para uso posterior. Útil para configuraciones dinámicas como URLs base, tokens, etc.

**Ejemplos:**
```gherkin
Dado que obtengo el valor "API_TOKEN" desde env y lo almaceno en "token"
Dado que obtengo el valor "BASE_URL" desde env y lo almaceno en "baseUrl"
Dado que obtengo el valor "API_KEY" desde env y lo almaceno en "apiKey"
```

---

## Autenticación

### `Dado que uso el token bearer "{token}"`
Configura autenticación Bearer Token (JWT) para todas las peticiones subsecuentes.

**Ejemplos:**
```gherkin
Dado que uso el token bearer "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
Dado que uso el token bearer "{authToken}"
```

### `Dado que uso autenticación básica con usuario "{usuario}" y contraseña "{password}"`
Configura autenticación HTTP Basic con usuario y contraseña.

**Ejemplos:**
```gherkin
Dado que uso autenticación básica con usuario "admin" y contraseña "secret123"
Dado que uso autenticación básica con usuario "testuser" y contraseña "pass1234"
```

### `Dado que establezco el header "{nombre}" a "{valor}"`
Agrega un header HTTP personalizado a todas las peticiones subsecuentes.

**Ejemplos:**
```gherkin
Dado que establezco el header "Content-Type" a "application/json"
Dado que establezco el header "X-API-Version" a "v2"
Dado que establezco el header "Accept-Language" a "es-ES"
Dado que establezco el header "X-Request-ID" a "12345"
```

### `Dado que establezco el header "{nombre_header}" desde env "{nombre_var_env}"`
### `Dado que agrego el header "{nombre_header}" desde env "{nombre_var_env}"`
Establece un header HTTP usando el valor de una variable de entorno o archivo .env.

**Ejemplos:**
```gherkin
Dado que establezco el header "Authorization" desde env "API_TOKEN"
Dado que agrego el header "X-API-Key" desde env "API_KEY"
Dado que establezco el header "X-Client-ID" desde env "CLIENT_ID"
```

### `Dado que establezco el parámetro "{nombre}" a "{valor}"`
Agrega un parámetro de query string a la siguiente petición HTTP.

**Ejemplos:**
```gherkin
Dado que establezco el parámetro "page" a "1"
Dado que establezco el parámetro "limit" a "10"
Dado que establezco el parámetro "sort" a "desc"
Dado que establezco el parámetro "filter" a "active"
```

---

## Peticiones HTTP

### `Cuando hago una petición GET a "{endpoint}"`
Envía una petición HTTP GET para recuperar datos del servidor.

**Ejemplos:**
```gherkin
Cuando hago una petición GET a "/users"
Cuando hago una petición GET a "/users/123"
Cuando hago una petición GET a "/users/{userId}"
Cuando hago una petición GET a "/api/v1/products"
```

### `Cuando hago una petición POST a "{endpoint}"`
Envía una petición HTTP POST sin cuerpo de datos.

**Ejemplos:**
```gherkin
Cuando hago una petición POST a "/users/123/activate"
Cuando hago una petición POST a "/logout"
```

### `Cuando hago una petición POST a "{endpoint}" con el cuerpo`
### `Cuando hago una petición POST a "{endpoint}" con el cuerpo:`
Envía una petición HTTP POST con datos JSON en el cuerpo usando el texto del paso.

**Ejemplos:**
```gherkin
Cuando hago una petición POST a "/users" con el cuerpo:
  """
  {
    "name": "Juan Pérez",
    "email": "juan@example.com",
    "age": 30
  }
  """

Cuando hago una petición POST a "/posts" con el cuerpo:
  """
  {
    "title": "Mi Post",
    "body": "Contenido del post",
    "userId": 1
  }
  """
```

### `Cuando hago una petición PUT a "{endpoint}" con el cuerpo`
### `Cuando hago una petición PUT a "{endpoint}" con el cuerpo:`
Envía una petición HTTP PUT con datos JSON para reemplazar completamente un recurso.

**Ejemplos:**
```gherkin
Cuando hago una petición PUT a "/users/123" con el cuerpo:
  """
  {
    "id": 123,
    "name": "Juan Pérez Actualizado",
    "email": "juan.nuevo@example.com",
    "age": 31
  }
  """
```

### `Cuando hago una petición PATCH a "{endpoint}" con el cuerpo`
### `Cuando hago una petición PATCH a "{endpoint}" con el cuerpo:`
Envía una petición HTTP PATCH con datos JSON para actualizar parcialmente un recurso.

**Ejemplos:**
```gherkin
Cuando hago una petición PATCH a "/users/123" con el cuerpo:
  """
  {
    "email": "nuevo.email@example.com"
  }
  """

Cuando hago una petición PATCH a "/posts/1" con el cuerpo:
  """
  {
    "title": "Título Actualizado"
  }
  """
```

### `Cuando hago una petición DELETE a "{endpoint}"`
Envía una petición HTTP DELETE para eliminar un recurso del servidor.

**Ejemplos:**
```gherkin
Cuando hago una petición DELETE a "/users/123"
Cuando hago una petición DELETE a "/posts/{postId}"
Cuando hago una petición DELETE a "/comments/456"
```

---

## Validación de Respuestas

### `Entonces el código de respuesta debe ser {status:d}`
Valida que el código de estado HTTP de la respuesta sea el esperado.

**Ejemplos:**
```gherkin
Entonces el código de respuesta debe ser 200
Entonces el código de respuesta debe ser 201
Entonces el código de respuesta debe ser 204
Entonces el código de respuesta debe ser 400
Entonces el código de respuesta debe ser 404
Entonces el código de respuesta debe ser 500
```

### `Entonces la respuesta debe ser exitosa`
Valida que la respuesta tenga un código de estado exitoso (2xx).

**Ejemplos:**
```gherkin
Cuando hago una petición GET a "/users/1"
Entonces la respuesta debe ser exitosa
```

### `Entonces la respuesta debe contener el campo "{campo}"`
Verifica que la respuesta JSON contenga un campo específico.

**Ejemplos:**
```gherkin
Entonces la respuesta debe contener el campo "id"
Entonces la respuesta debe contener el campo "name"
Entonces la respuesta debe contener el campo "email"
```

### `Entonces el campo "{campo}" debe ser "{valor}"`
Valida que un campo específico tenga exactamente el valor string esperado.

**Ejemplos:**
```gherkin
Entonces el campo "name" debe ser "Juan Pérez"
Entonces el campo "status" debe ser "active"
Entonces el campo "email" debe ser "juan@example.com"
```

### `Entonces el campo "{campo}" debe ser {valor:d}`
Valida que un campo específico tenga exactamente el valor numérico esperado.

**Ejemplos:**
```gherkin
Entonces el campo "id" debe ser 123
Entonces el campo "age" debe ser 30
Entonces el campo "count" debe ser 10
```

### `Entonces el campo "{campo}" debe ser igual a la variable "{variable}"`
Compara el valor de un campo con el valor almacenado en una variable.

**Ejemplos:**
```gherkin
Dado que establezco la variable "expectedName" a "Juan Pérez"
Cuando hago una petición GET a "/users/1"
Entonces el campo "name" debe ser igual a la variable "expectedName"
```

### `Entonces la respuesta debe tener la siguiente estructura`
### `Entonces la respuesta debe tener la siguiente estructura:`
Valida la estructura de la respuesta contra un esquema JSON definido en el texto del paso.

**Ejemplos:**
```gherkin
Entonces la respuesta debe tener la siguiente estructura:
  """
  {
    "id": 123,
    "name": "Juan Pérez",
    "email": "juan@example.com",
    "active": true
  }
  """
```

### `Entonces el tiempo de respuesta debe ser menor a {max_time:f} segundos`
Valida que el tiempo de respuesta de la petición HTTP sea menor al límite especificado.

**Ejemplos:**
```gherkin
Cuando hago una petición GET a "/users"
Entonces el tiempo de respuesta debe ser menor a 2.0 segundos
Entonces el tiempo de respuesta debe ser menor a 0.5 segundos
Entonces el tiempo de respuesta debe ser menor a 5.0 segundos
```

---

## Extracción de Datos

### `Cuando guardo el valor del campo "{campo}" en la variable "{variable}"`
Extrae el valor de un campo de la respuesta y lo almacena en una variable para uso posterior.

**Ejemplos con JSONPath:**
```gherkin
Cuando guardo el valor del campo "id" en la variable "userId"
Cuando guardo el valor del campo "user.email" en la variable "userEmail"
Cuando guardo el valor del campo "data.token" en la variable "authToken"
Cuando guardo el valor del campo "items[0].id" en la variable "firstItemId"
Cuando guardo el valor del campo "address.city" en la variable "city"
```

### `Cuando guardo la respuesta completa en la variable "{variable}"`
Almacena toda la respuesta JSON en una variable.

**Ejemplos:**
```gherkin
Cuando hago una petición GET a "/users/1"
Cuando guardo la respuesta completa en la variable "userData"

# Luego puedes usar esa variable en otra petición
Cuando hago una petición POST a "/backup" con la variable "userData"
```

---

## Variables

### `Entonces la variable "{variable1}" debe ser igual a la variable "{variable2}"`
Compara que dos variables tengan exactamente el mismo valor.

**Ejemplos:**
```gherkin
Dado que establezco la variable "expected" a "Juan"
Cuando guardo el valor del campo "name" en la variable "actual"
Entonces la variable "actual" debe ser igual a la variable "expected"
```

### `Entonces la variable "{variable1}" no debe ser igual a la variable "{variable2}"`
Verifica que dos variables tengan valores diferentes.

**Ejemplos:**
```gherkin
Cuando guardo el valor del campo "id" en la variable "userId1"
Cuando hago una petición GET a "/users/2"
Cuando guardo el valor del campo "id" en la variable "userId2"
Entonces la variable "userId1" no debe ser igual a la variable "userId2"
```

---

## Arrays y Colecciones

### `Entonces la respuesta debe ser un array`
### `Entonces la respuesta debe ser una lista`
Valida que la respuesta sea un array JSON (lista).

**Ejemplos:**
```gherkin
Cuando hago una petición GET a "/users"
Entonces la respuesta debe ser un array

Cuando hago una petición GET a "/posts"
Entonces la respuesta debe ser una lista
```

### `Entonces la respuesta debe tener {count:d} elementos`
Verifica que el array de respuesta tenga exactamente el número de elementos especificado.

**Ejemplos:**
```gherkin
Cuando hago una petición GET a "/users"
Entonces la respuesta debe tener 10 elementos
Entonces la respuesta debe tener 0 elementos
Entonces la respuesta debe tener 5 elementos
```

### `Entonces cada elemento debe tener el campo "{campo}"`
Valida que todos los elementos del array tengan un campo específico.

**Ejemplos:**
```gherkin
Cuando hago una petición GET a "/users"
Entonces la respuesta debe ser un array
Y cada elemento debe tener el campo "id"
Y cada elemento debe tener el campo "name"
Y cada elemento debe tener el campo "email"
```

### `Entonces el array "{ruta_array}" debe contener un elemento con "{campo}" igual a "{valor}"`
Busca en un array (anidado o de nivel raíz) un elemento que tenga un campo con un valor específico.

**Ejemplos con JSONPath:**
```gherkin
# Array de nivel raíz (cuando la respuesta es un array directamente)
Entonces el array "users" debe contener un elemento con "id" igual a "123"
Entonces el array "users" debe contener un elemento con "name" igual a "Juan"

# Array anidado usando notación de punto
Entonces el array "data.items" debe contener un elemento con "status" igual a "active"
Entonces el array "response.users" debe contener un elemento con "email" igual a "juan@example.com"
```



---

## Utilidades

### `Cuando espero {segundos:f} segundos`
Pausa la ejecución del test por el número de segundos especificado.

**Ejemplos:**
```gherkin
Cuando hago una petición POST a "/process"
Y espero 2 segundos
Cuando hago una petición GET a "/status"

Cuando espero 0.5 segundos
Cuando espero 1.0 segundos
Cuando espero 5.0 segundos
```

### `Cuando imprimo la respuesta`
Imprime la respuesta completa en la consola para propósitos de debugging.

**Ejemplos:**
```gherkin
Cuando hago una petición GET a "/users/1"
Entonces el código de respuesta debe ser 200
Y imprimo la respuesta
```

---

## Logging

### `Cuando habilito el guardado de peticiones y respuestas`
Activa el guardado automático de todas las interacciones HTTP en archivos JSON.

**Ejemplos:**
```gherkin
Dado que tengo un cliente Judo API
Cuando habilito el guardado de peticiones y respuestas
Cuando hago una petición GET a "/users/1"
```

### `Cuando deshabilito el guardado de peticiones y respuestas`
Desactiva el guardado automático de interacciones HTTP.

**Ejemplos:**
```gherkin
Cuando deshabilito el guardado de peticiones y respuestas
```

### `Cuando habilito el guardado de peticiones y respuestas en el directorio "{directorio}"`
Activa el logging de HTTP con un directorio personalizado para los archivos.

**Ejemplos:**
```gherkin
Cuando habilito el guardado de peticiones y respuestas en el directorio "api_logs"
Cuando habilito el guardado de peticiones y respuestas en el directorio "test_output/logs"
```

### `Cuando establezco el directorio de salida a "{directorio}"`
Configura el directorio donde se guardarán los logs de peticiones y respuestas.

**Ejemplos:**
```gherkin
Cuando establezco el directorio de salida a "test_results"
Cuando establezco el directorio de salida a "output/api_logs"
```

---

## Variables Avanzadas

### `Dado que establezco la variable "{nombre}" al JSON`
Almacena un objeto JSON completo en una variable usando el texto del paso.

**Ejemplos:**
```gherkin
Dado que establezco la variable "userData" al JSON
  """
  {
    "name": "Juan Pérez",
    "email": "juan@example.com",
    "age": 30,
    "address": {
      "city": "Santiago",
      "country": "Chile"
    }
  }
  """

Dado que establezco la variable "postData" al JSON
  """
  {
    "title": "Mi Post",
    "body": "Contenido",
    "userId": 1
  }
  """
```

---

## Peticiones con Variables

### `Cuando hago una petición {método} a "{endpoint}" con la variable "{nombre_var}"`
Envía una petición HTTP de cualquier método usando datos JSON almacenados en una variable.

**Ejemplos:**
```gherkin
Dado que establezco la variable "newUser" al JSON
  """
  {"name": "Juan", "email": "juan@example.com"}
  """
Cuando hago una petición POST a "/users" con la variable "newUser"

Cuando hago una petición PUT a "/users/123" con la variable "userData"
Cuando hago una petición PATCH a "/posts/1" con la variable "updateData"
```

---

## Validación JSONPath

### `Entonces la respuesta "{ruta_json}" debe ser "{valor_esperado}"`
Valida el valor de una ruta JSONPath específica contra un valor esperado.

**Ejemplos con JSONPath:**
```gherkin
Entonces la respuesta "$.name" debe ser "Juan Pérez"
Entonces la respuesta "$.user.email" debe ser "juan@example.com"
Entonces la respuesta "$.data.address.city" debe ser "Santiago"
Entonces la respuesta "$.items[0].title" debe ser "Primer Item"
```

### `Entonces la respuesta "{ruta_json}" debe ser {valor_esperado:d}`
Valida el valor numérico de una ruta JSONPath específica.

**Ejemplos con JSONPath:**
```gherkin
Entonces la respuesta "$.id" debe ser 123
Entonces la respuesta "$.user.age" debe ser 30
Entonces la respuesta "$.data.count" debe ser 10
Entonces la respuesta "$.items[0].price" debe ser 99
```

---

## Archivos

### `Cuando hago POST a "{endpoint}" con archivo JSON "{ruta_archivo}"`
Envía una petición POST usando datos JSON cargados desde un archivo externo.

### `Cuando hago PUT a "{endpoint}" con archivo JSON "{ruta_archivo}"`
Envía una petición PUT usando datos JSON cargados desde un archivo externo.

### `Cuando hago PATCH a "{endpoint}" con archivo JSON "{ruta_archivo}"`
Envía una petición PATCH usando datos JSON cargados desde un archivo externo.

### `Cuando guardo la respuesta en el archivo "{ruta_archivo}"`
Guarda la respuesta completa en un archivo para análisis posterior o debugging.

### `Cuando guardo la variable "{nombre_var}" en el archivo "{ruta_archivo}"`
Guarda el contenido de una variable en un archivo externo.

---

## Validación de Esquemas

### `Entonces la respuesta debe coincidir con el esquema`
Valida la respuesta contra un esquema JSON definido en el texto del paso.

### `Entonces la respuesta debe coincidir con el archivo de esquema "{ruta_archivo}"`
Valida la respuesta contra un esquema JSON almacenado en un archivo externo.

---

## Validación de Tipos

### `Entonces la respuesta "{ruta_json}" debe ser una cadena`
Valida que el valor en la ruta JSONPath especificada sea de tipo string.

**Ejemplos con JSONPath:**
```gherkin
Entonces la respuesta "$.name" debe ser una cadena
Entonces la respuesta "$.user.email" debe ser una cadena
Entonces la respuesta "$.data.description" debe ser una cadena
```

### `Entonces la respuesta "{ruta_json}" debe ser un número`
Valida que el valor en la ruta JSONPath especificada sea de tipo numérico.

**Ejemplos con JSONPath:**
```gherkin
Entonces la respuesta "$.id" debe ser un número
Entonces la respuesta "$.user.age" debe ser un número
Entonces la respuesta "$.data.count" debe ser un número
Entonces la respuesta "$.items[0].price" debe ser un número
```

### `Entonces la respuesta "{ruta_json}" debe ser un booleano`
Valida que el valor en la ruta JSONPath especificada sea de tipo boolean.

**Ejemplos con JSONPath:**
```gherkin
Entonces la respuesta "$.active" debe ser un booleano
Entonces la respuesta "$.user.verified" debe ser un booleano
Entonces la respuesta "$.data.isPublic" debe ser un booleano
```

### `Entonces la respuesta "{ruta_json}" debe ser un array`
Valida que el valor en la ruta JSONPath especificada sea de tipo array.

**Ejemplos con JSONPath:**
```gherkin
Entonces la respuesta "$.users" debe ser un array
Entonces la respuesta "$.data.items" debe ser un array
Entonces la respuesta "$.user.roles" debe ser un array
```

### `Entonces la respuesta "{ruta_json}" debe ser un objeto`
Valida que el valor en la ruta JSONPath especificada sea de tipo object.

**Ejemplos con JSONPath:**
```gherkin
Entonces la respuesta "$.user" debe ser un objeto
Entonces la respuesta "$.data.address" debe ser un objeto
Entonces la respuesta "$.metadata" debe ser un objeto
```

### `Entonces la respuesta "{ruta_json}" debe ser null`
Valida que el valor en la ruta JSONPath especificada sea null.

**Ejemplos con JSONPath:**
```gherkin
Entonces la respuesta "$.deletedAt" debe ser null
Entonces la respuesta "$.user.middleName" debe ser null
Entonces la respuesta "$.data.optionalField" debe ser null
```

### `Entonces la respuesta "{ruta_json}" no debe ser null`
Valida que el valor en la ruta JSONPath especificada no sea null.

**Ejemplos con JSONPath:**
```gherkin
Entonces la respuesta "$.id" no debe ser null
Entonces la respuesta "$.user.email" no debe ser null
Entonces la respuesta "$.data.createdAt" no debe ser null
```

### `Entonces la respuesta "{ruta_json}" debe ser un email válido`
Valida que el valor en la ruta JSONPath especificada tenga formato de email válido.

**Ejemplos con JSONPath:**
```gherkin
Entonces la respuesta "$.email" debe ser un email válido
Entonces la respuesta "$.user.email" debe ser un email válido
Entonces la respuesta "$.contact.primaryEmail" debe ser un email válido
```

### `Entonces la respuesta "{ruta_json}" debe ser una URL válida`
Valida que el valor en la ruta JSONPath especificada tenga formato de URL válido.

**Ejemplos con JSONPath:**
```gherkin
Entonces la respuesta "$.website" debe ser una URL válida
Entonces la respuesta "$.user.profileUrl" debe ser una URL válida
Entonces la respuesta "$.data.imageUrl" debe ser una URL válida
```

### `Entonces la respuesta "{ruta_json}" debe ser un UUID válido`
Valida que el valor en la ruta JSONPath especificada tenga formato de UUID válido.

**Ejemplos con JSONPath:**
```gherkin
Entonces la respuesta "$.uuid" debe ser un UUID válido
Entonces la respuesta "$.user.id" debe ser un UUID válido
Entonces la respuesta "$.transaction.referenceId" debe ser un UUID válido
```

---

## Notas Importantes

- **Interpolación de Variables**: Usa la sintaxis `{nombreVariable}` en URLs, headers y cuerpos JSON.
- **Archivos .env**: Los pasos `desde env` cargan automáticamente variables desde archivos .env.
- **JSONPath**: Usa sintaxis JSONPath estándar como `$.campo.subcampo` para navegar estructuras JSON.
- **Tipos de Datos**: El framework maneja automáticamente conversiones entre strings y números cuando es apropiado.
- **Logging Automático**: Cuando está habilitado, guarda automáticamente requests/responses con timestamps y metadata.
- **Archivos**: Soporta carga y guardado de datos JSON desde/hacia archivos externos.
- **Validación de Esquemas**: Permite validar respuestas contra esquemas JSON para verificar estructura.
- **Validación de Tipos**: Incluye validadores para tipos específicos como email, URL, UUID, etc.

---

*Judo Framework v1.3.36 - Documentación completa y verificada*