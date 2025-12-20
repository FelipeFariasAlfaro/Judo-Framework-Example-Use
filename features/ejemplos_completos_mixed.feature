@all @mix
Feature: Demostración Completa de Judo Framework MIX
  Esta característica demuestra todas las capacidades de Judo Framework
  Cada escenario muestra una funcionalidad o tipo de paso específico

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
