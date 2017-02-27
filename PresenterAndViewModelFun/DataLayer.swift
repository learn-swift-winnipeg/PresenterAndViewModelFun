import Foundation

class DataLayer {
    
    // MARK: Singleton
    
    static let singleton = DataLayer()
    private init() {} // Enforce singleton.
    
    // MARK: - CrementingNumber
    
    private(set) var lastSelectedCrementingNumber: CrementingNumber? {
        get { return CrementingNumber(value: 0, crementBy: 1) }
        set {
            // TODO: Implement.
        }
    }
    
    func save(_ crementingNumber: CrementingNumber) {
        // TODO: Implement.
    }
}
