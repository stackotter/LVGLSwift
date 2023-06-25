// swift-tools-version:5.5

import PackageDescription
import Foundation

#if os(macOS)
let SDLCFlags = ["-I/opt/homebrew/include"]
#else
let SDLCFlags = [String]()
#endif

let package = Package(
    name: "LVGL",
    platforms: [
       .macOS(.v10_15),
    ],
    products: [
        .library(name: "CLVGL", targets: ["CLVGL"]),
        .library(name: "LVGL", targets: ["LVGL"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-async-algorithms", from: "0.1.0"),
        //.package(url: "https://github.com/apple/swift-foundation", .branch("main")),
        .package(url: "https://github.com/lhoward/AsyncExtensions", .branch("linux")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "CLVGL",
            dependencies: [],
            cSettings: [
                        .headerSearchPath("lv_drivers"),
                        .headerSearchPath("lvgl"),
                        .unsafeFlags(SDLCFlags + ["-DLV_LVGL_H_INCLUDE_SIMPLE"])
                        ],
	    linkerSettings: [.unsafeFlags(["-L/opt/homebrew/lib","-lSDL2"])]
        ),
	.target(
	    name: "LVGL",
	    dependencies: [
		"CLVGL",
		"AsyncExtensions",
		.product(name: "AsyncAlgorithms", package: "swift-async-algorithms"),
                //.product(name: "FoundationPreview", package: "swift-foundation", condition: .when(platforms: [.linux])),
	    ]
	),
        .executableTarget(
            name: "LVGLDemo",
            dependencies: ["LVGL"]
        )
    ]
)    
