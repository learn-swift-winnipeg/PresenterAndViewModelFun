import UIKit

class MVPViewController: UIViewController,
    CrementingViewDelegate,
    PresenterView
{
    // MARK: - Outlets
    
    @IBOutlet private var crementingView: CrementingView!
    @IBOutlet private var messageLabel: UILabel!
    
    // MARK: - Stored Properties
    
    /**
     Lazy property instantiation allows use of self because instance is guaranteed to have been created by the time this evaluates. See "Lazy Stored Properties" section in Swift Programming Language: https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/Properties.html#//apple_ref/doc/uid/TP40014097-CH14-ID257
     */
    private lazy var presenter: Presenter = {
        return Presenter(
            dataLayer: DataLayerSingleton.instance,
            view: self
        )
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCrementingView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.updateViews()
    }
    
    // MARK: - Setting Up Views
    
    private func setupCrementingView() {
        crementingView.delegate = self
    }
    
    // MARK: - Updating Views
    
    func updateCrementingView(with valueLabelText: String) {
        crementingView.valueLabel.text = valueLabelText
    }
    
    func updateMessageLabel(with messageLabelText: String?) {
        messageLabel.text = messageLabelText
    }
    
    // MARK: - Handling User Events
    
    func crementingViewDidTapDecrement(_ crementingView: CrementingView) {
        presenter.crementingViewDidTapDecrement()
    }
    
    func crementingViewDidTapIncrement(_ crementingView: CrementingView) {
        presenter.crementingViewDidTapIncrement()
    }
}
