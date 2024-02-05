//
//  ProjectEditViewController.swift
//  home
//
//  Created by 오연서 on 2/1/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class ProjectEditViewController: BaseViewController {
    
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
    
    private lazy var projectPicture: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor(named: "Cool gray 3")
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var selectPhotoButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "selectPhoto"), for: .normal)
        view.addTarget(self, action: #selector(didTabselectButtuon), for: .touchUpInside)
        return view
    }()
    
    private var projectNameLabel: UILabel = {
        let label = UILabel()
        label.text = "프로젝트 이름"
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        return label
    }()
    
    private lazy var projectNameTextField: TextField = {
        let view = TextField()
        view.placeHolder = "프로젝트 이름"
        return view
    }()
    
    private var projectDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "프로젝트 설명"
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        return label
    }()
    
    private lazy var doneButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor(named: "Primary color")
        view.setTitle("완료", for: .normal)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        view.addTarget(self, action: #selector(didTabdoneButtuon), for: .touchUpInside)

        return view
    }()
    
    private lazy var projectDescriptionTextField: TextField = {
        let view = TextField()
        view.placeHolder = "프로젝트 설명"
        
        return view
    }()
    
    @IBAction func didTabselectButtuon(){
            let vc = UIImagePickerController()
            vc.sourceType = .photoLibrary
            vc.delegate = self
            vc.allowsEditing = true
            present(vc, animated: true)
        }
    
    @IBAction func didTabdoneButtuon(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    // MARK: - UI
    
    override func setUp() {
        super.setUp()
        view.backgroundColor = .white
 

    }
    
    override func initView() {
        super.initView()
        
        [backButton,projectPicture,selectPhotoButton,
        projectNameLabel, projectNameTextField ,projectDescriptionLabel, projectDescriptionTextField, doneButton].forEach { view in self.view.addSubview(view)}
    }
    
    override func initConstraint() {
        super.initConstraint()
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.leading.equalToSuperview().inset(20)
            make.width.height.equalTo(24)
        }
        
        projectPicture.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(200)
        }
        
        selectPhotoButton.snp.makeConstraints { make in
            make.top.equalTo(projectPicture.snp.bottom).offset(-20)
            make.leading.equalTo(projectPicture.snp.trailing).offset(-20)
            make.height.width.equalTo(50)
        }
        
        projectNameLabel.snp.makeConstraints { make in
            make.top.equalTo(selectPhotoButton.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(30)
        }
        
        projectNameTextField.snp.makeConstraints { make in
            make.top.equalTo(projectNameLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        
        projectDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(projectNameTextField.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(30)
        }
        
        projectDescriptionTextField.snp.makeConstraints { make in
            make.top.equalTo(projectDescriptionLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(90)
        }
        
        doneButton.snp.makeConstraints { make in
            make.top.equalTo(projectDescriptionTextField.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
       
        
    }
}


extension ProjectEditViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            projectPicture.image = image
        }
        
        picker.dismiss(animated: true, completion: nil)
        
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
