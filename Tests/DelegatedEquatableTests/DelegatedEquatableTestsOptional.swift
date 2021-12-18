import XCTest
@testable import DelegatedEquatable

protocol OptionalFoo {
    var type: String? { get }
}

class DelegatedEquatableNonOptionalTestsOptional: XCTestCase {

    struct FooImp: OptionalFoo {
        let type: String?
    }


    struct Bar: Equatable {
        var name: String

        @DelegatedEquatable(\.?.type)
        var type: OptionalFoo?

        init(name: String,
             type: OptionalFoo?) {

            self.name = name
            self.type = type

        }
    }

    struct BarNotNil: Equatable {
        var name: String

        @DelegatedEquatable(\.?.type, false)
        var type: OptionalFoo?

        init(name: String,
             type: OptionalFoo?) {

            self.name = name
            self.type = type

        }
    }

    func testEquatableOptionalNotEqual() {
        let left = Bar(name: "Aris", type: FooImp(type: "Football"))
        let right = Bar(name: "Aris", type: nil)

        XCTAssertFalse(left == right)
    }

    func testEquatableOptionalEqual() {
        let left = Bar(name: "Aris", type: FooImp(type: "Football"))
        let right = Bar(name: "Aris", type: FooImp(type: "Football"))

        XCTAssertEqual(left, right)
    }

    func testEquatableOptionalNotEqualWrappedNil() {
        let left = Bar(name: "Aris", type: nil)
        let right = Bar(name: "Aris", type: FooImp(type: nil))

        XCTAssertNotEqual(left, right)
    }

    func testEquatableOptionalEqualBothNil() {
        let left = Bar(name: "Aris", type: nil)
        let right = Bar(name: "Aris", type: nil)

        XCTAssertEqual(left, right)
    }

    func testEquatableOptionalNotEqualBothNil() {
        let left = BarNotNil(name: "Aris", type: nil)
        let right = BarNotNil(name: "Aris", type: nil)

        XCTAssertNotEqual(left, right)
    }

}
