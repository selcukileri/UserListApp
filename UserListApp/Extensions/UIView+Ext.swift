//
//  UIView+Ext.swift
//  UserListApp
//
//  Created by Selçuk İleri on 29.01.2025.
//

import UIKit

/// Birden fazla subview'ları tek seferde eklemek için kullandığım extension.
/// Kullanmaktaki genel amacım kod tekrarını azaltmak ve temiz, okunabilir bir yapı oluşturmak.
extension UIView {
    func addSubviews(_ views: UIView...){
        for view in views { addSubview(view) }
    }
}
