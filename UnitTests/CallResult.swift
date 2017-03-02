import Foundation

enum CallResult<T: Equatable> {
    case called(with: T?)
    case notCalled
}

extension CallResult: Equatable {
    static func == (lhs: CallResult, rhs: CallResult) -> Bool {
        switch lhs {
        case .called(let lhsValue):
            switch rhs {
            case .called(let rhsValue): return lhsValue == rhsValue
            default: return false
            }
        case .notCalled:
            switch rhs {
            case .notCalled: return true
            default: return false
            }
        }
    }
}
