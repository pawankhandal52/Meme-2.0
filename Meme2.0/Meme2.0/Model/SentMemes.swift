//
//  SentMemes.swift
//  Meme2.0
//
//  Created by StemDot on 11/30/17.
//  Copyright © 2017 Stemdot Business Solution. All rights reserved.
//

import Foundation
import UIKit
struct  SentMemes {
    var topText:String!
    var bottomText:String!
    var originImage:UIImage!
    var memedImage: UIImage!
    
    init(topText:String,bottomText:String,originImage: UIImage, memedImage:UIImage) {
        self.topText = topText
        self.bottomText  = bottomText
        self.originImage = originImage
        self.memedImage = memedImage
    }
}

func ==(lhs: SentMemes, rhs: SentMemes) -> Bool {
    return lhs.memedImage == rhs.memedImage
}
/* Convenience methods and variables for accessing and altering the collection of Memes */
struct MemeCollection {
    
    /* Get all memes from our app delegate */
    static var allMemes: [SentMemes] {
        return getMemeStorage().memes
    }
    
    /* Return a Meme at a given index */
    static func getMeme(atIndex index: Int) -> SentMemes {
        return allMemes[index]
    }
    
    /* Find the index of a given Meme */
    static func indexOf(meme: SentMemes) -> Int {
        
        /* If the meme is in the collection, return first index, otherwise return count of Memes */
        if let index = allMemes.index(where: {$0 == meme}) {
            return Int(index)
        } else {
            print(allMemes.count)
            return allMemes.count
        }
    }
    
    /* Add a meme to the last position of the meme collection */
    static func add(meme: SentMemes) {
        getMemeStorage().memes.append(meme)
    }
    
    /* Update a given Meme with a new Meme at a given index */
    static func update(atIndex index: Int, withMeme meme: SentMemes) {
        getMemeStorage().memes[index] = meme
    }
    
    /* Remove a Meme at a given index */
    static func remove(atIndex index: Int) {
        getMemeStorage().memes.remove(at: index)
    }
    
    /* Get a count of all Memes in our Meme Collection */
    static func count() -> Int {
        return getMemeStorage().memes.count
    }
    
    /* Locate the Meme storage location in our App Delegate */
    static func getMemeStorage() -> AppDelegate {
        let object = UIApplication.shared.delegate
        return object as! AppDelegate
    }
}
