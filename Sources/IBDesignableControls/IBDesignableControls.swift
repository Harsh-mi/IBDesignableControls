// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit

public extension UIView {
    
    // MARK: Border Properties
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let cgColor = layer.borderColor else { return nil }
            return UIColor(cgColor: cgColor)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    // MARK: Corner Radius Properties
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            updateCorners()
        }
    }
    
    @IBInspectable var topLeftRadius: CGFloat {
        get {
            return _topLeftRadius
        }
        set {
            _topLeftRadius = newValue
            updateCorners()
        }
    }
    
    @IBInspectable var topRightRadius: CGFloat {
        get {
            return _topRightRadius
        }
        set {
            _topRightRadius = newValue
            updateCorners()
        }
    }
    
    @IBInspectable var bottomLeftRadius: CGFloat {
        get {
            return _bottomLeftRadius
        }
        set {
            _bottomLeftRadius = newValue
            updateCorners()
        }
    }
    
    @IBInspectable var bottomRightRadius: CGFloat {
        get {
            return _bottomRightRadius
        }
        set {
            _bottomRightRadius = newValue
            updateCorners()
        }
    }
    
    // MARK: Private Stored Properties for Corner Radius
    private struct AssociatedCornerRadiusKeys {
        static var topLeftRadius: CGFloat = 0
        static var topRightRadius: CGFloat = 0
        static var bottomLeftRadius: CGFloat = 0
        static var bottomRightRadius: CGFloat = 0
    }
    
    private var _topLeftRadius: CGFloat {
        get { return objc_getAssociatedObject(self, &AssociatedCornerRadiusKeys.topLeftRadius) as? CGFloat ?? 0 }
        set { objc_setAssociatedObject(self, &AssociatedCornerRadiusKeys.topLeftRadius, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    private var _topRightRadius: CGFloat {
        get { return objc_getAssociatedObject(self, &AssociatedCornerRadiusKeys.topRightRadius) as? CGFloat ?? 0 }
        set { objc_setAssociatedObject(self, &AssociatedCornerRadiusKeys.topRightRadius, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    private var _bottomLeftRadius: CGFloat {
        get { return objc_getAssociatedObject(self, &AssociatedCornerRadiusKeys.bottomLeftRadius) as? CGFloat ?? 0 }
        set { objc_setAssociatedObject(self, &AssociatedCornerRadiusKeys.bottomLeftRadius, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    private var _bottomRightRadius: CGFloat {
        get { return objc_getAssociatedObject(self, &AssociatedCornerRadiusKeys.bottomRightRadius) as? CGFloat ?? 0 }
        set { objc_setAssociatedObject(self, &AssociatedCornerRadiusKeys.bottomRightRadius, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    // MARK: Update Corner Radius Method
    private func updateCorners() {
        var cornerRadii: CGSize = .zero
        let path: UIBezierPath
        
        if _topLeftRadius > 0 || _topRightRadius > 0 || _bottomLeftRadius > 0 || _bottomRightRadius > 0 {
            // If individual corner radii are set, use UIBezierPath to create the mask
            var corners = UIRectCorner()
            
            if _topLeftRadius > 0 {
                corners.insert(.topLeft)
            }
            if _topRightRadius > 0 {
                corners.insert(.topRight)
            }
            if _bottomLeftRadius > 0 {
                corners.insert(.bottomLeft)
            }
            if _bottomRightRadius > 0 {
                corners.insert(.bottomRight)
            }
            
            cornerRadii = CGSize(width: max(_topLeftRadius, _topRightRadius, _bottomLeftRadius, _bottomRightRadius), height: max(_topLeftRadius, _topRightRadius, _bottomLeftRadius, _bottomRightRadius))
            
            path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: cornerRadii)
            
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        } else {
            // If no individual corner radii are set, fall back to the default corner radius for all sides
            layer.cornerRadius = cornerRadius
            layer.mask = nil
        }
    }
    
    // MARK: - Shadow Properties
    @IBInspectable var shadowColor: UIColor? {
        set {
            layer.shadowColor = UIColor.clear.cgColor
            layer.shadowColor = newValue!.cgColor
        }
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor:color)
            }
            else {
                return nil
            }
        }
    }
    
    /* The opacity of the shadow. Defaults to 0. Specifying a value outside the
     * [0,1] range will give undefined results. Animatable. */
    @IBInspectable var shadowOpacity: Float {
        set {
            layer.shadowOpacity = newValue
        }
        get {
            return layer.shadowOpacity
        }
    }
    
    /* The shadow offset. Defaults to (0, -3). Animatable. */
    @IBInspectable var shadowOffset: CGPoint {
        set {
            layer.shadowOffset = CGSize(width: newValue.x, height: newValue.y)
        }
        get {
            return CGPoint(x: layer.shadowOffset.width, y:layer.shadowOffset.height)
        }
    }
    
    /* The blur radius used to create the shadow. Defaults to 3. Animatable. */
    @IBInspectable var shadowRadius: CGFloat {
        set {
            layer.shadowRadius = newValue
        }
        get {
            return layer.shadowRadius
        }
    }
    
    @IBInspectable var shadowTop: Bool {
        get {
            return _shadowTop
        }
        set {
            _shadowTop = newValue
            updateShadow()
        }
    }
    
    @IBInspectable var shadowBottom: Bool {
        get {
            return _shadowBottom
        }
        set {
            _shadowBottom = newValue
            updateShadow()
        }
    }
    
    // MARK: - Private Properties
    private struct AssociatedShadowKeys {
        static var shadowTop: Bool = false
        static var shadowBottom: Bool = false
    }
    
    private var _shadowTop: Bool {
        get { return objc_getAssociatedObject(self, &AssociatedShadowKeys.shadowTop) as? Bool ?? false }
        set { objc_setAssociatedObject(self, &AssociatedShadowKeys.shadowTop, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    private var _shadowBottom: Bool {
        get { return objc_getAssociatedObject(self, &AssociatedShadowKeys.shadowBottom) as? Bool ?? false }
        set { objc_setAssociatedObject(self, &AssociatedShadowKeys.shadowBottom, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    // MARK: - Update Shadow Method
    private func updateShadow() {
        
        let shadowPath = UIBezierPath()
        
        if shadowTop {
            // Top shadow: create a shadow path from the top-left to top-right
            shadowPath.move(to: CGPoint(x: 0, y: 0)) // Start at the top-left corner
            shadowPath.addLine(to: CGPoint(x: bounds.width, y: 0)) // Top-right corner
            shadowPath.addLine(to: CGPoint(x: bounds.width, y: shadowRadius)) // Extend the shadow below the top
            shadowPath.addLine(to: CGPoint(x: 0, y: shadowRadius)) // Back to the left
            shadowPath.close()
        }
        if shadowBottom {
            // Bottom shadow: create a shadow path from the bottom-left to bottom-right
            shadowPath.move(to: CGPoint(x: 0, y: bounds.height)) // Start at the bottom-left corner
            shadowPath.addLine(to: CGPoint(x: bounds.width, y: bounds.height)) // Bottom-right corner
            shadowPath.addLine(to: CGPoint(x: bounds.width, y: bounds.height - shadowRadius)) // Move shadow upward
            shadowPath.addLine(to: CGPoint(x: 0, y: bounds.height - shadowRadius)) // Back to left-bottom corner
            shadowPath.close()
        }
        
        layer.shadowPath = shadowPath.cgPath
        layer.masksToBounds = false // Allow shadow to extend beyond the view's bounds
    }
}
