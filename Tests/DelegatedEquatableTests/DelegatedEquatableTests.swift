import XCTest
@testable import DelegatedEquatable

protocol Foo {
    var type: String { get }
}


class DelegatedEquatableNonOptionalTests: XCTestCase {


    struct FooImp: Foo {
        let type: String
    }


    struct Bar: Equatable {
        var name: String

        @DelegatedEquatable(\.type)
        var type: Foo

        init(name: String,
             type: Foo) {

            self.name = name
            self.type = type

        }
    }

    func testEquatableNonOptionalNotEqual() {
        let left = Bar(name: "Aris", type: FooImp(type: "Football"))
        let right = Bar(name: "Aris", type: FooImp(type: "Basketball"))

        XCTAssertFalse(left == right)
    }

    func testEquatableNonOptionalEqual() {
        let left = Bar(name: "Aris", type: FooImp(type: "Football"))
        let right = Bar(name: "Aris", type: FooImp(type: "Football"))

        XCTAssertEqual(left, right)
    }

}
