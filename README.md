## Overview

This project contains an `iOS` & `iPadOS`  mobile application.

## Development


#### Installation

### Conventions

- We follow the [Swift naming convention for acronyms and initialisms](https://swift.org/documentation/api-design-guidelines/#follow-case-conventions):
  ```swift
  var recordID: String
  var id: String
  var uuid: String
  var documentUUID: String
  var utf8Bytes: [UTF8.CodeUnit]
  var isRepresentableAsASCII = true
  var userSMTPServer: SecureSMTPServer
  ```
- `Bool` properties start with `is`, `are`, `has`, `can`, `should`
- If a protocol exists to abstract the interface of a class (to improve testability), the protocol gets the plain name and the implementing class is prefixed with `Default`, e.g. `LoanDetailsCoordinator` as protocol and `DefaultLoanDetailsCoordinator` as implementation.
- All models should implement the `Hashable` protocol.
- We use `structs` for completely immutable objects.
- If a method takes too many parameters so the invocation does not neatly fit into a single line, we separate every argument onto a new line.
- All designated initializers must be declared without any default values for their parameters.

### Documentation

For information on the documentation syntax, check the following:

- [Official Apple documentation](https://developer.apple.com/library/archive/documentation/Xcode/Reference/xcode_markup_formatting_ref/index.html)
- [List of supported tags](https://developer.apple.com/library/archive/documentation/Xcode/Reference/xcode_markup_formatting_ref/MarkupFunctionality.html#//apple_ref/doc/uid/TP40016497-CH54-SW1)
- [Article on NSHipster](https://nshipster.com/swift-documentation/)

We are using `/** */` for documentation blocks spanning multiple lines and `///` if there's only a single line of documentation.

## Misc
