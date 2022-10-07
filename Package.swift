// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CertificatePinner",
    products: [
        .library(
            name: "CertificatePinner",
            targets: ["CertificatePinner"]),
    ],
    targets: [
        .target(
            name: "CertificatePinner",
            dependencies: []),
        .testTarget(
            name: "CertificatePinnerTests",
            dependencies: ["CertificatePinner"]),
    ]
)
