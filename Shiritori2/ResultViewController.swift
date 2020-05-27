//
//  ResultViewController.swift
//  Shiritori2
//
//  Created by Daichi Asami on 2020/02/15.
//  Copyright © 2020 litech. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController{
    
    @IBOutlet var label2 : UILabel!
    var onenumber2 : Int!
    var twonumber2:Int!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if onenumber2 == 5{
            label2.text = "1P"
        }else{
            label2.text = "2P"
        }
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
