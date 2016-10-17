//
//  ARFileManager.swift
//  ARFileManager
//
//  Created by Objective-C on 2016/10/13.
//  Copyright © 2016年 Archy Van. All rights reserved.
//

import Foundation

class ARFileManager: NSObject {
    
    static let manager : FileManager = {
        let manger = FileManager.default
        return manger
    }()
    
    class func listFilesInDirectory(atPath path: String, deep: Bool) -> [Any] {
        var listArr: [Any] = []
        if deep {
            do {
                let deepArr  = try manager.subpathsOfDirectory(atPath: path)
                listArr = deepArr
            } catch _ {
                listArr = []
            }
        } else {
            do {
                let shallowArr = try manager.contentsOfDirectory(atPath: path)
                listArr = shallowArr
            } catch _ {
                listArr = []
            }
        }
        return listArr
    }
    
    class func listFilesInHomeDirectory(deep: Bool) -> [Any] {
        return listFilesInDirectory(atPath: FileManager.homeDir(), deep: deep)
    }
    
    class func listFilesInLibraryDirectory(deep: Bool) -> [Any] {
        return listFilesInDirectory(atPath: FileManager.libraryDic(), deep: deep)
    }
    
    class func listFilesInDocumentDirectory(deep: Bool) -> [Any] {
        return listFilesInDirectory(atPath: FileManager.documentsDir(), deep: deep)
    }

    class func listFilesInTmpDirectory(deep: Bool) -> [Any] {
        return listFilesInDirectory(atPath: FileManager.tmpDir(), deep: deep)
    }

    class func listFilesInCachesDirectory(deep: Bool) -> [Any] {
        return listFilesInDirectory(atPath: FileManager.cachesDir(), deep: deep)
    }
 
    class func attributesOfItem(atPath path: String) throws -> [AnyHashable: Any]? {
        var attributes : [AnyHashable : Any]? = nil
        do {
           attributes =  try FileManager.default.attributesOfItem(atPath: path)
        }
        catch _ {
            attributes = nil
        }
        return attributes!
    }
    
    
    class func attributeOfItem(atPath path: String,forKey key: String) throws -> Any? {
        var attriubute : Any? = nil;
        do {
            attriubute = try attributesOfItem(atPath: path)?[key]
        } catch _ {
            attriubute = nil
        }
        return attriubute!
    }
}

extension FileManager {
    class func documentsDir() -> String {
        var paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as [String]
        return paths[0]
    }
    
    class func cachesDir() -> String {
        var paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true) as [String]
        return paths[0]
    }
    
    class func libraryDic() -> String {
        var paths = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true) as [String]
        return paths[0]
    }
    
    class func homeDir() -> String {
        return NSHomeDirectory()
    }
    
    class func tmpDir() -> String {
        return NSTemporaryDirectory()
    }
    
    class func preferencesDir() -> String {
        let librarayPath : String = libraryDic()
        return librarayPath.appending("Preferences")
    }
}
