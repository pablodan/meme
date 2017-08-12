//
//  ViewController.swift
//  Memem
//
//  Created by Paul Omeally on 8/8/17.
//  Copyright © 2017 Paul Omeally. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText:UITextField!
    
    let memeTextAttributes:[String:Any] = [
        NSStrokeColorAttributeName:UIColor.black,
        NSForegroundColorAttributeName:UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: 1.0
    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //align text
        topText.textAlignment = .center
        bottomText.textAlignment = .center
        
        topText.delegate = self
        bottomText.delegate = self
        
        topText.text = "TOP"
        bottomText.text = "BOTTOM"
        
        topText.defaultTextAttributes = memeTextAttributes
        bottomText.defaultTextAttributes = memeTextAttributes
    }

    override func viewWillAppear(_ animated: Bool) {
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        super.viewWillAppear(true)
        //subscribeToKeyboardNotifications()

    }

    
    @IBAction func launchPicker(_ sender: Any){
        
        let imagePicker = UIImagePickerController()
        
         imagePicker.delegate = self
         imagePicker.allowsEditing = true
         imagePicker.sourceType = .photoLibrary
        
         present(imagePicker, animated: true, completion: nil)

        
    }
    
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.contentMode = .scaleAspectFit
            imagePickerView.image = image

            dismiss(animated: true, completion: nil)
        }
        
    }
    
  
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
       
        textField.text = ""
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }

}





















