
import UIKit

class Button: UIButton
{
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //  Cài màu cho chữ
        setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        
        //  Bo tròn
        layer.cornerRadius = 15
        
        //  Viền
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
}
