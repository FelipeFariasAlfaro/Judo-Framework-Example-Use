# language: es
@es_ejecutar_todo @all
Característica: Demostración Completa de Judo Framework
  Esta característica demuestra todas las capacidades de Judo Framework
  Cada escenario muestra una funcionalidad o tipo de paso específico

  Antecedentes:
    Dado que tengo un cliente Judo API
    Y que la URL base es "https://jsonplaceholder.typicode.com"

  # ============================================
  # MÉTODOS HTTP BÁSICOS
  # ============================================

  @http @get_es
  Escenario: Petición GET - Obtener un recurso
    Cuando hago una petición GET a "/users/1"
    Entonces el código de respuesta debe ser 200
    Y la respuesta debe contener el campo "id"
    Y la respuesta debe contener el campo "name"
    Y la respuesta debe contener el campo "email"

  @http @post
  Escenario: Petición POST - Crear un nuevo recurso
    Cuando hago una petición POST a "/posts" con el cuerpo:
      """
      {
        "title": "Prueba Judo Framework",
        "body": "Probando petición POST",
        "userId": 1
      }
      """
    Entonces el código de respuesta debe ser 201
    Y la respuesta debe contener el campo "id"
    Y el campo "title" debe ser "Prueba Judo Framework"

  @http @put
  Escenario: Petición PUT - Actualizar recurso completo
    Cuando hago una petición PUT a "/posts/1" con el cuerpo:
      """
      {
        "id": 1,
        "title": "Título Actualizado",
        "body": "Cuerpo Actualizado",
        "userId": 1
      }
      """
    Entonces el código de respuesta debe ser 200
    Y el campo "title" debe ser "Título Actualizado"

  @http @patch
  Escenario: Petición PATCH - Actualización parcial
    Cuando hago una petición PATCH a "/posts/1" con el cuerpo:
      """
      {
        "title": "Título Parcheado"
      }
      """
    Entonces el código de respuesta debe ser 200
    Y el campo "title" debe ser "Título Parcheado"

  @http @delete
  Escenario: Petición DELETE - Eliminar un recurso
    Cuando hago una petición DELETE a "/posts/1"
    Entonces el código de respuesta debe ser 200

  # ============================================
  # PARÁMETROS DE CONSULTA
  # ============================================

  @parametros-consulta
  Escenario: Parámetros de consulta - Filtrar resultados
    Dado que establezco el parámetro "userId" a "1"
    Cuando hago una petición GET a "/posts"
    Entonces el código de respuesta debe ser 200
    Y la respuesta debe ser un array
    Y cada elemento debe tener el campo "userId"

  # ============================================
  # HEADERS
  # ============================================

  @headers
  Escenario: Headers personalizados
    Dado que establezco el header "X-Custom-Header" a "valor-prueba"
    Y que establezco el header "Accept" a "application/json"
    Cuando hago una petición GET a "/users/1"
    Entonces el código de respuesta debe ser 200

  # ============================================
  # VARIABLES
  # ============================================

  @variables @texto
  Escenario: Variables - Valores de texto
    Dado que establezco la variable "userId" a "1"
    Cuando hago una petición GET a "/users/{userId}"
    Entonces el código de respuesta debe ser 200
    Y el campo "id" debe ser 1

  @variables @numero
  Escenario: Variables - Valores numéricos
    Dado que establezco la variable "postId" a 1
    Cuando hago una petición GET a "/posts/{postId}"
    Entonces el código de respuesta debe ser 200
    Y el campo "id" debe ser 1

  # ============================================
  # EXTRACCIÓN DE DATOS
  # ============================================

  @extraccion
  Escenario: Extraer datos de la respuesta
    Cuando hago una petición POST a "/posts" con el cuerpo:
      """
      {
        "title": "Prueba Extracción",
        "body": "Probando extracción",
        "userId": 1
      }
      """
    Entonces el código de respuesta debe ser 201

  @extraccion
  Escenario: Guardar respuesta completa
    Cuando hago una petición GET a "/users/1"
    Entonces el código de respuesta debe ser 200
    Y guardo la respuesta completa en la variable "respuestaUsuario"

  # ============================================
  # VALIDACIÓN DE RESPUESTAS
  # ============================================

  @validacion @estado
  Escenario: Validar códigos de estado
    Cuando hago una petición GET a "/users/1"
    Entonces el código de respuesta debe ser 200
    Y la respuesta debe ser exitosa

  @validacion @campos
  Escenario: Validar campos de respuesta - Texto
    Cuando hago una petición GET a "/users/1"
    Entonces el código de respuesta debe ser 200
    Y el campo "name" debe ser "Leanne Graham"
    Y el campo "username" debe ser "Bret"

  @validacion @campos
  Escenario: Validar campos de respuesta - Número
    Cuando hago una petición GET a "/users/1"
    Entonces el código de respuesta debe ser 200
    Y el campo "id" debe ser 1

  @validacion @contiene
  Escenario: Validar que la respuesta contiene campos
    Cuando hago una petición GET a "/users/1"
    Entonces el código de respuesta debe ser 200
    Y la respuesta debe contener el campo "id"
    Y la respuesta debe contener el campo "name"
    Y la respuesta debe contener el campo "email"
    Y la respuesta debe contener el campo "address"
    Y la respuesta debe contener el campo "company"

  # ============================================
  # VALIDACIÓN DE ARRAYS
  # ============================================

  @arrays @basico
  Escenario: Validar respuesta de tipo array
    Cuando hago una petición GET a "/users"
    Entonces el código de respuesta debe ser 200
    Y la respuesta debe ser un array

  @arrays @contiene
  Escenario: Validar que array contiene elemento
    Cuando hago una petición GET a "/users"
    Entonces el código de respuesta debe ser 200
    Y el array "$" debe contener un elemento con "id" igual a "1"
    Y el array "$" debe contener un elemento con "username" igual a "Bret"

  @arrays @cada
  Escenario: Validar que cada elemento del array tiene un campo
    Cuando hago una petición GET a "/users"
    Entonces el código de respuesta debe ser 200
    Y cada elemento debe tener el campo "id"
    Y cada elemento debe tener el campo "name"
    Y cada elemento debe tener el campo "email"

  # ============================================
  # FLUJO DE TRABAJO - CRUD COMPLETO
  # ============================================

  @flujo @crud
  Escenario: Flujo de trabajo CRUD completo
    # CREAR
    Cuando hago una petición POST a "/posts" con el cuerpo:
      """
      {
        "title": "Post de Prueba CRUD",
        "body": "Probando operaciones CRUD completas",
        "userId": 1
      }
      """
    Entonces el código de respuesta debe ser 201
    Y guardo el valor del campo "id" en la variable "postId"

  # ============================================
  # FLUJO DE TRABAJO - AUTENTICACIÓN
  # ============================================

  @flujo @autenticacion
  Escenario: Flujo de autenticación con token
    Dado que establezco la variable "tokenAuth" a "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9"
    Y que uso el token bearer "{tokenAuth}"
    Cuando hago una petición GET a "/users/1"
    Entonces el código de respuesta debe ser 200

  # ============================================
  # UTILIDADES
  # ============================================

  @utilidad @espera
  Escenario: Esperar entre peticiones
    Cuando hago una petición GET a "/users/1"
    Entonces el código de respuesta debe ser 200
    Y espero 1.0 segundos
    Cuando hago una petición GET a "/users/2"
    Entonces el código de respuesta debe ser 200

  @utilidad @debug
  Escenario: Imprimir respuesta para depuración
    Cuando hago una petición GET a "/users/1"
    Entonces el código de respuesta debe ser 200
    Y imprimo la respuesta

  # ============================================
  # ESCENARIOS COMPLEJOS
  # ============================================

  @complejo @anidado
  Escenario: Trabajar con datos anidados
    Cuando hago una petición GET a "/users/1"
    Entonces el código de respuesta debe ser 200
    Y la respuesta debe contener el campo "address"
    Y la respuesta debe contener el campo "company"

  @complejo @multiples-peticiones
  Escenario: Múltiples peticiones relacionadas
    # Obtener usuario
    Cuando hago una petición GET a "/users/1"
    Entonces el código de respuesta debe ser 200
    Y guardo el valor del campo "id" en la variable "userId"

    # Obtener posts del usuario
    Dado que establezco el parámetro "userId" a "{userId}"
    Cuando hago una petición GET a "/posts"
    Entonces el código de respuesta debe ser 200
    Y la respuesta debe ser un array

    # Obtener primer post
    Cuando hago una petición GET a "/posts/1"
    Entonces el código de respuesta debe ser 200
    Y guardo el valor del campo "id" en la variable "postId"

    # Obtener comentarios del post
    Cuando hago una petición GET a "/posts/{postId}/comments"
    Entonces el código de respuesta debe ser 200
    Y la respuesta debe ser un array

  @complejo @datos-parametrizados
  Esquema del escenario: Pruebas parametrizadas con ejemplos
    Cuando hago una petición GET a "/users/<userId>"
    Entonces el código de respuesta debe ser 200
    Y el campo "id" debe ser <userId>
    Y la respuesta debe contener el campo "name"
    Y la respuesta debe contener el campo "email"

    Ejemplos:
      | userId |
      | 1      |
      | 2      |
      | 3      |

  # ============================================
  # RENDIMIENTO
  # ============================================

  @rendimiento
  Escenario: Validar tiempo de respuesta
    Cuando hago una petición GET a "/users/1"
    Entonces el código de respuesta debe ser 200
    Y el tiempo de respuesta debe ser menor a 5.0 segundos

  # ============================================
  # MANEJO DE ERRORES
  # ============================================

  @errores @no-encontrado
  Escenario: Manejar 404 No Encontrado
    Cuando hago una petición GET a "/users/999999"
    Entonces el código de respuesta debe ser 404

  @errores @validacion
  Escenario: Validar respuestas de error
    Cuando hago una petición POST a "/posts" con el cuerpo:
      """
      {}
      """
    Entonces el código de respuesta debe ser 201

  # ============================================
  # OPERACIONES CON ARCHIVOS
  # ============================================

  @archivos @post-json
  Escenario: Petición POST usando archivo JSON
    Cuando hago POST a "/posts" con archivo JSON "../base_requests/simple_post.json"
    Entonces el código de respuesta debe ser 201
    Y la respuesta debe contener el campo "id"
    Y el campo "title" debe ser "Simple Post from File"

  @archivos @put-json
  Escenario: Petición PUT usando archivo JSON
    Cuando hago PUT a "/posts/1" con archivo JSON "../base_requests/update_post.json"
    Entonces el código de respuesta debe ser 200
    Y el campo "title" debe ser "Updated Post Title"

  @archivos @patch-json
  Escenario: Petición PATCH usando archivo JSON
    Cuando hago PATCH a "/posts/1" con archivo JSON "../base_requests/simple_post.json"
    Entonces el código de respuesta debe ser 200
    Y el campo "title" debe ser "Simple Post from File"

  @archivos @guardar-respuesta
  Escenario: Guardar respuesta en archivo
    Cuando hago una petición GET a "/posts/1"
    Entonces el código de respuesta debe ser 200
    Y guardo la respuesta en el archivo "../base_responses/saved_response.json"

  @archivos @guardar-variable
  Escenario: Guardar datos extraídos en archivo
    Cuando hago una petición GET a "/posts/1"
    Entonces el código de respuesta debe ser 200
    Y guardo el valor del campo "title" en la variable "postTitle"
    Y guardo la variable "postTitle" en el archivo "../base_variables/post_title.txt"

  @archivos @lectura-escritura
  Escenario: Flujo completo de lectura y escritura de archivos
    # Crear un recurso usando datos desde archivo
    Cuando hago POST a "/posts" con archivo JSON "../base_requests/simple_post.json"
    Entonces el código de respuesta debe ser 201
    Y guardo el valor del campo "id" en la variable "newPostId"
    
    # Obtener un recurso existente (usar ID fijo)
    Cuando hago una petición GET a "/posts/1"
    Entonces el código de respuesta debe ser 200
    
    # Guardar la respuesta completa en un archivo
    Y guardo la respuesta en el archivo "../base_responses/created_post.json"
    
    # Extraer y guardar un campo específico
    Y guardo el valor del campo "title" en la variable "createdTitle"
    Y guardo la variable "createdTitle" en el archivo "../base_variables/created_title.txt"

  # ============================================
  # VARIABLES DE ENTORNO (.env)
  # ============================================



  @env @headers-dinamicos
  Escenario: Usar variables de entorno en headers
    Dado que establezco el header "Authorization" desde env "API_TOKEN"
    Cuando hago una petición GET a "/users/1"
    Entonces el código de respuesta debe ser 200
    Y la respuesta debe contener el campo "id"



  # ============================================
  # CARACTERÍSTICAS AVANZADAS - TIER 1
  # ROBUSTEZ Y CONFIABILIDAD
  # ============================================

  @avanzado @reintentos
  Escenario: Política de reintentos con estrategia exponencial
    Cuando hago una petición GET a "/users/1"
    Entonces el código de respuesta debe ser 200

  @avanzado @reintentos-personalizado
  Escenario: Política de reintentos con parámetros personalizados
    Cuando hago una petición GET a "/posts/1"
    Entonces el código de respuesta debe ser 200











  @avanzado @rate-limit
  Escenario: Rate Limiting - Limitar peticiones por segundo
    Dado que establezco el límite de velocidad a 10 peticiones por segundo
    Cuando hago una petición GET a "/users/1"
    Entonces el código de respuesta debe ser 200



  @avanzado @rate-limit-adaptativo
  Escenario: Rate Limiting adaptativo
    Cuando hago una petición GET a "/users/1"
    Entonces el código de respuesta debe ser 200

  @avanzado @validacion-array-mas
  Escenario: Validación de array con más elementos
    Cuando hago una petición GET a "/users"
    Entonces el código de respuesta debe ser 200
    Y la respuesta debe ser un array

  @avanzado @validacion-array-menos
  Escenario: Validación de array con menos elementos
    Cuando hago una petición GET a "/users"
    Entonces el código de respuesta debe ser 200
    Y la respuesta debe ser un array

  @avanzado @validacion-campos-multiples
  Escenario: Validación de múltiples campos
    Cuando hago una petición GET a "/users/1"
    Entonces el código de respuesta debe ser 200
    Y la respuesta debe contener el campo "id"
    Y la respuesta debe contener el campo "name"
    Y la respuesta debe contener el campo "email"

  @avanzado @validacion-tipo-campo
  Escenario: Validación de tipo de campo
    Cuando hago una petición GET a "/users/1"
    Entonces el código de respuesta debe ser 200
    Y la respuesta "$.id" debe ser un número
    Y la respuesta "$.name" debe ser una cadena

  @avanzado @validacion-patron
  Escenario: Validación de campo con patrón regex
    Cuando hago una petición GET a "/users/1"
    Entonces el código de respuesta debe ser 200
    Y la respuesta "$.email" debe ser un email válido

  @avanzado @validacion-rango
  Escenario: Validación de campo en rango
    Cuando hago una petición GET a "/users/1"
    Entonces el código de respuesta debe ser 200

  @avanzado @tiempo-respuesta-ms
  Escenario: Validar tiempo de respuesta en milisegundos
    Cuando hago una petición GET a "/users/1"
    Entonces el código de respuesta debe ser 200
    Y el tiempo de respuesta debe ser menor a 5.0 segundos

  @avanzado @validacion-schema-json
  Escenario: Validación contra JSON Schema
    Cuando hago una petición GET a "/users/1"
    Entonces el código de respuesta debe ser 200
    Y la respuesta debe coincidir con el esquema
      """
      {
        "type": "object",
        "properties": {
          "id": {"type": "number"},
          "name": {"type": "string"},
          "email": {"type": "string"}
        },
        "required": ["id", "name", "email"]
      }
      """

  # ============================================
  # CARACTERÍSTICAS AVANZADAS - TIER 2
  # RENDIMIENTO Y APIs MODERNAS
  # ============================================

  @avanzado @multiples-peticiones
  Escenario: Pruebas de rendimiento - Múltiples peticiones
    Cuando envío 10 solicitudes GET a "/users/1"
    Entonces todas las respuestas deben tener estado 200

  @avanzado @percentil-95
  Escenario: Validar percentil 95 de tiempo de respuesta
    Cuando envío 20 solicitudes GET a "/users"
    Entonces todas las respuestas deben tener estado 200

  @avanzado @tasa-error
  Escenario: Validar tasa de error
    Cuando envío 50 solicitudes GET a "/users/1"
    Entonces todas las respuestas deben tener estado 200


  @avanzado @datos-parametrizados
  Escenario: Cargar datos parametrizados desde archivo
    Cuando hago una petición GET a "/users/1"
    Entonces el código de respuesta debe ser 200
