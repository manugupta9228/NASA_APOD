# NASA_APOD

1. [Getting Started](#getting-started)
1. [Common Libraries](#common-libraries)
1. [Architecture](#architecture)
1. [Stores](#stores)
1. [Assets](#assets)
1. [Coding Style](#coding-style)

## Getting Started

### Human Interface Guidelines

Apple's [Human Interface Guidelines][ios-hig] standards have been followed.

[ios-hig]: https://developer.apple.com/ios/human-interface-guidelines/

### Xcode

[Xcode][xcode] is the IDE used for development, Version 13.2.1 (13C100).

To install, simply download [Xcode on the Mac App Store][xcode-app-store]. It comes with the newest SDK and simulators, and you can install more stuff under _Preferences > Downloads_.

[xcode]: https://developer.apple.com/xcode/

### Project Setup

A single App is build using the storyboard interface and works only in Portrait mode.
UI is developed using the Storyboards/Xibs
MVVM design pattern has been used



### Dependency Management

#### CocoaPods

Cocoapods is used as a Dependency Manager. Install it like so:

    sudo gem install cocoapods

This creates a Podfile, which will hold all your dependencies in one place. After adding your dependencies to the Podfile, you run

    pod install 

Note that from now on, you'll need to open the `.xcworkspace` file instead of `.xcproject`, or your code will not compile. The command

    pod update

will update all pods to the newest versions permitted by the Podfile. You can use a wealth of [operators][cocoapods-pod-syntax] to specify your exact version requirements.

[cocoapods]: https://cocoapods.org/

### Project Structure

For the project Structure using MVVM and Core Data for offline storage:

    ├─ Models
    ├─ Views (Controllers)
    ├─ ViewModels
    ├─ Common
    ├─ Services

## Common Libraries

    |-- Alamofire

### Alamofire

The majority of iOS developers use one of these network libraries. While `NSURLSession` is surprisingly powerful by itself, [Alamofire][alamofire-github] remain unbeaten when it comes to actually managing queues of requests, which is pretty much a requirement of any modern app. We recommend AFNetworking for Objective-C projects and Alamofire for Swift projects. While the two frameworks have subtle differences, they share the same ideology and are published by the same foundation.

[alamofire-github]: https://github.com/Alamofire/Alamofire


## Architecture

* [Model-View-ViewModel (MVVM)][mvvm]
    * Motivated by "massive view controllers": MVVM considers `UIViewController` subclasses part of the View and keeps them slim by maintaining all state in the ViewModel.
    * To learn more about it, check out Bob Spryn's [fantastic introduction][sprynthesis-mvvm].

[mvvm]: https://www.objc.io/issues/13-architecture/mvvm/


## Coding Style

### Naming

Apple pays great attention to keeping naming consistent. Adhering to their [coding guidelines for Objective-C][cocoa-coding-guidelines] and [API design guidelines for Swift][swift-api-design-guidelines] makes it much easier for new people to join the project.

[cocoa-coding-guidelines]: https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/CodingGuidelines/CodingGuidelines.html
[swift-api-design-guidelines]: https://swift.org/documentation/api-design-guidelines/
