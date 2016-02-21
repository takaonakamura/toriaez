//
//  ViewController.swift
//  scheduleZ
//
//  Created by 中村考男 on 2015/12/07.
//  Copyright © 2015年 tamagawa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnSinchoku: UIButton!
    @IBOutlet weak var btnNewSc: UIButton!
    override func viewDidLoad() {
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
            btnNewSc.hidden = false
            btnSinchoku.hidden = false
        }else{
            //ファイルが存在しない場合
            btnNewSc.hidden = false
            btnSinchoku.hidden = true
        }

        
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

