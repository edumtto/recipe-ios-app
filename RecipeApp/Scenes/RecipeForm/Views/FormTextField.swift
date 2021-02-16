//
//  FormTextField.swift
//  RecipeApp
//
//  Created by PicPay Eduardo on 10/02/21.
//

import Foundation
import UIKit

final class FormTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureStyle() {
        backgroundColor = .white
        layer.cornerRadius = 8
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
        borderStyle = .roundedRect
    }
}
