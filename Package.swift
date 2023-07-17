// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GeometryPrimitives2D",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "GeometryPrimitives2D",
            targets: ["GeometryPrimitives2D"]),
        .library(
            name: "GeometryUI",
            targets: ["GeometryUI"]),
        
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "GeometryPrimitives2D",
            dependencies: [])
        
        ,
        .target(
            name: "GeometryUI",
            dependencies: ["GeometryPrimitives2D"]),
        
        .testTarget(
            name: "GeometryPrimitives2DTests",
            dependencies: ["GeometryPrimitives2D"]),
    ]
)
