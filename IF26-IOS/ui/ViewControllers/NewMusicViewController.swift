//
//  NewMusicViewController.swift
//  IF26-IOS
//
//  Created by Laura Haegel on 19/12/2019.
//  Copyright © 2019 if26. All rights reserved.
//

import UIKit
import MobileCoreServices
import CoreData

class NewMusicViewController: UIViewController {

    @IBOutlet weak var musicTitle: UITextField!
    @IBOutlet weak var error: UILabel!
    var selectedUrl: URL?
    var musicUrl: URL?
    let coreDataStack = CoreDataStack() {}
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        error.text = ""
        
    }
    
    @IBAction func validate(_ sender: Any) {
    
        if selectedUrl == nil {
            error.text = "you have to select a file"
            return
        }
        if musicTitle.text == nil {
            error.text = "you have to enter a title"
            return
        }
        
        copySelectedFileToAppIfNotExists()
        if !addMusicToDB() {
            deleteFromApp()
        }
        // dismiss vc
        
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
        selectedUrl = selectedFileUrl
        
    }
    
    func copySelectedFileToAppIfNotExists() {
        
        if selectedUrl == nil {
            return
        }
        
        // by default we display the downloads directory
        let dir = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first!
        let sandboxFileUrl = dir.appendingPathComponent(selectedUrl!.lastPathComponent)
        
        // we verify the music hasn't already been copied before
        if !FileManager.default.fileExists(atPath: sandboxFileUrl.path) {
            
            // upload to the app's directory
            do {
                try FileManager.default.copyItem(at: selectedUrl!, to: sandboxFileUrl)
            }
            catch {
                print("cannot copy file")
                return
            }
            
        }
        musicUrl = sandboxFileUrl
        
    }
    
    func deleteFromApp() {
        
        do {
            try FileManager.default.removeItem(at: musicUrl!)
        }
        catch {
            print("cannot delete file")
        }
        
    }
    
}

extension NewMusicViewController {
    
    func addMusicToDB() -> Bool {
        
        if musicUrl == nil || musicTitle.text == nil {
            return false
        }
        
        // create music
        let music = NSEntityDescription.insertNewObject(forEntityName: "Music", into: coreDataStack.managedObjectContext) as! Music
        music.setValue(UUID(), forKey: "mid")
        music.setValue(musicUrl!, forKey: "path")
        music.setValue(musicTitle.text!, forKey: "title")
        
        // add music to database
        do {
            try coreDataStack.managedObjectContext.save()
            return true
        } catch {
            print("cannot add music to db")
            return false
        }
        
    }
    
}

