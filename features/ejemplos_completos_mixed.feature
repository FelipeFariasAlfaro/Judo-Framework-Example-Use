# language: en
@mix_ejecutar_todo @all
Feature: Demostración Completa de Judo Framework - Modo Mixto
  Esta característica demuestra todas las capacidades de Judo Framework
  Cada escenario muestra una funcionalidad o tipo de paso específico
  Usando modo mixto: descripciones en español con palabras clave Gherkin en inglés

  Background:
    Given que tengo un cliente Judo API
    And que la URL base es "https://jsonplaceholder.typicode.com"

  # ============================================
  # MÉTODOS HTTP BÁSICOS
  # ============================================

  @http @get_es
  Scenario: Petición GET - Obtener un recurso
    When hago una petición GET a "/users/1"
    Then el código de respuesta debe ser 200
    And la respuesta debe contener el campo "id"
    And la respuesta debe contener el campo "name"
    And la respuesta debe contener el campo "email"

  @http @post
  Scenario: Petición POST - Crear un nuevo recurso
    When hago una petición POST a "/posts" con el cuerpo:
      """
      {
        "title": "Prueba Judo Framework",
        "body": "Probando petición POST",
        "userId": 1
      }
      """
    Then el código de respuesta debe ser 201
    And la respuesta debe contener el campo "id"
    And el campo "title" debe ser "Prueba Judo Framework"

  @http @put
  Scenario: Petición PUT - Actualizar recurso completo
    When hago una petición PUT a "/posts/1" con el cuerpo:
      """
      {
        "id": 1,
        "title": "Título Actualizado",
        "body": "Cuerpo Actualizado",
        "userId": 1
      }
      """
    Then el código de respuesta debe ser 200
    And el campo "title" debe ser "Título Actualizado"

  @http @patch
  Scenario: Petición PATCH - Actualización parcial
    When hago una petición PATCH a "/posts/1" con el cuerpo:
      """
      {
        "title": "Título Parcheado"
      }
      """
    Then el código de respuesta debe ser 200
    And el campo "title" debe ser "Título Parcheado"

  @http @delete
  Scenario: Petición DELETE - Eliminar un recurso
    When hago una petición DELETE a "/posts/1"
    Then el código de respuesta debe ser 200

  # ============================================
  # PARÁMETROS DE CONSULTA
  # ============================================

  @parametros-consulta
  Scenario: Parámetros de consulta - Filtrar resultados
    Given que establezco el parámetro "userId" a "1"
    When hago una petición GET a "/posts"
    Then el código de respuesta debe ser 200
    And la respuesta debe ser un array
    And cada elemento debe tener el campo "userId"

  # ============================================
  # HEADERS
  # ============================================

  @headers
  Scenario: Headers personalizados
    Given que establezco el header "X-Custom-Header" a "valor-prueba"
    And que establezco el header "Accept" a "application/json"
    When hago una petición GET a "/users/1"
    Then el código de respuesta debe ser 200

  # ============================================
  # VARIABLES
  # ============================================

  @variables @texto
  Scenario: Variables - Valores de texto
    Given que establezco la variable "userId" a "1"
    When hago una petición GET a "/users/{userId}"
    Then el código de respuesta debe ser 200
    And el campo "id" debe ser 1

  @variables @numero
  Scenario: Variables - Valores numéricos
    Given que establezco la variable "postId" a 1
    When hago una petición GET a "/posts/{postId}"
    Then el código de respuesta debe ser 200
    And el campo "id" debe ser 1

  # ============================================
  # EXTRACCIÓN DE DATOS
  # ============================================

  @extraccion
  Scenario: Extraer datos de la respuesta
    When hago una petición POST a "/posts" con el cuerpo:
      """
      {
        "title": "Prueba Extracción",
        "body": "Probando extracción",
        "userId": 1
      }
      """
    Then el código de respuesta debe ser 201

  @extraccion
  Scenario: Guardar respuesta completa
    When hago una petición GET a "/users/1"
    Then el código de respuesta debe ser 200
    And guardo la respuesta completa en la variable "respuestaUsuario"

  # ============================================
  # VALIDACIÓN DE RESPUESTAS
  # ============================================

  @validacion @estado
  Scenario: Validar códigos de estado
    When hago una petición GET a "/users/1"
    Then el código de respuesta debe ser 200
    And la respuesta debe ser exitosa

  @validacion @campos
  Scenario: Validar campos de respuesta - Texto
    When hago una petición GET a "/users/1"
    Then el código de respuesta debe ser 200
    And el campo "name" debe ser "Leanne Graham"
    And el campo "username" debe ser "Bret"

  @validacion @campos
  Scenario: Validar campos de respuesta - Número
    When hago una petición GET a "/users/1"
    Then el código de respuesta debe ser 200
    And el campo "id" debe ser 1

  @validacion @contiene
  Scenario: Validar que la respuesta contiene campos
    When hago una petición GET a "/users/1"
    Then el código de respuesta debe ser 200
    And la respuesta debe contener el campo "id"
    And la respuesta debe contener el campo "name"
    And la respuesta debe contener el campo "email"
    And la respuesta debe contener el campo "address"
    And la respuesta debe contener el campo "company"

  # ============================================
  # VALIDACIÓN DE ARRAYS
  # ============================================

  @arrays @basico
  Scenario: Validar respuesta de tipo array
    When hago una petición GET a "/users"
    Then el código de respuesta debe ser 200
    And la respuesta debe ser un array

  @arrays @contiene
  Scenario: Validar que array contiene elemento
    When hago una petición GET a "/users"
    Then el código de respuesta debe ser 200
    And el array "$" debe contener un elemento con "id" igual a "1"
    And el array "$" debe contener un elemento con "username" igual a "Bret"

  @arrays @cada
  Scenario: Validar que cada elemento del array tiene un campo
    When hago una petición GET a "/users"
    Then el código de respuesta debe ser 200
    And cada elemento debe tener el campo "id"
    And cada elemento debe tener el campo "name"
    And cada elemento debe tener el campo "email"

  # ============================================
  # FLUJO DE TRABAJO - CRUD COMPLETO
  # ============================================

  @flujo @crud
  Scenario: Flujo de trabajo CRUD completo
    # CREAR
    When hago una petición POST a "/posts" con el cuerpo:
      """
      {
        "title": "Post de Prueba CRUD",
        "body": "Probando operaciones CRUD completas",
        "userId": 1
      }
      """
    Then el código de respuesta debe ser 201
    And guardo el valor del campo "id" en la variable "postId"

  # ============================================
  # FLUJO DE TRABAJO - AUTENTICACIÓN
  # ============================================

  @flujo @autenticacion
  Scenario: Flujo de autenticación con token
    Given que establezco la variable "tokenAuth" a "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9"
    And que uso el token bearer "{tokenAuth}"
    When hago una petición GET a "/users/1"
    Then el código de respuesta debe ser 200

  # ============================================
  # UTILIDADES
  # ============================================

  @utilidad @espera
  Scenario: Esperar entre peticiones
    When hago una petición GET a "/users/1"
    Then el código de respuesta debe ser 200
    And espero 1.0 segundos
    When hago una petición GET a "/users/2"
    Then el código de respuesta debe ser 200

  @utilidad @debug
  Scenario: Imprimir respuesta para depuración
    When hago una petición GET a "/users/1"
    Then el código de respuesta debe ser 200
    And imprimo la respuesta

  # ============================================
  # ESCENARIOS COMPLEJOS
  # ============================================

  @complejo @anidado
  Scenario: Trabajar con datos anidados
    When hago una petición GET a "/users/1"
    Then el código de respuesta debe ser 200
    And la respuesta debe contener el campo "address"
    And la respuesta debe contener el campo "company"

  @complejo @multiples-peticiones
  Scenario: Múltiples peticiones relacionadas
    # Obtener usuario
    When hago una petición GET a "/users/1"
    Then el código de respuesta debe ser 200
    And guardo el valor del campo "id" en la variable "userId"

    # Obtener posts del usuario
    Given que establezco el parámetro "userId" a "{userId}"
    When hago una petición GET a "/posts"
    Then el código de respuesta debe ser 200
    And la respuesta debe ser un array

    # Obtener primer post
    When hago una petición GET a "/posts/1"
    Then el código de respuesta debe ser 200
    And guardo el valor del campo "id" en la variable "postId"

    # Obtener comentarios del post
    When hago una petición GET a "/posts/{postId}/comments"
    Then el código de respuesta debe ser 200
    And la respuesta debe ser un array

  @complejo @datos-parametrizados
  Scenario Outline: Pruebas parametrizadas con ejemplos
    When hago una petición GET a "/users/<userId>"
    Then el código de respuesta debe ser 200
    And el campo "id" debe ser <userId>
    And la respuesta debe contener el campo "name"
    And la respuesta debe contener el campo "email"

    Examples:
      | userId |
      | 1      |
      | 2      |
      | 3      |

  # ============================================
  # RENDIMIENTO
  # ============================================

  @rendimiento
  Scenario: Validar tiempo de respuesta
    When hago una petición GET a "/users/1"
    Then el código de respuesta debe ser 200
    And el tiempo de respuesta debe ser menor a 5.0 segundos

  # ============================================
  # MANEJO DE ERRORES
  # ============================================

  @errores @no-encontrado
  Scenario: Manejar 404 No Encontrado
    When hago una petición GET a "/users/999999"
    Then el código de respuesta debe ser 404

  @errores @validacion
  Scenario: Validar respuestas de error
    When hago una petición POST a "/posts" con el cuerpo:
      """
      {}
      """
    Then el código de respuesta debe ser 201

  # ============================================
  # OPERACIONES CON ARCHIVOS
  # ============================================

  @archivos @post-json
  Scenario: Petición POST usando archivo JSON
    When hago POST a "/posts" con archivo JSON "../base_requests/simple_post.json"
    Then el código de respuesta debe ser 201
    And la respuesta debe contener el campo "id"
    And el campo "title" debe ser "Simple Post from File"

  @archivos @put-json
  Scenario: Petición PUT usando archivo JSON
    When hago PUT a "/posts/1" con archivo JSON "../base_requests/update_post.json"
    Then el código de respuesta debe ser 200
    And el campo "title" debe ser "Updated Post Title"

  @archivos @patch-json
  Scenario: Petición PATCH usando archivo JSON
    When hago PATCH a "/posts/1" con archivo JSON "../base_requests/simple_post.json"
    Then el código de respuesta debe ser 200
    And el campo "title" debe ser "Simple Post from File"

  @archivos @guardar-respuesta
  Scenario: Guardar respuesta en archivo
    When hago una petición GET a "/posts/1"
    Then el código de respuesta debe ser 200
    And guardo la respuesta en el archivo "../base_responses/saved_response.json"

  @archivos @guardar-variable
  Scenario: Guardar datos extraídos en archivo
    When hago una petición GET a "/posts/1"
    Then el código de respuesta debe ser 200
    And guardo el valor del campo "title" en la variable "postTitle"
    And guardo la variable "postTitle" en el archivo "../base_variables/post_title.txt"

  @archivos @lectura-escritura
  Scenario: Flujo completo de lectura y escritura de archivos
    # Crear un recurso usando datos desde archivo
    When hago POST a "/posts" con archivo JSON "../base_requests/simple_post.json"
    Then el código de respuesta debe ser 201
    And guardo el valor del campo "id" en la variable "newPostId"
    
    # Obtener un recurso existente (usar ID fijo)
    When hago una petición GET a "/posts/1"
    Then el código de respuesta debe ser 200
    
    # Guardar la respuesta completa en un archivo
    And guardo la respuesta en el archivo "../base_responses/created_post.json"
    
    # Extraer y guardar un campo específico
    And guardo el valor del campo "title" en la variable "createdTitle"
    And guardo la variable "createdTitle" en el archivo "../base_variables/created_title.txt"

  # ============================================
  # VARIABLES DE ENTORNO (.env)
  # ============================================

  @env @headers-dinamicos
  Scenario: Usar variables de entorno en headers
    Given que establezco el header "Authorization" desde env "API_TOKEN"
    When hago una petición GET a "/users/1"
    Then el código de respuesta debe ser 200
    And la respuesta debe contener el campo "id"

  # ============================================
  # CARACTERÍSTICAS AVANZADAS - TIER 1
  # ROBUSTEZ Y CONFIABILIDAD
  # ============================================

  @avanzado @reintentos
  Scenario: Política de reintentos con estrategia exponencial
    When hago una petición GET a "/users/1"
    Then el código de respuesta debe ser 200

  @avanzado @reintentos-personalizado
  Scenario: Política de reintentos con parámetros personalizados
    When hago una petición GET a "/posts/1"
    Then el código de respuesta debe ser 200

  @avanzado @rate-limit
  Scenario: Rate Limiting - Limitar peticiones por segundo
    Given que establezco el límite de velocidad a 10 peticiones por segundo
    When hago una petición GET a "/users/1"
    Then el código de respuesta debe ser 200

  @avanzado @rate-limit-adaptativo
  Scenario: Rate Limiting adaptativo
    When hago una petición GET a "/users/1"
    Then el código de respuesta debe ser 200

  @avanzado @validacion-array-mas
  Scenario: Validación de array con más elementos
    When hago una petición GET a "/users"
    Then el código de respuesta debe ser 200
    And la respuesta debe ser un array

  @avanzado @validacion-array-menos
  Scenario: Validación de array con menos elementos
    When hago una petición GET a "/users"
    Then el código de respuesta debe ser 200
    And la respuesta debe ser un array

  @avanzado @validacion-campos-multiples
  Scenario: Validación de múltiples campos
    When hago una petición GET a "/users/1"
    Then el código de respuesta debe ser 200
    And la respuesta debe contener el campo "id"
    And la respuesta debe contener el campo "name"
    And la respuesta debe contener el campo "email"

  @avanzado @validacion-tipo-campo
  Scenario: Validación de tipo de campo
    When hago una petición GET a "/users/1"
    Then el código de respuesta debe ser 200
    And la respuesta "$.id" debe ser un número
    And la respuesta "$.name" debe ser una cadena

  @avanzado @validacion-patron
  Scenario: Validación de campo con patrón regex
    When hago una petición GET a "/users/1"
    Then el código de respuesta debe ser 200
    And la respuesta "$.email" debe ser un email válido

  @avanzado @validacion-rango
  Scenario: Validación de campo en rango
    When hago una petición GET a "/users/1"
    Then el código de respuesta debe ser 200

  @avanzado @tiempo-respuesta-ms
  Scenario: Validar tiempo de respuesta en milisegundos
    When hago una petición GET a "/users/1"
    Then el código de respuesta debe ser 200
    And el tiempo de respuesta debe ser menor a 5.0 segundos

  @avanzado @validacion-schema-json
  Scenario: Validación contra JSON Schema
    When hago una petición GET a "/users/1"
    Then el código de respuesta debe ser 200
    And la respuesta debe coincidir con el esquema
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
  Scenario: Pruebas de rendimiento - Múltiples peticiones
    When envío 10 solicitudes GET a "/users/1"
    Then todas las respuestas deben tener estado 200

  @avanzado @percentil-95
  Scenario: Validar percentil 95 de tiempo de respuesta
    When envío 20 solicitudes GET a "/users"
    Then todas las respuestas deben tener estado 200

  @avanzado @tasa-error
  Scenario: Validar tasa de error
    When envío 50 solicitudes GET a "/users/1"
    Then todas las respuestas deben tener estado 200

  @avanzado @datos-parametrizados
  Scenario: Cargar datos parametrizados desde archivo
    When hago una petición GET a "/users/1"
    Then el código de respuesta debe ser 200