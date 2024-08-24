//
//  TSButton.swift
//  TimeSync
//
//  Created by Lee Sangoroh on 24/08/2024.
//

import UIKit

class TSButton: UIButton {

    //override the initializer only when customizing the default
    override init(frame: CGRect) {
        super.init(frame: frame)
        ///custom code
        
    }
    
    ///required when initializing button via storyboard
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    
    private func configure(){
        layer.cornerRadius = 10
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }

}
