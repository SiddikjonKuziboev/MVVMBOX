//
//  LoginVC.swift
//  Box
//
//  Created by Kuziboev Siddikjon on 03/11/22.
//

import UIKit

class LoginVC: UIViewController {

   
    @IBOutlet weak var pinCodeView: UIStackView!
    @IBOutlet weak var keyboardContainerView: UIView!{
        didSet {
            keyboardContainerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            keyboardContainerView.layer.cornerRadius = 32
           
        }
    }
    @IBOutlet var pinTFView: [UIView]!
    
    @IBOutlet var btnsContainerView: [UIView]!
    
    @IBOutlet var keyboardNumberLbls: [UILabel]!{
        didSet {
            keyboardNumberLbls.forEach { lbl in
                lbl.font = UIFont.systemFont(
                    ofSize:  36,
                    weight: .regular)
                
            }
        }
    }
    
    var auth: BiometricIDAuth!
    var pinTxt = ""

    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setUpAuth()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        btnsContainerView.forEach { v in
            v.layer.cornerRadius = v.bounds.height/2
            v.clipsToBounds = true
        }
    }
    
    @IBAction func clearBtnTapped(_ sender: Any) {
        if pinTxt.count > 0 {
            pinTxt.removeLast()
            pinTFView[pinTxt.count].backgroundColor = #colorLiteral(red: 0.8040950298, green: 0.8180619478, blue: 0.8375059962, alpha: 1)
            
            debugPrint(pinTxt)
        }
    }
    @IBAction func keyboardBtnTapped(_ sender: UIButton) {
        if pinTxt.count < 6 {
            pinTxt = pinTxt + "\(sender.tag)"
            pinTFView[pinTxt.count-1].backgroundColor = #colorLiteral(red: 0.1075630262, green: 0.5864781737, blue: 0.5181127787, alpha: 1)
        }
        
        debugPrint(pinTxt)
        
        if pinTxt.count == 6 && pinTxt == "121212" {
            let vc = UserVC()
            present(vc, animated: true)
            debugPrint("Start action from here")
        }else if pinTxt.count == 6 {
            animateError()

           
        }
    }
   
    private func animateError() {
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .autoreverse) {

                self.pinCodeView.transform = CGAffineTransform.init(translationX: 20, y: 0)

    }completion: {[self] _ in

        self.pinCodeView.transform = .identity
        pinTFView.forEach { tf in
            tf.backgroundColor = #colorLiteral(red: 0.8040950298, green: 0.8180619478, blue: 0.8375059962, alpha: 1)
        }
        pinTxt = ""
    }

    }
    
}

extension LoginVC {
    func setUpAuth() {
        auth = BiometricIDAuth()
        auth.canEvaluate { (canEvaluate, type, canEvaluateError) in
            if canEvaluate {
                auth.evaluate { [weak self] (success, error) in
                    guard success else {return}
                    self?.pinTFView.forEach { tf in
                        tf.backgroundColor = #colorLiteral(red: 0.1075630262, green: 0.5864781737, blue: 0.5181127787, alpha: 1)
                    }
                    let vc = UserVC()
                    vc.modalPresentationStyle = .formSheet
                    self?.present(vc, animated: true)
                }
            }
        }
    }
    
    func alert(title: String, message: String, okActionTitle: String) {
        let alertView = UIAlertController(title: title,
                                          message: message,
                                          preferredStyle: .alert)
        let okAction = UIAlertAction(title: okActionTitle, style: .default)
        alertView.addAction(okAction)
        present(alertView, animated: true)
    }

}
