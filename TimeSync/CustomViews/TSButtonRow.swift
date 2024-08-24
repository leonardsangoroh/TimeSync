//
//  TSButtonRow.swift
//  TimeSync
//
//  Created by Lee Sangoroh on 24/08/2024.
//

import UIKit

class TSButtonRow: UIView {
    let call = TSRowButtonItem(image: UIImage(systemName: "phone")!, title: "Call")
    let text = TSRowButtonItem(image: UIImage(systemName: "message")!, title: "Text")
    let mail = TSRowButtonItem(image: UIImage(systemName: "tray.and.arrow.up")!, title: "Mail")
    let meet = TSRowButtonItem(image: UIImage(systemName: "video")!, title: "Meet")
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureTSButtonRow()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureTSButtonRow() {
        
        self.addSubview(call)
        self.addSubview(text)
        self.addSubview(mail)
        self.addSubview(meet)
        
        call.translatesAutoresizingMaskIntoConstraints = false
        text.translatesAutoresizingMaskIntoConstraints = false
        mail.translatesAutoresizingMaskIntoConstraints = false
        meet.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            call.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            call.topAnchor.constraint(equalTo: self.topAnchor),
            call.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            text.leadingAnchor.constraint(equalTo: call.trailingAnchor),
            text.topAnchor.constraint(equalTo: self.topAnchor),
            text.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            text.widthAnchor.constraint(equalTo: call.widthAnchor),
            
            mail.leadingAnchor.constraint(equalTo: text.trailingAnchor),
            mail.topAnchor.constraint(equalTo: self.topAnchor),
            mail.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            mail.widthAnchor.constraint(equalTo: call.widthAnchor),
            
            meet.leadingAnchor.constraint(equalTo: mail.trailingAnchor),
            meet.topAnchor.constraint(equalTo: self.topAnchor),
            meet.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            meet.widthAnchor.constraint(equalTo: call.widthAnchor),
            meet.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            
        ])
    }
    
    
}
