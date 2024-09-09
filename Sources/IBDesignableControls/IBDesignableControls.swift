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
    private struct AssociatedKeys {
        static var topLeftRadius: CGFloat = 0
        static var topRightRadius: CGFloat = 0
        static var bottomLeftRadius: CGFloat = 0
        static var bottomRightRadius: CGFloat = 0
    }
    
    private var _topLeftRadius: CGFloat {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.topLeftRadius) as? CGFloat ?? 0 }
        set { objc_setAssociatedObject(self, &AssociatedKeys.topLeftRadius, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    private var _topRightRadius: CGFloat {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.topRightRadius) as? CGFloat ?? 0 }
        set { objc_setAssociatedObject(self, &AssociatedKeys.topRightRadius, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    private var _bottomLeftRadius: CGFloat {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.bottomLeftRadius) as? CGFloat ?? 0 }
        set { objc_setAssociatedObject(self, &AssociatedKeys.bottomLeftRadius, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    private var _bottomRightRadius: CGFloat {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.bottomRightRadius) as? CGFloat ?? 0 }
        set { objc_setAssociatedObject(self, &AssociatedKeys.bottomRightRadius, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
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
}
