// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "FastMBTICore",
    platforms: [.iOS(.v18), .macOS(.v14)],
    products: [
        .library(name: "FastMBTICore", targets: ["FastMBTICore"])
    ],
    targets: [
        .target(
            name: "FastMBTICore",
            resources: [.copy("Resources/quizTree.json")]
        ),
        .testTarget(
            name: "FastMBTICoreTests",
            dependencies: ["FastMBTICore"]
        )
    ]
)
