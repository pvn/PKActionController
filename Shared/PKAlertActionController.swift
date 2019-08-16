//
//  PKAlertController.swift
//  CLEARTV
//
//  Created by praveen shrivastav on 16/08/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

enum AlertTitle:String {
    case ok = "Ok"
    case cancel = "Cancel"
}

public class PKAlertActionController: NSObject {

    //MARK: variables -
    var actionHandler: (() -> Void)?
    
    fileprivate var alertController: UIAlertController?
    fileprivate var buttonTitle:String?
    fileprivate var title:String?
    fileprivate var titleDescription:String?
    fileprivate var color:UIColor?
    
    //MARK: initialize methods -
    convenience init(titleMsg: String, subtitleMsg: String) {
        self.init()
        self.defaultConfiguration()
        
        if alertController == nil {
            self.alertController = UIAlertController()
        }
        self.alertController!.title = title
        self.title = titleMsg
        self.titleDescription = subtitleMsg
    }
    
    //MARK: show alert methods -
    func showAlertController(presentedController: UIViewController) {
        
        // set message to alert
        self.setMessage()
        
        // set action to alert
        self.addAction()
        
        DispatchQueue.main.async {
            presentedController.present(self.alertController!, animated: true, completion: nil)
        }
    }
    
    //MARK: default configuration for e.g., title color as 'red' -
    func defaultConfiguration() {
        self.color = .red
        self.buttonTitle = AlertTitle.ok.rawValue
    }
    
    //MARK: set configuration to overridet the default configuration value -
    func setConfiguration(color:UIColor, buttonTitle: String) {
        self.color = color
        self.buttonTitle = buttonTitle
    }
    
    //MARK: set attributed text to title and description -
    fileprivate func getAttributedMessage() -> NSMutableAttributedString {
        
        let attributedTitle = self.textToAttributedString(self.title!, color: self.color ?? UIColor.white, fontSize: 50)
        let attributedSubTitle = self.textToAttributedString(self.titleDescription!, color:UIColor.white, fontSize: 40)
        
        return self.appendAttributedString(attributedTitle, secStr: attributedSubTitle)
    }
    
    //MARK: method to set the message to alert
    func setMessage() {
        let attributedAlertMsg = self.getAttributedMessage()
        self.alertController!.setValue(attributedAlertMsg, forKey: "attributedMessage")
    }
    
    //MARK: add action to alert -
    func addAction() {
        
        let alertAction = UIAlertAction(title: self.buttonTitle, style: .default, handler: { (actionHandler) -> Void in
            self.actionButtonClicked()
        })
        
        self.alertController?.addAction(alertAction)
    }
    
    //MARK: action methods on action button clicked
    func actionButtonClicked() {
        self.actionHandler?()
    }
    
    //MARK: dismiss alert -
    func dismissAlertController() {
        self.alertController?.dismiss(animated: true, completion: nil)
    }

    //MARK: set attributed text to title and description  with color and font size -
    fileprivate func textToAttributedString(_ text:String,color:UIColor,fontSize:CGFloat) -> NSMutableAttributedString{
        
        let attributes = [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]
        let attributetText = NSMutableAttributedString(string: "\(text)\n", attributes: attributes as [NSAttributedString.Key : Any])
        return attributetText
    }
    
    fileprivate func appendAttributedString(_ firstStr:NSMutableAttributedString, secStr:NSMutableAttributedString) -> NSMutableAttributedString {
        let appenedResult = NSMutableAttributedString()
        appenedResult.append(firstStr)
        appenedResult.append(secStr)
        return appenedResult
        
    }
}
