//
//  IconComponent.swift
//  home
//
//  Created by 반성준 on 1/19/24.
//

import UIKit

class IconComponent: BaseView {
    
    // MARK: - Property
    
    var imageName: String? {
        didSet { update() }
    }
    
    var bgColor: UIColor? {
        didSet { update() }
    }
    
    var imageSize: CGFloat = 22
    var containerSize: CGFloat = 44
    
    var isChecked: Bool = false {
        didSet {
            iconContainerView.layer.borderWidth = isChecked ? 2 : 0
        }
    }
    
    var isDisabled: Bool = false {
        didSet {
            dimmedView.isHidden = !isDisabled
        }
    }
    
    // MARK: - View
    
    private lazy var iconContainerView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor(named: "Point")?.cgColor
        view.layer.cornerRadius = containerSize / 2
        view.layer.masksToBounds = true
        return view
    }()
    
    private var iconView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "icon_my"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: "000B69", alpha: 0.4)
        view.isHidden = true
        return view
    }()
    
    // MARK: - Init
    
    convenience init(imageName: String = "icon_my",
                     bgColor: UIColor,
                     imageSize: CGFloat = 22,
                     containerSize: CGFloat = 44) {
        defer {
            self.imageSize = imageSize
            self.containerSize = containerSize
            self.imageName = imageName
            self.bgColor = bgColor
        }
        
        self.init(frame: .zero)
    }
    
    // MARK: - UI
    
    override func configureSubviews() {
        super.configureSubviews()
        
        addSubview(iconContainerView)
        iconContainerView.addSubview(iconView)
        iconContainerView.addSubview(dimmedView)
    }
    
    override func configureConstraints() {
        super.configureConstraints()
        self.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(iconContainerView)
        }
        
        iconContainerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.width.height.equalTo(containerSize)
        }
        
        dimmedView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        iconView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(imageSize)
        }
    }
    
    // MARK: - Bind
    
    override func update() {
        super.update()
        
        if let imageName {
            iconContainerView.backgroundColor = bgColor
            iconView.image = UIImage(named: imageName)
        }
    
        iconContainerView.layer.cornerRadius = containerSize/2
        iconContainerView.snp.removeConstraints()
        iconContainerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.width.height.equalTo(containerSize)
        }
        
        iconView.snp.removeConstraints()
        iconView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(imageSize)
        }
    }
}

