# SDK

## Overview

### Available Operations

* [list_pets](#list_pets) - List all pets

## list_pets

List all pets

### Example Usage

<!-- UsageSnippet language="ruby" operationID="listPets" method="get" path="/pets" -->
```ruby
require 'openapi'

Models = ::OpenApiSDK::Models
s = ::OpenApiSDK::SDK.new
res = s.list_pets

unless res.pets.nil?
  # handle response
end

```

### Response

**[T.nilable(Models::Operations::ListPetsResponse)](../../models/operations/listpetsresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |