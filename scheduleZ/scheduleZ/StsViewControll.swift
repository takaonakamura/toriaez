//
//  StsViewControll.swift
//  scheduleZ
//
//  Created by 中村考男 on 2016/01/05.
//  Copyright © 2016年 tamagawa. All rights reserved.
//

import UIKit

class StsViewController: UIViewController{
    @IBOutlet weak var lblStsTittle: UILabel!
    @IBOutlet weak var lblStsKoutei: UILabel!
    @IBOutlet weak var lblStsStatus: UILabel!
    @IBOutlet weak var lblNowDate: UILabel!
    @IBOutlet weak var lblNextDate: UILabel!
    @IBOutlet weak var lblNextKotei: UILabel!
    
    var arBaseData = [String]()
    var arDates = [String]()
    var arKoteis = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ドキュメントパス
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        //ファイル名
        let fileName = "zakkuri.txt"
        let fileNamedt = "datez.txt"
        let fileNamews = "workSz.txt"
       
        //ファイルパス
        let filePath = path + "/" + fileName
        let filePathdt = path + "/" + fileNamedt
        let filePathws = path + "/" + fileNamews

        //既存ファイル存在確認
        let FileManager = NSFileManager.defaultManager()
        if FileManager.fileExistsAtPath(filePath){
            //ファイルが存在する場合
            if let array = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as? Array<String>{
                arBaseData = array
            }
        }
        if FileManager.fileExistsAtPath(filePathdt){
            //ファイルが存在する場合
            if let array = NSKeyedUnarchiver.unarchiveObjectWithFile(filePathdt) as? Array<String>{
                arDates = array
            }
        }
        if FileManager.fileExistsAtPath(filePathws){
            //ファイルが存在する場合
            if let array = NSKeyedUnarchiver.unarchiveObjectWithFile(filePathws) as? Array<String>{
                arKoteis = array
            }
        }

        lblStsTittle.text = arBaseData[0]
        var nowCount = 0
        var nowKotei = ""
        var nowJoutai = ""
        var nowDate = ""

        var nextDate = ""
        var nextKotei = "スケージュール終了！"
        
        nowCount = Int(arBaseData[5])!
        
        nowDate = arDates[nowCount]
        lblNowDate.text = nowDate
        
        nowKotei = self.koteiCDtoJP(arBaseData[6])!
        lblStsKoutei.text = nowKotei
        
        nowJoutai = self.jotaiCDtoJP(arBaseData[7])!
        lblStsStatus.text = nowJoutai
        
        if nowCount < arDates.count{
            nextDate = arDates[nowCount+1]
            nextKotei = arKoteis[nowCount+1]
        }
        lblNextDate.text = nextDate
        lblNextKotei.text = nextKotei
    }
    
    
    // 状態をコード値から日本語に変換する
    func jotaiCDtoJP(JotaiCD: String) -> String? {
        let Jotai = JotaiCD
        var JotaiJP: String = ""
        switch Jotai {
        case "0":
            JotaiJP = "まだ"
        case "1":
            JotaiJP = "まだまだ"
        case "2":
            JotaiJP = "半分？くらい"
        case "3":
            JotaiJP = "あとちょい"
        case "4":
            JotaiJP = "完了！"
        default:
            JotaiJP = "なし"
        }
        return JotaiJP
    }
    
    // 工程をコード値から日本語に変換する
    func koteiCDtoJP(koteiCD: String) -> String? {
        let kotei = koteiCD
        var koteiJP: String = ""
        switch kotei {
        case "0":
            koteiJP = "準備"
        case "1":
            koteiJP = "作成"
        case "2":
            koteiJP = "テスト"
        default:
            koteiJP = ""
        }
        return koteiJP
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
