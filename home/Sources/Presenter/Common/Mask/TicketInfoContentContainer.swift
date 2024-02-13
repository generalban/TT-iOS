//
//  TicketInfoContentContainer.swift
//  home
//
//  Created by 반성준 on 2/4/24.
//

import UIKit

final class TicketInfoFrame: BaseView {
    let lineWidth: CGFloat = 3
    let cornerRadius: CGFloat = 5
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        context.translateBy(x: 0, y: 0)
        UIColor(hexCode: "A5ADC5").setStroke()
        UIColor.white.setFill()
        
        
        let rectLeft = bounds.minX
        let rectDashTop = bounds.minY+(cornerRadius + 4)
        let dashLineHeight = bounds.height-(2*(cornerRadius + 4))
        
        
        let path = UIBezierPath(roundedRect: CGRect(x: bounds.minX,
                                                    y:bounds.minY,
                                                    width: bounds.width,
                                                    height: bounds.height),
                                cornerRadius: cornerRadius)
        path.lineWidth = lineWidth
        path.stroke()
        
        let arcCenter = CGPoint(x: bounds.maxX, y: bounds.midY)
        let arcPath = UIBezierPath(arcCenter: arcCenter,
                                   radius: 16,
                                   startAngle: 0,
                                   endAngle: 360,
                                   clockwise: true)
        arcPath.lineWidth = lineWidth/2
    
        // path.fill()
        // path.stroke()
        // arcPath.fill()
        // arcPath.stroke()
       
        path.append(arcPath)
        
        path.fill()
        path.stroke()
        
        context.clear(CGRect(x: bounds.maxX-2,
                             y: arcCenter.y-14,
                             width: lineWidth,
                             height: 28))
        
        let lineDash = UIBezierPath()
        lineDash.lineWidth = lineWidth
        lineDash.move(to: CGPoint(x: rectLeft, y: rectDashTop))
        lineDash.addLine(to: CGPoint(x: rectLeft, y: rectDashTop+dashLineHeight))
        UIColor.white.setStroke()
        lineDash.stroke()
        
        let layer = CAShapeLayer()
        layer.lineWidth = lineWidth
        layer.strokeColor = UIColor(hexCode: "A5ADC5").cgColor
        layer.fillColor = UIColor.white.cgColor
        layer.path = path.cgPath
        layer.fillRule = .evenOdd
        
        self.layer.mask = layer
        
    }
    
    override func prepare() {
        self.isOpaque = false
    }
}

final class TicketInfoContainer: BaseView {
    
    // MARK: - View
    
    private var ticketInfoFrame = TicketInfoFrame()
    
    var layoutGuideView: UIView = {
        let view = UIView()
        return view
    }()
    
    // MARK: - UI
    
    override func prepare() {
        super.prepare()
        
        self.clipsToBounds = true
        self.layer.cornerRadius =  5
        // self.backgroundColor = .white
    }
    
    override func configureSubviews() {
        super.configureSubviews()
        
        self.addSubview(layoutGuideView)
        self.addSubview(ticketInfoFrame)
    }
    
    override func configureConstraints() {
        super.configureConstraints()
        
        ticketInfoFrame.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        layoutGuideView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}
