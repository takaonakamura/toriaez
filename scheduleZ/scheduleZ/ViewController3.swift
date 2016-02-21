//
//  ViewController3.swift
//  scheduleZ
//
//  Created by 中村考男 on 2015/12/08.
//  Copyright © 2015年 tamagawa. All rights reserved.
//

import UIKit

class ViewController3: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var txtDays: UITextField!
    
    @IBOutlet weak var txtSDate: UITextField!
    
    @IBOutlet weak var lblTittle: UILabel!
    @IBOutlet weak var lblKotei: UILabel!
    @IBOutlet weak var lblYoubi: UILabel!
    
    @IBOutlet weak var lblMessage01: UILabel!
    @IBOutlet weak var lblMessage02: UILabel!

    var kote: String = ""
    var koutei: String = ""
    var weeks: String = ""
    var youbi: String = ""

    //セーブボタン
    @IBAction func btnSave(sender: AnyObject) {}
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            txtDays.delegate = self
            txtSDate.delegate = self
            
            //初期値を設定する
            txtDays.text = "3"
            let now = NSDate()
            let formatter = NSDateFormatter()
            formatter.dateFormat = "yyyy/MM/dd"
            txtSDate.text = formatter.stringFromDate(now)
            
            
            
            //AppDelegateの変数を使うよ
            let rcvApp: AppDelegate=(UIApplication.sharedApplication().delegate as! AppDelegate)
            
            //前画面からデータ引継ぎ
            lblTittle.text = rcvApp.ADTittle
            
            kote = rcvApp.ADKoutei!
            switch kote {
            case "0":
                koutei = "準備"
            case "1":
                koutei = "作成"
            case "2":
                koutei = "テスト"
            default:
                koutei = "なし"
            }
            lblKotei.text = koutei
            
            weeks = rcvApp.ADYoubi!
            switch weeks {
            case "0":
                youbi = "休日"
            case "1":
                youbi = "平日"
            case "2":
                youbi = "毎日"
            default:
                youbi = "なし"
            }
            lblYoubi.text = youbi
            lblMessage01.text = ""
            lblMessage02.text = ""
            
            
        }

    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if identifier == "sgSave"{
            lblMessage01.text = ""
            lblMessage02.text = ""
            if txtDays.text == "" {
                lblMessage01.text = "日数を入力してください"
                return false
            }
            if Int(txtDays.text!) < 3 || Int(txtDays.text!) > 40 {
                lblMessage01.text = "日数入力は３から４０までです。"
                return false
            }
            if txtSDate.text == "" {
                lblMessage02.text = "開始日を入力してください"
                return false
            }
            
        //基準日
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let kijunDate = formatter.dateFromString(txtSDate.text!)
        var arDateData:[String] = []
        var arKoteData:[String] = []
        var arStsData:[String] = []
        let days = Int(txtDays.text!)
        var intPlanDays:Int = 0
        var intDoDays:Int = 0
        var intTestDays:Int = 0
        var i:Int = 1
        var n:Int = 1
        var strChoisKotei: String = ""
        
        //工程按分
        let impKote = days! % 3
        let norKote = (days! - impKote) / 3
        
        switch kote {
        case "0":
            if impKote == 0 && norKote == 1{
                intPlanDays = norKote
                intDoDays = norKote
                intTestDays = norKote
            }else if impKote == 0 && norKote > 1{
                intPlanDays = norKote + 2
                intDoDays = norKote - 1
                intTestDays = norKote - 1
            }else{
                intPlanDays = norKote + impKote
                intDoDays = norKote
                intTestDays = norKote
            }
        case "1":
            if impKote == 0 && norKote == 1{
                intPlanDays = norKote
                intDoDays = norKote
                intTestDays = norKote
            }else if impKote == 0 && norKote > 1{
                intPlanDays = norKote - 1
                intDoDays = norKote + 2
                intTestDays = norKote - 1
            }else{
                intPlanDays = norKote
                intDoDays = norKote + impKote
                intTestDays = norKote
            }
            
        case "2":
            if impKote == 0 && norKote == 1{
                intPlanDays = norKote
                intDoDays = norKote
                intTestDays = norKote
            }else if impKote == 0 && norKote > 1{
                intPlanDays = norKote - 1
                intDoDays = norKote - 1
                intTestDays = norKote + 2
            }else{
                intPlanDays = norKote
                intDoDays = norKote
                intTestDays = norKote + impKote
            }
        default:
            intPlanDays = norKote
            intDoDays = norKote
            intTestDays = norKote + impKote
            
        }
        
        //対象日付取得
        switch weeks {
        case "0":
            //土日
            while i < days! + 1{
                //下記の処理を日数分繰り返す
                //日付の取得
                n += 1
                let addDate = NSDate(timeInterval: 24*60*60*Double(n), sinceDate: kijunDate!);//1日後
                //日付から曜日を取得する
                let cal = NSCalendar.currentCalendar()
                let comp = cal.components(NSCalendarUnit.Weekday, fromDate: addDate)
                let weekIdx = comp.weekday // 1 (1 ~ 7までの数値で日曜日〜月曜日を返す)
                //対象曜日の判定
                switch weekIdx {
                case 1,7:
                    //対象曜日の場合、日付と工程と進捗状態を保存してカウントを１加算する
                    //工程を選択する
                    if case 1...intPlanDays = i {
                        strChoisKotei = "準備"
                    }
                    else if case intPlanDays + 1...intPlanDays + intDoDays = i {
                        strChoisKotei = "作成"
                    }
                    else {
                        strChoisKotei = "テスト"
                    }
                    arDateData.append(formatter.stringFromDate(addDate))
                    arKoteData.append(strChoisKotei)
                    arStsData.append("0")
                    i += 1
                default: continue
                }
            }
            
        case "1":
            //平日
            while i < days! + 1{
                //下記の処理を日数分繰り返す
                //日付の取得
                n += 1
                let addDate = NSDate(timeInterval: 24*60*60*Double(n), sinceDate: kijunDate!);//1日後
                //日付から曜日を取得する
                let cal = NSCalendar.currentCalendar()
                let comp = cal.components(NSCalendarUnit.Weekday, fromDate: addDate)
                let weekIdx = comp.weekday // 1 (1 ~ 7までの数値で日曜日〜月曜日を返す)
                //対象曜日の判定
                switch weekIdx {
                case 2,3,4,5,6:
                    //対象曜日の場合、日付と工程と進捗状態を保存してカウントを１加算する
                    //工程を選択する
                    if case 1...intPlanDays = i {
                        strChoisKotei = "準備"
                    }
                    else if case intPlanDays + 1...intPlanDays + intDoDays = i {
                        strChoisKotei = "作成"
                    }
                    else {
                        strChoisKotei = "テスト"
                    }
                    arDateData.append(formatter.stringFromDate(addDate))
                    arKoteData.append(strChoisKotei)
                    arStsData.append("0")
                    i += 1
                default: continue
                }
            }
            
        case "2":
            //毎日
            for i in 1...days! {
                let addDate = NSDate(timeInterval: 24*60*60*Double(i), sinceDate: kijunDate!);//1日後
                //対象曜日の場合、日付と工程と進捗状態を保存してカウントを１加算する
                //工程を選択する
                if case 1...intPlanDays = i {
                    strChoisKotei = "準備"
                }
                else if case intPlanDays + 1...intPlanDays + intDoDays = i {
                    strChoisKotei = "作成"
                }
                else {
                    strChoisKotei = "テスト"
                }
                arDateData.append(formatter.stringFromDate(addDate))
                arKoteData.append(strChoisKotei)
                arStsData.append("0")
            }
            
        default:
            break
        }
        
        //ドキュメントパス
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        //ファイル名
        let fileName = "zakkuri.txt"
        let fileNamedt = "datez.txt"
        let fileNamews = "workSz.txt"
        let fileNamest = "stsz.txt"
        //ファイルパス
        let filePath = path + "/" + fileName
        let filePathdt = path + "/" + fileNamedt
        let filePathws = path + "/" + fileNamews
        let filePathst = path + "/" + fileNamest
        //保存配列(基本情報)
        var arBaseData:[String] = [lblTittle.text!,kote,weeks,txtDays.text!,txtSDate.text!,"0"]
        //保存配列(追加情報)
        arBaseData.append("0")
        arBaseData.append("0")
        //既存ファイル存在確認
        
        let FileManager = NSFileManager.defaultManager()
        if FileManager.fileExistsAtPath(filePath){
            //ファイルが存在する場合
            //ファイル削除
            do {
                try NSFileManager.defaultManager().removeItemAtPath(filePath)
            } catch {
                // Failed to write file
            }
            
        }
        if FileManager.fileExistsAtPath(filePathdt){
            //日付ファイルが存在する場合
            //ファイル削除
            do {
                try NSFileManager.defaultManager().removeItemAtPath(filePathdt)
            } catch {
                // Failed to write file
            }
            
        }
        if FileManager.fileExistsAtPath(filePathws){
            //工程ファイルが存在する場合
            //ファイル削除
            do {
                try NSFileManager.defaultManager().removeItemAtPath(filePathws)
            } catch {
                // Failed to write file
            }
            
        }
        if FileManager.fileExistsAtPath(filePathst){
            //状態ファイルが存在する場合
            //ファイル削除
            do {
                try NSFileManager.defaultManager().removeItemAtPath(filePathst)
            } catch {
                // Failed to write file
            }
            
        }
        // 保存処理
        let result = NSKeyedArchiver.archiveRootObject(arBaseData, toFile: filePath)
        if result{
            print("基本ファイル保存成功")
        }
        let resultDt = NSKeyedArchiver.archiveRootObject(arDateData, toFile: filePathdt)
        if resultDt{
            print("日付ファイル保存成功")
        }
        let resultWs = NSKeyedArchiver.archiveRootObject(arKoteData, toFile: filePathws)
        if resultWs{
            print("工程ファイル保存成功")
        }
        let resultSt = NSKeyedArchiver.archiveRootObject(arStsData, toFile: filePathst)
        if resultSt{
            print("状態ファイル保存成功")
            }
        }

        
        return true
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField == txtSDate{
            //DatePiker設定(日付のみ・日本語・今日日付以降)
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = UIDatePickerMode.Date
            datePicker.locale = NSLocale(localeIdentifier: "ja")
            datePicker.minimumDate = NSDate()
            textField.inputView = datePicker
            datePicker.addTarget(self, action: "datePikerChanged:", forControlEvents: .ValueChanged)
        }
        
    }
    
    func datePikerChanged(sender:UIDatePicker){
        //開始日テキスト出力
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        txtSDate.text = formatter.stringFromDate(sender.date)
    
    }
    
    
    //mark: touch events
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
