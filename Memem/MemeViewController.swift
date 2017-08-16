//
//  MemeViewController
//  Memem
//
//  Created by Paul Omeally on 8/8/17.
//  Copyright © 2017 Paul Omeally. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate
{
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText:UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!    
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var topToolbar: UIToolbar!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupTextField(textField: topText, text: topText.text!)
        setupTextField(textField: bottomText, text: bottomText.text!)
        shareButton.isEnabled = false
    }

    override func viewWillAppear(_ animated: Bool)
    {
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()

    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(true)
        unsubscribeFromKeyboardNotifications()
    }
    
    func manageShareButton ()
    {
        shareButton.isEnabled = true
    }
    
    func hideToolBar()
    {
        bottomToolbar.isHidden = true
        topToolbar.isHidden = true
    }
    
    func showToolbar()
    {
        bottomToolbar.isHidden = false
        topToolbar.isHidden = false
    }
    
    func setupTextField(textField: UITextField, text: String )
    {
        textField.delegate = self
        
        let memeTextAttributes:[String:Any] = [
            NSStrokeColorAttributeName:UIColor.black,
            NSForegroundColorAttributeName:UIColor.white,
            NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName: -2.0
        ]
        textField.defaultTextAttributes =  memeTextAttributes
        textField.text = text
        textField.textAlignment = NSTextAlignment.center
    }

    func subscribeToKeyboardNotifications()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(_ notification: Notification)
    {
        if bottomText.isFirstResponder
        {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(_ notification: Notification)
    {
        view!.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat
    {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue //of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    @IBAction func launchPicker(_ sender: Any)
    {
        displayImagePicker(sourceType: .photoLibrary)
    }
    
    
    @IBAction func pickAnImageFromCamera(_ sender: Any)
    {
        displayImagePicker(sourceType: .camera)
    }
    
    func displayImagePicker(sourceType: UIImagePickerControllerSourceType)
    {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType =  sourceType
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func saveMeme (_ image: UIImage)
    {
        _ = Meme(topText: topText.text!, bottomText: bottomText.text!, originalImage: imagePickerView.image, savedMeme: image)
    }

    @IBAction func shareMeme (_ sender: Any)
    {
        let image = generatedMemedImage()
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        controller.completionWithItemsHandler = { (activityType, completed, returnedItems, activityError) -> () in
            if (completed) {
                self.saveMeme(image)
                self.dismiss(animated: true, completion: nil)
            }
        }
        present(controller, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.contentMode = .scaleAspectFit
            imagePickerView.image = image
            //set share button once image is selected
            shareButton.isEnabled = true
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    func generatedMemedImage() -> UIImage
    {
        //hide toolbar
         hideToolBar()
        //render view to an image
         UIGraphicsBeginImageContext(self.view.frame.size)
         view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
         let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
         UIGraphicsEndImageContext()
         showToolbar()
        
         return memedImage
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }

}





















