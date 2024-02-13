//
//  TicketSubContentContainer.swift
//  home
//
//  Created by 반성준 on 2/4/24.
//

import UIKit

final class TicketSubContentFrame: BaseView {
    let lineWidth: CGFloat = 3
    let cornerRadius: CGFloat = 5
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        context.translateBy(x: 0, y: 0)
        UIColor(hexCode: "A5ADC5").setStroke()
        
        let path = UIBezierPath(roundedRect: CGRect(x: bounds.minX,
                                                    y:bounds.minY,
                                                    width: bounds.width,
                                                    height: bounds.height),
                                cornerRadius: cornerRadius)
        path.lineWidth = lineWidth
        path.stroke()
        
        let layer = CAShapeLayer()
        layer.lineWidth = lineWidth
        layer.strokeColor = UIColor(hexCode: "A5ADC5").cgColor
        layer.fillColor = UIColor.white.cgColor
        layer.path = path.cgPath

        self.layer.mask = layer
        
    }
    
    override func prepare() {
        self.isOpaque = false
    }
}

final class TicketSubContentContainer: BaseView {

    // MARK: - View
    
    private var ticketContentFrame = TicketSubContentFrame()
    
    private var ticketColorView: UIView = {
        let view = UIView()
        view.backgroundColor = .point
        return view
    }()
    
    var layoutGuideView: UIView = {
        let view = UIView()
        return view
    }()
    
    // MARK: - UI
    
    override func prepare() {
        super.prepare()
      
        self.clipsToBounds = true
        self.layer.cornerRadius =  5
        self.backgroundColor = .white
    }
    
    override func configureSubviews() {
        super.configureSubviews()
        
        self.addSubview(layoutGuideView)
        self.addSubview(ticketContentFrame)
    }
    
    override func configureConstraints() {
        super.configureConstraints()
        
        ticketContentFrame.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        layoutGuideView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}

