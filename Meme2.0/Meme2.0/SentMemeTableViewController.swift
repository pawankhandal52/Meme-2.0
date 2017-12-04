//
//  SentMemeTableViewController.swift
//  Meme2.0
//
//  Created by StemDot on 11/30/17.
//  Copyright © 2017 Stemdot Business Solution. All rights reserved.
//

import UIKit

class SentMemeTableViewController: UITableViewController {
    
    
    
    //var memes:[SentMemes]!
    @IBOutlet var plusSign: UIBarButtonItem!

    
    override func viewDidLoad() {
        super.viewDidLoad()
       // print("Size of meme \(memes.count)")
        
        // Do any additional setup after loading the view.
       // let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //memes = appDelegate.memes
        //print("Size of meme \(memes.count)")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       // print("Size of meme \(memes.count)")
        self.tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("tableView \(memes)")
        return MemeCollection.count()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell")!
        let me = MemeCollection.allMemes[(indexPath as NSIndexPath).row]
        print("Top Text \(me.topText)")
        // Set the name and images
        cell.textLabel?.text = me.topText
        cell.imageView?.image = me.memedImage
        
        // If the cell has a detail label, we will put the evil scheme in.
        if let detailTextLabel = cell.detailTextLabel {
            detailTextLabel.text = me.bottomText
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "SentMemeDesc") as! SentMemeDescViewController
        detailController.memedImage = MemeCollection.allMemes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    

}
