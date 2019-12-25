//
//  NewMusicViewController.swift
//  IF26-IOS
//
//  Created by Laura Haegel on 19/12/2019.
//  Copyright © 2019 if26. All rights reserved.
//

import UIKit
import MobileCoreServices


class NewMusicViewController: UIViewController {

    @IBOutlet weak var musicTitle: UITextField!
    @IBOutlet weak var error: UILabel!
    var musicUrl: URL?
    let musicHelper = MusicHelper()
    let storageHelper = StorageUtil()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        error.text = ""
        
    }
    
    @IBAction func validate(_ sender: Any) {
    
        if musicUrl == nil {
            error.text = "you have to select a file"
            return
        }
        if musicTitle.text == nil {
            error.text = "you have to enter a title"
            return
        }
                
        if !addMusicToDB() {
            storageHelper.deleteFile(url: musicUrl!)
        }
        
        RedirectHelper.getInstance().redirectToHomeScreen()
        
    }
    
    @IBAction func chooseClicked(_ sender: Any) {
        
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypeMP3 as String], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        self.present(documentPicker, animated: true, completion: nil)

    }
    
}

extension NewMusicViewController: UIDocumentPickerDelegate {
    
    // this is where we'd actually upload it to a distant server
    // for this course's matter we'll just upload it to our app's sandbox
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        guard let selectedFileUrl = urls.first else {
            return
        }
        
        // we copy musics in the app's root folder
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let sandboxFileUrl = dir.appendingPathComponent(selectedFileUrl.lastPathComponent)

        storageHelper.copyfile(source: selectedFileUrl, destination: sandboxFileUrl)
        
        musicUrl = sandboxFileUrl
        
    }
    
}

extension NewMusicViewController {
    
    func addMusicToDB() -> Bool {
        guard let title = musicTitle.text, !title.isEmpty else {
            return false
        }
        guard let musicPath = musicUrl?.absoluteString else {
            print("something isn't filled")
            return false
        }
        
        // add music to database
        let currentUser = LoginHelper.getInstance().getConnectedUserData()
        return musicHelper.addMusicToDb(title: title, path: musicPath, artist: currentUser!)
        
    }
    
}
