//
//  SelectIconColorViewController.swift
//  home
//
//  Created by 반성준 on 1/20/24.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

final class SelectIconColorViewController: BaseViewController {
    
    // MARK: - ColorSet (객체화)
    
    let colorSet: [(title: String, colors: [UIColor])] = [
        ("파스텔", [UIColor(hexCode: "FFD7D7"),
                 UIColor(hexCode: "FFD1B8"),
                 UIColor(hexCode: "FFF7AF"),
                 UIColor(hexCode: "CFFFA9"),
                 UIColor(hexCode: "B4FFC9"),
                 UIColor(hexCode: "B0FFFA"),
                 UIColor(hexCode: "BDE3FF"),
                 UIColor(hexCode: "C7C6FF"),
                 UIColor(hexCode: "E4C1FF"),
                 UIColor(hexCode: "FFC6FD")]),
        ("비비드", [UIColor(hexCode: "FF7373"),
                 UIColor(hexCode: "FFA574"),
                 UIColor(hexCode: "FFEE53"),
                 UIColor(hexCode: "96FF43"),
                 UIColor(hexCode: "44FF78"),
                 UIColor(hexCode: "54FFF3"),
                 UIColor(hexCode: "51B5FF"),
                 UIColor(hexCode: "6361FF"),
                 UIColor(hexCode: "B455FF"),
                 UIColor(hexCode: "FF5AF9")]),
        ("뉴트럴", [UIColor(hexCode: "CFAFAF"),
                 UIColor(hexCode: "9F8C81"),
                 UIColor(hexCode: "CBBCA5"),
                 UIColor(hexCode: "A7BC9A"),
                 UIColor(hexCode: "7D9E8A"),
                 UIColor(hexCode: "49A0A0"),
                 UIColor(hexCode: "9EB1D4"),
                 UIColor(hexCode: "7875B4"),
                 UIColor(hexCode: "9C83A8"),
                 UIColor(hexCode: "000000")])
    ]
    
    // MARK: - Property
    
    weak var delegate: SelectIconColorViewControllerDelegate?
    
    private var userColor: UIColor = UIColor.point
    private var memberColor: [UIColor] = []
    private var currentColorIndexPath: IndexPath? = nil
    
    var currentColor: UIColor? {
        guard let indexPath = currentColorIndexPath else { return nil }
        return colorSet[indexPath.section].colors[indexPath.row]
    }
    
    private let disposeBag = DisposeBag()
    
    private var addedTeamIconImage: UIImage? = nil
    
    // MARK: - Init
    
    convenience init(userColor: UIColor, memberColors: [UIColor]) {
        self.init()
        self.userColor = userColor
        self.memberColor = memberColors
    }
    
    // MARK: - View
    
    private var backgroundView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        return visualEffectView
    }()
    
    private var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    private var titleLabel: UILabel = {
       let label = UILabel()
        label.text = "아이콘 색 선택"
        label.font = .sfProDisplay(size: 14, weight: .semiBold)
        label.textColor = UIColor(hexCode: "33315B")
        return label
    }()
    
    private lazy var colorCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: 0, height: 40)
        layout.itemSize = .init(width: 44, height: 44)
        layout.minimumInteritemSpacing = 18
        layout.minimumLineSpacing = 18
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ColorCollectionViewHeader.self)
        collectionView.register(ColorCollectionViewCell.self)
        return collectionView
    }()
    
    private var confirmButton: PaddedButton = {
        let button = PaddedButton()
        button.text = "확인"
        button.padding = .init(top: 10, left: 60, bottom: 10, right: 60)
        return button
    }()
    
    // MARK: - UI
    
    override func setUp() {
        super.setUp()
        
        view.backgroundColor = .clear
    }
    
    override func initView() {
        super.initView()
        
        view.addSubview(backgroundView)
        view.addSubview(containerView)
        containerView.addSubview(colorCollectionView)
        containerView.addSubview(confirmButton)
        containerView.addSubview(titleLabel)
    }
    
    override func initConstraint() {
        super.initConstraint()
        
        backgroundView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(colorCollectionView).offset(40)
            make.bottom.equalTo(confirmButton).offset(15)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        colorCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalTo(44 * 5 + 18 * 4)
            make.height.equalTo(106)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(colorCollectionView.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(12)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let height = colorCollectionView.collectionViewLayout.collectionViewContentSize.height
        colorCollectionView.snp.removeConstraints()
        colorCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalTo(44 * 5 + 18 * 4)
            make.height.equalTo(height)
        }
    }
    
    // MARK: - Bind
    
    override func bind() {
        super.bind()
        confirmButton.rx
            .controlEvent(.touchUpInside)
            .bind(with: self) { owner, _ in
                owner.complete()
            }
            .disposed(by: disposeBag)
    }
    
    private func complete() {
        delegate?.selectIconColor(self.currentColor)
        dismiss(animated: false)
    }
}

extension SelectIconColorViewController: UICollectionViewDelegate,
                                         UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return colorSet.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorSet[0].colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let color = colorSet[indexPath.section].colors[indexPath.row]
        let cell = ColorCollectionViewCell.makeCell(to: collectionView,
                                                indexPath: indexPath,
                                                color: color)
        if memberColor.contains(color) {
            cell.isDisabled = true
        }
        
        if userColor == color {
            cell.isChecked = true
            currentColorIndexPath = indexPath
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return ColorCollectionViewHeader.makeHeader(to: collectionView, 
                                                    kind: kind,
                                                    indexPath: indexPath,
                                                    title: colorSet[indexPath.section].title)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ColorCollectionViewCell,
        !cell.isDisabled else { return }
        if let prevIndexPath = currentColorIndexPath,
            let prevSelectedCell = collectionView.cellForItem(at: prevIndexPath) as? ColorCollectionViewCell {
            prevSelectedCell.isChecked = false
        }
        cell.isChecked = true
        currentColorIndexPath = indexPath
    }
}

protocol SelectIconColorViewControllerDelegate: AnyObject {
    func selectIconColor(_ color: UIColor?)
}
