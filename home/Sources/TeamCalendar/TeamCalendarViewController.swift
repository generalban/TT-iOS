//
//  TeamCalendarViewController.swift
//  home
//
//  Created by 오연서 on 2/7/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class TeamCalendarViewController: BaseViewController {
    
    // MARK: - Test Data
    
    private var tickets: [Ticket] = Ticket.dummy
    private var todoTickets: [Ticket] = Ticket.dummy
    private var inprogressTickets: [Ticket] = Ticket.dummy
    private var doneTickets: [Ticket] = Ticket.dummy
    
    // MARK: - Property
    
    var isCompleteLayout: Bool = false
    var selectedTicketTypeRelay: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    let disposeBag = DisposeBag()

    // MARK: - View
    
    lazy var backButton: UIButton = {
        let button = UIButton(primaryAction: UIAction(handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        button.setImage(UIImage(named: "icon_left"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    lazy var alarmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "alarm"), for: .normal)
        button.tintColor = UIColor(named: "활성화 테두리")
        return button
    }()
    
    lazy var topView: TopView = {
        TopView()
    }()
    
    let scrollView = UIScrollView ()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var calendarTopView = CalendarTopView(
        didTapbackButtonCompletionHandler: { [weak self] in
            guard let self = self else { return }
            
            self.baseDate = self.calendar.date(
                byAdding: .month,
                value: -1,
                to: self.baseDate
            ) ?? self.baseDate
        },
        didTapforwardButtonCompletionHandler: { [weak self] in
            guard let self = self else { return }
            
            self.baseDate = self.calendar.date(
                byAdding: .month,
                value: 1,
                to: self.baseDate
            ) ?? self.baseDate
        })
    
    private lazy var calendarMonthView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(TeamCalendarDateCollectionViewCell.self,
                                forCellWithReuseIdentifier: TeamCalendarDateCollectionViewCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private var dividerView: UIView = {
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
    
    private lazy var todoTicketTableViewController: TicketTableViewController = {
        let tableViewController = TicketTableViewController()
        tableViewController.delegate = self
        tableViewController.dataSource = self
        return tableViewController
    }()
    
    private lazy var inprogressTicketTableViewController: TicketTableViewController = {
        let tableViewController = TicketTableViewController()
        tableViewController.delegate = self
        tableViewController.dataSource = self
        return tableViewController
    }()
    
    private lazy var doneTicketTableViewController: TicketTableViewController = {
        let tableViewController = TicketTableViewController()
        tableViewController.delegate = self
        tableViewController.dataSource = self
        return tableViewController
    }()
    
    
    
    // MARK: - Calendar Data Values
    
    private var baseDate: Date {
        didSet {
            days = generateDaysInMonth(for: baseDate)
            calendarMonthView.reloadData()
            calendarTopView.baseDate = baseDate
        }
    }
    
    private lazy var days = generateDaysInMonth(for: baseDate)
    
    private var numberOfWeeksInBaseDate: Int {
        calendar.range(of: .weekOfMonth, in: .month, for: baseDate)?.count ?? 0
    }
    
    private let calendar = Calendar(identifier: .gregorian)
    
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter
    }()
    
    
    // MARK: - Initializers
    
    init(baseDate: Date) {
        self.baseDate = baseDate
        
        super.init(nibName: nil, bundle: nil)
        
        modalPresentationStyle = .overCurrentContext
        modalTransitionStyle = .crossDissolve
        definesPresentationContext = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        isCompleteLayout = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: - Bind

    override func bind() {
        super.bind()
        
        selectedTicketTypeRelay
            .bind(with: self, onNext: { owner, index in
                guard let prevSelectedViewController = owner.ticketPageViewController.viewControllers?.first else { return }
                
                // 받은 티켓 뷰 컨트롤러로 전환
                if prevSelectedViewController == owner.todoTicketTableViewController && index == 0 {
                    owner.ticketPageViewController.setViewControllers([owner.todoTicketTableViewController],
                                                                      direction: .reverse,
                                                                      animated: true)
                }
                // 보낸 티켓 뷰 컨트롤러로 전환
                else if prevSelectedViewController == owner.inprogressTicketTableViewController && index == 1 {
                    owner.ticketPageViewController.setViewControllers([owner.inprogressTicketTableViewController],
                                                                      direction: .forward,
                                                                      animated: true)
                }
                // 일반 티켓 뷰 컨트롤러로 전환
                else if index == 2 {
                    let direction: UIPageViewController.NavigationDirection = prevSelectedViewController == owner.doneTicketTableViewController ? .forward : .reverse
                    owner.ticketPageViewController.setViewControllers([owner.doneTicketTableViewController],
                                                                      direction: direction,
                                                                      animated: true)
                }
            })
            .disposed(by: disposeBag)

        
    }
    
    
    // MARK: - UI
    
    override func setUp() {
        super.setUp()
        view.backgroundColor = .white
        addChild(ticketPageViewController)
        ticketPageViewController.setViewControllers([inprogressTicketTableViewController],
                                                    direction: .forward, animated: false)
    }
    
    override func initView() {
        super.initView()
        [backButton, alarmButton,topView, scrollView].forEach { view in self.view.addSubview(view) }
        scrollView.addSubview(contentView)
        [calendarTopView, calendarMonthView, dividerView, ticketTypeSelectionView, ticketPageViewController.view].forEach {view in contentView.addSubview(view)}
        
        scrollView.isUserInteractionEnabled = true
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 1000)
    }
    
    override func initConstraint() {
        super.initConstraint()
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(12)
            make.leading.equalToSuperview().inset(19)
            make.size.equalTo(24)
        }
        
        alarmButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(12)
            make.trailing.equalToSuperview().inset(19)
            make.size.equalTo(24)
        }
        
        topView.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(10)
            make.leading.equalToSuperview()
            make.height.equalTo(70)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.height.equalTo(2000)
        }
        
        calendarTopView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).inset(15)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(80)
        }
        
        calendarMonthView.snp.makeConstraints { make in
            make.top.equalTo(calendarTopView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(700)
        }
        
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(calendarMonthView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(10)
        }
        
        ticketTypeSelectionView.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        ticketPageViewController.view.snp.makeConstraints { make in
            make.top.equalTo(ticketTypeSelectionView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}


// MARK: - Day Generation
private extension TeamCalendarViewController {
    
    func monthMetadata(for baseDate: Date) throws -> MonthMetadata {
        
        guard let numberOfDaysInMonth = calendar.range(of: .day, in: .month, for: baseDate)?.count,
              
                let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: baseDate))
        else {
            throw CalendarDataError.metadataGeneration
        }
        
        let firstDayWeekday = calendar.component(.weekday, from: firstDayOfMonth)
        
        return MonthMetadata(
            numberOfDays: numberOfDaysInMonth,
            firstDay: firstDayOfMonth,
            firstDayWeekday: firstDayWeekday)
    }
    
    
    func generateDaysInMonth(for baseDate: Date) -> [Day] {
        guard let metadata = try? monthMetadata(for: baseDate) else {
            preconditionFailure("An error occurred when generating the metadata for \(baseDate)")
        }
        
        let numberOfDaysInMonth = metadata.numberOfDays
        let offsetInInitialRow = metadata.firstDayWeekday
        let firstDayOfMonth = metadata.firstDay
        
        var days: [Day] = (1..<(numberOfDaysInMonth + offsetInInitialRow)) //offsetInInitialRow : 이전 달 날짜로 공백 채우기
            .map { day in
                let isWithinDisplayedMonth = day >= offsetInInitialRow
                let dayOffset =
                isWithinDisplayedMonth ?
                day - offsetInInitialRow :
                -(offsetInInitialRow - day)
                
                return generateDay(
                    offsetBy: dayOffset,
                    for: firstDayOfMonth,
                    isWithinDisplayedMonth: isWithinDisplayedMonth)
            }
        
        days += generateStartOfNextMonth(using: firstDayOfMonth)
        
        return days
    }
    
    func generateDay(
        offsetBy dayOffset: Int,
        for baseDate: Date,
        isWithinDisplayedMonth: Bool
    ) -> Day {
        let date = calendar.date(
            byAdding: .day,
            value: dayOffset,
            to: baseDate)
        ?? baseDate
        
        return Day(
            date: date,
            number: dateFormatter.string(from: date),
            isWithinDisplayedMonth: isWithinDisplayedMonth
        )
    }
    
    func generateStartOfNextMonth(
        using firstDayOfDisplayedMonth: Date
    ) -> [Day] {
        guard let lastDayInMonth = calendar.date(
            byAdding: DateComponents(month: 1, day: -1),
            to: firstDayOfDisplayedMonth)
        else {
            return []
        }
        
        let additionalDays = 7 - calendar.component(.weekday, from: lastDayInMonth)
        guard additionalDays > 0 else {
            return []
        }
        
        let days: [Day] = (1...additionalDays)
            .map {
                generateDay(
                    offsetBy: $0,
                    for: lastDayInMonth,
                    isWithinDisplayedMonth: false)
            }
        return days
    }
    
    enum CalendarDataError: Error {
        case metadataGeneration
    }
}

