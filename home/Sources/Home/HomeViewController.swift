//
//  HomeViewController.swift
//  home
//
//  Created by 오연서 on 1/14/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class HomeViewController: BaseViewController {
    
    // MARK: - Test Data
    
    private var projects: [Project] = Project.dummy
    private var tickets: [Ticket] = Ticket.dummy
    // private var projects: [Project] = []
    // private var tickets: [Ticket] = []
    
    // MARK: - Property
    
    // MARK: - User 저장시 프로젝트 화면
    // nil 일 경우, 로그인 전 화면
    @UserDefaultsWrapper("user", defaultValue: nil)
    private var user: User?
    
    private var alarmCount: Int = 2
    
    private var isBannerViewHide = false
    
    private let disposeBag = DisposeBag()
    
    
    // MARK: - View
    
    // 배너를 담을 UIView
    private var bannerView: BannerView = {
        let bannerView = BannerView()
        bannerView.setSignInText()
        return bannerView
    }()
    
    private lazy var toolTipView: TooltipView = {
        TooltipView(text: "읽지 않은 알림이 2개 있어요!")
    }()
    
    var alarmContainer: UIView = UIView()
    
    //알람 버튼
    lazy var alarmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "alarm"), for: .normal)
        button.tintColor = UIColor(named: "활성화 테두리")
        return button
    }()
    
    private var mainContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.layer.maskedCorners = CACornerMask([.layerMinXMinYCorner,
                                                 .layerMaxXMinYCorner])
        return view
    }()
    
    // 스크롤을 담당할 UIScrollView
    private lazy var scrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private var signInContainerView: SignInContainerView = {
        SignInContainerView()
    }()
    
    private lazy var userContainerViewController: UserContainerViewController = {
        let userContainerViewController = UserContainerViewController()
        userContainerViewController.datasource = self
        return userContainerViewController
    }()
    
    // MARK: - View Life Cycle
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let _ = user {
            toolTipView.show(animated: false,
                             forView: alarmButton,
                             withinSuperview: alarmContainer)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        setLayout()
    }
    
    // MARK: - UI
    
    override func setUp() {
        super.setUp()
        
        // FIXME: - 임시 User 설정
        // user = User(name: "허수민", backgroundColor: .primary)
        user = nil
        
        view.backgroundColor = UIColor(named:"메뉴 배경 1")
        addChild(userContainerViewController)
    }
    
    override func initView() {
        super.initView()
        alarmContainer.addSubview(toolTipView)
        alarmContainer.addSubview(alarmButton)
        bannerView.addSubview(alarmContainer)
        mainContainerView.addSubview(scrollView)
        scrollView.addSubview(signInContainerView)
        scrollView.addSubview(userContainerViewController.view)
        
        let subviews: [UIView] = [
            bannerView,
            mainContainerView
        ]
        
        subviews.forEach { view in
            self.view.addSubview(view)
        }
    }
    
    override func initConstraint() {
        super.initConstraint()
        
        bannerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        alarmContainer.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(12)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(30)
        }
        
        alarmButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(19)
            make.size.equalTo(24)
        }
        
        mainContainerView.snp.makeConstraints { make in
            make.top.equalTo(bannerView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        signInContainerView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(mainContainerView)
            make.height.equalTo(600).priority(.low)
        }
        
        userContainerViewController.view.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(mainContainerView)
            make.height.equalTo(600).priority(.low)
        }
    }
    
    override func bind() {
        super.bind()
        
        alarmButton.rx
            .tap
            .bind(with: self) { owner, _ in
                owner.presentAlertViewController()
            }
            .disposed(by: disposeBag)
        
        signInContainerView.signInButton.rx
            .controlEvent(.touchUpInside)
            .bind(with: self) { owner, _ in
                owner.presentSignInViewController()
            }
            .disposed(by: disposeBag)
        
        signInContainerView.registerButton.rx
            .controlEvent(.touchUpInside)
            .bind (with: self) { owner, _ in
                owner.presentRegisterViewController()
            }
            .disposed(by: disposeBag)
    }
    
    func setLayout() {
        if let user = user {
            signInContainerView.isHidden = true
            userContainerViewController.view.isHidden = false
            bannerView.setUserWelcomText(name: user.name)
            tabBarController?.tabBar.isHidden = false
        } else {
            signInContainerView.isHidden = false
            userContainerViewController.view.isHidden = true
            bannerView.setSignInText()
            tabBarController?.tabBar.isHidden = true
        }
    }
    
    func presentSignInViewController() {
        let viewController = SignInViewController()
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func presentRegisterViewController() {
        let viewController = RegisterViewController()
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func presentAlertViewController() {
        let viewController = AlertViewController()
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension HomeViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            if scrollView.contentOffset.y > 30, !self.isBannerViewHide {
                self.isBannerViewHide = true
            } else if scrollView.contentOffset.y < -50, self.isBannerViewHide {
                self.isBannerViewHide = false
            }
            self.updateBannerViewConstraints(self.isBannerViewHide)
        }
        
        UIView.animate(withDuration: 1) { [weak self] in
            guard let self = self else { return }
            self.updateAlarmViewConstraint(self.isBannerViewHide)
        }
    }
    
    func updateBannerViewConstraints(_ hide: Bool) {
        self.bannerView.snp.removeConstraints()
        self.bannerView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        if !hide {
            self.bannerView.updateHeight()
        } else {
            self.bannerView.snp.makeConstraints { $0.height.equalTo(10) }
        }
        
        self.view.layoutIfNeeded()
    }
    
    func updateAlarmViewConstraint(_ hide: Bool) {
        alarmContainer.removeFromSuperview()
        alarmContainer.snp.removeConstraints()
        signInContainerView.snp.removeConstraints()
        userContainerViewController.view.snp.removeConstraints()
        if hide {
            scrollView.addSubview(alarmContainer)
            alarmContainer.snp.makeConstraints { make in
                make.top.equalTo(scrollView.contentLayoutGuide).inset(12)
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(30)
            }
            
            signInContainerView.snp.makeConstraints { make in
                make.top.equalTo(alarmContainer.snp.bottom)
                make.leading.trailing.bottom.equalTo(scrollView.contentLayoutGuide)
                make.width.equalTo(mainContainerView)
                make.height.equalTo(600).priority(.low)
            }
            
            userContainerViewController.view.snp.makeConstraints { make in
                make.top.equalTo(alarmContainer.snp.bottom)
                make.leading.trailing.bottom.equalTo(scrollView.contentLayoutGuide)
                make.width.equalTo(mainContainerView)
                make.height.equalTo(600).priority(.low)
            }
        } else {
            bannerView.addSubview(alarmContainer)
            alarmContainer.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide).inset(12)
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(30)
            }
            
            signInContainerView.snp.makeConstraints { make in
                make.top.leading.trailing.bottom.equalTo(scrollView.contentLayoutGuide)
                make.width.equalTo(mainContainerView)
                make.height.equalTo(600).priority(.low)
            }
            
            userContainerViewController.view.snp.makeConstraints { make in
                make.top.leading.trailing.bottom.equalTo(scrollView.contentLayoutGuide)
                make.width.equalTo(mainContainerView)
                make.height.equalTo(600).priority(.low)
            }
        }
        userContainerViewController.viewDidAppear(false)
        self.view.layoutIfNeeded()
    }
}

extension HomeViewController: UserContainerViewControllerDataSource {
    func projectCollectionView() -> Int {
        return projects.count
    }
    
    func projectCollectionView(row: Int) -> Project {
        return projects[row]
    }
    
    func ticketTableView() -> Int {
        return tickets.count
    }
    
    func ticketTableView(row: Int) -> Ticket {
        return tickets[row]
    }
}
