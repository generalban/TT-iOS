//
//  RegisterViewController+ProgressBar.swift
//  home
//
//  Created by 반성준 on 2/5/24.
//

import UIKit

class ProgressBar: BaseView {
    private var _currentCount: Int = 0
    var isSimilar: Bool = false
    var currentCount: Int {
        get { _currentCount }
        set (newVal) {
            if newVal < 0 { _currentCount = 0 }
            else if maxCount >= newVal { _currentCount = newVal }
            else { _currentCount = maxCount }
        }
    }
    
    private var _maxCount: Int = 1
    var maxCount: Int {
        get { _maxCount }
        set (newVal) {
            if currentCount >= newVal { currentCount = newVal }
            if newVal > 0 { _maxCount = newVal }
            else { _maxCount = 1 }
        }
    }
    
    private var mainContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    private var progressBackgroundBar: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(hexCode: "DFE4ED")
        return view
    }()
    
    private var progressBar: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(hexCode: "8303FF")
        return view
    }()
    
    
    override func prepare() {
        super.prepare()
        
    }
    
    override func configureSubviews() {
        super.configureSubviews()
        
        let mainContainerSubviews: [UIView] = [progressBackgroundBar,
                                               progressBar]
        mainContainerSubviews.forEach { subview in
            mainContainer.addSubview(subview)
        }
        
        self.addSubview(mainContainer)
    }
    
    override func configureConstraints() {
        super.configureConstraints()
        
        self.snp.makeConstraints { make in
            make.height.equalTo(mainContainer)
        }
        
        mainContainer.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(progressBackgroundBar)
        }
        
        progressBackgroundBar.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(6)
        }
        
        progressBar.snp.makeConstraints { make in
            make.leading.centerY.height.equalTo(progressBackgroundBar)
            make.width.equalTo(progressBackgroundBar).multipliedBy(currentCount/maxCount)
        }
    }
    
    func setCount(count: Int) {
        self.currentCount = count
        updateProgressBarLayout()
    }
    
    func increase() {
        self.currentCount += 1
        updateProgressBarLayout()
    }
    
    func decrease() {
        self.currentCount -= 1
        updateProgressBarLayout()
    }
    
    func updateProgressBarLayout(){
        UIView.animate(withDuration: 0.4) {
            let ratio = CGFloat(self.currentCount)/CGFloat(self.maxCount)
            self.progressBar.snp.removeConstraints()
            self.progressBar.snp.makeConstraints { make in
                make.leading.centerY.height.equalTo(self.progressBackgroundBar)
                make.width.equalTo(self.progressBackgroundBar).multipliedBy(ratio)
            }
            self.layoutIfNeeded()
        }
    }
}

