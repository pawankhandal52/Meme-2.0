//
//  SentMemeDescViewController.swift
//  Meme2.0
//
//  Created by StemDot on 12/4/17.
//  Copyright © 2017 Stemdot Business Solution. All rights reserved.
//

import UIKit

class SentMemeDescViewController: UIViewController {

    var memedImage:SentMemes!
    
    @IBOutlet weak var sentMemedImage:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sentMemedImage.image = memedImage.memedImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
