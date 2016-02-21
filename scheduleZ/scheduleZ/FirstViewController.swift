//
//  FirstViewController.swift
//  scheduleZ
//
//  Created by 中村考男 on 2016/01/15.
//  Copyright © 2016年 tamagawa. All rights reserved.
//
import UIKit

class FirstViewController: UIViewController{
    
    @IBOutlet weak var btnStart: UIButton!
    @IBAction func btnStart(sender: AnyObject) {
        
        //ドキュメントパス
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        //ファイル名
        let fileName = "zakkuri.txt"
        //ファイルパス
        let filePath = path + "/" + fileName
        //既存ファイル存在確認
        let FileManager = NSFileManager.defaultManager()
        if FileManager.fileExistsAtPath(filePath){
            //ファイルが存在する場合
            let svc:StsViewController = StsViewController()
            self.showViewController(svc, sender: nil)
//            self.presentViewController(svc, animated: true, completion: nil)
        }else{
            //ファイルが存在しない場合
            let vc:ViewController2 = ViewController2()
            self.showViewController(vc, sender: nil)
//            self.presentViewController(vc, animated: true, completion: nil)
        }

        /*
        // 遷移するViewを定義する.
        let mySecondViewController: UIViewController = SecondViewController()
        
        // アニメーションを設定する.
        mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
        
        // Viewの移動する.
        self.presentViewController(mySecondViewController, animated: true, completion: nil)
        */
        
        
    }
    
    override func viewDidLoad() {
        btnStart.hidden = true
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
