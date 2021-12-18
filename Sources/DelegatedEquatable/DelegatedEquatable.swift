@propertyWrapper
struct DelegatedEquatable<Value, Property: Equatable>: Equatable {

    static func == (lhs: DelegatedEquatable<Value, Property>,
                    rhs: DelegatedEquatable<Value, Property>) -> Bool {
        
        guard lhs.delegateKeypath == rhs.delegateKeypath else {
            return false
        }

        return lhs.wrappedValue[keyPath: lhs.delegateKeypath] == rhs.wrappedValue[keyPath: rhs.delegateKeypath]
    }

    static func == (lhs: DelegatedEquatable<Value?, Property>, rhs: DelegatedEquatable<Value?, Property>) -> Bool {

        if lhs.wrappedValue == nil && rhs.wrappedValue == nil {
            return  lhs.bothNilReturnValue && rhs.bothNilReturnValue
        }

        guard lhs.wrappedValue != nil && rhs.wrappedValue != nil
        else { return false }

        guard lhs.delegateKeypath == rhs.delegateKeypath else {
            return false
        }

        return lhs.wrappedValue[keyPath: lhs.delegateKeypath] == rhs.wrappedValue[keyPath: rhs.delegateKeypath]
    }

    var wrappedValue: Value {
        get {
            value!
        }

        set {
            value = newValue
        }
    }

    private var value: Value?

    var bothNilReturnValue: Bool

    let delegateKeypath: KeyPath<Value, Property>

    init(_ delegateKeyPath: KeyPath<Value, Property>,
         _ bothNilReturnValue: Bool = true) {
        self.delegateKeypath = delegateKeyPath
        self.bothNilReturnValue = bothNilReturnValue
    }
}
