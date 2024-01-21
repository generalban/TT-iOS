//
//  MyPageViewController.swift
//  home
//
//  Created by 반성준 on 1/19/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class MyPageViewController: BaseViewController {
    
    // MARK: - Test Data
    
    private var receivedTickets: [Ticket] = [Ticket(status: .done,
                                                    color: UIColor(hexCode: "6361FF"),
                                                    name: "DD-2",
                                                    description: "화면설계서 수정",
                                                    date: "11/11",
                                                    move: false),
                                             Ticket(status: .inProgress,
                                                    color: UIColor(hexCode: "54FFF3"),
                                                    name: "DD-2",
                                                    description: "화면설계서 수정",
                                                    date: "11/11",
                                                    move: true),
                                             Ticket(status: .toDo,
                                                    color: UIColor(hexCode: "49A0A0"),
                                                    name: "TT-3",
                                                    description: "회의록 전달",
                                                    date: "11/13",
                                                    move: false)]
    
    private var sentTickets: [Ticket] = [Ticket(status: .inProgress,
                                                color: UIColor(hexCode: "6361FF"),
                                                name: "DD-2",
                                                description: "화면설계서 수정",
                                                date: "11/10",
                                                move: false),
                                         Ticket(status: .toDo,
                                                color: UIColor(hexCode: "54FFF3"),
                                                name: "DD-2",
                                                description: "화면설계서 수정",
                                                date: "11/20",
                                                move: false)]
    
    // MARK: - Property
    
    private var isBannerViewHide = false
    
    var selectedTicketTypeRelay: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    
    let disposeBag = DisposeBag()
    
    // MARK: - View
    
    private var bannerView: BannerView = {
        BannerView()
    }()
    
    private var alarmButton: UIImageView = {
        UIImageView(image: UIImage(named: "alarm"))
    }()
    
    private var userInfoView: UserInfoView = {
        UserInfoView()
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
    
    private var divider: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: "F6F6F6")
        return view
    }()
    
    private lazy var ticketTypeSelectionView: SelectionView = {
        SelectionView(selectedTypeRelay: selectedTicketTypeRelay)
    }()
    
    private lazy var ticketPageViewController: UIPageViewController = {
        let pageViewController = UIPageViewController(transitionStyle: .scroll,
                                                      navigationOrientation: .horizontal)
        pageViewController.delegate = self
        pageViewController.dataSource = self
        return pageViewController
    }()
    
    private lazy var receivedTicketTableViewController: TicketTableViewController = {
        let tableViewController = TicketTableViewController()
        tableViewController.delegate = self
        tableViewController.dataSource = self
        return tableViewController
    }()
    
    private lazy var sentTicketTableViewController: TicketTableViewController = {
        let tableViewController = TicketTableViewController()
        tableViewController.delegate = self
        tableViewController.dataSource = self
        return tableViewController
    }()
    
    // MARK: - View Life Cycle
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: - UI
    
    override func setUp() {
        super.setUp()
        
        view.backgroundColor = UIColor(named:"메뉴 배경 1")
        addChild(ticketPageViewController)
        ticketPageViewController.setViewControllers([receivedTicketTableViewController],
                                                    direction: .forward, animated: false)
    }
    
    override func initView() {
        super.initView()
        
        bannerView.addSubview(alarmButton)
        
        let subviews: [UIView] = [
            bannerView,
            mainContainerView
        ]
        
        subviews.forEach { view in
            self.view.addSubview(view)
        }
        
        let mainContainerSubviews: [UIView] = [
            userInfoView,
            divider,
            ticketTypeSelectionView,
            ticketPageViewController.view
        ]
        
        mainContainerSubviews.forEach { view in
            mainContainerView.addSubview(view)
        }
    }
    
    override func initConstraint() {
        super.initConstraint()
        
        bannerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        alarmButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(12)
            make.trailing.equalToSuperview().inset(19)
            make.size.equalTo(24)
        }
        
        mainContainerView.snp.makeConstraints { make in
            make.top.equalTo(bannerView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        userInfoView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(4)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        divider.snp.makeConstraints { make in
            make.top.equalTo(userInfoView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(11)
        }
        
        ticketTypeSelectionView.snp.makeConstraints { make in
            make.top.equalTo(divider.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        ticketPageViewController.view.snp.makeConstraints { make in
            make.top.equalTo(ticketTypeSelectionView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func bind() {
        super.bind()
        
        selectedTicketTypeRelay
            .bind(with: self, onNext: { owner, index in
                guard let prevSelectedViewController = owner.ticketPageViewController.viewControllers?.first else { return }
                if prevSelectedViewController == owner.receivedTicketTableViewController,
                   index != 0{
                    owner.ticketPageViewController.setViewControllers([owner.sentTicketTableViewController],
                                                                      direction: .forward,
                                                                      animated: true)
                } else if prevSelectedViewController == owner.sentTicketTableViewController,
                          index != 1 {
                    owner.ticketPageViewController.setViewControllers([owner.receivedTicketTableViewController],
                                                                      direction: .reverse,
                                                                      animated: true)
                }
            })
            .disposed(by: disposeBag)
        
        userInfoView.editUserInfoButton.rx
            .controlEvent(.touchUpInside)
            .bind (with: self) { owner, _ in
                owner.presentEditUserInfoController()
            }
            .disposed(by: disposeBag)
    }
}

extension MyPageViewController {
    private func presentEditUserInfoController() {
        let viewController = EditUserInfoViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension MyPageViewController: UIPageViewControllerDelegate,
                                UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentViewController = pageViewController.viewControllers?.first,
              currentViewController == sentTicketTableViewController else { return nil }
        return receivedTicketTableViewController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentViewController = pageViewController.viewControllers?.first,
              currentViewController == receivedTicketTableViewController else { return nil }
        return sentTicketTableViewController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        guard let currentViewController = pageViewController.viewControllers?.first else { return }
        let value = currentViewController == receivedTicketTableViewController ? 0 : 1
        self.selectedTicketTypeRelay.accept(value)
    }
}

extension MyPageViewController: TicketTableViewControllerDelegate,
                                TicketTableViewControllerDataSource {
    
    func tableViewController(_ tableViewController: TicketTableViewController, numberOfRowsInSection section: Int) -> Int {
        if tableViewController == receivedTicketTableViewController {
            return receivedTickets.count
        } else if tableViewController == sentTicketTableViewController {
            return sentTickets.count
        }
        return 0
    }
    
    func tableViewController(_ tableViewController: TicketTableViewController,
                             cellDataForRowAt indexPath: IndexPath) -> Ticket? {
        if tableViewController == receivedTicketTableViewController {
            return receivedTickets[indexPath.row]
        } else if tableViewController == sentTicketTableViewController {
            return sentTickets[indexPath.row]
        }
        return nil
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            if scrollView.contentOffset.y > 0, !self.isBannerViewHide {
                self.isBannerViewHide = true
            } else if scrollView.contentOffset.y < 0, self.isBannerViewHide {
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
        alarmButton.removeFromSuperview()
        alarmButton.snp.removeConstraints()
        userInfoView.snp.removeConstraints()
        
        if hide {
            mainContainerView.addSubview(alarmButton)
            alarmButton.snp.makeConstraints { make in
                make.top.equalTo(mainContainerView).inset(12)
                make.trailing.equalToSuperview().inset(19)
                make.size.equalTo(24)
            }
            userInfoView.snp.makeConstraints { make in
                make.top.equalTo(alarmButton.snp.bottom).inset(4)
                make.leading.trailing.equalToSuperview().inset(20)
            }
        } else {
            bannerView.addSubview(alarmButton)
            alarmButton.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide).inset(12)
                make.trailing.equalToSuperview().inset(19)
                make.size.equalTo(24)
            }
            userInfoView.snp.makeConstraints { make in
                make.top.equalTo(mainContainerView).inset(4)
                make.leading.trailing.equalToSuperview().inset(20)
            }
        }
        userInfoView.updateHeight()
        self.view.layoutIfNeeded()
    }
}
