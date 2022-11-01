//
//  Alert.swift
//  Box
//
//  Created by Kuziboev Siddikjon on 11/1/22.
//

import UIKit
let SCREEN_SIZE = UIScreen.main.bounds


class Alert {
    
    enum AlertType {
    case warning
    case success
    case unknown
    case error
    }


    static var closeBtn : UIButton = {
       let b = UIButton()
        b.backgroundColor = .white
        b.layer.cornerRadius = 10
        b.addShadow(offset: CGSize(width: 0, height: 0), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2465917322), radius: 4, opacity: 1)
        b.setImage(UIImage(named: "xcancel")?.withRenderingMode(.alwaysTemplate), for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    static var timer : Timer? = nil
    static var heightConstant: CGFloat = 0

   class func calculateCollectionViewHeight(text: String) {
        heightConstant = 0
       heightConstant = text.height(withConstrainedWidth: SCREEN_SIZE.width-90, font: UIFont.systemFont(ofSize: 14))
    }
    
   class func showAlert(state: AlertType, duration: TimeInterval = 4, userInteration: Bool = true, message: String) {
    
       calculateCollectionViewHeight(text: message)
       if heightConstant < 50 {
           heightConstant = 52
       }else {
           heightConstant += 40
       }
        let view = UIView(frame: CGRect(x: 20, y: -90, width: SCREEN_SIZE.width-40, height: heightConstant))
       
        view.layer.cornerRadius = 14
//        view.backgroundColor = .white

        view.addShadow(offset: CGSize(width: 0, height: 8), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.16), radius: 16, opacity: 1)
    
        let titleLbl = UILabel()
        titleLbl.frame = view.frame
        titleLbl.textColor = .white
        titleLbl.minimumScaleFactor = 8
        titleLbl.adjustsFontSizeToFitWidth = true
        titleLbl.textAlignment = .left
        
        titleLbl.numberOfLines = 3
       titleLbl.font = UIFont.systemFont(ofSize: 14)
       
       ///XButton
       closeBtn.addTarget(self, action: #selector(Alert.refreshTimeView), for: .touchUpInside)
       
       let conViewForTimer = UIView()
       conViewForTimer.layer.cornerRadius = 16
       conViewForTimer.translatesAutoresizingMaskIntoConstraints = false
       
       
       NSLayoutConstraint.activate([
        conViewForTimer.heightAnchor.constraint(equalToConstant: 32),
        conViewForTimer.widthAnchor.constraint(equalToConstant: 32),
       ])
       
       
       let timerView = TimerView()
       timerView.createCircularPath(radius: 16, lineWidth: 2, bgLineColor: .white, progressColor: #colorLiteral(red: 1, green: 0.5659318566, blue: Float(0.5651587248), alpha: 1), firstDuration: Int(duration), isHaveCountLbl: true)
       timerView.progressAnimation()
//       timerView.delegate = self as? TimerViewDelegate
       timerView.backgroundColor = .white
       
        timerView.translatesAutoresizingMaskIntoConstraints = false
       
       
       conViewForTimer.addSubview(timerView)
       NSLayoutConstraint.activate([
        timerView.centerXAnchor.constraint(equalTo: conViewForTimer.centerXAnchor),
        timerView.centerYAnchor.constraint(equalTo: conViewForTimer.centerYAnchor),
       ])
       
       conViewForTimer.addSubview(closeBtn)
       NSLayoutConstraint.activate([
        closeBtn.centerXAnchor.constraint(equalTo: conViewForTimer.centerXAnchor),
        closeBtn.centerYAnchor.constraint(equalTo: conViewForTimer.centerYAnchor),
        closeBtn.widthAnchor.constraint(equalToConstant: 20),
        closeBtn.heightAnchor.constraint(equalToConstant: 20)
       ])
       
       ///Stack
       let h_sv = UIStackView()
       h_sv.axis = .horizontal
       h_sv.alignment = .center
       h_sv.distribution = .fill
       h_sv.spacing = 12

       h_sv.addArrangedSubview(titleLbl)
       h_sv.addArrangedSubview(conViewForTimer)
       h_sv.translatesAutoresizingMaskIntoConstraints = false

       
       view.addSubview(h_sv)
       NSLayoutConstraint.activate([
        h_sv.topAnchor.constraint(equalTo: view.topAnchor, constant: 7),
        h_sv.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
        h_sv.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
        h_sv.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -7),
       ])
       
       
        view.tag = 9981
        
       if #available(iOS 13.0, *) {
           if let window =  UIWindow.keyWindows {
               if let vi = window.viewWithTag(9981) {
                   vi.removeFromSuperview()
               }
               window.addSubview(view)
           }
       } else {
           
#warning(" have to handle ")

           // Fallback on earlier versions
       }
        
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.6, options: .curveEaseIn, animations: {
            let statusBarHeight: CGFloat
            #if swift(>=5.1)
            if #available(iOS 13, *) {
                statusBarHeight = UIWindow.keyWindows?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
            } else {
                statusBarHeight = UIApplication.shared.statusBarFrame.height
            }
            #else
            statusBarHeight = UIApplication.shared.statusBarFrame.height
            #endif
            view.transform = CGAffineTransform(translationX: 0, y: 90+statusBarHeight)
        })
       
      
        
       
       ///Gesture
        let swipee = UISwipeGestureRecognizer(target: self, action: #selector(Alert.viewSwipped))
        swipee.direction = .up
        view.addGestureRecognizer(swipee)
        
        
        titleLbl.text = message
        
        switch state {
        case .warning:
            view.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            closeBtn.tintColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        case .error:
            view.backgroundColor = #colorLiteral(red: 1, green: 0.4549019608, blue: 0.4549019608, alpha: 1)
            closeBtn.tintColor = #colorLiteral(red: 1, green: 0.4549019608, blue: 0.4549019608, alpha: 1)
        case .success:
            view.backgroundColor = .green
        case .unknown:
            view.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            closeBtn.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
       
        }
        
        timer = Timer.scheduledTimer(timeInterval: duration, target: self, selector: #selector(Alert.viewSwipped), userInfo: nil, repeats: false)
        
    }

    
    @objc class func viewSwipped() {
        timer?.invalidate()
        if #available(iOS 13.0, *) {
            if let window = UIWindow.keyWindows {
                if let view = window.viewWithTag(9981) {
                    UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: .curveEaseIn, animations: {
                        view.transform = .identity
                    }) { (_) in
                        view.removeFromSuperview()
                    }
                }
            }
        } else {
#warning(" have to handle ")
            // Fallback on earlier versions
        }
        
     }
    
}

    //MARK: -TimerViewDelegate
extension Alert {
  @objc class func refreshTimeView() {
        viewSwipped()
    }
    
    
}
