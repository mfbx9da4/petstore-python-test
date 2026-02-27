<!-- Start SDK Example Usage [usage] -->
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
<!-- End SDK Example Usage [usage] -->