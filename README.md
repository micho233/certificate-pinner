# CertificatePinner

CertificatePinner is a helper library for SSL pinning written in swift.

# Features

 - [x] Public key pinning
 - [ ] Certificate file pinning

# Installation
The CertificatePinner library is available to install using SPM, Cocoapods and Carthage dependency manager.
### SPM
The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. 

Once you have your Swift package set up, adding CertificatePinner as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.
```swift
dependencies: [
    .package(url: "https://github.com/micho233/certificate-pinner.git", .upToNextMajor(from: "1.0.0"))
]
```
### Cocoapods
[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate CertificatePinner into your Xcode project using CocoaPods, specify it in your `Podfile`:
```ruby
pod 'CertificatePinner'
```
### Carthage
[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks. To integrate CertificatePinner into your Xcode project using Carthage, specify it in your `Cartfile`:
```ruby
github "micho233/certificate-pinner"
```

# Usage

CertificatePinner provides an elegant way for certificate pinning (for now only public key pinning) in order to prevent man-in-the-middle attack.

### Usage with URLSession
CertificatePinner class can be declared anywhere in your networking class, or provided by data source.

```swift
var pinner = CertificatePinner(pins: ["PublicKeyhash", "AnyOtherPublicKeyHash"])
```
#### iOS13+
```swift
func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge) async -> (URLSession.AuthChallengeDisposition, URLCredential?) {
    return await pinner.checkCertificateValidity(for: challenge)
}
```

#### iOS9+
```swift
func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
    pinner.checkCertificateValidity(for: challenge, completion: completionHandler)
}
```
