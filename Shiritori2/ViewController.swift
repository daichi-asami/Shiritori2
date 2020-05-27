//
//  ViewController.swift
//  Shiritori
//
//  Created by Daichi Asami on 2019/12/07.
//  Copyright © 2019 litech. All rights reserved.
//

import UIKit
import Foundation

extension String {
/// 「カタカナ」に変換
var toKatakana: String? {
    return self.applyingTransform(.hiraganaToKatakana, reverse: false)
    }
var toHiragana: String? {
    return self.applyingTransform(.hiraganaToKatakana, reverse: true)
    }
}

class ViewController: UIViewController ,UITextFieldDelegate{
    @IBOutlet var nyuuryokufield: UITextField!
    @IBOutlet var hyouzilabel: UILabel!
    @IBOutlet var siritorilabel:UILabel!
    @IBOutlet var yosokulabel:UILabel!
    @IBOutlet var hanteilabel:UILabel!
    @IBOutlet var plabel:UILabel!
    
    
    
    @IBOutlet var yosokusurubutton:UIButton!
    @IBOutlet var siritoributton:UIButton!

    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    
    
    let hurt0 = UIImage(named: "hurt0.png")
    let hurt1 = UIImage(named: "hurt1.png")
    let hurt2 = UIImage(named: "hurt2.png")
    let hurt3 = UIImage(named: "hurt3.png")
    let hurt4 = UIImage(named: "hurt4.png")
    
    
    
    var nyuuryokuword = ""
    var yosokuword = ""
    var yosokunozoitaword = ""
    var onenumber = 0
    var twonumber = 0
    var turnnumber = 0
    
    var nyuuryokuArray : [String] = [""]
    
    var  alertContoroller: UIAlertController!
    
    var dictionary: [String: String] = [:]
    
    var imagearray = [String]()
    var imagearray2 = [String]()
    
