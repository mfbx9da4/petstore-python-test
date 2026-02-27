# openapi

Developer-friendly & type-safe Java SDK specifically catered to leverage *openapi* API.

[![Built by Speakeasy](https://img.shields.io/badge/Built_by-SPEAKEASY-374151?style=for-the-badge&labelColor=f3f4f6)](https://www.speakeasy.com/?utm_source=openapi&utm_campaign=java)
[![License: MIT](https://img.shields.io/badge/LICENSE_//_MIT-3b5bdb?style=for-the-badge&labelColor=eff6ff)](https://mit-license.org/)


<br /><br />
> [!IMPORTANT]
> This SDK is not yet ready for production use. To complete setup please follow the steps outlined in your [workspace](https://app.speakeasy.com/org/speakeasy-self/speakeasy-self). Delete this section before > publishing to a package manager.

<!-- Start Summary [summary] -->
## Summary


<!-- End Summary [summary] -->

<!-- Start Table of Contents [toc] -->
## Table of Contents
<!-- $toc-max-depth=2 -->
* [openapi](#openapi)
  * [SDK Installation](#sdk-installation)
  * [SDK Example Usage](#sdk-example-usage)
  * [Asynchronous Support](#asynchronous-support)
  * [Available Resources and Operations](#available-resources-and-operations)
  * [Error Handling](#error-handling)
  * [Server Selection](#server-selection)
  * [Custom HTTP Client](#custom-http-client)
  * [Debugging](#debugging)
* [Development](#development)
  * [Maturity](#maturity)
  * [Contributions](#contributions)

<!-- End Table of Contents [toc] -->

<!-- Start SDK Installation [installation] -->
## SDK Installation

### Getting started

JDK 11 or later is required.

The samples below show how a published SDK artifact is used:

Gradle:
```groovy
implementation 'org.openapis:openapi:0.0.3'
```

Maven:
```xml
<dependency>
    <groupId>org.openapis</groupId>
    <artifactId>openapi</artifactId>
    <version>0.0.3</version>
</dependency>
```

### How to build
After cloning the git repository to your file system you can build the SDK artifact from source to the `build` directory by running `./gradlew build` on *nix systems or `gradlew.bat` on Windows systems.

If you wish to build from source and publish the SDK artifact to your local Maven repository (on your filesystem) then use the following command (after cloning the git repo locally):

On *nix:
```bash
./gradlew publishToMavenLocal -Pskip.signing
```
On Windows:
```bash
gradlew.bat publishToMavenLocal -Pskip.signing
```
<!-- End SDK Installation [installation] -->

<!-- Start SDK Example Usage [usage] -->
## SDK Example Usage

### Example

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
#### Asynchronous Call
An asynchronous SDK client is also available that returns a [`CompletableFuture<T>`][comp-fut]. See [Asynchronous Support](#asynchronous-support) for more details on async benefits and reactive library integration.
```java
package hello.world;

import java.util.concurrent.CompletableFuture;
import org.openapis.openapi.AsyncSDK;
import org.openapis.openapi.SDK;
import org.openapis.openapi.models.operations.async.ListPetsResponse;

public class Application {

    public static void main(String[] args) {

        AsyncSDK sdk = SDK.builder()
            .build()
            .async();

        CompletableFuture<ListPetsResponse> resFut = sdk.listPets()
                .call();

        resFut.thenAccept(res -> {
            if (res.pets().isPresent()) {
            // handle response
            }
        });
    }
}
```

[comp-fut]: https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/CompletableFuture.html
<!-- End SDK Example Usage [usage] -->

<!-- Start Asynchronous Support [async-support] -->
## Asynchronous Support

The SDK provides comprehensive asynchronous support using Java's [`CompletableFuture<T>`][comp-fut] and [Reactive Streams `Publisher<T>`][reactive-streams] APIs. This design makes no assumptions about your choice of reactive toolkit, allowing seamless integration with any reactive library.

<details>
<summary>Why Use Async?</summary>

Asynchronous operations provide several key benefits:

- **Non-blocking I/O**: Your threads stay free for other work while operations are in flight
- **Better resource utilization**: Handle more concurrent operations with fewer threads
- **Improved scalability**: Build highly responsive applications that can handle thousands of concurrent requests
- **Reactive integration**: Works seamlessly with reactive streams and backpressure handling

</details>

<details>
<summary>Reactive Library Integration</summary>

The SDK returns [Reactive Streams `Publisher<T>`][reactive-streams] instances for operations dealing with streams involving multiple I/O interactions. We use Reactive Streams instead of JDK Flow API to provide broader compatibility with the reactive ecosystem, as most reactive libraries natively support Reactive Streams.

**Why Reactive Streams over JDK Flow?**
- **Broader ecosystem compatibility**: Most reactive libraries (Project Reactor, RxJava, Akka Streams, etc.) natively support Reactive Streams
- **Industry standard**: Reactive Streams is the de facto standard for reactive programming in Java
- **Better interoperability**: Seamless integration without additional adapters for most use cases

**Integration with Popular Libraries:**
- **Project Reactor**: Use `Flux.from(publisher)` to convert to Reactor types
- **RxJava**: Use `Flowable.fromPublisher(publisher)` for RxJava integration
- **Akka Streams**: Use `Source.fromPublisher(publisher)` for Akka Streams integration
- **Vert.x**: Use `ReadStream.fromPublisher(vertx, publisher)` for Vert.x reactive streams
- **Mutiny**: Use `Multi.createFrom().publisher(publisher)` for Quarkus Mutiny integration

**For JDK Flow API Integration:**
If you need JDK Flow API compatibility (e.g., for Quarkus/Mutiny 2), you can use adapters:
```java
// Convert Reactive Streams Publisher to Flow Publisher
Flow.Publisher<T> flowPublisher = FlowAdapters.toFlowPublisher(reactiveStreamsPublisher);

// Convert Flow Publisher to Reactive Streams Publisher
Publisher<T> reactiveStreamsPublisher = FlowAdapters.toPublisher(flowPublisher);
```

For standard single-response operations, the SDK returns `CompletableFuture<T>` for straightforward async execution.

</details>

<details>
<summary>Supported Operations</summary>

Async support is available for:

- **[Server-sent Events](#server-sent-event-streaming)**: Stream real-time events with Reactive Streams `Publisher<T>`
- **[JSONL Streaming](#jsonl-streaming)**: Process streaming JSON lines asynchronously
- **[Pagination](#pagination)**: Iterate through paginated results using `callAsPublisher()` and `callAsPublisherUnwrapped()`
- **[File Uploads](#file-uploads)**: Upload files asynchronously with progress tracking
- **[File Downloads](#file-downloads)**: Download files asynchronously with streaming support
- **[Standard Operations](#example)**: All regular API calls return `CompletableFuture<T>` for async execution

</details>

[comp-fut]: https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/CompletableFuture.html
[reactive-streams]: https://www.reactive-streams.org/
<!-- End Asynchronous Support [async-support] -->

<!-- Start Available Resources and Operations [operations] -->
## Available Resources and Operations

<details open>
<summary>Available methods</summary>

### [SDK](docs/sdks/sdk/README.md)

* [listPets](docs/sdks/sdk/README.md#listpets) - List all pets

</details>
<!-- End Available Resources and Operations [operations] -->

<!-- Start Error Handling [errors] -->
## Error Handling

Handling errors in this SDK should largely match your expectations. All operations return a response object or raise an exception.


[`SDKException`](./src/main/java/models/errors/SDKException.java) is the base class for all HTTP error responses. It has the following properties:

| Method           | Type                        | Description                                                              |
| ---------------- | --------------------------- | ------------------------------------------------------------------------ |
| `message()`      | `String`                    | Error message                                                            |
| `code()`         | `int`                       | HTTP response status code eg `404`                                       |
| `headers`        | `Map<String, List<String>>` | HTTP response headers                                                    |
| `body()`         | `byte[]`                    | HTTP body as a byte array. Can be empty array if no body is returned.    |
| `bodyAsString()` | `String`                    | HTTP body as a UTF-8 string. Can be empty string if no body is returned. |
| `rawResponse()`  | `HttpResponse<?>`           | Raw HTTP response (body already read and not available for re-read)      |

### Example
```java
package hello.world;

import java.io.UncheckedIOException;
import java.lang.Exception;
import java.util.Optional;
import org.openapis.openapi.SDK;
import org.openapis.openapi.models.errors.SDKException;
import org.openapis.openapi.models.operations.ListPetsResponse;

public class Application {

    public static void main(String[] args) throws Exception {

        SDK sdk = SDK.builder()
            .build();
        try {

            ListPetsResponse res = sdk.listPets()
                    .call();

            if (res.pets().isPresent()) {
                // handle response
            }
        } catch (SDKException ex) { // all SDK exceptions inherit from SDKException

            // ex.ToString() provides a detailed error message including
            // HTTP status code, headers, and error payload (if any)
            System.out.println(ex);

            // Base exception fields
            var rawResponse = ex.rawResponse();
            var headers = ex.headers();
            var contentType = headers.first("Content-Type");
            int statusCode = ex.code();
            Optional<byte[]> responseBody = ex.body();
        } catch (UncheckedIOException ex) {
            // handle IO error (connection, timeout, etc)
        }    }
}
```

### Error Classes
**Primary error:**
* [`SDKException`](./src/main/java/models/errors/SDKException.java): The base class for HTTP error responses.

<details><summary>Less common errors (6)</summary>

<br />

**Network errors:**
* `java.io.IOException` (always wrapped by `java.io.UncheckedIOException`). Commonly encountered subclasses of
`IOException` include `java.net.ConnectException`, `java.net.SocketTimeoutException`, `EOFException` (there are
many more subclasses in the JDK platform).

**Inherit from [`SDKException`](./src/main/java/models/errors/SDKException.java)**:


</details>
<!-- End Error Handling [errors] -->

<!-- Start Server Selection [server] -->
## Server Selection

### Override Server URL Per-Client

The default server can be overridden globally using the `.serverURL(String serverUrl)` builder method when initializing the SDK client instance. For example:
```java
package hello.world;

import java.lang.Exception;
import org.openapis.openapi.SDK;
import org.openapis.openapi.models.operations.ListPetsResponse;

public class Application {

    public static void main(String[] args) throws Exception {

        SDK sdk = SDK.builder()
                .serverURL("https://petstore.example.com/v1")
            .build();

        ListPetsResponse res = sdk.listPets()
                .call();

        if (res.pets().isPresent()) {
            // handle response
        }
    }
}
```
<!-- End Server Selection [server] -->

<!-- Start Custom HTTP Client [http-client] -->
## Custom HTTP Client

The Java SDK makes API calls using an `HTTPClient` that wraps the native
[HttpClient](https://docs.oracle.com/en/java/javase/11/docs/api/java.net.http/java/net/http/HttpClient.html). This
client provides the ability to attach hooks around the request lifecycle that can be used to modify the request or handle
errors and response.

The `HTTPClient` interface allows you to either use the default `SpeakeasyHTTPClient` that comes with the SDK,
or provide your own custom implementation with customized configuration such as custom executors, SSL context,
connection pools, and other HTTP client settings.

The interface provides synchronous (`send`) methods and asynchronous (`sendAsync`) methods. The `sendAsync` method
is used to power the async SDK methods and returns a `CompletableFuture<HttpResponse<Blob>>` for non-blocking operations.

The following example shows how to add a custom header and handle errors:

```java
import org.openapis.openapi.SDK;
import org.openapis.openapi.utils.HTTPClient;
import org.openapis.openapi.utils.SpeakeasyHTTPClient;
import org.openapis.openapi.utils.Utils;

import java.io.IOException;
import java.net.URISyntaxException;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.io.InputStream;
import java.time.Duration;

public class Application {
    public static void main(String[] args) {
        // Create a custom HTTP client with hooks
        HTTPClient httpClient = new HTTPClient() {
            private final HTTPClient defaultClient = new SpeakeasyHTTPClient();
            
            @Override
            public HttpResponse<InputStream> send(HttpRequest request) throws IOException, URISyntaxException, InterruptedException {
                // Add custom header and timeout using Utils.copy()
                HttpRequest modifiedRequest = Utils.copy(request)
                    .header("x-custom-header", "custom value")
                    .timeout(Duration.ofSeconds(30))
                    .build();
                    
                try {
                    HttpResponse<InputStream> response = defaultClient.send(modifiedRequest);
                    // Log successful response
                    System.out.println("Request successful: " + response.statusCode());
                    return response;
                } catch (Exception error) {
                    // Log error
                    System.err.println("Request failed: " + error.getMessage());
                    throw error;
                }
            }
        };

        SDK sdk = SDK.builder()
            .client(httpClient)
            .build();
    }
}
```

<details>
<summary>Custom HTTP Client Configuration</summary>

You can also provide a completely custom HTTP client with your own configuration:

```java
import org.openapis.openapi.SDK;
import org.openapis.openapi.utils.HTTPClient;
import org.openapis.openapi.utils.Blob;
import org.openapis.openapi.utils.ResponseWithBody;

import java.io.IOException;
import java.net.URISyntaxException;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.io.InputStream;
import java.time.Duration;
import java.util.concurrent.Executors;
import java.util.concurrent.CompletableFuture;

public class Application {
    public static void main(String[] args) {
        // Custom HTTP client with custom configuration
        HTTPClient customHttpClient = new HTTPClient() {
            private final HttpClient client = HttpClient.newBuilder()
                .executor(Executors.newFixedThreadPool(10))
                .connectTimeout(Duration.ofSeconds(30))
                // .sslContext(customSslContext) // Add custom SSL context if needed
                .build();

            @Override
            public HttpResponse<InputStream> send(HttpRequest request) throws IOException, URISyntaxException, InterruptedException {
                return client.send(request, HttpResponse.BodyHandlers.ofInputStream());
            }

            @Override
            public CompletableFuture<HttpResponse<Blob>> sendAsync(HttpRequest request) {
                // Convert response to HttpResponse<Blob> for async operations
                return client.sendAsync(request, HttpResponse.BodyHandlers.ofPublisher())
                    .thenApply(resp -> new ResponseWithBody<>(resp, Blob::from));
            }
        };

        SDK sdk = SDK.builder()
            .client(customHttpClient)
            .build();
    }
}
```

</details>

You can also enable debug logging on the default `SpeakeasyHTTPClient`:

```java
import org.openapis.openapi.SDK;
import org.openapis.openapi.utils.SpeakeasyHTTPClient;

public class Application {
    public static void main(String[] args) {
        SpeakeasyHTTPClient httpClient = new SpeakeasyHTTPClient();
        httpClient.enableDebugLogging(true);

        SDK sdk = SDK.builder()
            .client(httpClient)
            .build();
    }
}
```
<!-- End Custom HTTP Client [http-client] -->

<!-- Start Debugging [debug] -->
## Debugging

### Debug & Logging

#### SLF4j Logging
This SDK uses [SLF4j](https://www.slf4j.org/) for structured logging across HTTP requests, retries, pagination, streaming, and hooks. SLF4j provides comprehensive visibility into SDK operations.

**Log Levels:**
- **DEBUG**: High-level operations (HTTP requests/responses, retry attempts, page fetches, hook execution, stream lifecycle)
- **TRACE**: Detailed information (request/response bodies, backoff calculations, individual items processed)

**Configuration:**

Add your preferred SLF4j implementation to your project. For example, using Logback:

```gradle
dependencies {
    implementation 'ch.qos.logback:logback-classic:1.4.14'
}
```

Configure logging levels in your `logback.xml`:

```xml
<configuration>
    <appender name="STDOUT" class="ch.qos.logback.core.ConsoleAppender">
        <encoder>
            <pattern>%d{HH:mm:ss.SSS} [%thread] %-5level %logger{36} - %msg%n</pattern>
        </encoder>
    </appender>

    <!-- SDK-wide logging -->
    <logger name="org.openapis.openapi" level="DEBUG"/>
    
    <!-- Component-specific logging -->
    <logger name="org.openapis.openapi.utils.SpeakeasyHTTPClient" level="DEBUG"/>
    <logger name="org.openapis.openapi.utils.Retries" level="DEBUG"/>
    <logger name="org.openapis.openapi.utils.pagination" level="DEBUG"/>
    <logger name="org.openapis.openapi.utils.Hooks" level="TRACE"/>
    
    <root level="INFO">
        <appender-ref ref="STDOUT"/>
    </root>
</configuration>
```

**What Gets Logged:**
- **HTTP Client**: Request/response details, headers (with sensitive headers redacted), bodies (at TRACE level)
- **Retries**: Retry attempts, backoff delays, exhaustion, non-retryable exceptions
- **Pagination**: Page fetches, pagination state, errors
- **Streaming**: Stream initialization, item processing, closure
- **Hooks**: Hook execution counts, operation IDs, exceptions

#### Legacy Debug Logging
For backward compatibility, you can still use the legacy debug logging method:

```java
SDK.builder()
    .enableHTTPDebugLogging(true)
    .build();
```
Example output:
```
Sending request: http://localhost:35123/bearer#global GET
Request headers: {Accept=[application/json], Authorization=[******], Client-Level-Header=[added by client], Idempotency-Key=[some-key], x-speakeasy-user-agent=[speakeasy-sdk/java 0.0.1 internal 0.1.0 org.openapis.openapi]}
Received response: (GET http://localhost:35123/bearer#global) 200
Response headers: {access-control-allow-credentials=[true], access-control-allow-origin=[*], connection=[keep-alive], content-length=[50], content-type=[application/json], date=[Wed, 09 Apr 2025 01:43:29 GMT], server=[gunicorn/19.9.0]}
Response body:
{
  "authenticated": true, 
  "token": "global"
}
```
__WARNING__: Debug logging should only be used for temporary debugging purposes. Leaving this option on in a production system could expose credentials/secrets in logs. <i>Authorization</i> headers are redacted by default. You can specify additional redacted header names via `SpeakeasyHTTPClient.setRedactedHeaders`.

__NOTE__: This is a convenience method that calls `HTTPClient.enableDebugLogging()`. The `SpeakeasyHTTPClient` honors this setting. If you are using a custom HTTP client, it is up to the custom client to honor this setting.


#### JDK HTTP Client Logging
Another option is to set the System property `-Djdk.httpclient.HttpClient.log=all`. However, this option does not log request/response bodies.
<!-- End Debugging [debug] -->

<!-- Placeholder for Future Speakeasy SDK Sections -->

# Development

## Maturity

This SDK is in beta, and there may be breaking changes between versions without a major version update. Therefore, we recommend pinning usage
to a specific package version. This way, you can install the same version each time without breaking changes unless you are intentionally
looking for the latest version.

## Contributions

While we value open-source contributions to this SDK, this library is generated programmatically. Any manual changes added to internal files will be overwritten on the next generation. 
We look forward to hearing your feedback. Feel free to open a PR or an issue with a proof of concept and we'll do our best to include it in a future release. 

### SDK Created by [Speakeasy](https://www.speakeasy.com/?utm_source=openapi&utm_campaign=java)
