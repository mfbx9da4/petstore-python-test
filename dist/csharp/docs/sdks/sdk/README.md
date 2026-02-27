# SDK

## Overview

### Available Operations

* [ListPets](#listpets) - List all pets

## ListPets

List all pets

### Example Usage

<!-- UsageSnippet language="csharp" operationID="listPets" method="get" path="/pets" -->
```csharp
using Openapi;

var sdk = new SDK();

var res = await sdk.ListPetsAsync();

// handle response
```

### Response

**[ListPetsResponse](../../Models/Requests/ListPetsResponse.md)**

### Errors

| Error Type                         | Status Code                        | Content Type                       |
| ---------------------------------- | ---------------------------------- | ---------------------------------- |
| Openapi.Models.Errors.APIException | 4XX, 5XX                           | \*/\*                              |