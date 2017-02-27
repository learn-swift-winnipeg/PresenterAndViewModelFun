import UIKit
import DesignedInXibAndNestableInOtherXibs

@IBDesignable
class CrementerControl: UIControl, DesignedInXibAndNestableInOtherXibsViewProtocol {
    var viewFromXib: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViewFromXib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupViewFromXib()
    }
}