    override func viewDidLoad() {
        
        imagearray = ["hurt0.png", "hurt1.png", "hurt2.png", "hurt3.png", "hurt4.png"]
        imagearray2 = ["hurt0.png","heart24.png", "heart23.png", "heart22.png", "heart21.png"]
        
        image1.image = UIImage(named: imagearray[onenumber])
        image2.image = UIImage(named: imagearray2[twonumber])
        
        super.viewDidLoad()
        nyuuryokufield.delegate = self
        
        yosokusurubutton.isHidden = true
        yosokusurubutton.isEnabled = false
        
        hyouzilabel.text = "り"
        plabel.text = "1Pのターン"
        plabel.textColor = UIColor.red
        yosokuword = "リ"
        turnnumber = 1
        
        // Do any additional setup after loading the view.
        
        guard let path = Bundle.main.path(forResource:"meishi", ofType:"csv") else {
            print("csvファイルがないよ")
            return
        }
        
        //csvファイルを読み出し
        let csvString = try! String(contentsOfFile: path, encoding: String.Encoding.utf8)
        //読みだしたファイルを行ごとに分割
        let csvLines = csvString.components(separatedBy: .newlines)
        
        //１行ごとにdictionaryに入れる
        for line in csvLines {
            let wordArray = line.components(separatedBy: ",")
            if wordArray.count == 2{
                dictionary[wordArray[1]] = wordArray[0]
            }
        }
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "toSecond" {
        let resultViewContoroller = segue.destination as! ResultViewController
        resultViewContoroller.onenumber2 = onenumber
        resultViewContoroller.twonumber2 = twonumber
        
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    
    func alert(title:String,message:String){
        alertContoroller = UIAlertController(title: title,message: message,preferredStyle: .alert)
        alertContoroller.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertContoroller, animated: true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    




    
    
    
    
    @IBAction func enterbutton(){
        nyuuryokuword = nyuuryokufield.text!.toKatakana!
        print(nyuuryokuword)
        
        self.view.endEditing(true)
        
        
        
        if String(hyouzilabel.text!.toKatakana!) != String(nyuuryokuword.prefix(1)){
            
            nyuuryokuword = nyuuryokufield.text!
            alert(title: "Wow!", message: " 最初の文字が違います")
            nyuuryokufield.textColor = UIColor.red
            
            
        }else if nyuuryokuArray.contains(nyuuryokuword){
            
            nyuuryokufield.textColor = UIColor.blue
            alert(title: "Wow!", message: "この単語はすでに使っています")
            
        }else if dictionary[nyuuryokufield.text!.toKatakana!] == nil{
            
            nyuuryokufield.textColor = UIColor.red
            alert(title: "Sorry..", message: "この単語は辞書にありません")
        }else if String(nyuuryokuword.suffix(1)) == "ン"{
            alert(title: "注意", message: "最後が『ん』だよ！")
        }else if String(nyuuryokuword.suffix(1)) == "ー"{
            alert(title: "Sorry..", message: "最後が『ー』はやめて！")
        }else if String(nyuuryokuword.suffix(1)) == "ャ"{
            nyuuryokuword = String(nyuuryokuword.prefix(nyuuryokuword.count - 1)) + "ヤ"
            nyuuryokufield.text = ""
            
            nyuuryokuArray.append(nyuuryokuword)
            print(nyuuryokuArray)
                
                if turnnumber == 1{
                    turnnumber = 2
                }else{
                    turnnumber = 1
                }
                    
                     if turnnumber == 2{
                         plabel.text = "2Pのターン"
                        plabel.textColor = UIColor.blue
                     }else{
                         plabel.text = "1Pのターン"
                        plabel.textColor = UIColor.red
                     }
                
                
                
                
                    siritoributton.isHidden = true
                    siritoributton.isEnabled = false
                    
                    yosokusurubutton.isHidden = false
                    yosokusurubutton.isEnabled = true
                    
                   
            
                    image1.image = UIImage(named: imagearray[onenumber])
                    image2.image = UIImage(named: imagearray2[twonumber])
            
            
            
            
        }else if String(nyuuryokuword.suffix(1)) == "ュ"{
        nyuuryokuword = String(nyuuryokuword.prefix(nyuuryokuword.count - 1)) + "ユ"
        print(nyuuryokuword)
            
        nyuuryokufield.text = ""
        
        nyuuryokuArray.append(nyuuryokuword)
        print(nyuuryokuArray)
            
            if turnnumber == 1{
                turnnumber = 2
            }else{
                turnnumber = 1
            }
                
                 if turnnumber == 2{
                     plabel.text = "2Pのターン"
                    plabel.textColor = UIColor.blue
                 }else{
                     plabel.text = "1Pのターン"
                    plabel.textColor = UIColor.red
                 }
            
            
            
            
                siritoributton.isHidden = true
                siritoributton.isEnabled = false
                
                yosokusurubutton.isHidden = false
                yosokusurubutton.isEnabled = true
                
               
        
                image1.image = UIImage(named: imagearray[onenumber])
                image2.image = UIImage(named: imagearray2[twonumber])
        
        
            
        }else if String(nyuuryokuword.suffix(1)) == "ョ"{
        nyuuryokuword = String(nyuuryokuword.prefix(nyuuryokuword.count - 1)) + "ヨ"
        print(nyuuryokuword)
            
        nyuuryokufield.text = ""
        
        nyuuryokuArray.append(nyuuryokuword)
        print(nyuuryokuArray)
            
            if turnnumber == 1{
                turnnumber = 2
            }else{
                turnnumber = 1
            }
                
                 if turnnumber == 2{
                     plabel.text = "2Pのターン"
                    plabel.textColor = UIColor.blue
                 }else{
                     plabel.text = "1Pのターン"
                    plabel.textColor = UIColor.red
                 }
            
            
            
            
                siritoributton.isHidden = true
                siritoributton.isEnabled = false
                
                yosokusurubutton.isHidden = false
                yosokusurubutton.isEnabled = true
                
               
        
                image1.image = UIImage(named: imagearray[onenumber])
                image2.image = UIImage(named: imagearray2[twonumber])
        
        
            
        }else if String(nyuuryokuword.suffix(1)) == "ァ"{
        nyuuryokuword = String(nyuuryokuword.prefix(nyuuryokuword.count - 1)) + "ア"
        print(nyuuryokuword)
            
        nyuuryokufield.text = ""
        
        nyuuryokuArray.append(nyuuryokuword)
        print(nyuuryokuArray)
            
            if turnnumber == 1{
                turnnumber = 2
            }else{
                turnnumber = 1
            }
                
                 if turnnumber == 2{
                     plabel.text = "2Pのターン"
                    plabel.textColor = UIColor.blue
                 }else{
                     plabel.text = "1Pのターン"
                    plabel.textColor = UIColor.red
                 }
            
            
            
            
                siritoributton.isHidden = true
                siritoributton.isEnabled = false
                
                yosokusurubutton.isHidden = false
                yosokusurubutton.isEnabled = true
                
               
        
                image1.image = UIImage(named: imagearray[onenumber])
                image2.image = UIImage(named: imagearray2[twonumber])
        
        
            
        }else if String(nyuuryokuword.suffix(1)) == "ィ"{
        nyuuryokuword = String(nyuuryokuword.prefix(nyuuryokuword.count - 1)) + "イ"
        print(nyuuryokuword)
            
        nyuuryokufield.text = ""
        
        nyuuryokuArray.append(nyuuryokuword)
        print(nyuuryokuArray)
            
            if turnnumber == 1{
                turnnumber = 2
            }else{
                turnnumber = 1
            }
                
                 if turnnumber == 2{
                     plabel.text = "2Pのターン"
                    plabel.textColor = UIColor.blue
                 }else{
                     plabel.text = "1Pのターン"
                    plabel.textColor = UIColor.red
                 }
            
            
            
            
                siritoributton.isHidden = true
                siritoributton.isEnabled = false
                
                yosokusurubutton.isHidden = false
                yosokusurubutton.isEnabled = true
                
               
        
                image1.image = UIImage(named: imagearray[onenumber])
                image2.image = UIImage(named: imagearray2[twonumber])
        
        
            
        }else if String(nyuuryokuword.suffix(1)) == "ゥ"{
        nyuuryokuword = String(nyuuryokuword.prefix(nyuuryokuword.count - 1)) + "ウ"
        print(nyuuryokuword)
            
        nyuuryokufield.text = ""
        
        nyuuryokuArray.append(nyuuryokuword)
        print(nyuuryokuArray)
            
            if turnnumber == 1{
                turnnumber = 2
            }else{
                turnnumber = 1
            }
                
                 if turnnumber == 2{
                     plabel.text = "2Pのターン"
                    plabel.textColor = UIColor.blue
                 }else{
                     plabel.text = "1Pのターン"
                    plabel.textColor = UIColor.red
                 }
            
            
            
            
                siritoributton.isHidden = true
                siritoributton.isEnabled = false
                
                yosokusurubutton.isHidden = false
                yosokusurubutton.isEnabled = true
                
               
        
                image1.image = UIImage(named: imagearray[onenumber])
                image2.image = UIImage(named: imagearray2[twonumber])
        
        
            
        }else if String(nyuuryokuword.suffix(1)) == "ェ"{
        nyuuryokuword = String(nyuuryokuword.prefix(nyuuryokuword.count - 1)) + "エ"
        print(nyuuryokuword)
            
        nyuuryokufield.text = ""
        
        nyuuryokuArray.append(nyuuryokuword)
        print(nyuuryokuArray)
            
            if turnnumber == 1{
                turnnumber = 2
            }else{
                turnnumber = 1
            }
                
                 if turnnumber == 2{
                     plabel.text = "2Pのターン"
                    plabel.textColor = UIColor.blue
                 }else{
                     plabel.text = "1Pのターン"
                    plabel.textColor = UIColor.red
                 }
            
            
            
            
                siritoributton.isHidden = true
                siritoributton.isEnabled = false
                
                yosokusurubutton.isHidden = false
                yosokusurubutton.isEnabled = true
                
               
        
                image1.image = UIImage(named: imagearray[onenumber])
                image2.image = UIImage(named: imagearray2[twonumber])
        
        
            
        }else if String(nyuuryokuword.suffix(1)) == "ォ"{
        nyuuryokuword = String(nyuuryokuword.prefix(nyuuryokuword.count - 1)) + "オ"
        print(nyuuryokuword)
            
        nyuuryokufield.text = ""
        
        nyuuryokuArray.append(nyuuryokuword)
        print(nyuuryokuArray)
            
            if turnnumber == 1{
                turnnumber = 2
            }else{
                turnnumber = 1
            }
                
                 if turnnumber == 2{
                     plabel.text = "2Pのターン"
                    plabel.textColor = UIColor.blue
                 }else{
                     plabel.text = "1Pのターン"
                    plabel.textColor = UIColor.red
                 }
            
            
            
            
                siritoributton.isHidden = true
                siritoributton.isEnabled = false
                
                yosokusurubutton.isHidden = false
                yosokusurubutton.isEnabled = true
                
               
        
                image1.image = UIImage(named: imagearray[onenumber])
                image2.image = UIImage(named: imagearray2[twonumber])
        
        
            
        }
        else{
            nyuuryokuword = nyuuryokufield.text!.toKatakana!
            nyuuryokufield.textColor = UIColor.black
                    
            nyuuryokufield.text = ""
            
            nyuuryokuArray.append(nyuuryokuword)
            print(nyuuryokuArray)
                
                if turnnumber == 1{
                    turnnumber = 2
                }else{
                    turnnumber = 1
                }
                    
                     if turnnumber == 2{
                         plabel.text = "2Pのターン"
                        plabel.textColor = UIColor.blue
                     }else{
                         plabel.text = "1Pのターン"
                        plabel.textColor = UIColor.red
                     }
                
                
                
                
                    siritoributton.isHidden = true
                    siritoributton.isEnabled = false
                    
                    yosokusurubutton.isHidden = false
                    yosokusurubutton.isEnabled = true
                    
                   
            
                    image1.image = UIImage(named: imagearray[onenumber])
                    image2.image = UIImage(named: imagearray2[twonumber])
            
        }
     }
    
    
    
    
    
    
    
    
    @IBAction func yosokubutton(){
        self.view.endEditing(true)
        
        yosokuword = nyuuryokufield.text!.toKatakana!
        
        print(yosokuword.prefix(1))
        print(nyuuryokuword.suffix(1))
        print(String(nyuuryokuword.suffix(1)) != String(yosokuword.prefix(1)))
        print(yosokuword != "")
        print(dictionary[nyuuryokufield.text!.toKatakana!] != nil)
        print(String(yosokuword.suffix(1)) != "ン")
        print(yosokuword.suffix(1) != "ー")
        
        print(String(nyuuryokuword.suffix(1)) != String(yosokuword.prefix(1)) && yosokuword != "" && dictionary[nyuuryokufield.text!.toKatakana!] != nil && String(yosokuword.suffix(1)) != "ン" && yosokuword.suffix(1) != "ー")
        
        
        
        
        if (String(nyuuryokuword.suffix(1)) != String(yosokuword.prefix(1)) && yosokuword != "" && dictionary[nyuuryokufield.text!.toKatakana!] != nil && String(yosokuword.suffix(1)) != "ン" && yosokuword.suffix(1) != "ー"){
            
            hyouzilabel.text = String(nyuuryokuword.toHiragana!.suffix(1))
            nyuuryokufield.textColor = UIColor.black
            yosokulabel.text = String(yosokuword)
            siritorilabel.text = String(nyuuryokuword)
            nyuuryokufield.text = ""
            
            hanteilabel.text = "残念！"
            print(1)
            
           
            
            
            
            if turnnumber == 1{
                turnnumber = 1
            }else{
                turnnumber = 2
            }
            
            if turnnumber == 2{
                plabel.textColor = UIColor.blue
                plabel.text = "2Pのターン"
            }else{
                plabel.textColor = UIColor.red
                plabel.text = "1Pのターン"
            }
            turnnumber = 2
            
            
            
            image1.image = UIImage(named: imagearray[onenumber])
            image2.image = UIImage(named: imagearray2[twonumber])
            
            siritoributton.isHidden = false
            siritoributton.isEnabled = true
            
            yosokusurubutton.isHidden = true
            yosokusurubutton.isEnabled = false
                   
        }else if yosokuword == "" {
            yosokuword = ""
        }else if dictionary[nyuuryokufield.text!.toKatakana!] == nil{
            alert(title: "Sorry...", message: "この単語は辞書にありません")
        }else if yosokuword.suffix(1) == "ン"{
            alert(title: "注意", message: "最後が『ん』だよ！")
        }else if yosokuword.suffix(1) == "ー" && String(nyuuryokuword.suffix(1)) != String(yosokuword.prefix(1)){
                yosokunozoitaword = String(yosokuword.prefix(yosokuword.count - 1))
            hyouzilabel.text = String(nyuuryokuword.toHiragana!.suffix(1))
//                alert(title: "ひゃ", message: "ふふ")
               
                nyuuryokufield.textColor = UIColor.black
                yosokulabel.text = String(yosokuword)
                siritorilabel.text = String(nyuuryokuword)
                nyuuryokufield.text = ""
                
                hanteilabel.text = "残念！"
                
                
                
                
                if turnnumber == 1{
                    turnnumber = 1
                }else{
                    turnnumber = 2
                }
                
                if turnnumber == 2{
                    plabel.text = "2Pのターン"
                    plabel.textColor = UIColor.blue
                }else{
                    plabel.text = "1Pのターン"
                    plabel.textColor = UIColor.red
                }
                turnnumber = 2
                
                
            
                image1.image = UIImage(named: imagearray[onenumber])
                image2.image = UIImage(named: imagearray2[twonumber])
                
                siritoributton.isHidden = false
                siritoributton.isEnabled = true
                
                yosokusurubutton.isHidden = true
                yosokusurubutton.isEnabled = false
            
        }else if yosokuword.suffix(1) == "ー" && String(nyuuryokuword.suffix(1)) == String(yosokuword.prefix(1)){
            
            yosokunozoitaword = String(yosokuword.prefix(yosokuword.count - 1))
            hyouzilabel.text = String(nyuuryokuword.toHiragana!.suffix(1))
            
            nyuuryokufield.textColor = UIColor.black
            yosokulabel.text = String(yosokuword)
            siritorilabel.text = String(nyuuryokuword)
            nyuuryokufield.text = ""
            hanteilabel.text = "正解！"
            
            if turnnumber == 1{
                turnnumber = 2
            }else{
                turnnumber = 1
            }
            
            if turnnumber == 2{
                plabel.text = "2Pのターン"
                plabel.textColor = UIColor.blue
            }else{
                plabel.text = "1Pのターン"
                plabel.textColor = UIColor.red
            }
            turnnumber = 1
            
            if turnnumber == 2{
                onenumber = onenumber + 1
            }else{
                twonumber = twonumber + 1
            }
            
            if onenumber == 4 || twonumber == 4{
                self.performSegue(withIdentifier: "toSecond", sender: self)
            }
            
            
            
            image1.image = UIImage(named: imagearray[onenumber])
            image2.image = UIImage(named: imagearray2[twonumber])
            
            siritoributton.isHidden = false
            siritoributton.isEnabled = true
            
            yosokusurubutton.isHidden = true
            yosokusurubutton.isEnabled = false
            

            
        }else{
            nyuuryokufield.textColor = UIColor.black
            yosokulabel.text = String(yosokuword)
            siritorilabel.text = String(nyuuryokuword)
            nyuuryokufield.text = ""
            hyouzilabel.text = String(nyuuryokuword.toHiragana!.suffix(1))
            hanteilabel.text = "正解！"
            
            if turnnumber == 1{
                turnnumber = 2
            }else{
                turnnumber = 1
            }
            
            if turnnumber == 2{
                plabel.text = "2Pのターン"
                plabel.textColor = UIColor.blue
            }else{
                plabel.text = "1Pのターン"
                plabel.textColor = UIColor.red
            }
//            turnnumber = 1
            
            if turnnumber == 2{
                onenumber = onenumber + 1
            }else{
                twonumber = twonumber + 1
            }
            if onenumber == 4 || twonumber == 4{
                self.performSegue(withIdentifier: "toSecond", sender: self)
            }
            
           
            
            image1.image = UIImage(named: imagearray[onenumber])
            image2.image = UIImage(named: imagearray2[twonumber])
            
            siritoributton.isHidden = false
            siritoributton.isEnabled = true
            
            yosokusurubutton.isHidden = true
            yosokusurubutton.isEnabled = false
            

        }
        
    }
    
    

}
