//
//  TeamCalendarDateCollectionViewCell.swift
//  home
//
//  Created by 오연서 on 2/10/24.
//

import UIKit

class TeamCalendarDateCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Property
    private var tickets: [Ticket] = Ticket.dummy
    
    //MARK: - View
    
    private lazy var currentDateBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = UIColor(named: "활성화 테두리")
        return view
    }()
    
    private lazy var selectionBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .label
        return label
    }()
    
    
    static let reuseIdentifier = String(describing: CalendarDateCollectionViewCell.self)
    
    var day: Day? {
        didSet {
            guard let day = day else { return }
            numberLabel.text = day.number
            updateSelectionStatus()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        isAccessibilityElement = true
        accessibilityTraits = .button
        
        contentView.addSubview(selectionBackgroundView)
        contentView.addSubview(currentDateBackgroundView)
        contentView.addSubview(numberLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.deactivate(selectionBackgroundView.constraints)
        
        numberLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
        }
        
        currentDateBackgroundView.snp.makeConstraints { make in
            make.centerY.equalTo(numberLabel)
            make.centerX.equalTo(numberLabel)
            make.width.equalTo(37)
            make.height.equalTo(37)
        }
        currentDateBackgroundView.layer.cornerRadius = 37 / 2
        
        selectionBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(currentDateBackgroundView.snp.bottom).offset(2)
            make.centerX.equalTo(numberLabel)
            make.width.equalTo(50)
            make.height.equalTo(5)
        }
    }
}

// MARK: - Appearance
private extension TeamCalendarDateCollectionViewCell {
    
    func updateSelectionStatus() {
        guard let day = day else { return }
                
        var ticketOffset: [String : Int] = [:]
        var currentOffset = 10
        
        //오늘 날짜에 동그라미
        if Calendar.current.isDateInToday(day.date) {
            applySelectedStyle()
            
        } else {
            applyDefaultStyle(isWithinDisplayedMonth: day.isWithinDisplayedMonth)
        }
        
        contentView.subviews.forEach { subview in
                if subview.tag == 100 {
                    subview.removeFromSuperview()
                }
        }
        
        // 티켓 해당 날짜에 대한 뷰 추가
        for ticket in tickets {
            
            if ticket.startDate <= day.date && day.date <= ticket.dueDate {
                if let offset = ticketOffset[ticket.code] {
                    addTicketView(for: ticket, withOffset: offset)
                } else {
                    ticketOffset[ticket.code] = currentOffset
                    addTicketView(for: ticket, withOffset: currentOffset)
                    currentOffset += 10
                }
            }
        }
    }
    
    func addTicketView(for ticket: Ticket, withOffset offset: Int) {
        let ticketView = UIView()
        ticketView.backgroundColor = ticket.color
        ticketView.translatesAutoresizingMaskIntoConstraints = false
        ticketView.tag = 100 // Tag to identify ticket views
        
        contentView.addSubview(ticketView)
        
        ticketView.snp.makeConstraints { make in
            make.top.equalTo(currentDateBackgroundView.snp.bottom).offset(2 + offset)
            make.centerX.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(5)
        }
    }
    
    func applySelectedStyle() {
        accessibilityTraits.insert(.selected)
        accessibilityHint = nil
        currentDateBackgroundView.isHidden = false
        numberLabel.textColor = .white
        selectionBackgroundView.isHidden = true
    }
    
    func applyDefaultStyle(isWithinDisplayedMonth: Bool) {
        accessibilityTraits.remove(.selected)
        accessibilityHint = "Tap to select"
        
        //선택하지 않은 날짜들과 이전달+다음달 날짜들 default color
        numberLabel.textColor = isWithinDisplayedMonth ? .label : .secondaryLabel
        selectionBackgroundView.isHidden = true
        currentDateBackgroundView.isHidden = true
    }
}
