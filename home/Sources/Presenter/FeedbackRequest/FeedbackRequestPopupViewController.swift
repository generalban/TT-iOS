//
//  FeedbackRequestPopupViewController.swift
//  home
//
//  Created by 반성준 on 2/4/24.
//

import UIKit

import RxSwift
import RxCocoa

final class FeedbackRequestPopupViewController: BaseViewController {
    // MARK: - Property
    
    var team: [User]! {
        didSet {
            update()
        }
    }
    
    var files: [AttachedItem] = AttachedItem.dummyFiles
    var links: [AttachedItem] = AttachedItem.dummyLinks
    
    private let disposeBag = DisposeBag()
    
    // MARK: - View
    
    private var backgroundView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        return visualEffectView
    }()
    
    private var mainContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .sfProDisplay(size: 14, weight: .semiBold)
        label.textAlignment = .left
        label.text = "리뷰어 설정"
        label.textColor = UIColor(hexCode: "33315B")
        return label
    }()
    
    private var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: "DEDEDE")
        return view
    }()
    
    private lazy var teamCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = .init(width: 44, height: 66)
        layout.minimumInteritemSpacing = 30
        layout.minimumLineSpacing = 18
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UserCell.self)
        return collectionView
    }()
    
    private var fileLabel: UILabel = {
        let label = UILabel()
        label.font = .sfProDisplay(size: 14, weight: .semiBold)
        label.textAlignment = .left
        label.text = "파일 첨부"
        label.textColor = UIColor(hexCode: "33315B")
        return label
    }()
    
    private var fileDividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: "DEDEDE")
        return view
    }()
    
    private var fileDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .sfProDisplay(size: 12)
        label.textAlignment = .left
        label.text = "완료한 작업의 파일이나 링크를 첨부해 주세요."
        label.textColor = UIColor(hexCode: "33315B")
        return label
    }()
    
    private var attachedFileTitleLable: PaddedButton = {
        PaddedButton(text: "첨부 파일",
                     padding: .init(top: 6, left: 20, bottom: 6, right: 20),
                     textColor: .white,
                     backgroundColor: .point)
    }()
    
    private lazy var attachedFileCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = .init(width: 92, height: 24)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ItemCell.self)
        return collectionView
    }()
    
    private var linkTitleLable: PaddedButton = {
        PaddedButton(
            iconText:"🔗",
            text: "링크 첨부",
            padding: .init(top: 6, left: 20, bottom: 6, right: 20),
            textColor: UIColor(hexCode: "33315B"),
            backgroundColor: UIColor(hexCode: "DFE4ED"))
    }()
    
    private lazy var linkCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = .init(width: 92, height: 24)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ItemCell.self)
        return collectionView
    }()
    
    private var sendButton: IconButton = {
        IconButton(text: "피드백 요청 보내기", textColor: UIColor(hexCode: "33315B"))
    }()
    
    private lazy var fileDropDownMenuView: FileDropDownMenuView = {
        let menuView = FileDropDownMenuView()
        menuView.isHidden = true
        menuView.delegate = self
        return menuView
    }()
    
    private lazy var attachLinkView: AttachLinkView = {
        let menuView = AttachLinkView()
        menuView.isHidden = true
        menuView.delegate = self
        return menuView
    }()
    
    // MARK: - UI
    
    override func setUp() {
        super.setUp()
        view.backgroundColor = .clear
    }
    
    override func initView() {
        super.initView()
        
        let mainContainerSubviews: [UIView] = [
            titleLabel,
            dividerView,
            teamCollectionView,
            sendButton,
            fileLabel,
            fileDividerView,
            fileDescriptionLabel,
            attachedFileTitleLable,
            attachedFileCollectionView,
            linkTitleLable,
            linkCollectionView
        ]
        
        mainContainerSubviews.forEach { subview in
            mainContainer.addSubview(subview)
        }
        
        view.addSubview(backgroundView)
        view.addSubview(mainContainer)
        view.addSubview(fileDropDownMenuView)
        view.addSubview(attachLinkView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func initConstraint() {
        backgroundView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        mainContainer.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(sendButton).offset(16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.trailing.equalToSuperview().inset(18)
        }
        
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        teamCollectionView.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(44 * 5 + 18 * 4)
            make.height.equalTo(40)
        }
        
        fileLabel.snp.makeConstraints { make in
            make.top.equalTo(teamCollectionView.snp.bottom).offset(28)
            make.leading.trailing.equalToSuperview().inset(18)
        }
        
        fileDividerView.snp.makeConstraints { make in
            make.top.equalTo(fileLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        fileDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(fileDividerView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(18)
        }
        
        attachedFileTitleLable.snp.makeConstraints { make in
            make.top.equalTo(fileDescriptionLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(18)
            make.trailing.lessThanOrEqualToSuperview().inset(18)
            make.width.equalTo(linkTitleLable)
        }
        
        attachedFileCollectionView.snp.makeConstraints { make in
            make.top.equalTo(attachedFileTitleLable.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(18)
            make.height.equalTo(60)
        }
        
        linkTitleLable.snp.makeConstraints { make in
            make.top.equalTo(attachedFileCollectionView.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(18)
            make.trailing.lessThanOrEqualToSuperview().inset(18)
        }
        
        linkCollectionView.snp.makeConstraints { make in
            make.top.equalTo(linkTitleLable.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(18)
            make.height.equalTo(60)
        }
        
        sendButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(12)
            make.top.equalTo(linkCollectionView.snp.bottom).offset(4)
        }
        
        fileDropDownMenuView.snp.makeConstraints { make in
            make.leading.equalTo(attachedFileTitleLable)
            make.top.equalTo(attachedFileTitleLable.snp.bottom)
        }
        
        attachLinkView.snp.makeConstraints { make in
            make.leading.equalTo(linkTitleLable)
            make.top.equalTo(linkTitleLable.snp.bottom)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let height = teamCollectionView.collectionViewLayout.collectionViewContentSize.height
        teamCollectionView.snp.removeConstraints()
        teamCollectionView.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(44 * 4 + 30 * 3)
            make.height.equalTo(height)
        }
    }
    
    // MARK: - Bind
    
    override func bind() {
        super.bind()
        sendButton.rx
            .controlEvent(.touchUpInside)
            .bind(with: self) { owner, _ in
                owner.sendFeedbackRequest()
            }
            .disposed(by: disposeBag)
        
        attachedFileTitleLable.rx
            .controlEvent(.touchUpInside)
            .bind(with: self) { owner, _ in
                owner.fileDropDownMenuView.isHidden.toggle()
            }
            .disposed(by: disposeBag)
        
        linkTitleLable.rx
            .controlEvent(.touchUpInside)
            .bind(with: self) { owner, _ in
                owner.attachLinkView.isHidden.toggle()
            }
            .disposed(by: disposeBag)
        
    }
    
    func update() {
        
    }
    
    private func sendFeedbackRequest() {
        dismiss(animated: false)
        AlertPopup.present(icon: UIImage(named: "icon_send_fill"),
                           text: "피드백 요청이 전송되었어요!")
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            
            mainContainer.snp.updateConstraints { make in
                make.centerY.equalToSuperview().offset(-keyboardHeight/2)
            }
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        mainContainer.snp.updateConstraints { make in
            make.centerY.equalToSuperview()
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}

extension FeedbackRequestPopupViewController: UICollectionViewDelegate,
                                              UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case teamCollectionView: return team.count
        case attachedFileCollectionView: return files.count
        case linkCollectionView: return links.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case teamCollectionView:
            let cell = UserCell.makeCell(to: collectionView,
                                         indexPath: indexPath,
                                         user: team[indexPath.row])
            return cell
        case attachedFileCollectionView:
            let cell = ItemCell.makeCell(to: collectionView, 
                                         indexPath: indexPath, 
                                         item: files[indexPath.row])
            return cell
        case linkCollectionView:
            let cell = ItemCell.makeCell(to: collectionView,
                                         indexPath: indexPath,
                                         item: links[indexPath.row])
            return cell
        default: return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard collectionView == teamCollectionView else { return }
        guard let cell = collectionView.cellForItem(at: indexPath) as? UserCell,
              !cell.isDisabled else { return }
        cell.isChecked.toggle()
    }
}

extension FeedbackRequestPopupViewController {
    static func present(team: [User]) {
        let viewController = FeedbackRequestPopupViewController()
        viewController.team = team
        viewController.modalPresentationStyle = .overCurrentContext
        let rootVC = UIApplication
            .shared
            .connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .last?.rootViewController as? UINavigationController
        rootVC?.present(viewController, animated: false)
    }
}

extension FeedbackRequestPopupViewController: FileDropDownMenuViewDelegate {
    func selectButton(type: FeedbackRequestPopupViewController.FileDropDownMenuType) {
        switch type {
        case .gallery:
            // FIXME: - 사진 앨범
            break
        case .selectFile:
            // FIXME: - 파일 선택
            break
        case .cancel:
            fileDropDownMenuView.isHidden.toggle()
        }
    }
}

extension FeedbackRequestPopupViewController: AttachLinkViewDelegate {
    func attachLink(link: String) {
        //FIXME: - 링크 처리
        self.links.append(AttachedItem(name: link, type: .link))
        self.linkCollectionView.reloadData()
        attachLinkView.isHidden.toggle()
    }
    
    
}
