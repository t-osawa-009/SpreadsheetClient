import Foundation

struct Extension<Base> {
    public let base: Base
    public init (_ base: Base) {
        self.base = base
    }
}

protocol ExtensionCompatible {
    associatedtype Compatible
    static var ex: Extension<Compatible>.Type { get }
    var ex: Extension<Compatible> { get }
}

extension ExtensionCompatible {
    static var ex: Extension<Self>.Type {
        return Extension<Self>.self
    }

    var ex: Extension<Self> {
        return Extension(self)
    }
}
