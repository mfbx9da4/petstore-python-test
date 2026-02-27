<!-- Start SDK Example Usage [usage] -->
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
<!-- End SDK Example Usage [usage] -->