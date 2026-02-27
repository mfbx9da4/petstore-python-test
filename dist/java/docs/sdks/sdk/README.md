# SDK

## Overview

### Available Operations

* [listPets](#listpets) - List all pets

## listPets

List all pets

### Example Usage

<!-- UsageSnippet language="java" operationID="listPets" method="get" path="/pets" -->
```java
package hello.world;

import java.lang.Exception;
import org.openapis.openapi.SDK;
import org.openapis.openapi.models.operations.ListPetsResponse;

public class Application {

    public static void main(String[] args) throws Exception {

        SDK sdk = SDK.builder()
            .build();

        ListPetsResponse res = sdk.listPets()
                .call();

        if (res.pets().isPresent()) {
            // handle response
        }
    }
}
```

### Response

**[ListPetsResponse](../../models/operations/ListPetsResponse.md)**

### Errors

| Error Type                 | Status Code                | Content Type               |
| -------------------------- | -------------------------- | -------------------------- |
| models/errors/APIException | 4XX, 5XX                   | \*/\*                      |