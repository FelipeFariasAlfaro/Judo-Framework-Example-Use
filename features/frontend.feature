Feature: Playwright Frontend Testing

  @test-front @mix
  Scenario: Navegacion en pantalla completa y consulta de API
    Given go to url "https://www.centyc.cl"
    Given I have a Judo API client
    And the base URL is "https://jsonplaceholder.typicode.com"
    When I send a GET request to "/users/1"
    Then the response status should be 200