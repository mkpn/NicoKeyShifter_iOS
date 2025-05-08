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
        // ここに依存関係を追加できます
    ],
    targets: [
        .target(
            name: "NicoKeyShifter_iOS",
            dependencies: []),
        .testTarget(
            name: "NicoKeyShifter_iOSTests",
            dependencies: ["NicoKeyShifter_iOS"]),
    ]
) 