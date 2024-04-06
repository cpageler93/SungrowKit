# SungrowKit

SungrowKit is a Swift Package designed to fetch data from a Sungrow inverter using the Modbus protocol.

## Setup

Add SungrowKit as a dependency to your Swift Package. In your `Package.swift` file, add the following entry:

```swift
dependencies: [
    .package(url: "https://github.com/cpageler93/SungrowKit.git", from: "1.0.0")
]
```

## Usage

Import SungrowKit into your Swift code:

```swift
import SungrowKit
```

Initialize a SungrowClient:

```swift
let client = SungrowClient(address: "192.168.178.55")
```

Fetch data from the inverter:

```swift
let response = try? await client.send(request: .totalDCPower)
let formattedResponseValue = response?.formattedValue ?? "–"
```

## Note

Ensure that your device is connected to the Sungrow inverter over the local network and has the necessary permissions to access the inverter.

## License

SungrowKit is released under the MIT license. See the [license file](LICENSE) for more details.