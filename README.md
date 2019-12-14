# SpreadsheetClient
Get the value of a Google spreadsheet file

```swift
let client = SpreadsheetClient()
client.send(id: "SPREADSHEET_ID", sheetNumber: 1) { (result) in
    switch result {
    case .success(let value):
        print(value)
    case .failure(let error):
        print(error.localizedDescription)
    }
}
```

## Requirements
- iOS 10.0+ / macOS 10.12+ / tvOS 10.0+ / watchOS 3.0+
- Swift 5.1+

## Installation
### CocoaPods
```
# Podfile
use_frameworks!

target 'YOUR_TARGET_NAME' do
    pod 'SpreadsheetClient'
end
```

```sh
$ pod install
```

### Carthage
```
github "t-osawa-009/SpreadsheetClient"
```

```sh
$ carthage update
```

### Swift Package Manager
```
dependencies: [
    .package(url: "https://github.com/t-osawa-009/SpreadsheetClient.git", from: "0.0.1")
]
```
## Notes
- Your spreadsheet should be "Published" for this to work

## CONTRIBUTING
- There's still a lot of work to do here. We would love to see you involved. You can find all the details on how to get started in the Contributing Guide.

## License
SpreadsheetClient is released under the MIT license. See LICENSE for details.
