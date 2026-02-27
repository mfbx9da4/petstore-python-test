<!-- Start SDK Example Usage [usage] -->
```ruby
require "openapi"

Models = ::OpenApiSDK::Models
s = ::OpenApiSDK::SDK.new
res = s.list_pets

unless res.pets.nil?
  # handle response
end

```
<!-- End SDK Example Usage [usage] -->