//
//  SentMemeCollectionViewController.swift
//  Meme2.0
//
//  Created by StemDot on 11/24/17.
//  Copyright © 2017 Stemdot Business Solution. All rights reserved.
//

import UIKit

class SentMemeCollectionViewController: UICollectionViewController {
    
    

    @IBOutlet weak var flowLayout:UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let space:CGFloat = 3.0
        let dimesion = (self.view.frame.width - (2 * space)) / 3.0
        flowLayout.minimumLineSpacing = space
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSize(width: dimesion, height: dimesion)
    }

    override func viewWillAppear(_ animated: Bool) {
        // print("Size of meme \(memes.count)")
        self.collectionView?.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "SentMemeDesc") as! SentMemeDescViewController
        detailController.memedImage = MemeCollection.allMemes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MemeCollection.count()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollection", for: indexPath) as! SentMemeCollectionCellView
        //let villain = self.allVillains[(indexPath as NSIndexPath).row]
        let me = MemeCollection.allMemes[(indexPath as NSIndexPath).row]
        
    
        cell.sentMemeViewCell?.image = me.memedImage
        
        return cell
    }
}

