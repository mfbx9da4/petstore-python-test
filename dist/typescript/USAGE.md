<!-- Start SDK Example Usage [usage] -->
```typescript
import { SDK } from "openapi";

const sdk = new SDK();

async function run() {
  const result = await sdk.listPets();

  console.log(result);
}

run();

```
<!-- End SDK Example Usage [usage] -->