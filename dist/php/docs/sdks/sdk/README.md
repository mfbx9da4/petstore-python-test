# SDK

## Overview

### Available Operations

* [listPets](#listpets) - List all pets

## listPets

List all pets

### Example Usage

<!-- UsageSnippet language="php" operationID="listPets" method="get" path="/pets" -->
```php
declare(strict_types=1);

require 'vendor/autoload.php';

use OpenAPI\OpenAPI;

$sdk = OpenAPI\SDK::builder()->build();



$response = $sdk->listPets(

);

if ($response->pets !== null) {
    // handle response
}
```

### Response

**[?Operations\ListPetsResponse](../../Models/Operations/ListPetsResponse.md)**

### Errors

| Error Type          | Status Code         | Content Type        |
| ------------------- | ------------------- | ------------------- |
| Errors\APIException | 4XX, 5XX            | \*/\*               |