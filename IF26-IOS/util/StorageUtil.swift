//
//  StorageUtil.swift
//  IF26-IOS
//
//  Created by Laura Haegel on 22/12/2019.
//  Copyright © 2019 if26. All rights reserved.
//

import UIKit

class StorageUtil {
    
    func copyfile(source: URL, destination: URL) {
        // we check that it hasn't already been uploaded
        if !FileManager.default.fileExists(atPath: destination.path) {
               
            // upload to the app's directory
            do {
                try FileManager.default.copyItem(at: source, to: destination)
            }
            catch {
                print(error)
                return
            }
                   
        }
    }
    
    func deleteFile(url: URL) {
        
        do {
            try FileManager.default.removeItem(at: url)
        }
        catch {
            print("cannot delete file")
        }
        
    }
    
}
