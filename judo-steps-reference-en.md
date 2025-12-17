# Complete Steps Reference - Judo Framework (English)

This is the complete reference of all **VERIFIED** steps available in Judo Framework v1.3.40 in English.

**⚠️ IMPORTANT**: This documentation has been verified against the framework source code. It only includes steps that actually exist and work.

**💡 Note**: All steps use the `@step()` decorator, which means they work with any keyword (Given, When, Then, And, But). This provides maximum flexibility in writing your test scenarios.

## 📋 Table of Contents

- [Configuration](#configuration)
- [Authentication](#authentication)
- [HTTP Requests](#http-requests)
- [Response Validation](#response-validation)
- [Data Extraction](#data-extraction)
- [Variables](#variables)
- [Arrays and Collections](#arrays-and-collections)
- [File Operations](#file-operations)
- [Utilities](#utilities)
- [Logging](#logging)

---

## Configuration

### `Given I have a Judo API client`
Initializes the Judo Framework context to begin API testing.

**Examples:**
```gherkin
Given I have a Judo API client
```

### `Given the base URL is "{url}"`
Sets the base URL that will be used for all subsequent HTTP requests.

**Examples:**
```gherkin
Given the base URL is "https://api.example.com"
And the base URL is "https://jsonplaceholder.typicode.com"
```

### `Given I set the base URL to "{base_url}"`
Alternative step for setting the base URL.

### `Given I set the variable "{name}" to "{value}"`
Creates or updates a string variable that can be reused in other steps.

**Examples:**
```gherkin
Given I set the variable "userId" to "123"
And I set the variable "apiVersion" to "v1"
```

### `Given I set the variable "{name}" to {value:d}`
Creates or updates a numeric (integer) variable.

**Examples:**
```gherkin
Given I set the variable "maxRetries" to 3
And I set the variable "timeout" to 5000
```

### `Given I set the variable "{name}" to the JSON`
Stores a complete JSON object in a variable using the step text.

**Examples:**
```gherkin
Given I set the variable "userData" to the JSON
  """
  {
    "name": "John Doe",
    "email": "john@example.com",
    "age": 30
  }
  """
```

### `I get the value "{env_var_name}" from env and store it in "{variable_name}"`
Gets the value from an environment variable (.env) and stores it in a variable for later use. Useful for dynamic configurations like base URLs, tokens, etc.

**Examples:**
```gherkin
Given I get the value "API_TOKEN" from env and store it in "token"
And I get the value "BASE_URL" from env and store it in "baseUrl"
```

---

## Authentication

### `Given I use bearer token "{token}"`
Configures Bearer Token (JWT) authentication for all subsequent requests.

**Examples:**
```gherkin
Given I use bearer token "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
And I use bearer token "{token}"
```

### `Given I use basic authentication with username "{username}" and password "{password}"`
Configures HTTP Basic authentication with username and password.

**Examples:**
```gherkin
Given I use basic authentication with username "admin" and password "secret123"
```

### `Given I set the header "{name}" to "{value}"`
Adds a custom HTTP header to all subsequent requests.

**Examples:**
```gherkin
Given I set the header "Content-Type" to "application/json"
And I set the header "X-API-Version" to "v2"
And I set the header "Accept-Language" to "en-US"
```

### `Given I set the header "{header_name}" from env "{env_var_name}"`
Sets an HTTP header using the value from an environment variable or .env file.

**Examples:**
```gherkin
Given I set the header "Authorization" from env "API_TOKEN"
And I set the header "X-API-Key" from env "API_KEY"
```

### `Given I set the query parameter "{name}" to "{value}"`
Adds a query string parameter to the next HTTP request.

**Examples:**
```gherkin
Given I set the query parameter "page" to "1"
And I set the query parameter "limit" to "10"
And I set the query parameter "sort" to "desc"
```

### `Given I set the query parameter "{name}" to {value:d}`
Adds a numeric query string parameter to the next HTTP request.

---

## HTTP Requests

### `When I send a GET request to "{endpoint}"`
Sends an HTTP GET request to retrieve data from the server.

**Examples:**
```gherkin
When I send a GET request to "/users"
When I send a GET request to "/users/123"
When I send a GET request to "/users/{userId}"
```

### `When I send a POST request to "{endpoint}"`
Sends an HTTP POST request without a data body.

**Examples:**
```gherkin
When I send a POST request to "/users/123/activate"
```

### `When I send a POST request to "{endpoint}" with JSON`
Sends an HTTP POST request with JSON data in the body using the step text.

**Examples:**
```gherkin
When I send a POST request to "/users" with JSON
  """
  {
    "name": "John Doe",
    "email": "john@example.com",
    "age": 30
  }
  """
```

### `When I send a PUT request to "{endpoint}" with JSON`
Sends an HTTP PUT request with JSON data to completely replace a resource.

**Examples:**
```gherkin
When I send a PUT request to "/users/123" with JSON
  """
  {
    "name": "John Doe Updated",
    "email": "john.new@example.com"
  }
  """
```

### `When I send a PATCH request to "{endpoint}" with JSON`
Sends an HTTP PATCH request with JSON data to partially update a resource.

**Examples:**
```gherkin
When I send a PATCH request to "/users/123" with JSON
  """
  {
    "email": "new.email@example.com"
  }
  """
```

### `When I send a DELETE request to "{endpoint}"`
Sends an HTTP DELETE request to remove a resource from the server.

**Examples:**
```gherkin
When I send a DELETE request to "/users/123"
When I send a DELETE request to "/users/{userId}"
```

### `When I send a {method} request to "{endpoint}" with the variable "{var_name}"`
Sends an HTTP request of any method using JSON data stored in a variable.

**Examples:**
```gherkin
Given I set the variable "newUser" to the JSON
  """
  {"name": "John", "email": "john@example.com"}
  """
When I send a POST request to "/users" with the variable "newUser"
```

---

## Response Validation

### `Then the response status should be {status:d}`
Validates that the HTTP response status code matches the expected value.

**Examples:**
```gherkin
Then the response status should be 200
Then the response status should be 201
Then the response status should be 404
```

### `Then the response should be successful`
Validates that the response has a successful status code (2xx).

**Examples:**
```gherkin
When I send a GET request to "/users/1"
Then the response should be successful
```

### `Then the response should contain "{key}"`
Verifies that the JSON response contains a specific field.

**Examples:**
```gherkin
Then the response should contain "id"
And the response should contain "name"
And the response should contain "email"
```

### `Then the response field "{key}" should equal "{value}"`
Validates that a specific field has exactly the expected string value.

**Examples:**
```gherkin
Then the response field "name" should equal "John Doe"
And the response field "status" should equal "active"
And the response field "email" should equal "john@example.com"
```

### `Then the response field "{key}" should equal {value:d}`
Validates that a specific field has exactly the expected numeric value.

**Examples:**
```gherkin
Then the response field "id" should equal 123
And the response field "age" should equal 30
And the response field "count" should equal 10
```

### `Then the response field "{key}" should equal the variable "{variable}"`
Compares a field value with the value stored in a variable.

**Examples:**
```gherkin
Given I set the variable "expectedName" to "John Doe"
When I send a GET request to "/users/1"
Then the response field "name" should equal the variable "expectedName"
```

### `Then the response should match the schema`
Validates the response structure against a JSON schema defined in the step text.

**Examples:**
```gherkin
Then the response should match the schema:
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
```

### `Then the response should be valid JSON`
Verifies that the response is valid and well-formed JSON.

**Examples:**
```gherkin
When I send a GET request to "/users/1"
Then the response should be valid JSON
```

### `Then the response time should be less than {max_time:f} seconds`
Validates that the HTTP request response time is less than the specified limit.

**Examples:**
```gherkin
When I send a GET request to "/users"
Then the response time should be less than 2.0 seconds
```

### `Then the response "{json_path}" should be "{expected_value}"`
Validates the value of a specific JSONPath against an expected value.

**JSONPath Examples:**
```gherkin
Then the response "$.name" should be "John Doe"
Then the response "$.user.email" should be "john@example.com"
Then the response "$.data.address.city" should be "New York"
Then the response "$.items[0].title" should be "First Item"
```

### `Then the response "{json_path}" should be {expected_value:d}`
Validates the numeric value of a specific JSONPath.

**JSONPath Examples:**
```gherkin
Then the response "$.id" should be 123
Then the response "$.user.age" should be 30
Then the response "$.data.count" should be 10
Then the response "$.items[0].price" should be 99
```

### `Then the response "{json_path}" should match "{pattern}"`
Validates a JSONPath expression result against a pattern.

---

## Data Extraction

### `When I extract "{json_path}" from the response as "{variable_name}"`
Extracts a value from the response and stores it in a variable for later use.

**JSONPath Examples:**
```gherkin
When I extract "$.id" from the response as "userId"
When I extract "$.user.email" from the response as "userEmail"
When I extract "$.data.token" from the response as "authToken"
When I extract "$.items[0].id" from the response as "firstItemId"
When I extract "$.address.city" from the response as "city"
```

### `When I store the response as "{variable_name}"`
Stores the entire JSON response in a variable.

---

## Variables

### `Then the variable "{var1}" should equal the variable "{var2}"`
Compares that two variables have exactly the same value.

**Examples:**
```gherkin
Given I set the variable "expected" to "John"
When I extract "$.name" from the response as "actual"
Then the variable "actual" should equal the variable "expected"
```

### `Then the variable "{var1}" should not equal the variable "{var2}"`
Verifies that two variables have different values.

**Examples:**
```gherkin
When I extract "$.id" from the response as "userId1"
When I send a GET request to "/users/2"
When I extract "$.id" from the response as "userId2"
Then the variable "userId1" should not equal the variable "userId2"
```

---

## Arrays and Collections

### `Then the response should be an array`
Validates that the response is a JSON array (list).

**Examples:**
```gherkin
When I send a GET request to "/users"
Then the response should be an array
```

### `Then the response array should have {count:d} items`
Verifies that the response array has exactly the specified number of elements.

**Examples:**
```gherkin
When I send a GET request to "/users"
Then the response should be an array
And the response array should have 10 items
```

### `Then each item in the response array should have "{key}"`
Validates that all elements in the array have a specific field.

**Examples:**
```gherkin
When I send a GET request to "/users"
Then the response should be an array
And each item in the response array should have "id"
And each item in the response array should have "name"
And each item in the response array should have "email"
```

### `Then the response array should contain an item with "{key}" equal to "{value}"`
Searches the response array for an element that has a field with a specific value.

**Examples:**
```gherkin
Then the response array should contain an item with "id" equal to "123"
Then the response array should contain an item with "name" equal to "John"
```

### `Then the response array "{array_path}" should contain an item with "{key}" equal to "{value}"`
Searches in a nested or root-level array for an element with a specific field-value pair.

**JSONPath Examples:**
```gherkin
# Root-level array (when response is directly an array)
Then the response array "users" should contain an item with "id" equal to "123"
Then the response array "users" should contain an item with "name" equal to "John"

# Nested array using dot notation
Then the response array "data.items" should contain an item with "status" equal to "active"
Then the response array "response.users" should contain an item with "email" equal to "john@example.com"
```

---

## File Operations

### `When I POST to "{endpoint}" with JSON file "{file_path}"`
Sends a POST request using JSON data loaded from an external file.

**Examples:**
```gherkin
When I POST to "/users" with JSON file "test_data/new_user.json"
```

### `When I PUT to "{endpoint}" with JSON file "{file_path}"`
Sends a PUT request using JSON data loaded from an external file.

**Examples:**
```gherkin
When I PUT to "/users/123" with JSON file "test_data/updated_user.json"
```

### `When I PATCH to "{endpoint}" with JSON file "{file_path}"`
Sends a PATCH request using JSON data loaded from an external file.

**Examples:**
```gherkin
When I PATCH to "/users/123" with JSON file "test_data/user_patch.json"
```

### `When I {method} to "{endpoint}" with data file "{file_path}"`
Sends a request with data from a file (auto-detects format).

**Examples:**
```gherkin
When I POST to "/users" with data file "test_data/user.json"
When I PUT to "/users/123" with data file "test_data/user.yaml"
```

### `Then the response should match JSON file "{file_path}"`
Validates that the response matches JSON data from an external file.

**Examples:**
```gherkin
When I send a GET request to "/users/1"
Then the response should match JSON file "expected_responses/user_1.json"
```

### `Then the response should match schema file "{file_path}"`
Validates the response against a JSON schema stored in an external file.

**Examples:**
```gherkin
When I send a GET request to "/users/1"
Then the response should match schema file "schemas/user_schema.json"
```

### `When I save the response to file "{file_path}"`
Saves the complete response to a file for later analysis or debugging.

**Examples:**
```gherkin
When I send a GET request to "/users/1"
And I save the response to file "output/user_response.json"
```

### `When I save the variable "{var_name}" to file "{file_path}"`
Saves the content of a variable to an external file.

**Examples:**
```gherkin
When I extract "$.token" from the response as "authToken"
And I save the variable "authToken" to file "output/token.txt"
```

### `When I load test data "{data_name}" from file "{file_path}"`
Loads test data from an external file (JSON, YAML, CSV).

**Examples:**
```gherkin
When I load test data "users" from file "test_data/users.json"
```

### `When I load test data "{data_name}" from JSON`
Loads test data from inline JSON in the step text.

**Examples:**
```gherkin
When I load test data "testUser" from JSON
  """
  {
    "name": "John Doe",
    "email": "john@example.com"
  }
  """
```

### `When I load test data "{data_name}" from YAML`
Loads test data from inline YAML in the step text.

**Examples:**
```gherkin
When I load test data "testUser" from YAML
  """
  name: John Doe
  email: john@example.com
  """
```

---

## Type Validation

### `Then the response "{json_path}" should be a string`
Validates that the value at the specified JSONPath is of type string.

**JSONPath Examples:**
```gherkin
Then the response "$.name" should be a string
Then the response "$.user.email" should be a string
Then the response "$.data.description" should be a string
```

### `Then the response "{json_path}" should be a number`
Validates that the value at the specified JSONPath is of type number.

**JSONPath Examples:**
```gherkin
Then the response "$.id" should be a number
Then the response "$.user.age" should be a number
Then the response "$.data.count" should be a number
Then the response "$.items[0].price" should be a number
```

### `Then the response "{json_path}" should be a boolean`
Validates that the value at the specified JSONPath is of type boolean.

**JSONPath Examples:**
```gherkin
Then the response "$.active" should be a boolean
Then the response "$.user.verified" should be a boolean
Then the response "$.data.isPublic" should be a boolean
```

### `Then the response "{json_path}" should be an array`
Validates that the value at the specified JSONPath is of type array.

**JSONPath Examples:**
```gherkin
Then the response "$.users" should be an array
Then the response "$.data.items" should be an array
Then the response "$.user.roles" should be an array
```

### `Then the response "{json_path}" should be an object`
Validates that the value at the specified JSONPath is of type object.

**JSONPath Examples:**
```gherkin
Then the response "$.user" should be an object
Then the response "$.data.address" should be an object
Then the response "$.metadata" should be an object
```

### `Then the response "{json_path}" should be null`
Validates that the value at the specified JSONPath is null.

**JSONPath Examples:**
```gherkin
Then the response "$.deletedAt" should be null
Then the response "$.user.middleName" should be null
Then the response "$.data.optionalField" should be null
```

### `Then the response "{json_path}" should not be null`
Validates that the value at the specified JSONPath is not null.

**JSONPath Examples:**
```gherkin
Then the response "$.id" should not be null
Then the response "$.user.email" should not be null
Then the response "$.data.createdAt" should not be null
```

### `Then the response "{json_path}" should be a valid email`
Validates that the value at the specified JSONPath has a valid email format.

**JSONPath Examples:**
```gherkin
Then the response "$.email" should be a valid email
Then the response "$.user.email" should be a valid email
Then the response "$.contact.primaryEmail" should be a valid email
```

### `Then the response "{json_path}" should be a valid URL`
Validates that the value at the specified JSONPath has a valid URL format.

**JSONPath Examples:**
```gherkin
Then the response "$.website" should be a valid URL
Then the response "$.user.profileUrl" should be a valid URL
Then the response "$.data.imageUrl" should be a valid URL
```

### `Then the response "{json_path}" should be a valid UUID`
Validates that the value at the specified JSONPath has a valid UUID format.

**JSONPath Examples:**
```gherkin
Then the response "$.uuid" should be a valid UUID
Then the response "$.user.id" should be a valid UUID
Then the response "$.transaction.referenceId" should be a valid UUID
```

---

## Utilities

### `When I wait {seconds:f} seconds`
Pauses test execution for the specified number of seconds.

**Examples:**
```gherkin
When I send a POST request to "/process" with JSON
  """
  {"action": "start"}
  """
And I wait 2 seconds
When I send a GET request to "/process/status"
```

### `When I print the response`
Prints the complete response to the console for debugging purposes.

**Examples:**
```gherkin
When I send a GET request to "/users/1"
And I print the response
```

---

## Logging

### `When I enable request/response logging`
Enables automatic saving of all HTTP interactions to JSON files.

**Examples:**
```gherkin
Given I enable request/response logging
When I send a GET request to "/users/1"
```

### `When I disable request/response logging`
Disables automatic saving of HTTP interactions.

**Examples:**
```gherkin
Given I disable request/response logging
```

### `When I enable request/response logging to directory "{directory}"`
Enables HTTP logging with a custom directory for the files.

**Examples:**
```gherkin
Given I enable request/response logging to directory "api_logs"
```

### `When I set the output directory to "{directory}"`
Configures the directory where request/response logs will be saved.

**Examples:**
```gherkin
Given I set the output directory to "test_output"
```

---

## Advanced Features

### `Then the response should contain`
Validates response contains fields from a table (used with Behave tables).

### `Then the response should match "{json_path}" with "{matcher}"`
Validates a JSONPath with a matcher pattern (supports Karate-style patterns).

---

## Important Notes

- **Variable Interpolation**: Use `{variableName}` syntax in URLs, headers, and JSON bodies.
- **.env Files**: Steps with `from env` automatically load variables from .env files.
- **JSONPath**: Use standard JSONPath syntax like `$.field.subfield` to navigate JSON structures.
- **Data Types**: The framework automatically handles conversions between strings and numbers when appropriate.
- **Automatic Logging**: When enabled, automatically saves requests/responses with timestamps and metadata.
- **Pattern Matching**: Supports Karate-style patterns like `##string`, `##number`, `##email`, etc.
- **File Formats**: Supports JSON, YAML, and CSV files for test data.
- **Verification**: This documentation has been verified against the source code v1.3.36.

---

*Judo Framework v1.3.36 - Documentation verified against source code*