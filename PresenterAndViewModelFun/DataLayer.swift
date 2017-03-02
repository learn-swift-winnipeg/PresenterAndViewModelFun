import Foundation

protocol DataLayer {
    var lastSelectedCrementingNumber: CrementingNumber? { get }
    func save(_ crementingNumber: CrementingNumber)
}

class DataLayerSingleton: DataLayer {
    
    // MARK: Singleton
    
    static let instance = DataLayerSingleton()
    private init() {} // Enforce singleton.
    
    // MARK: - CrementingNumber
    
    private(set) var lastSelectedCrementingNumber: CrementingNumber? = CrementingNumber(value: 0, crementBy: 1)
    
    func save(_ crementingNumber: CrementingNumber) {
        lastSelectedCrementingNumber = crementingNumber
    }
}
