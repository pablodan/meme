//
//  ViewController.swift
//  Memem
//
//  Created by Paul Omeally on 8/8/17.
//  Copyright © 2017 Paul Omeally. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var imagePickerView: UIImageView!
    
    let memeTextAttributes:[String:Any] = [
        NSStrokeColorAttributeName:UIColor.white,
        NSForegroundColorAttributeName:UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: 1.0
    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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


}





















