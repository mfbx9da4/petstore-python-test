# SDK

## Overview

### Available Operations

* [list_pets](#list_pets) - List all pets

## list_pets

List all pets

### Example Usage

<!-- UsageSnippet language="python" operationID="listPets" method="get" path="/pets" -->
```python
from openapi import SDK


with SDK() as sdk:

    res = sdk.list_pets()

    # Handle response
    print(res)

```

### Parameters

| Parameter                                                           | Type                                                                | Required                                                            | Description                                                         |
| ------------------------------------------------------------------- | ------------------------------------------------------------------- | ------------------------------------------------------------------- | ------------------------------------------------------------------- |
| `retries`                                                           | [Optional[utils.RetryConfig]](../../models/utils/retryconfig.md)    | :heavy_minus_sign:                                                  | Configuration to override the default retry behavior of the client. |

### Response

**[List[models.Pet]](../../models/.md)**

### Errors

| Error Type             | Status Code            | Content Type           |
| ---------------------- | ---------------------- | ---------------------- |
| errors.SDKDefaultError | 4XX, 5XX               | \*/\*                  |