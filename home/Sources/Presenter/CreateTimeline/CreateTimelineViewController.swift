//
//  CreateTimelineViewController.swift
//  home
//
//  Created by 오연서 on 2/14/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class CreateTimelineViewController: BaseViewController {
    
    // MARK: - Property
    
    private let disposeBag = DisposeBag()
    
    // MARK: - View
    
    lazy var backButton: UIButton = {
        let button = UIButton(primaryAction: UIAction(handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        button.setImage(UIImage(named: "icon_left"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "새로운 타임라인을\n만들어보세요."
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 27)
        return label
    }()
    
    private var timelineLabel: UILabel = {
        let label = UILabel()
        label.text = "타임라인 이름"
        label.font = .sfProDisplay(size: 14, weight: .semiBold)
        label.textColor = UIColor(hexCode: "33315B")
        return label
    }()
    
    private lazy var timelineTextField: TextField = {
        let view = TextField()
        view.placeHolder = "타임라인 이름"
        return view
    }()
    
    private var doneButton: DoneButton = {
        let view = DoneButton()
        view.isHidden = true
        return view
    }()
    
    
    // MARK: - Bind

    override func bind() {
        super.bind()
        
        timelineTextField.textObservable
            .map { text in
                if let text = text, !text.isEmpty {
                    return false
                } else {
                    return true
                }
            }            .bind(to: doneButton.rx.isHidden)
            .disposed(by: disposeBag)
    }
    
    
    // MARK: - UI
    
    override func setUp() {
        super.setUp()
        view.backgroundColor = .white
    }
    
    override func initView() {
        super.initView()
        [backButton, titleLabel,timelineLabel, timelineTextField, doneButton].forEach { view in
            self.view.addSubview(view)
        }
        
    }
    
    override func initConstraint() {
        super.initConstraint()
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.leading.equalToSuperview().inset(20)
            make.width.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(30)
        }

        timelineLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
        }
        
        timelineTextField.snp.makeConstraints { make in
            make.top.equalTo(timelineLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        doneButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }
}
