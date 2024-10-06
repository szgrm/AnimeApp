// swift-tools-version:5.9

import PackageDescription

let package = Package(
  name: "AnilistAPI",
  platforms: [
    .iOS(.v12),
    .macOS(.v10_14),
    .tvOS(.v12),
    .watchOS(.v5),
  ],
  products: [
    .library(name: "AnilistAPI", targets: ["AnilistAPI"]),
    .library(name: "SchemaTestMocks", targets: ["SchemaTestMocks"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apollographql/apollo-ios.git", from: "1.0.0"),
  ],
  targets: [
    .target(
      name: "AnilistAPI",
      dependencies: [
        .product(name: "ApolloAPI", package: "apollo-ios"),
      ],
      path: "./Sources"
    ),
    .target(
      name: "SchemaTestMocks",
      dependencies: [
        .product(name: "ApolloTestSupport", package: "apollo-ios"),
        .target(name: "AnilistAPI"),
      ],
      path: "./SchemaTestMocks"
    ),
  ]
)
