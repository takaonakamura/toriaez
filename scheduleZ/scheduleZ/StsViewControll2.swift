//
//  StsViewControll2.swift
//  scheduleZ
//
//  Created by 中村考男 on 2016/01/17.
//  Copyright © 2016年 tamagawa. All rights reserved.
//

import UIKit

class StsViewController2: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    @IBOutlet weak var tbvStatus: UITableView!
    var arBaseData = [String]()

    var arDates = [String]()
    var arKoteis = [String]()
    var arStss = [String]()
    let pvJoutai = UIPickerView()
    var selJotai = ""
    let arJotaiItems = ["まだまだ", "半分？くらい","あとちょい","完了！"]
    override func viewDidLoad() {
        super.viewDidLoad()

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
        if FileManager.fileExistsAtPath(filePathst){
            //ファイルが存在する場合
            if let array = NSKeyedUnarchiver.unarchiveObjectWithFile(filePathst) as? Array<String>{
                arStss = array
            }
        }

    }
    @IBAction func btnStsUpdate(sender: AnyObject) {
        //ドキュメントパス
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        //ファイル名
        let fileName = "zakkuri.txt"
        let fileNamest = "stsz.txt"
        //ファイルパス
        let filePath = path + "/" + fileName
        let filePathst = path + "/" + fileNamest
        //保存配列(基本情報)編集
        //工程と状態の更新
        var intUpdPosition = 0
        let intStsCnt: Int = arStss.count
        for (var i = 0; i < intStsCnt ; i++) {
            if arStss[i] != "0"{
                intUpdPosition = i
            }
        }
        arBaseData[5] = String(intUpdPosition)
        arBaseData[6] = koteiJPtoCD(arKoteis[intUpdPosition])!
        arBaseData[7] = arStss[intUpdPosition]

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
        let resultSt = NSKeyedArchiver.archiveRootObject(arStss, toFile: filePathst)
        if resultSt{
            print("状態ファイル保存成功")
        }

    }
    
    
    func tableView(tbvStatus: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arDates.count
    }
    //各セルの要素を設定する
    func tableView(tbvStatus: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tbvStatus.dequeueReusableCellWithIdentifier("stsCell", forIndexPath: indexPath) as! stTableViewCell
        cell.lblStDate.text = arDates[indexPath.row]
        cell.lblStWS.text = arKoteis[indexPath.row]
        
        let Joutai = jotaiCDtoJP(arStss[indexPath.row])
        cell.lblStSTS.text =  Joutai!
        return cell
    }
    
    
    func tableView(tbvStatus: UITableView,
        willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
            return indexPath
    }
    
    func tableView(tbvStatus: UITableView,
        didSelectRowAtIndexPath indexPath: NSIndexPath) {
            let title = "進捗更新"
            let rowValue = arDates[indexPath.row]
            let message = "\(rowValue)の進捗を更新してください \n\n\n\n\n\n\n\n\n"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "変更", style: UIAlertActionStyle.Default,handler:{
                (action: UIAlertAction!) -> Void in
                
                if self.selJotai != ""{
                   let updJotai = self.jotaiJPtoCD(self.selJotai)
                    self.arStss[indexPath.row] = updJotai!
                }
                else{
                    self.arStss[indexPath.row] = "1"
                }
                self.tbvStatus.reloadData()
            })
            let cancelAction = UIAlertAction(title: "キャンセル", style: .Cancel) { action in}
            // PickerView
            pvJoutai.selectRow(1, inComponent: 0, animated: true)
            pvJoutai.frame = CGRectMake(0, 50, view.bounds.width * 0.65, 150)
            pvJoutai.dataSource = self
            pvJoutai.delegate = self
            alert.view.addSubview(pvJoutai)
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            presentViewController(alert, animated: true, completion: nil)
    }
    
    
    // PickerViewの列数
    func numberOfComponentsInPickerView(pvJoutai: UIPickerView) -> Int {
        return 1
    }
    
    // PickerViewの行数
    func pickerView(pvJoutai: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arJotaiItems.count
    }

    // PickerViewの項目
    func pickerView(pvJoutai: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arJotaiItems[row]
    }
    
    // PickerViewの項目選択時
    func pickerView(pvJoutai: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            selJotai = arJotaiItems[row]
    }

    
    // 状態を日本語からコード値に変換する
    func jotaiJPtoCD(JoutaiJP: String) -> String? {
        let Jotai = JoutaiJP
        var JotaiCD: String = ""
        switch Jotai {
        case "まだ":
            JotaiCD = "0"
        case "まだまだ":
            JotaiCD = "1"
        case "半分？くらい":
            JotaiCD = "2"
        case "あとちょい":
            JotaiCD = "3"
        case "完了！":
            JotaiCD = "4"
        default:
            JotaiCD  = ""
        }
        return JotaiCD
    }
    // 状態をコード値から日本語に変換する
    func jotaiCDtoJP(JotaiCD: String) -> String? {
        let Jotai = JotaiCD
        var JotaiJP: String = ""
        switch Jotai {
            case "0":
            JotaiJP =  "まだ"
            case "1":
            JotaiJP =  "まだまだ"
            case "2":
            JotaiJP =  "半分？くらい"
            case "3":
            JotaiJP = "あとちょい"
            case "4":
            JotaiJP =  "完了！"
            default:
            JotaiJP  = "なし"
            }
        return JotaiJP
    }

    // をコード値から日本語に変換する
    func koteiJPtoCD(koteiJP: String) -> String? {
        let kotei = koteiJP
        var koteiCD: String = ""
        switch kotei {
        case "準備":
            koteiCD = "0"
        case "作成":
            koteiCD = "1"
        case "テスト":
            koteiCD = "2"
        default:
            koteiCD = ""
        }
        return koteiCD
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}