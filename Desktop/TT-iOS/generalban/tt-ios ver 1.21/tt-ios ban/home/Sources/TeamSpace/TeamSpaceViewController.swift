//
//  TeamSpaceViewController.swift
//  home
//
//  Created by 반성준 on 1/20/24.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

final class TeamSpaceViewController: BaseViewController {
    
    // MARK: - Test Data
    typealias User = (name: String, backgroundColor: UIColor)
    
    private var user: User = ("허수민", UIColor(hexCode: "54FFF3"))
    
    private var members: [User] = [("이준영", UIColor(hexCode: "54FFF3")),
                                   ("김두현", UIColor(hexCode: "44FF78")),
                                   ("오연서", UIColor(hexCode: "FF5AF9")),
                                   ("반성준", UIColor(hexCode: "BDE3FF")),
                                   ("김태우", UIColor(hexCode: "E4C1FF")),
                                   ("이준영", UIColor(hexCode: "54FFF3")),
                                   ("김두현", UIColor(hexCode: "44FF78")),
                                   ("오연서", UIColor(hexCode: "FF5AF9")),
                                   ("반성준", UIColor(hexCode: "BDE3FF")),
                                   ("김태우", UIColor(hexCode: "E4C1FF"))]
    
    typealias Project = (projectName: String, projectCardImage: UIImage?)
    
    private var projectList: [Project] = [("프로젝트1", UIImage(named: "card_main")),
                                          ("프로젝트2", UIImage(named: "card_color1")),
                                          ("프로젝트3", UIImage(named: "card_color2"))]
    
    // MARK: - Property
    
    private let disposeBag = DisposeBag()
    
    private var selectedIndexPaths: [IndexPath] {
        self.projectCollectionView
            .indexPathsForSelectedItems?
            .filter { $0.row != 0 } ?? []
    }
    
    private var isProjectEditing: Bool = false
    
