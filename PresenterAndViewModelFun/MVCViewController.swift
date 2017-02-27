import UIKit

// MARK: -

class MVCViewController: UIViewController,
    CrementingViewDelegate
{
    // MARK: - Outlets
    
    @IBOutlet private var crementingView: CrementingView!
    @IBOutlet private var messageLabel: UILabel!
    
    // MARK: - Stored Properties
    
    private var crementingNumber: CrementingNumber?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCrementingView()
        
        loadLastSelectedCrementingNumberFromDataLayer()
        updateViews()
    }
    
    // MARK: - Setting Up Views
    
    private func setupCrementingView() {
        crementingView.delegate = self
    }
    
    // MARK: - Updating Views
    
    private func updateViews() {
        updateCrementingView()
        updateMessageLabel()
    }
    
    private func updateCrementingView() {
        let valueLabelText = crementingNumber?.value.description ?? "###"
        crementingView.valueLabel.text = valueLabelText
    }
    
    private func updateMessageLabel() {
        if isCurrentCrementingNumberInFibonacciSequence {
            messageLabel.text = "Fibonacci!"
        } else {
            messageLabel.text = nil
        }
    }
    
    // MARK: - Loading Data
    
    private func loadLastSelectedCrementingNumberFromDataLayer() {
        crementingNumber = DataLayer.singleton.lastSelectedCrementingNumber
    }
    
    // MARK: - Saving Data
    
    private func saveCrementingNumberToDataLayer() {
        guard let crementingNumber = self.crementingNumber else { return }
        DataLayer.singleton.save(crementingNumber)
    }
    
    // MARK: - Handling User Events
    
    func crementingViewDidTapDecrement(_ crementingView: CrementingView) {
        decrementCrementingNumber()
        updateViews()
        saveCrementingNumberToDataLayer()
    }
    
    func crementingViewDidTapIncrement(_ crementingView: CrementingView) {
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
