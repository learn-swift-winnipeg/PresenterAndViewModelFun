import UIKit
import DesignedInXibAndNestableInOtherXibs

protocol CrementingViewDelegate: class {
    func crementingViewDidTapDecrement(_ crementingView: CrementingView)
    func crementingViewDidTapIncrement(_ crementingView: CrementingView)
}

@IBDesignable
class CrementingView: UIView, DesignedInXibAndNestableInOtherXibsViewProtocol {
    
    // MARK: - Outlets
    
    @IBOutlet var valueLabel: UILabel!
    
    // MARK: - Stored Properties
    
    weak var delegate: CrementingViewDelegate?
    var viewFromXib: UIView!
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViewFromXib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupViewFromXib()
    }
    
    // MARK: - Actions
    
    @IBAction func decrementTapped(_ sender: Any) {
        delegate?.crementingViewDidTapDecrement(self)
    }
    
    @IBAction func incrementTapped(_ sender: Any) {
        delegate?.crementingViewDidTapIncrement(self)
    }
}
