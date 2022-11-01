//
//  TimerView.swift
//  Box
//
//  Created by Kuziboev Siddikjon on 11/1/22.
//

import UIKit

protocol TimerViewDelegate {
    func refreshTimeView()
}

class TimerView: UIView {
    
    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    private let startPoint = CGFloat(-Double.pi / 2)
    private let endPoint = CGFloat(3 * Double.pi / 2)
    private var count = 0
    private var duration = 60

    
    var lblCount : UILabel = {
       let l = UILabel()
        l.textAlignment = .center
        l.textColor = .black
        l.font = UIFont.systemFont(ofSize: 14)
        l.frame = CGRect(x: 0, y: 0, width: 17, height: 18)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    var delegate: TimerViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    func createCircularPath(radius: CGFloat, lineWidth: CGFloat, bgLineColor: UIColor = .clear, progressColor: UIColor, firstDuration: Int, isHaveCountLbl: Bool = true) {
        // created circularPath for circleLayer and progressLayer
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: radius, startAngle: startPoint, endAngle: endPoint, clockwise: true)
        // circleLayer path defined to circularPath
        circleLayer.path = circularPath.cgPath
        // ui edits
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        circleLayer.lineWidth = lineWidth
        circleLayer.strokeEnd = 1.0
        circleLayer.strokeColor = bgLineColor.cgColor
        // added circleLayer to layer
        layer.addSublayer(circleLayer)
        // progressLayer path defined to circularPath
        progressLayer.path = circularPath.cgPath
        // ui edits
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = lineWidth
        progressLayer.strokeEnd = 0
        progressLayer.strokeColor = progressColor.cgColor
        
        // added progressLayer to layer
        layer.addSublayer(progressLayer)


        
        duration = firstDuration
        lblCount.text = "\(firstDuration)"
       
        
        //MARK: -Button
        if  isHaveCountLbl {
            self.addSubview(lblCount)
            lblCount.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            lblCount.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        }
       
        
        
    }
    
    func progressAnimation() {
        // created circularProgressAnimation with keyPath
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        // set the end time
        circularProgressAnimation.duration = CFTimeInterval(duration)
        circularProgressAnimation.toValue = 1.0
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = true
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
        
        lblCount.isHidden = false
        lblCount.text = "\(duration)"
        count = duration
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] timer in
            if count == 0 {
                timer.invalidate()
                lblCount.isHidden = true
                delegate?.refreshTimeView()
            } else {
                count -= 1
            }
            lblCount.text = "\(count)"
        }
    }
}
