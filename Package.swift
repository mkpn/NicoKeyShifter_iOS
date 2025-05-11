// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "NicoKeyShifter_iOS",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "NicoKeyShifter_iOS",
            targets: ["NicoKeyShifter_iOS"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.8.1"),
        .package(url: "https://github.com/hmlongco/Factory.git", from: "2.4.3")
    ],
    targets: [
        .target(
            name: "NicoKeyShifter_iOS",
            dependencies: [
                .product(name: "Factory", package: "Factory"),
                .product(name: "Alamofire", package: "Alamofire")
            ]),
        .testTarget(
            name: "NicoKeyShifter_iOSTests",
            dependencies: [
                "NicoKeyShifter_iOS",
                .product(name: "FactoryTesting", package: "Factory")
            ]),
    ]
)
