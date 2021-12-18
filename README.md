# DelegatedEquatable

A property wrapper that allows to delegate the Equatable implementation in one of the object's (Equatable conforming) properties.
This delegation allows the automatic Equatable conformance synthesis without manually implementing `==` even though one of the properties does not itself conform to Equatable.

Usage of this should be done with care and only when the use case fits the requirements.

### Sample

```
// Non Equatable 
protocol Foo {
    var type: String { get }
}
```

```
struct FooImp: Foo {
    let type: String
}
// Equatable conformance is auto synthesized
struct Bar: Equatable {
    var name: String

    @DelegatedEquatable(\.type) // delegates the equality check to the property type of Foo protocol.
    var type: Foo

// init should be manually implemented
    init(name: String,
         type: Foo) {

        self.name = name
        self.type = type

    }
}
```
