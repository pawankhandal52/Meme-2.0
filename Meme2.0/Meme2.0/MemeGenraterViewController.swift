//
//  MemeGenraterViewController.swift
//  Meme2.0
//
//  Created by StemDot on 11/28/17.
//  Copyright © 2017 Stemdot Business Solution. All rights reserved.
//

import UIKit

class MemeGenraterViewController: UIViewController, UITextFieldDelegate,
UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    //@IBOutlet userSelectedImage: UIImageView!
    @IBOutlet var userPickedImage: UIImageView!
    @IBOutlet var camera: UIBarButtonItem!
    @IBOutlet var album: UIBarButtonItem!
    @IBOutlet var topTextField: UITextField!
    @IBOutlet var bottomTextField: UITextField!
    @IBOutlet var saveMemeButton: UIBarButtonItem!
    @IBOutlet var shareMemeOutlet: UIBarButtonItem!
    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet var bottomBar: UIToolbar!
    
    //var fontAttributes: UIFont!
    override func viewDidLoad() {
        super.viewDidLoad()
        topTextField.delegate = self
        bottomTextField.delegate = self
        
        // Do any additional setup after loading the view.
        //Chcek the camera have or not
        camera.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        shareMemeOutlet.isEnabled = false
        saveMemeButton.isEnabled = false
        //fontAttributes = fontAttributes()
        configureTextFields(textFields: [topTextField,bottomTextField])
    }

     func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "TOP"{
            self.topTextField.text = ""
        }else if textField.text == "BOTTOM"{
            self.bottomTextField.text = ""
            subscribeToKeyboardNotifications()
        }
    }
    
    //when user press the return key on the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Cancel By user to take image")
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let imageGet = info[UIImagePickerControllerOriginalImage] as? UIImage {
            userPickedImage.contentMode = .scaleAspectFill
            userPickedImage.image = imageGet
        }
        shareMemeOutlet.isEnabled = true
        saveMemeButton.isEnabled = true
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareMeme(_ sender: Any) {
        //genrate a meme image
        let myImage = generateMemedImage()
        
        let controller = UIActivityViewController(activityItems: [myImage], applicationActivities: nil)
        if let popoverPresentationController = controller.popoverPresentationController {
            popoverPresentationController.barButtonItem = (sender as! UIBarButtonItem)
        }
        
        
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func cancelMemeCreater(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
  
    @IBAction func showAlbum(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func openCamera(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func generateMemedImage() -> UIImage {
        //Hide nav and toolbar
        hideNavItems(hide: true)
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        hideNavItems(hide: false)
        return memedImage
    }
    
    @IBAction func saveMeme() {
        let meme = SentMemes(topText: self.topTextField.text!, bottomText: self.bottomTextField.text!, originImage: self.userPickedImage.image!, memedImage: generateMemedImage())
        UIImageWriteToSavedPhotosAlbum(meme.memedImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        
        // Add it to the memes array in the Application Delegate
        MemeCollection.add(meme: meme)
        
        //print("Size after save the image \(appDelegate.memes.count)")
    }
    
    //MARK: - Add image to Library
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    private func hideNavItems(hide: Bool){
        navigationController?.setNavigationBarHidden(hide, animated: false)
        
        navigationBar.isHidden = hide
        bottomBar.isHidden = hide
    }
    
    
    /* Pass an array of text fields and set the default text attributes for each */
    func configureTextFields(textFields: [UITextField?]){
        for textField in textFields{
            textField?.delegate = self
            
            /* Define default Text Attributes */
            let memeTextAttributes:[String:Any] = [
                NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
                NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
                NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 30)!,
                
            ]
            textField?.defaultTextAttributes = memeTextAttributes
            textField?.textAlignment = .center
        }
    }
    
    
    //This method is used to shift the ui up when keyboard is shown
    @objc func keyboardWillShow(_ notification:Notification) {
        
        view.frame.origin.y = 0 - getKeyboardHeight(notification)
    }
    
    
    @objc func keyboardWillHide(_ notification:Notification){
        view.frame.origin.y = 0
    }
    
    //This method is used to get the height of keyboard
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    //Subscribe when keyboard is show
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
   
    
    
}

