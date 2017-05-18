//
//  ViewController.swift
//  FileManagement_Swift_Kiet
//
//  Created by Kiet Nguyen on 5/17/17.
//  Copyright © 2017 Kiet Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var fileManager : FileManager?
    var documentDir : NSString?
    var filePath : NSString?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fileManager = FileManager.default
        let dirPaths:NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        documentDir = dirPaths[0] as? NSString
        print("path : \(documentDir)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK : - Button Create File
    @IBAction func btnCreateFileClicked(_ sender: Any) {
        filePath=documentDir?.appendingPathComponent("file1.txt") as NSString?
        fileManager?.createFile(atPath: filePath! as String, contents: nil, attributes: nil)
        filePath=documentDir?.appendingPathComponent("file2.txt") as NSString?
        fileManager?.createFile(atPath: filePath! as String, contents: nil, attributes: nil)
        self.showSuccessAlert(titleAlert: "Success", messageAlert: "File created successfully")
        
    }
    
    func showSuccessAlert(titleAlert: String, messageAlert: String)
    {
        let alert:UIAlertController = UIAlertController(title:titleAlert, message: messageAlert as String, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
        }
        alert.addAction(okAction)
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            self.present(alert, animated: true, completion: nil)
        }

    }
    
    //MARK : - Button Create Dicrectory
    @IBAction func btnCreateDirectoryClicked(_ sender: Any) {
        filePath = documentDir?.appendingPathComponent("/folder1") as NSString?
        do {
            try fileManager?.createDirectory(atPath: filePath! as String, withIntermediateDirectories: false, attributes: nil)
        }
        catch let error as NSError {
            print(error)
        }
        self.showSuccessAlert(titleAlert: "Success", messageAlert: "Directory created successfully")
    }
    
    //MARK : - Button Equality Check
    @IBAction func btnEqualityClicked(_ sender: Any) {
        let filePath1=documentDir?.appendingPathComponent("temp.txt")
        let filePath2=documentDir?.appendingPathComponent("copy.txt")
        if(fileManager? .contentsEqual(atPath: filePath1!, andPath: filePath2!))!
        {
            self.showSuccessAlert(titleAlert: "Message", messageAlert: "Files are equal.")
        }
        else
        {
            self.showSuccessAlert(titleAlert: "Message", messageAlert: "Files are not equal.")
        }
    }
    //MARK : - Button Write File
    @IBAction func btnWriteFileClicked(_ sender: Any) {
        let content: NSString = NSString(string: "Nguyễn Anh Kiệt")
        let fileContent: Data = content.data(using: String.Encoding.utf8.rawValue)!
        try? fileContent.write(to: URL(fileURLWithPath: documentDir!.appendingPathComponent("file1.txt")), options: [.atomic])
        self.showSuccessAlert(titleAlert: "Success", messageAlert: "Content written successfully")
    }
    //MARK : - Button Read File
    @IBAction func btnReadFileClicked(_ sender: Any) {
        filePath = documentDir?.appendingPathComponent("/file1.txt") as! NSString
        var fileContent: Data?
        fileContent = fileManager?.contents(atPath: filePath! as String)
        let str: NSString = NSString(data: fileContent!, encoding: String.Encoding.utf8.rawValue)!
        self.showSuccessAlert(titleAlert: "Success", messageAlert: ("data : \(str)" as NSString) as String)
    }
    //MARK : - Button Copy File
    @IBAction func btnCopyFileClicked(_ sender: Any) {
        let originalFile=documentDir?.appendingPathComponent("file1.txt")
        let copyFile=documentDir?.appendingPathComponent("copy.txt")
        try? fileManager?.copyItem(atPath: originalFile!, toPath: copyFile!)
        print(documentDir!)
        self.showSuccessAlert(titleAlert: "Success", messageAlert:"File copied successfully")
    }
    //MARK : - Button Move File
    @IBAction func btnMoveClicked(_ sender: Any) {
        let oldFilePath: String = documentDir!.appendingPathComponent("file1.txt")
        let newFilePath: String = documentDir!.appendingPathComponent("/folder1/file1.txt") as String
        do {
            try fileManager?.moveItem(atPath: oldFilePath, toPath: newFilePath)
        }
        catch let error as NSError {
            print(error)
        }
        self.showSuccessAlert(titleAlert: "Success", messageAlert: "File moved successfully")
    }
    //MARK : - Button File Permission
    @IBAction func btnFilePermissionClicked(_ sender: Any) {
        filePath = documentDir?.appendingPathComponent("file1.txt") as NSString?
        var filePermissions:NSString = ""
        
        if((fileManager?.isWritableFile(atPath: filePath! as String)) != nil)
        {
            filePermissions = filePermissions.appending("file is writable. ") as NSString
        }
        if((fileManager?.isReadableFile(atPath: filePath! as String)) != nil)
        {
            filePermissions = filePermissions.appending("file is readable. ") as NSString
        }
        if((fileManager?.isExecutableFile(atPath: filePath! as String)) != nil)
        {
            filePermissions = filePermissions.appending("file is executable.") as NSString
        }
        self.showSuccessAlert(titleAlert: "Success", messageAlert: "\(filePermissions)")
    }
    //MARK : - Button DirectoryContents File
    @IBAction func btnDirectoryContentsClicked(_ sender: Any) {
        var error: NSError? = nil
        do {
            let arrDirContent = try fileManager!.contentsOfDirectory(atPath: filePath! as String)
            self.showSuccessAlert(titleAlert: "Success", messageAlert: "Content of directory \(arrDirContent)")
        }
        catch let error as NSError {
            
        }
    }
    //MARK : - Button Remove File
    @IBAction func btnRemoveFile(_ sender: Any) {
        filePath = documentDir?.appendingPathComponent("file1.txt") as! NSString
        try? fileManager?.removeItem(atPath: filePath! as String)
        self.showSuccessAlert(titleAlert: "Message", messageAlert: "File removed successfully.")
    }
    
}

