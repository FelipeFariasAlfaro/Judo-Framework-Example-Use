# language: en
@eng_examples_all @all
Feature: Judo Framework Complete Showcase
  This feature demonstrates all capabilities of Judo Framework
  Each scenario showcases a specific feature or step type

  Background:
    Given I have a Judo API client
    And the base URL is "https://jsonplaceholder.typicode.com"

  # ============================================
  # BASIC HTTP METHODS
  # ============================================

  @http @get_en
  Scenario: GET request - Retrieve a resource
    Given I have a Judo API client
    And the base URL is "https://jsonplaceholder.typicode.com"
    When I send a GET request to "/users/1"
    Then the response status should be 200
    And the response should contain "id"
    And the response should contain "name"
    And the response should contain "email"

  @http @post
  Scenario: POST request - Create a new resource
    # POST is used to CREATE new resources on the server
    # Send data in JSON format in the request body
    # Status 201 means "Created" - resource was successfully created
    # The response usually includes the new resource with its generated ID
    When I send a POST request to "/posts" with JSON
      """
      {
        "title": "Judo Framework Test",
        "body": "Testing POST request",
        "userId": 1
      }
      """
    Then the response status should be 201
    And the response should contain "id"
    And the response field "title" should equal "Judo Framework Test"

  @http @put
  Scenario: PUT request - Update entire resource
    # PUT is used to REPLACE/UPDATE an entire resource
    # You must send ALL fields, even if only changing one
    # Missing fields may be set to null or default values
    # Status 200 means the update was successful
    When I send a PUT request to "/posts/1" with JSON
      """
      {
        "id": 1,
        "title": "Updated Title",
        "body": "Updated Body",
        "userId": 1
      }
      """
    Then the response status should be 200
    And the response field "title" should equal "Updated Title"

  @http @patch
  Scenario: PATCH request - Partial update
    # PATCH is used for PARTIAL updates
    # Only send the fields you want to change
    # Other fields remain unchanged
    # More efficient than PUT when updating few fields
    When I send a PATCH request to "/posts/1" with JSON
      """
      {
        "title": "Patched Title"
      }
      """
    Then the response status should be 200
    And the response field "title" should equal "Patched Title"

  @http @delete
  Scenario: DELETE request - Remove a resource
    # DELETE is used to remove/delete a resource
    # Usually returns 200 (OK) or 204 (No Content)
    # After deletion, GET requests to the same resource should return 404
    When I send a DELETE request to "/posts/1"
    Then the response status should be 200

  # ============================================
  # QUERY PARAMETERS
  # ============================================

  @query-params
  Scenario: Query parameters - Filter results with string value
    # This filters posts to only show posts from userId=1
    # URL will be: /posts?userId=1
    Given I set the query parameter "userId" to "1"
    When I send a GET request to "/posts"
    Then the response status should be 200
    And the response should be an array
    And each item in the response array should have "userId"

  @query-params
  Scenario: Query parameters - Limit results with numeric value
    # This limits the response to only 5 items
    # URL will be: /posts?_limit=5
    Given I set the query parameter "_limit" to 5
    When I send a GET request to "/posts"
    Then the response status should be 200
    And the response array should have 5 items

  @query-params
  Scenario: Query parameters - Multiple parameters combined
    # Combine multiple query parameters
    # URL will be: /posts?userId=1&_limit=3
    Given I set the query parameter "userId" to 1
    And I set the query parameter "_limit" to 3
    When I send a GET request to "/posts"
    Then the response status should be 200
    And the response should be an array
    And the response array should have 3 items

  # ============================================
  # HEADERS
  # ============================================

  @headers
  Scenario: Custom headers
    # Headers provide metadata about the request
    # Common uses: authentication, content type, API versioning, tracking
    # X-Custom-Header: custom application-specific header
    # Accept: tells server what format you want in response
    Given I set the header "X-Custom-Header" to "test-value"
    And I set the header "Accept" to "application/json"
    When I send a GET request to "/users/1"
    Then the response status should be 200

  # ============================================
  # VARIABLES
  # ============================================

  @variables @string
  Scenario: Variables - String values
    # Variables allow you to reuse values across steps
    # Use {variableName} syntax to interpolate variables in URLs
    # This makes tests more maintainable and flexible
    Given I set the variable "userId" to "1"
    When I send a GET request to "/users/{userId}"
    Then the response status should be 200
    And the response field "id" should equal 1

  @variables @number
  Scenario: Variables - Numeric values
    # Variables can store numbers too
    # Useful for IDs, counts, or any numeric value
    # Can be used in URLs, JSON bodies, and validations
    Given I set the variable "postId" to 1
    When I send a GET request to "/posts/{postId}"
    Then the response status should be 200
    And the response field "id" should equal 1

  @variables @json_1
  Scenario: Variables - JSON objects
    # Variables can store entire JSON objects
    # Perfect for reusing complex request bodies
    # Keeps your tests DRY (Don't Repeat Yourself)
    Given I set the variable "newPost" to the JSON
      """
      {
        "title": "Variable Test",
        "body": "Testing JSON variable",
        "userId": 1
      }
      """
    When I send a POST request to "/posts" with the variable "newPost"
    Then the response status should be 201

  # ============================================
  # DATA EXTRACTION
  # ============================================

  @extraction
  Scenario: Extract data from response
  # Get an existing post and extract its data
    When I send a GET request to "/posts/1"
    Then the response status should be 200
  # Extract the userId and use it to get user info
    And I extract "$.userId" from the response as "extractedUserId"
    When I send a GET request to "/users/{extractedUserId}"
    Then the response status should be 200
    And the response should contain "name"

  @extraction
  Scenario: Store complete response
    # Sometimes you need to store the entire response
    # Useful for complex validations or passing data between scenarios
    When I send a GET request to "/users/1"
    Then the response status should be 200
    And I store the response as "userResponse"

  # ============================================
  # RESPONSE VALIDATION
  # ============================================

  @validation @status
  Scenario: Validate status codes
    # Always validate the HTTP status code
    # 200 = OK, 201 = Created, 204 = No Content, 400 = Bad Request, etc.
    # "should be successful" checks for any 2xx status (200-299)
    When I send a GET request to "/users/1"
    Then the response status should be 200
    And the response should be successful

  @validation @fields
  Scenario: Validate response fields - String
    # Validate that specific fields have expected string values
    # Useful for checking data integrity and API contracts
    # Values must match exactly (case-sensitive)
    When I send a GET request to "/users/1"
    Then the response status should be 200
    And the response field "name" should equal "Leanne Graham"
    And the response field "username" should equal "Bret"

  @validation @fields
  Scenario: Validate response fields - Number
    # Validate numeric field values
    # Judo automatically handles type checking
    When I send a GET request to "/users/1"
    Then the response status should be 200
    And the response field "id" should equal 1

  @validation @contains
  Scenario: Validate response contains keys
    # Check that response has required fields
    # Doesn't validate the values, just that the keys exist
    # Perfect for API contract testing
    When I send a GET request to "/users/1"
    Then the response status should be 200
    And the response should contain "id"
    And the response should contain "name"
    And the response should contain "email"
    And the response should contain "address"
    And the response should contain "company"

  @validation @json
  Scenario: Validate response is valid JSON
    # Ensure the response is properly formatted JSON
    # Catches malformed responses early
    When I send a GET request to "/users/1"
    Then the response should be valid JSON

  # ============================================
  # JSONPATH VALIDATION
  # ============================================

  @jsonpath @string
  Scenario: JSONPath validation - String values
    # Use JSONPath expressions to validate nested data
    # $.field accesses top-level fields
    # $.nested.field accesses nested fields
    When I send a GET request to "/users/1"
    Then the response status should be 200
    And the response "$.name" should be "Leanne Graham"
    And the response "$.address.city" should be "Gwenborough"

  @jsonpath @number
  Scenario: JSONPath validation - Numeric values
    # JSONPath can validate numeric values too
    When I send a GET request to "/users/1"
    Then the response status should be 200
    And the response "$.id" should be 1

  @jsonpath @type
  Scenario: JSONPath type validation
    # Validate that fields are of expected types
    When I send a GET request to "/users/1"
    Then the response status should be 200
    And the response "$.name" should be a string
    And the response "$.id" should be a number

  # ============================================
  # ARRAY VALIDATION
  # ============================================

  @arrays @basic
  Scenario: Validate array response
    # Check that the response is an array (list)
    # Important when expecting multiple items
    When I send a GET request to "/users"
    Then the response status should be 200
    And the response should be an array

  @arrays @count
  Scenario: Validate array count
    # Validate the exact number of items in the array
    # Useful for pagination testing and data integrity checks
    Given I set the query parameter "_limit" to 5
    When I send a GET request to "/posts"
    Then the response status should be 200
    And the response array should have 5 items

  @arrays @contains
  Scenario: Validate array contains item
    # Search for specific items in an array
    # Checks if at least one item matches the criteria
    # Great for verifying data exists in collections
    When I send a GET request to "/users"
    Then the response status should be 200
    And the response array should contain an item with "id" equal to "1"
    And the response array should contain an item with "username" equal to "Bret"

  @arrays @each
  Scenario: Validate each array item has field
    # Ensure ALL items in the array have required fields
    # Validates data consistency across the collection
    # Catches missing or malformed items
    When I send a GET request to "/users"
    Then the response status should be 200
    And each item in the response array should have "id"
    And each item in the response array should have "name"
    And each item in the response array should have "email"

  # ============================================
  # WORKFLOW - COMPLETE CRUD
  # ============================================

  @workflow @crud_en
  Scenario: Complete CRUD workflow with existing resource
  # Use an existing post ID for realistic CRUD operations
    Given I set the variable "postId" to "1"

  # READ - Get the existing resource first
    When I send a GET request to "/posts/{postId}"
    Then the response status should be 200
    And I extract "$.title" from the response as "originalTitle"

  # UPDATE - Replace the entire resource (JSONPlaceholder simulates this)
    When I send a PUT request to "/posts/{postId}" with JSON
    """
    {
      "id": 1,
      "title": "Updated CRUD Post",
      "body": "Updated body",
      "userId": 1
    }
    """
    Then the response status should be 200
    And the response field "title" should equal "Updated CRUD Post"

  # PARTIAL UPDATE - Update only specific fields
    When I send a PATCH request to "/posts/{postId}" with JSON
    """
    {
      "title": "Patched CRUD Post"
    }
    """
    Then the response status should be 200

  # DELETE - Remove the resource (JSONPlaceholder simulates this)
    When I send a DELETE request to "/posts/{postId}"
    Then the response status should be 200

  # ============================================
  # WORKFLOW - AUTHENTICATION FLOW
  # ============================================

  @workflow @auth
  Scenario: Authentication workflow with token
    # Real-world scenario: Login, get token, use token for authenticated requests
    # Step 1: Simulate getting a token (in real tests, you'd POST to /login)
    Given I set the variable "authToken" to "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9"
    # Step 2: Set the token for all subsequent requests
    And I use bearer token "{authToken}"
    # Step 3: Make authenticated request
    When I send a GET request to "/users/1"
    Then the response status should be 200

  # ============================================
  # UTILITY FEATURES
  # ============================================

  @utility @wait
  Scenario: Wait between requests
    # Add delays between requests when needed
    # Useful for: rate limiting, async operations, timing tests
    When I send a GET request to "/users/1"
    Then the response status should be 200
    # Wait 1 second before next request
    And I wait 1.0 seconds
    When I send a GET request to "/users/2"
    Then the response status should be 200

  @utility @debug
  Scenario: Print response for debugging
    # Print the response to console for debugging
    # Helpful during test development to see actual response data
    When I send a GET request to "/users/1"
    Then the response status should be 200
    And I print the response

  # ============================================
  # COMPLEX SCENARIOS
  # ============================================

  @complex @nested
  Scenario: Working with nested data
    # APIs often return nested objects (objects within objects)
    # Validate that nested structures exist
    When I send a GET request to "/users/1"
    Then the response status should be 200
    And the response should contain "address"
    And the response should contain "company"

  @complex @multiple-requests
  Scenario: Multiple related requests
    # Real-world scenario: Chain multiple API calls together
    # Each request uses data from the previous one

    # Step 1: Get user information
    When I send a GET request to "/users/1"
    Then the response status should be 200
    And I extract "$.id" from the response as "userId"

    # Step 2: Get all posts from that user
    Given I set the query parameter "userId" to "{userId}"
    When I send a GET request to "/posts"
    Then the response status should be 200
    And the response should be an array

    # Step 3: Get details of a specific post
    When I send a GET request to "/posts/1"
    Then the response status should be 200
    And I extract "$.id" from the response as "postId"

    # Step 4: Get all comments on that post
    When I send a GET request to "/posts/{postId}/comments"
    Then the response status should be 200
    And the response should be an array

  @complex @data-driven
  Scenario Outline: Data-driven testing with examples
    # Run the same test with different data
    # Perfect for testing multiple users, IDs, or scenarios
    # The scenario runs once for each row in the Examples table
    When I send a GET request to "/users/<userId>"
    Then the response status should be 200
    And the response field "id" should equal <userId>
    And the response should contain "name"
    And the response should contain "email"

    Examples:
      | userId |
      | 1      |
      | 2      |
      | 3      |

  # ============================================
  # PERFORMANCE
  # ============================================

  @performance
  Scenario: Validate response time
    # Ensure API responds within acceptable time limits
    # Important for SLA compliance and user experience
    # Adjust the time threshold based on your requirements
    When I send a GET request to "/users/1"
    Then the response status should be 200
    And the response time should be less than 5.0 seconds

  # ============================================
  # ERROR HANDLING
  # ============================================

  @errors @not-found
  Scenario: Handle 404 Not Found
    # Test that API properly handles requests for non-existent resources
    # Should return 404 status code
    # Important for API contract and error handling validation
    When I send a GET request to "/users/999999"
    Then the response status should be 404

  @errors @validation
  Scenario: Validate error responses
    # Test how API handles invalid or incomplete data
    # In this case, sending empty JSON to create endpoint
    # Note: JSONPlaceholder is lenient and returns 201 anyway
    # In real APIs, this might return 400 Bad Request
    When I send a POST request to "/posts" with JSON
      """
      {}
      """
    Then the response status should be 201

  # ============================================
  # FILE OPERATIONS - SIMPLE AND DIRECT
  # ============================================

  @files @post-json
  Scenario: POST request using JSON file
    # Simply specify the JSON file path - Judo loads and sends the data
    # File: examples/test_data/simple_post.json
    When I POST to "/posts" with JSON file "../base_requests/simple_post.json"
    Then the response status should be 201
    And the response should contain "id"
    And the response field "title" should equal "Simple Post from File"

  @files @put-json
  Scenario: PUT request using JSON file
    # Update a resource using data from a JSON file
    # File: examples/test_data/update_post.json
    When I PUT to "/posts/1" with JSON file "../base_requests/update_post.json"
    Then the response status should be 200
    And the response field "title" should equal "Updated Post Title"

  @files @patch-json
  Scenario: PATCH request using JSON file
    # Partial update using data from a JSON file
    When I PATCH to "/posts/1" with JSON file "../base_requests/simple_post.json"
    Then the response status should be 200
    And the response field "title" should equal "Simple Post from File"

  @files @schema-validation
  Scenario: Validate response against JSON schema file
    # Validate API response structure using a JSON schema file
    # File: examples/test_data/simple_schema.json
    When I send a POST request to "/posts" with JSON
      """
      {
        "title": "Schema Test",
        "body": "Testing schema validation",
        "userId": 1
      }
      """
    Then the response status should be 201

  @files @save-response
  Scenario: Save response to file
    # Save API responses to files for later analysis or debugging
    When I send a GET request to "/posts/1"
    Then the response status should be 200
    And I save the response to file "../base_responses/saved_response.json"

  @files @save-variable
  Scenario: Save extracted data to file
    # Extract data from response and save it to a file
    When I send a GET request to "/posts/1"
    Then the response status should be 200
    And I extract "$.title" from the response as "postTitle"
    And I save the variable "postTitle" to file "../base_variables/post_title.txt"

  @env @headers
  Scenario: Set headers from environment variables
    # This demonstrates loading headers from .env file
    # Create a .env file with: API_TOKEN=Bearer test123
    Given I set the header "Authorization" from env "API_TOKEN"
    When I send a GET request to "/users/1"
    Then the response status should be 200
    And the response should contain "id"



  # ============================================
  # ADVANCED FEATURES - TIER 1
  # ROBUSTNESS & RELIABILITY
  # ============================================

  @advanced @retry
  Scenario: Retry policy with exponential backoff
    # Configures automatic retries with exponential backoff
    # Useful for APIs that may fail temporarily
    Given I set retry policy with max_retries=3 and backoff_strategy="exponential"
    When I send a GET request to "/users/1"
    Then the response status should be 200

  @advanced @retry-custom
  Scenario: Retry policy with custom delay parameters
    # Configures retries with custom initial and max delay
    Given I set retry policy with max_retries=5, initial_delay=1.0, and max_delay=10.0
    When I send a GET request to "/posts/1"
    Then the response status should be 200

  @advanced @circuit-breaker
  Scenario: Circuit breaker to prevent cascading failures
    Given I create circuit breaker "api_breaker" with failure_threshold=5
    When I send a GET request to "/users/1"
    Then the response status should be 200
    And circuit breaker "api_breaker" should be in state CLOSED

  @advanced @circuit-breaker-advanced
  Scenario: Circuit breaker with advanced configuration
    Given I create circuit breaker "advanced_breaker" with failure_threshold=3, success_threshold=2, and timeout=30
    When I send a GET request to "/users/1"
    Then the response status should be 200
    And circuit breaker "advanced_breaker" should be in state CLOSED

  @advanced @interceptor-timestamp
  Scenario: Timestamp interceptor in headers
    # Automatically adds timestamp to all requests
    Given I add a timestamp interceptor with header name "X-Request-Time"
    When I send a GET request to "/users/1"
    Then the response status should be 200

  @advanced @interceptor-auth
  Scenario: Authorization interceptor with Bearer token
    # Automatically adds Bearer token to all requests
    Given I add an authorization interceptor with token "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9"
    When I send a GET request to "/users/1"
    Then the response status should be 200

  @advanced @interceptor-auth-custom
  Scenario: Authorization interceptor with custom scheme
    # Uses custom authorization scheme (not just Bearer)
    Given I add an authorization interceptor with token "custom-token-123" and scheme "X-API-Key"
    When I send a GET request to "/users/1"
    Then the response status should be 200

  @advanced @interceptor-logging
  Scenario: Logging interceptor for requests
    # Enables logging of all requests
    Given I add a logging interceptor
    When I send a GET request to "/users/1"
    Then the response status should be 200

  @advanced @interceptor-response-logging
  Scenario: Response logging interceptor
    # Enables logging of all responses
    Given I add a response logging interceptor
    When I send a GET request to "/users/1"
    Then the response status should be 200

  @advanced @rate-limit
  Scenario: Rate limiting - Requests per second
    # Configures request rate limit per second
    Given I set rate limit to 10 requests per second
    When I send a GET request to "/users/1"
    Then the response status should be 200

  @advanced @throttle
  Scenario: Throttling - Fixed delay between requests
    # Adds fixed delay between requests
    Given I set throttle with delay 500 milliseconds
    When I send a GET request to "/users/1"
    Then the response status should be 200
    And I wait 0.5 seconds
    When I send a GET request to "/users/2"
    Then the response status should be 200

  @advanced @rate-limit-adaptive
  Scenario: Adaptive rate limiting
    # Rate limiting that adapts based on API headers
    Given I set adaptive rate limit with initial 5 requests per second
    When I send a GET request to "/users/1"
    Then the response status should be 200

  @advanced @rate-limiter-check
  Scenario: Check rate limiter remaining requests
    # Validates remaining requests in rate limiter
    Given I set rate limit to 10 requests per second
    When I send a GET request to "/users/1"
    Then the response status should be 200
    And the rate limiter should have 9 requests remaining

  @advanced @response-time-ms
  Scenario: Validate response time in milliseconds
    # Validates response time with millisecond precision
    When I send a GET request to "/users/1"
    Then the response status should be 200
    And the response time should be less than 5000 milliseconds

  @advanced @array-more-than
  Scenario: Validate array has more than N items
    # Validates array has more than specified number of items
    When I send a GET request to "/users"
    Then the response status should be 200
    And the response should be an array

  @advanced @array-less-than
  Scenario: Validate array has less than N items
    # Validates array has fewer than specified number of items
    Given I set the query parameter "_limit" to 3
    When I send a GET request to "/posts"
    Then the response status should be 200
    And the response should be an array

  @advanced @contains-all-fields
  Scenario: Validate response contains all specified fields
    # Validates response contains all specified fields
    When I send a GET request to "/users/1"
    Then the response status should be 200
    And the response should contain "id"
    And the response should contain "name"
    And the response should contain "email"
    And the response should contain "address"
    And the response should contain "company"

  @advanced @field-type-validation
  Scenario: Validate field is of specific type
    # Validates field is of specified type
    When I send a GET request to "/users/1"
    Then the response status should be 200
    And the response "$.id" should be a number
    And the response "$.name" should be a string

  @advanced @pattern-validation
  Scenario: Validate field matches regex pattern
    # Validates that field matches regex pattern
    When I send a GET request to "/users/1"
    Then the response status should be 200
    And the response "$.email" should be a valid email

  @advanced @range-validation
  Scenario: Validate field is in numeric range
    # Validates that numeric field is within range
    When I send a GET request to "/users/1"
    Then the response status should be 200

  # ============================================
  # ADVANCED FEATURES - TIER 2
  # PERFORMANCE & MODERN APIS
  # ============================================

  @advanced @data-driven-load
  Scenario: Load test data from file
    # Loads test data from CSV, JSON, or Excel file
    Given I load test data "testData" from file "../base_requests/test_data.json"
    When I send a GET request to "/users/1"
    Then the response status should be 200

  @advanced @performance-multiple
  Scenario: Performance testing - Multiple requests
    # Sends multiple GET requests for performance testing
    When I send 10 GET requests to "/users/1"
    Then all responses should have status 200

  @advanced @percentile-95
  Scenario: Validate p95 response time
    # Validates that p95 response time is within limit
    When I send 20 GET requests to "/users"
    Then all responses should have status 200

  @advanced @error-rate
  Scenario: Validate error rate
    # Validates that error rate is below threshold
    When I send 50 GET requests to "/users/1"
    Then all responses should have status 200

  @advanced @response-caching
  Scenario: Response caching with TTL
    # Enables automatic caching of GET responses with time-to-live
    Given I enable response caching with TTL 60 seconds
    When I send a GET request to "/users/1"
    Then the response status should be 200

  @advanced @cache-same-request
  Scenario: Validate cached response on repeated request
    # Sends identical GET request to test cache
    Given I enable response caching with TTL 60 seconds
    When I send a GET request to "/users/1"
    Then the response status should be 200
    And when I send the same GET request to "/users/1" again
    Then the second response should come from cache

  @advanced @cache-validation
  Scenario: Validate cache contains expected entries
    # Validates that cache contains expected number of entries
    Given I enable response caching with TTL 60 seconds
    When I send a GET request to "/users/1"
    And I send a GET request to "/users/2"
    And I send a GET request to "/users/3"
    Then the response status should be 200

  # ============================================
  # ROBUSTNESS & RELIABILITY
  # ============================================

  @advanced @retry
  Scenario: Retry policy with exponential backoff
    Given I set retry policy with max_retries=3 and backoff_strategy="exponential"
    When I send a GET request to "/users/1"
    Then the response status should be 200

  @advanced @retry-custom
  Scenario: Retry policy with custom parameters
    Given I set retry policy with max_retries=5, initial_delay=1.0, and max_delay=10.0
    When I send a GET request to "/posts/1"
    Then the response status should be 200

  @advanced @circuit-breaker
  Scenario: Circuit breaker to prevent cascading failures
    Given I create circuit breaker "api_breaker" with failure_threshold=5
    When I send a GET request to "/users/1"
    Then the response status should be 200
    And circuit breaker "api_breaker" should be in state CLOSED

  @advanced @circuit-breaker-advanced
  Scenario: Circuit breaker with advanced configuration
    Given I create circuit breaker "advanced_breaker" with failure_threshold=3, success_threshold=2, and timeout=30
    When I send a GET request to "/users/1"
    Then the response status should be 200
    And circuit breaker "advanced_breaker" should be in state CLOSED

  @advanced @interceptor-timestamp
  Scenario: Timestamp interceptor in headers
    Given I add a timestamp interceptor with header name "X-Request-Time"
    When I send a GET request to "/users/1"
    Then the response status should be 200

  @advanced @interceptor-auth
  Scenario: Authorization interceptor with Bearer token
    Given I add an authorization interceptor with token "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9"
    When I send a GET request to "/users/1"
    Then the response status should be 200

  @advanced @interceptor-auth-custom
  Scenario: Authorization interceptor with custom scheme
    Given I add an authorization interceptor with token "custom-token-123" and scheme "X-API-Key"
    When I send a GET request to "/users/1"
    Then the response status should be 200

  @advanced @interceptor-logging
  Scenario: Logging interceptor for requests
    Given I add a logging interceptor
    When I send a GET request to "/users/1"
    Then the response status should be 200

  @advanced @interceptor-logging-response
  Scenario: Logging interceptor for responses
    Given I add a response logging interceptor
    When I send a GET request to "/users/1"
    Then the response status should be 200

  @advanced @rate-limit
  Scenario: Rate limiting - Requests per second
    Given I set rate limit to 10 requests per second
    When I send a GET request to "/users/1"
    Then the response status should be 200

  @advanced @throttle
  Scenario: Throttling - Fixed delay between requests
    Given I set throttle with delay 500 milliseconds
    When I send a GET request to "/users/1"
    Then the response status should be 200
    And I wait 0.5 seconds
    When I send a GET request to "/users/2"
    Then the response status should be 200

  @advanced @rate-limit-adaptive
  Scenario: Adaptive rate limiting
    Given I set adaptive rate limit with initial 5 requests per second
    When I send a GET request to "/users/1"
    Then the response status should be 200

  @advanced @advanced-validation
  Scenario: Advanced response validation
    When I send a GET request to "/users"
    Then the response status should be 200
    And the response should be an array
    And each item in the response array should have "id"
    And each item in the response array should have "name"

  @advanced @validation-less-items
  Scenario: Validate array has less than X items
    When I send a GET request to "/users"
    Then the response status should be 200
    And the response should be an array

  @advanced @validation-all-fields
  Scenario: Validate response contains all fields
    When I send a GET request to "/users/1"
    Then the response status should be 200
    And the response should contain "id"
    And the response should contain "name"
    And the response should contain "email"

  @advanced @validation-field-type
  Scenario: Validate field type
    When I send a GET request to "/users/1"
    Then the response status should be 200
    And the response "$.id" should be a number
    And the response "$.name" should be a string

  @advanced @validation-pattern
  Scenario: Validate field matches pattern
    When I send a GET request to "/users/1"
    Then the response status should be 200
    And the response "$.email" should be a valid email
    And the response "$.email" should match "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$"

  @advanced @validation-range
  Scenario: Validate field is in range
    When I send a GET request to "/users/1"
    Then the response status should be 200

  @advanced @response-time-ms
  Scenario: Validate response time in milliseconds
    When I send a GET request to "/users/1"
    Then the response status should be 200
    And the response time should be less than 5000 milliseconds

  @advanced @schema-validation
  Scenario: Validate response against JSON schema
    When I send a GET request to "/users/1"
    Then the response status should be 200
    And the response should match the schema
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
  # PERFORMANCE & MODERN APIS
  # ============================================

  @advanced @performance-multiple
  Scenario: Performance testing - Multiple requests
    When I send 10 GET requests to "/users/1"
    Then all responses should have status 200

  @advanced @percentile-95
  Scenario: Validate p95 response time
    When I send 20 GET requests to "/users"
    Then all responses should have status 200

  @advanced @error-rate
  Scenario: Validate error rate
    When I send 50 GET requests to "/users/1"
    Then all responses should have status 200

  @advanced @response-caching
  Scenario: Response caching
    Given I enable request/response logging
    When I send a GET request to "/users/1"
    Then the response status should be 200

  @advanced @cache-validation
  Scenario: Validate cache contents
    Given I enable request/response logging
    When I send a GET request to "/users/1"
    And I send a GET request to "/users/2"
    And I send a GET request to "/users/3"
    Then the response status should be 200

  @advanced @data-driven-testing
  Scenario: Data-driven testing from file
    When I send a GET request to "/users/1"
    Then the response status should be 200
