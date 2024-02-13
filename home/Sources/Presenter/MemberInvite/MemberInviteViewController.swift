//
//  MemberInviteViewController.swift
//  home
//
//  Created by 반성준 on 1/21/24.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

final class MemberInviteViewController: BaseViewController {
    
    // MARK: - Property
    
    private let disposeBag = DisposeBag()
    
    private var newMemberIds: [String] {
        self.newUserIdTextFieldStackView.arrangedSubviews
            .compactMap { ($0 as? TextField)?.text }
    }
    
    // MARK: - View
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        
        let baseAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.sfProDisplay(size: 27)]
        
        let attributedText = NSMutableAttributedString(string: "초대할 팀원의 아이디를\n입력해 주세요.", attributes: baseAttributes)
        
        attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedText.length))
        
        // FIXME: - 한글 지원 폰트 필요
        attributedText.addAttribute(.font, value: UIFont.sfProDisplay(size: 27, weight: .semiBold), range: NSRange(location: 0, length: 6))
        
        attributedText.addAttribute(.font, value: UIFont.sfProDisplay(size: 27, weight: .semiBold), range: NSRange(location: 8, length: 3))
        
        label.attributedText = attributedText
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    private var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon_left"), for: .normal)
        return button
    }()
    
    private lazy var scrollView: UIScrollView = {
        UIScrollView()
    }()
    
    private var containerView: UIView = {
        UIView()
    }()
    
    private var myProfileLabel: UILabel = {
        let label = UILabel()
        label.text = "내 프로필"
        label.font = .sfProDisplay(size: 14, weight: .semiBold)
        label.textColor = UIColor(hexCode: "33315B")
        return label
    }()
    
    private var completeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "Primary color")
        button.setTitle("초대 보내기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        
        return button
    }()
    
    private lazy var teamNameTextField: TextField = {
        let view = TextField()
        view.placeHolder = "팀 이름"
        
        return view
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "초대할 팀원"
        label.textColor = UIColor(named: "서브 텍스트 1")
        
        return label
    }()
    
    private lazy var newUserIdTextFieldStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 11
        view.addArrangedSubview(TextField("아이디"))
        return view
    }()
    
    private lazy var newTeamButton: NewInviteMemberButton = {
        NewInviteMemberButton()
    }()
    
    // MARK: - UI
    
    override func setUp() {
        super.setUp()
        
        view.backgroundColor = .white
    }
    
    override func initView() {
        super.initView()
        
        containerView.addSubview(backButton)
        containerView.addSubview(titleLabel)
        containerView.addSubview(scrollView)
        
        scrollView.addSubview(newUserIdTextFieldStackView)
        scrollView.addSubview(newTeamButton)
        
        view.addSubview(containerView)
        view.addSubview(completeButton)
    }
    
    override func initConstraint() {
        super.initConstraint()
        
        containerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(completeButton.snp.top).offset(-16)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(20)
            make.width.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view).inset(20)
            make.top.equalTo(backButton.snp.bottom).offset(18)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(26)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        newUserIdTextFieldStackView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.contentLayoutGuide)
            make.leading.trailing.equalTo(view).inset(20)
        }
        
        newTeamButton.snp.makeConstraints { make in
            make.top.equalTo(newUserIdTextFieldStackView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(scrollView.contentLayoutGuide)
        }
        
        completeButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(56)
        }
        
    }
    
    // MARK: - Bind
    
    override func bind() {
        super.bind()
        
        newTeamButton.rx.controlEvent(.touchUpInside)
            .bind(with: self) { owner, _ in
                owner.newUserIdTextFieldStackView.addArrangedSubview(TextField("아이디"))
                owner.scrollView.contentOffset.y = owner.scrollView.contentSize.height
            }
            .disposed(by: disposeBag)
        
        backButton.rx
            .tap
            .bind(with: self) { owner, _ in
                owner.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
        
        completeButton.rx
            .controlEvent(.touchUpInside)
            .bind(with: self) { owner, _ in
                owner.inviteMembers()
            }
            .disposed(by: disposeBag)
    }
    
}

extension MemberInviteViewController {
    func inviteMembers() {
        // FIXME: - InviteMember Logic

        self.navigationController?.popViewController(animated: true)
    }
}
