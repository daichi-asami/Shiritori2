//
//  exampleViewController.swift
//  Shiritori2
//
//  Created by Daichi Asami on 2020/02/29.
//  Copyright © 2020 litech. All rights reserved.
//

import UIKit

class exampleViewController: UIViewController {
    
    @IBOutlet weak var image : UIImageView!
    @IBOutlet var exbutton:UIButton!
    @IBOutlet var ex2button:UIButton!
    
    
    var imagearray = [String]()
    
    var number = 0
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagearray = ["ex1.png", "ex4.png", "ex6.png", "ex7.png", "ex8.png","ex9.png", "ex10.png", "ex11.png", "ex12.png", "ex13.png","ex14.png", "ex2.png", "ex15.png", "ex5.png"]
        
        image.image = UIImage(named: imagearray[number])

        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextbutton(){
        if number == 13{
            number = 13
        }else{
            number = number + 1
            image.image = UIImage(named: imagearray[number])
        }
    }
    @IBAction func backbutton(){
        if number == 0{
            number = 0
        }else{
            number = number - 1
            image.image = UIImage(named: imagearray[number])
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
