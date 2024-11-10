//
//  UIStackView+Ex.swift
//  Verregular1
//
//  Created by Elizaveta Potapova on 11/7/24.
//

import Foundation
import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { view in
            addArrangedSubview(view)
        }
    }
}
