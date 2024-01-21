//
//  BaseCollectionReusableView.swift
//  home
//
//  Created by 반성준 on 1/21/24.
//

import UIKit

class BaseCollectionReusableView: UICollectionReusableView {
    public class var reuseIdentifier: String { "\(self).identifier" }
    
    func prepare() {
        backgroundColor = .clear
    }
    
    func configureSubviews() { }
    
    func configureConstraints() { }
    
    func bindEvents() { }
    
    func update() { }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        prepare()
        
        configureSubviews()
        configureConstraints()
        
        bindEvents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
