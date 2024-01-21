//
//  TeamSpaceViewController+TeamMemberStackView.swift
//  home
//
//  Created by 반성준 on 1/19/24.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

extension TeamSpaceViewController {
    final class TeamMemberStackView: BaseView {
        
        // MARK: - Property
        
        private var members: [User] = [] {
            didSet {
                update()
            }
        }
        private let disposeBag = DisposeBag()
        
        // MARK: - View
        
        private var mainContainer: UIView = {
           UIView()
        }()
        
        private var scrollView: UIScrollView = {
            let scrollView = UIScrollView()
            scrollView.showsHorizontalScrollIndicator = false
            return scrollView
        }()
        
        private var stackView: UIStackView = {
           let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.distribution = .fill
            stackView.spacing = 20
            return stackView
        }()
        
        private var dividerView: UIView = {
           let view = UIView()
            view.backgroundColor = UIColor(hexCode: "E8E8E8")
            return view
        }()
        
        var addMemberButton: IconControlComponent = {
            IconControlComponent(imageName: "icon_team_plus",
                          bgColor: UIColor(hexCode: "E8E8E8"),
                          imageSize: 33.6,
                          containerSize: 44)
        }()
        
        // MARK: Init
        
        convenience init(members: [User]) {
            defer {
                self.members = members
            }
            
            self.init()
        }
        
        // MARK: - UI
        
        override func prepare() {
            super.prepare()
            
        }
        
        override func configureSubviews() {
            super.configureSubviews()
            
            addSubview(mainContainer)
            mainContainer.addSubview(scrollView)
            mainContainer.addSubview(dividerView)
            mainContainer.addSubview(addMemberButton)
            scrollView.addSubview(stackView)
        }
        
        override func configureConstraints() {
            super.configureConstraints()
            
            self.snp.makeConstraints { make in
                make.bottom.equalTo(mainContainer)
            }
            
            mainContainer.snp.makeConstraints { make in
                make.top.leading.trailing.equalToSuperview()
                make.height.equalTo(stackView)
            }
            
            scrollView.snp.makeConstraints { make in
                make.height.equalTo(stackView)
                make.top.leading.equalToSuperview()
                make.trailing.equalTo(dividerView.snp.leading).offset(-7)
            }
            
            stackView.snp.makeConstraints { make in
                make.top.leading.trailing.bottom.equalTo(scrollView.contentLayoutGuide)
            }
            
            dividerView.snp.makeConstraints { make in
                make.trailing.equalTo(addMemberButton.snp.leading).offset(-7)
                make.width.equalTo(1)
                make.top.bottom.equalTo(addMemberButton)
            }
            
            addMemberButton.snp.makeConstraints { make in
                make.top.trailing.equalToSuperview()
            }
        }
        
        // MARK: - Bind
        
        override func update() {
            super.update()
            
            self.stackView.arrangedSubviews
                .forEach { stackView.removeArrangedSubview($0)}
            members.forEach { user in
                stackView.addArrangedSubview(UserIconView(user: user))
            }
        }
    }
}
