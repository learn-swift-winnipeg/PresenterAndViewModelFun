import Foundation

// MARK: - FibonacciSequence

struct FibonacciSequence {
    
    // MARK: - Stored Properties
    
    fileprivate let contents: [Int] = FibonacciSequence.makeFibonacciSequence()
    
    // MARK: - Static
    
    private static func makeFibonacciSequence() -> Array<Int> {
        let negativeFibonacciSequence = sequence(
            state: (-1, -1),
            next: { (state: inout (Int, Int)) -> Int? in
                let (n1, n2) = state
                if n1 > 0 { return nil }
                state = (n2, n1 &+ n2)
                
                return n1
            }
        )
        
        let positiveFibonacciSequence = sequence(
            state: (0, 1),
            next: { (state: inout (Int, Int)) -> Int? in
                let (n1, n2) = state
                if n1 < 0 { return nil }
                state = (n2, n1 &+ n2)
                
                return n1
            }
        )
        
        return Array(negativeFibonacciSequence).reversed() + Array(positiveFibonacciSequence)
    }
}

// MARK: - CustomStringConvertible

extension FibonacciSequence: CustomStringConvertible {
    var description: String {
        return contents.description
    }
}

// MARK: - Sequence

extension FibonacciSequence: Sequence {
    typealias Iterator = AnyIterator<Int>
    
    func makeIterator() -> Iterator {
        var iterator = contents.makeIterator()
        return AnyIterator { iterator.next() }
    }
}

// MARK: - BidirectionalCollection

extension FibonacciSequence: BidirectionalCollection {
    typealias Index = Int
    
    var startIndex: Index { return contents.startIndex }
    var endIndex: Index { return contents.endIndex }
    
    subscript (position: Index) -> Iterator.Element {
        return contents[position]
    }
    
    func index(after i: Index) -> Index {
        return contents.index(after: i)
    }
    
    func index(before i: Index) -> Index {
        return contents.index(before: i)
    }
}