    // MARK: - View
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        
        let baseAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.sfProDisplay(size: 27)]
        
        let attributedText = NSMutableAttributedString(string: "Ticket-Taka 팀의\n공간입니다.", attributes: baseAttributes)
        
        attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedText.length))
        
        // FIXME: - 한글 지원 폰트 필요
        attributedText.addAttribute(.font, value: UIFont.sfProDisplay(size: 27, weight: .semiBold), range: NSRange(location: 0, length: 13))
        
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
    
    private var alarmButton: UIImageView = {
        UIImageView(image: UIImage(named: "alarm"))
    }()
    
    private var bannerView: UIView = {
        UIView()
    }()
    
    private var calendarButton: UIImageView = {
        UIImageView(image: UIImage(named: "icon_calendar"))
    }()
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
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
    
    private lazy var myProfileIconView: UserIconView = {
        UserIconView(user: user)
    }()
    
    private var teamMemberLabel: UILabel = {
        let label = UILabel()
        label.text = "참여 팀원"
        label.font = .sfProDisplay(size: 14, weight: .semiBold)
        label.textColor = UIColor(hexCode: "33315B")
        return label
    }()
    
    private lazy var teamMemberStackView: TeamMemberStackView = {
        TeamMemberStackView(members: members)
    }()
    
    private var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: "F6F6F6")
        return view
    }()
    
    private var projectLabel: UILabel = {
       let label = UILabel()
        label.text = "프로젝트"
        label.font = .sfProDisplay(size: 14, weight: .semiBold)
        label.textColor = UIColor(hexCode: "33315B")
        return label
    }()
    
    private var editButton: UIButton = {
       let button = UIButton()
        button.setTitle("편집", for: .normal)
        button.titleLabel?.font = .sfProDisplay(size: 14, weight: .semiBold)
        button.setTitleColor(UIColor(hexCode: "B8BAC0"), for: .normal)
        return button
    }()
    
    private lazy var projectCollectionView: UICollectionView = {
        let width = (UIScreen.main.bounds.size.width - 20 * 3)/2
        let height = width * 1.17
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = .init(width: width, height: height)
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = true
        collectionView.register(ProjectCollectionViewCell.self)
        collectionView.clipsToBounds = false
        return collectionView
    }()
    
    private var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("삭제하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hexCode: "FF002E")
        button.layer.cornerRadius = 10
        button.isHidden = true
        return button
    }()
    
    
    // MARK: - UI
    
    override func setUp() {
        super.setUp()
        
        view.backgroundColor = .white
    }
    
    override func initView() {
        super.initView()
        
        bannerView.addSubview(backButton)
        bannerView.addSubview(alarmButton)
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(calendarButton)
        containerView.addSubview(myProfileLabel)
        containerView.addSubview(myProfileIconView)
        containerView.addSubview(teamMemberLabel)
        containerView.addSubview(teamMemberStackView)
        containerView.addSubview(dividerView)
        containerView.addSubview(projectLabel)
        containerView.addSubview(editButton)
        containerView.addSubview(projectCollectionView)
        
        scrollView.addSubview(containerView)
        
        view.addSubview(scrollView)
        view.addSubview(bannerView)
        view.addSubview(deleteButton)
    }
    
    override func initConstraint() {
        super.initConstraint()
        
        bannerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(backButton)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(20)
            make.width.height.equalTo(24)
        }
        
        alarmButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(12)
            make.trailing.equalToSuperview().inset(20)
            make.size.equalTo(24)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(bannerView.snp.bottom).offset(18)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
            make.height.equalTo(400).priority(.low)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalTo(view).inset(20)
        }
        
        calendarButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel)
            make.trailing.equalToSuperview().inset(20)
            make.size.equalTo(24)
        }
        
        myProfileLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        myProfileIconView.snp.makeConstraints { make in
            make.top.equalTo(myProfileLabel.snp.bottom).offset(12)
            make.leading.equalTo(myProfileLabel)
        }
        
        teamMemberLabel.snp.makeConstraints { make in
            make.top.equalTo(myProfileIconView.snp.bottom).offset(21)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        teamMemberStackView.snp.makeConstraints { make in
            make.top.equalTo(teamMemberLabel.snp.bottom).offset(12)
            make.leading.trailing.equalTo(teamMemberLabel)
        }
        
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(teamMemberStackView.snp.bottom).offset(21)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(11)
            
        }
        
        projectLabel.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
        }
        
        editButton.snp.makeConstraints { make in
            make.centerY.equalTo(projectLabel)
            make.trailing.equalToSuperview().inset(20)
        }
        
        projectCollectionView.snp.makeConstraints { make in
            make.top.equalTo(projectLabel.snp.bottom).offset(15)
            make.height.equalTo(600)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(60)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-14)
            make.height.equalTo(56)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let height = projectCollectionView.collectionViewLayout.collectionViewContentSize.height
        projectCollectionView.snp.removeConstraints()
        projectCollectionView.snp.makeConstraints { make in
            make.top.equalTo(projectLabel.snp.bottom).offset(15)
            make.height.equalTo(height)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(60)
        }
        self.view.layoutIfNeeded()
    }
    
    // MARK: - Bind
    
    override func bind() {
        super.bind()
        backButton.rx
            .tap
            .bind(with: self) { owner, _ in
                owner.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
        
        myProfileIconView.rx
            .controlEvent(.touchUpInside)
            .bind(with: self) { owner, _ in
                owner.presentSelectIconColorViewController()
            }
            .disposed(by: disposeBag)
        
        teamMemberStackView.addMemberButton.rx
            .controlEvent(.touchUpInside)
            .bind(with: self) { owner, _ in
                owner.presentInviteMemberViewController()
            }
            .disposed(by: disposeBag)
    }
    
}

extension TeamSpaceViewController {
    func presentSelectIconColorViewController() {
        let viewController = SelectIconColorViewController(userColor: user.backgroundColor,
                                                           memberColors:members.map{ $0.backgroundColor })
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.delegate = self
        let rootVC = UIApplication
            .shared
            .connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .last?.rootViewController as? UINavigationController
        rootVC?.present(viewController, animated: false)
    }
    
    func presentInviteMemberViewController() {
        let viewController = MemberInviteViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension TeamSpaceViewController: UICollectionViewDelegate,
                                   UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return projectList.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard indexPath.row != 0 else {
            return ProjectCollectionViewCell.makeCell(to: collectionView,
                                                      indexPath: indexPath)
            
        }
        
        let project = projectList[indexPath.row - 1]
        return ProjectCollectionViewCell.makeCell(to: collectionView,
                                                  indexPath: indexPath,
                                                  title: project.projectName,
                                                  cardImage: project.projectCardImage)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cellSelected(collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        cellSelected(collectionView)
    }
    
    func cellSelected(_ collectionView: UICollectionView){
        if !selectedIndexPaths.isEmpty {
            isProjectEditing = true
            deleteButton.isHidden = false
            projectLabel.textColor = UIColor(hexCode: "B8BAC0")
            editButton.setTitleColor(UIColor(hexCode: "33315B"), for: .normal)
        } else {
            isProjectEditing = false
            deleteButton.isHidden = true
            projectLabel.textColor = UIColor(hexCode: "33315B")
            editButton.setTitleColor(UIColor(hexCode: "B8BAC0"), for: .normal)
        }
    }
}

extension TeamSpaceViewController: SelectIconColorViewControllerDelegate {
    func selectIconColor(_ color: UIColor?) {
        user = (user.name, color ?? .point)
        myProfileIconView.user = user
    }
}
