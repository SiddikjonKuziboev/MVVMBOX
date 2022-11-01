//
//  UIWindow.swift
//  Box
//
//  Created by Kuziboev Siddikjon on 11/1/22.
//


import UIKit.UIWindow

extension UIWindow {
    @available(iOS 13.0, *)
    static let keyWindows = UIApplication.shared.windows.filter {$0.isKeyWindow}.first

}

extension UIView {
    
    func addShadow(offset: CGSize, color: CGColor, radius: CGFloat, opacity: Float){
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
        self.layer.shadowColor = color
    }
    
    func addBorder(borderWidth: CGFloat = 1, color: CGColor = UIColor.black.cgColor, radius: CGFloat = 0){
        self.layer.borderColor = color
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = radius
    }
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }
}
