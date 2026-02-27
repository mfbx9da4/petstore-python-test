<!-- Start SDK Example Usage [usage] -->
```python
# Synchronous Example
from openapi import SDK


with SDK() as sdk:

    res = sdk.list_pets()

    # Handle response
    print(res)
```

</br>

The same SDK client can also be used to make asynchronous requests by importing asyncio.

```python
# Asynchronous Example
import asyncio
from openapi import SDK

async def main():

    async with SDK() as sdk:

        res = await sdk.list_pets_async()

        # Handle response
        print(res)

asyncio.run(main())
```
<!-- End SDK Example Usage [usage] -->