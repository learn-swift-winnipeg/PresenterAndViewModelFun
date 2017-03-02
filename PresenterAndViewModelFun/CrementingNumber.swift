
// MARK: - CrementingNumber

class CrementingNumber {
    var value: Int
    let crementBy: Int
    
    init(value: Int, crementBy: Int) {
        self.value = value
        self.crementBy = crementBy
    }
}

// MARK: - Equatable

extension CrementingNumber: Equatable {
    static func == (
        lhs: CrementingNumber,
        rhs: CrementingNumber) -> Bool
    {
        return lhs.value == rhs.value &&
            lhs.crementBy == rhs.crementBy
    }
}

