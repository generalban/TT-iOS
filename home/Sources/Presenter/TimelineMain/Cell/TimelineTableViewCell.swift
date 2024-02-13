//
//  TimelineTableViewCell.swift
//  home
//
//  Created by 오연서 on 2/5/24.
//

import UIKit

import SnapKit
import RxSwift

class TimelineTableViewCell: BaseTableViewCell {
    
    
    // MARK: - Property
    
    private let disposeBag = DisposeBag()
    
    // MARK: - View
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Cool gray 4")
        view.layer.cornerRadius = 10
        return view
    }()

    
    private (set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "타임라인 1"
        label.textColor = UIColor(named: "서브 텍스트 1")
        
        return label
    }()
    
     lazy var rightIconView: UIButton = {
        let view = UIButton()
        
        view.setImage(UIImage(named: "icon_shortcuts"), for: .normal)
        return view
    }()

    // MARK: - UI
    
    override func configureSubviews() {
        super.configureSubviews()
        
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(rightIconView)
    }
    
    override func configureConstraints() {
        super.configureConstraints()
        
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(19)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(containerView.snp.leading).inset(17)
            make.centerY.equalToSuperview()
            
        }
        
        rightIconView.snp.makeConstraints { make in
            make.size.equalTo(30)
            make.trailing.equalTo(containerView.snp.trailing).inset(10)
            make.centerY.equalToSuperview()
        }
    }
}

extension TimelineTableViewCell {
    static func makeCell(to view: UITableView, indexPath: IndexPath) -> TimelineTableViewCell {
        guard let cell = view.dequeueReusableCell(
            withIdentifier: TimelineTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? TimelineTableViewCell else { fatalError("Cell is not registered to view....") }
        
        return cell
    }
}

