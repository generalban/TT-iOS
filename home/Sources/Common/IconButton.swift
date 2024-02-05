//
//  IconButton.swift
//  home
//
//  Created by 반성준 on 2/4/24.
//

import UIKit

final class IconButton: BaseControl {
    
    var iconSize: CGFloat = 30
    var iconImage: UIImage? {  didSet { update() } }
    var text: String? { didSet { update() } }
    
    // MARK: - View
    
    var container: UIView = {
        UIImageView()
    }()
    
    var textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    
    
    var iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Init
    
    convenience init(icon: UIImage? = UIImage(named: "icon_send_fill"),
                     text: String,
                     textColor: UIColor? = UIColor(named: "33315B"),
                     font: UIFont = UIFont.sfProDisplay(size: 13)) {
        self.init()
        defer {
            self.iconImage = icon
            self.text = text
            self.textLabel.textColor = textColor ?? .black
            self.textLabel.font = font
        }
    }
    
    // MARK: - UI
    
    override func prepare() {
        super.prepare()
        
        clipsToBounds = true
    }
    
    override func configureSubviews() {
        super.configureSubviews()
        addSubview(container)
        container.addSubview(textLabel)
        container.addSubview(iconView)
        
    }
    
    override func configureConstraints() {
        super.configureConstraints()
        
        self.snp.makeConstraints { make in
            make.width.height.equalTo(container)
        }
        
        container.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(iconView)
            make.leading.equalTo(textLabel)
        }
        textLabel.snp.makeConstraints { make in
            make.trailing.equalTo(iconView.snp.leading).offset(-8)
            make.centerY.equalToSuperview()
        }
        iconView.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.size.equalTo(iconSize)
        }
    }
    
    override func update() {
        super.update()
        if iconImage != nil {  iconView.isHidden = false }
        
        self.iconView.image = iconImage
        self.textLabel.text = text
    }
}
