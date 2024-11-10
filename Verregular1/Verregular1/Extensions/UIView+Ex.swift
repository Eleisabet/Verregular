//
//  UIView+Ex.swift
//  Verregular1
//
//  Created by Elizaveta Potapova on 11/7/24.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { view in
            addSubview(view)
        }
    }
}
