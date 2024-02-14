//
//  CreateTicketViewController.swift
//  home
//
//  Created by 오연서 on 2/14/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class CreateTicketViewController: BaseViewController {
       
    // MARK: - Test Data
    
    private var members: [User] = [User(name: "이준영", backgroundColor: UIColor(hexCode: "54FFF3")),
                                   User(name: "김두현", backgroundColor: UIColor(hexCode: "44FF78")),
                                   User(name: "오연서", backgroundColor: UIColor(hexCode: "FF5AF9")),
                                   User(name: "반성준", backgroundColor: UIColor(hexCode: "BDE3FF")),
                                   User(name: "김태우", backgroundColor: UIColor(hexCode: "E4C1FF")),
                                   User(name: "이준영", backgroundColor: UIColor(hexCode: "54FFF3")),
                                   User(name: "김두현", backgroundColor: UIColor(hexCode: "44FF78")),
                                   User(name: "반성준", backgroundColor: UIColor(hexCode: "BDE3FF")),
                                   User(name: "김태우", backgroundColor: UIColor(hexCode: "E4C1FF"))]
    
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
    
    private var scrollview = UIScrollView()
    private var contentView = UIView()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "새로운 티켓을\n만들어보세요."
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 27)
        return label
    }()
    
    private var ticketLabel: UILabel = {
        let label = UILabel()
        label.text = "티켓 제목"
        label.font = .sfProDisplay(size: 14, weight: .semiBold)
        label.textColor = UIColor(hexCode: "33315B")
        return label
    }()
    
    private lazy var ticketTextField: TextField = {
        let view = TextField()
        view.placeHolder = "티켓 제목"
        return view
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "요청 사항"
        label.font = .sfProDisplay(size: 14, weight: .semiBold)
        label.textColor = UIColor(hexCode: "33315B")
        return label
    }()
    
    private lazy var descriptionTextField: TextField = {
        let view = TextField()
        view.placeHolder = "요청 사항"
        return view
    }()
    
    private var recipientLabel: UILabel = {
        let label = UILabel()
        label.text = "보낼 팀원"
        label.font = .sfProDisplay(size: 14, weight: .semiBold)
        label.textColor = UIColor(hexCode: "33315B")
        return label
    }()
    
    private lazy var recipientCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = .init(width: 44, height: 70)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.allowsMultipleSelection = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(RecipientCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: RecipientCollectionViewCell.self))
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    private var periodLabel: UILabel = {
        let label = UILabel()
        label.text = "기간 설정"
        label.font = .sfProDisplay(size: 14, weight: .semiBold)
        label.textColor = UIColor(hexCode: "33315B")
        return label
    }()
    
    private var periodView: PeriodView = {
        PeriodView()
    }()
    
    private var doneButton: DoneButton = {
        let view = DoneButton()
        view.isHidden = true
        return view
    }()
    
    
    // MARK: - Bind
    
    override func bind() {
        super.bind()
        
        let ticketTextFieldObservable = ticketTextField.textObservable
            .map { $0 ?? "" }
        
        let descriptionTextFieldObservable = descriptionTextField.textObservable
            .map { $0 ?? "" }
        
        let isFieldsFilledObservable = Observable.combineLatest(ticketTextFieldObservable, descriptionTextFieldObservable)
            .map { ticketText, descriptionText in
                ticketText.isEmpty || descriptionText.isEmpty
            }
        isFieldsFilledObservable
            .bind(to: doneButton.rx.isHidden)
            .disposed(by: disposeBag)
    }
    
    // MARK: - UI
    
    override func setUp() {
        super.setUp()
        view.backgroundColor = .white
    }
    
    override func initView() {
        super.initView()
        [backButton, scrollview].forEach { view in self.view.addSubview(view)}
        scrollview.addSubview(contentView)
        [titleLabel,ticketLabel, ticketTextField, descriptionLabel, descriptionTextField,
         recipientLabel, recipientCollectionView, periodLabel, periodView, doneButton].forEach { view in contentView.addSubview(view)}
    }
    
    override func initConstraint() {
        super.initConstraint()
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.leading.equalToSuperview().inset(20)
            make.width.height.equalTo(24)
        }
        
        scrollview.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(10)
            make.width.equalTo(view.snp.width)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.width.equalTo(view.snp.width)
            make.height.equalTo(1000)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(30)
        }
        
        ticketLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
        }
        
        ticketTextField.snp.makeConstraints { make in
            make.top.equalTo(ticketLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(ticketTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
        }
        
        descriptionTextField.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(90)
        }
        
        recipientLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
        }
        
        recipientCollectionView.snp.makeConstraints { make in
            make.top.equalTo(recipientLabel.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(150)
        }
        
        periodLabel.snp.makeConstraints { make in
            make.top.equalTo(recipientCollectionView.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
        }
        
        periodView.snp.makeConstraints { make in
            make.top.equalTo(periodLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().inset(30)
            make.height.equalTo(100)
        }
        
        doneButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
    }
}

extension CreateTicketViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        members.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: RecipientCollectionViewCell.self), for: indexPath) as? RecipientCollectionViewCell else {
                fatalError("Unable to dequeue RecipientCollectionViewCell")
            }
        
        cell.user = members[indexPath.item]
        return cell
    }

}
