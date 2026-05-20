// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "MeshGlass",
    platforms: [.macOS(.v13)],
    targets: [
        .executableTarget(
            name: "MeshGlass",
            path: "Sources/MeshGlass"
        )
    ]
)
