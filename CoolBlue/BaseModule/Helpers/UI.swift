//
//  UI.swift
//  CoolBlue
//
//  Created by Amr Hossam on 1/11/20.
//  Copyright © 2020 Amr Hossam. All rights reserved.
//

import UIKit

let appColor = UIColor.hex("0090E3")
func appFont(_ size: CGFloat) -> UIFont {
    return UIFont.boldSystemFont(ofSize: size)
}

class CustomNav: UINavigationBar {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        titleTextAttributes = [NSAttributedString.Key.font: appFont(17), NSAttributedString.Key.foregroundColor: UIColor.white]
        setBackgroundImage(UIImage(), for: .default)
        isTranslucent = false
        shadowImage = UIImage()
    }
}

public extension UIColor {
    class func hex(_ hexString: String) -> UIColor {
        let hexInt = Int(hexString, radix: 16)
        if let hex = hexInt {
            let components = (
                R: CGFloat((hex >> 16) & 0xff) / 255,
                G: CGFloat((hex >> 08) & 0xff) / 255,
                B: CGFloat((hex >> 00) & 0xff) / 255
            )
            return UIColor(red: components.R, green: components.G, blue: components.B, alpha: 1)
        } else {
            return .black
        }
    }
}

public extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        
        set {
            layer.cornerRadius = newValue
        }
    }
    @IBInspectable var BorderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        
        set {
            layer.borderWidth = newValue
        }
    }
    @IBInspectable var BorderColor: UIColor? {
        get {
            return layer.borderColor != nil ? UIColor(cgColor: layer.borderColor!) : nil
        }
        
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        
        set {
            layer.shadowRadius = newValue
        }
    }
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        
        set {
            layer.shadowOpacity = newValue
        }
    }
    @IBInspectable var shadowColor: UIColor? {
        get {
            return layer.shadowColor != nil ? UIColor(cgColor: layer.shadowColor!) : nil
        }
        
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        
        set {
            layer.shadowOffset = newValue
        }
    }
    @IBInspectable var zPosition: CGFloat {
        get {
            return layer.zPosition
        }
        
        set {
            layer.zPosition = newValue
        }
    }
}

func showAlert(_ msg:String) {
    var title = ""
    if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
        if let infoDict = NSDictionary(contentsOfFile: path),
            let appTitle = infoDict["CFBundleDisplayName"] as? String {
            title = appTitle
        }
    }
    DispatchQueue.main.async {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        alert.show()
    }
}

extension UIAlertController {
    open override func awakeFromNib() {
        super.awakeFromNib()
        //view.tintColor = appColor
    }
    
    func show() {
        DispatchQueue.main.async {
            self.present(animated: true) {
                self.view.tintColor = appColor
            }
        }
    }
    
    func present(animated: Bool, completion: (() -> Void)?) {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            topController.present(self, animated: animated, completion: completion)
        }
    }
}
