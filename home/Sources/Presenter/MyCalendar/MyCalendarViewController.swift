//
//  MyCalendarViewController.swift
//  home
//
//  Created by 오연서 on 1/23/24.
//

import UIKit
import SnapKit

final class MyCalendarViewController: BaseViewController{
    
    // MARK: - Property
    
    var topViewHeight: Constraint?
    var isCompleteLayout: Bool = false
    private var tickets: [Ticket] = Ticket.dummy
    
    //MARK: - View
    
    private lazy var topView: TopView = {
        TopView()
    }()
    
    private lazy var alarmButton: UIButton = {
        let button = UIButton(primaryAction: UIAction(handler: { _ in
            self.navigationController?.pushViewController(AlertViewController(), animated: true)}))
        button.setImage(UIImage(named: "alarm"), for: .normal)
        button.tintColor = UIColor(named: "활성화 테두리")
        return button
    }()
    
    private lazy var toolTipView: TooltipView = {
        var viewController = AlertViewController()
        return TooltipView(text: "읽지 않은 알림이 2개 있어요!")
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
    
    //달력 중간부분
    private lazy var calendarMonthView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CalendarDateCollectionViewCell.self,
                                forCellWithReuseIdentifier: CalendarDateCollectionViewCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: "F6F6F6")
        return view
    }()
    
    private lazy var myTicketTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.register(MyCalendarViewController.TicketTableViewCell.self)
        tableView.sectionHeaderHeight = 2
        return tableView
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
        toolTipView.show(animated: false, forView: alarmButton, withinSuperview: view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    // MARK: - UI
    
    override func setUp() {
        super.setUp()
        view.backgroundColor = UIColor(named:"메뉴 배경 1")
    }
    
    override func initView() {
        super.initView()
        [topView, scrollView, alarmButton, toolTipView].forEach {view in self.view.addSubview(view)}
        scrollView.addSubview(contentView)
        [calendarTopView, calendarMonthView, dividerView, myTicketTableView].forEach {view in contentView.addSubview(view)}
        
        scrollView.delegate = self
        scrollView.isUserInteractionEnabled = true
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 1000)
        
    }
    
    override func initConstraint() {
        super.initConstraint()
        
        topView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            topViewHeight = make.height.equalTo(160).constraint
        }
        
        alarmButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(12)
            make.trailing.equalToSuperview().inset(19)
            make.size.equalTo(24)
        }
        
        toolTipView.snp.makeConstraints { make in
            make.trailing.equalTo(alarmButton.snp.leading).offset(-8)
            make.centerY.equalTo(alarmButton)
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
            make.height.equalTo(5000)
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
        
        myTicketTableView.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension MyCalendarViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard isCompleteLayout else { return }
        
        if scrollView.contentOffset.y > 0, topView.frame.size.height > 0 {
            updateTopViewHeight(0)
        } else if scrollView.contentOffset.y < 0, topView.frame.size.height == 0 {
            updateTopViewHeight(180)
        }
    }
    
    private func updateTopViewHeight(_ offset: Double) {
        UIView.animate(withDuration: 0.3) {
            self.topViewHeight?.update(offset: offset)
            self.view.layoutIfNeeded()
        } completion: { _ in
            
        }
    }
}

// MARK: - Day Generation
private extension MyCalendarViewController {
    
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
extension MyCalendarViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,numberOfItemsInSection section: Int) -> Int {
        days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let day = days[indexPath.row]
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CalendarDateCollectionViewCell.reuseIdentifier,
            for: indexPath) as! CalendarDateCollectionViewCell
        cell.day = day
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MyCalendarViewController: UICollectionViewDelegateFlowLayout {
    
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

extension MyCalendarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tickets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ticket = tickets[indexPath.row]
        return TicketTableViewCell.makeCell(to: tableView, indexPath: indexPath, ticket: ticket)
    }
}
