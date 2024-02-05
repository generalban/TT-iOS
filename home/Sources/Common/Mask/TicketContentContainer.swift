//
//  TicketContentMast.swift
//  home
//
//  Created by 반성준 on 2/4/24.
//

import UIKit

final class TicketContentFrame: BaseView {
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
        
        let rectRight = bounds.maxX
        let rectTop = bounds.minY+(cornerRadius + 4)
        let lineHeight = bounds.height-(2*(cornerRadius + 4))
        
        context.clear(CGRect(x: rectRight-lineWidth,
                             y: rectTop,
                             width: lineWidth,
                             height: lineHeight))
        
        path.lineWidth = lineWidth
        path.move(to: CGPoint(x: rectRight, y: rectTop))
        path.addLine(to: CGPoint(x: rectRight, y: rectTop+lineHeight))
        path.setLineDash([8], count: 1, phase: 0)
    
        path.stroke()
        
        UIColor.white.setFill()
        
        let layer = CAShapeLayer()
        layer.lineWidth = lineWidth
        layer.strokeColor = UIColor(hexCode: "A5ADC5").cgColor
        layer.fillColor = UIColor.white.cgColor
        layer.path = path.cgPath
        layer.fillMode = .backwards
    
        self.layer.mask = layer
        
    }
    
    override func prepare() {
        self.isOpaque = false
    }
}

final class TicketContentContainer: BaseView {
    
    var ticketColor: UIColor = .point {
        didSet {
            self.ticketColorView.backgroundColor = ticketColor
        }
    }

    // MARK: - View
    
    private var ticketContentFrame = TicketContentFrame()
    
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
        
        self.addSubview(ticketColorView)
        self.addSubview(layoutGuideView)
        self.addSubview(ticketContentFrame)
    }
    
    override func configureConstraints() {
        super.configureConstraints()
        
        ticketContentFrame.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        ticketColorView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.width.equalTo(20)
        }
        
        layoutGuideView.snp.makeConstraints { make in
            make.leading.equalTo(ticketColorView.snp.trailing)
            make.top.trailing.bottom.equalToSuperview()
        }
    }
}