// MARK: - UICollectionViewDataSource
extension TeamCalendarViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,numberOfItemsInSection section: Int) -> Int {
        days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let day = days[indexPath.row]
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TeamCalendarDateCollectionViewCell.reuseIdentifier,
            for: indexPath) as! TeamCalendarDateCollectionViewCell
        cell.day = day
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension TeamCalendarViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = Int(collectionView.frame.width / 7)
        let height = Int(collectionView.frame.height) / numberOfWeeksInBaseDate
        return CGSize(width: width, height: height)
    }
}

extension TeamCalendarViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if viewController == todoTicketTableViewController {
            return doneTicketTableViewController
        }
        else if viewController == doneTicketTableViewController {
            return inprogressTicketTableViewController
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if viewController == inprogressTicketTableViewController {
            return doneTicketTableViewController
        }
        else if viewController == doneTicketTableViewController {
            return todoTicketTableViewController
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        guard let currentViewController = pageViewController.viewControllers?.first else { return }
        
        let value: Int
        if currentViewController == inprogressTicketTableViewController {
            value = 0
        } else if currentViewController == doneTicketTableViewController {
            value = 2
        } else {
            value = 1
        }
        
        self.selectedTicketTypeRelay.accept(value)
    }
}


extension TeamCalendarViewController: TicketTableViewControllerDelegate,TicketTableViewControllerDataSource {
    func ticketSelected(_ tableViewController: TicketTableViewController, ticket: Ticket) {
        TicketPopupViewController.present(ticket: ticket)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

    }
    
    func ticketTableViewController(_ tableViewController: TicketTableViewController) -> [Ticket] {
        if tableViewController == todoTicketTableViewController {
            return todoTickets
        } else if tableViewController == inprogressTicketTableViewController {
            return inprogressTickets
        } else if tableViewController == doneTicketTableViewController {
            return doneTickets
        }
        return []
    }
}
