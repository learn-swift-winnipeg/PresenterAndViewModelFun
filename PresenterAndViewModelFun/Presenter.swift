import Foundation

// MARK: - PresenterView

protocol PresenterView: class {
    func updateCrementingView(with valueLabelText: String)
    func updateMessageLabel(with messageLabelText: String?)
}

// MARK: - Presenter

class Presenter {
    
    // MARK: - Stored Properties
    
    private let dataLayer: DataLayer
    private var crementingNumber: CrementingNumber?
    
    // NOTE: `weak` reference is important to avoid reference cycle a.k.a. memory leak!
    private weak var view: PresenterView?
    
    // MARK: - Lifecycle
    
    init(dataLayer: DataLayer, view: PresenterView) {
        self.dataLayer = dataLayer
        self.view = view
        
        loadLastSelectedCrementingNumberFromDataLayer()
    }
    
    // MARK: - Loading Data
    
    private func loadLastSelectedCrementingNumberFromDataLayer() {
        crementingNumber = dataLayer.lastSelectedCrementingNumber
    }
    
    // MARK: - Saving Data
    
    private func saveCrementingNumberToDataLayer() {
        guard let crementingNumber = self.crementingNumber else { return }
        dataLayer.save(crementingNumber)
    }
    
    // MARK: - Updating Views
    
    func updateViews() {
        updateCrementingView()
        updateMessageLabel()
    }
    
    private func updateCrementingView() {
        let valueLabelText = crementingNumber?.value.description ?? "###"
        view?.updateCrementingView(with: valueLabelText)
    }
    
    private func updateMessageLabel() {
        let messageLabelText = isCurrentCrementingNumberInFibonacciSequence ? "Fibonacci!" : nil
        view?.updateMessageLabel(with: messageLabelText)
    }
    
    // MARK: - Handling User Events
    
    func crementingViewDidTapDecrement() {
        decrementCrementingNumber()
        updateViews()
        saveCrementingNumberToDataLayer()
    }
    
    func crementingViewDidTapIncrement() {
        incrementCrementingNumber()
        updateViews()
        saveCrementingNumberToDataLayer()
    }
    
    // MARK: - Business Logic
    
    private func decrementCrementingNumber() {
        guard let crementingNumber = self.crementingNumber else {
            // We can't decrement a nil value...
            return
        }
        
        crementingNumber.value -= crementingNumber.crementBy
    }
    
    private func incrementCrementingNumber() {
        guard let crementingNumber = self.crementingNumber else {
            // We can't increment a nil value...
            return
        }
        
        crementingNumber.value += crementingNumber.crementBy
    }
    
    private var isCurrentCrementingNumberInFibonacciSequence: Bool {
        guard let currentValue = crementingNumber?.value else {
            // A nil value is not in the Fibonacci sequence.
            return false
        }
        
        return FibonacciSequence().contains(currentValue)
    }
}
