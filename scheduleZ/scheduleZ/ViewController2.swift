//
//  ViewController2.swift
//  scheduleZ
//
//  Created by 中村考男 on 2015/12/08.
//  Copyright © 2015年 tamagawa. All rights reserved.
//

import UIKit

class ViewController2: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var txtTitlle: UITextField!
    @IBOutlet weak var sgmKoutei: UISegmentedControl!
    @IBOutlet weak var sgmYoubi: UISegmentedControl!

    @IBOutlet weak var lblMassege: UILabel!
    @IBAction func btnVC2Next(sender: AnyObject){
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtTitlle.delegate = self
        txtTitlle.returnKeyType = .Done
        lblMassege.text = ""
    }
    
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        //遷移前に入力チェック
        if identifier == "sgNext"{
            lblMassege.text = ""
            if txtTitlle.text == "" {
                lblMassege.text = "タイトルを入力してください"
                return false
            }
            //次画面に引き継ぐ情報
            let adVc2: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            adVc2.ADTittle = txtTitlle.text
            adVc2.ADKoutei = String(sgmKoutei.selectedSegmentIndex)
            adVc2.ADYoubi = String(sgmYoubi.selectedSegmentIndex)
        }
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
