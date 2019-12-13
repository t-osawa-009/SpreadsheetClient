// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "SpreadsheetClient",
    platforms: [.iOS(.v10), .macOS(.v10_12), .tvOS(.v10), .watchOS(.v3)],
    products: [
        .library(name: "SpreadsheetClient", targets: ["SpreadsheetClient"])
    ],
    targets: [
        .target(
            name: "SpreadsheetClient",
            path: "Sources"
        )
    ],
    swiftLanguageVersions: [.v5]
)
