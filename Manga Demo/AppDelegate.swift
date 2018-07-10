//
//  AppDelegate.swift
//  Manga Demo
//
//  Created by Thien Vu Le on Jul/7/18.
//  Copyright © 2018 Thien Vu Le. All rights reserved.
//

import UIKit
import R2Shared
import R2Streamer
import PromiseKit
import CryptoSwift


struct Location {
  let absolutePath: String
  let relativePath: String
  let type: PublicationType
}

public enum PublicationType: String {
  case epub = "epub"
  case cbz = "cbz"
  case unknown = "unknown"
  
  init(rawString: String?) {
    self = PublicationType(rawValue: rawString ?? "") ?? .unknown
  }
}


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  weak var libraryViewController: LibraryViewController!
  var publicationServer: PublicationServer!
  
  /// TODO: make it static like the epub parser.
  var cbzParser: CbzParser!
  
  /// Publications waiting to be added to the PublicationServer (first opening).
  /// publication identifier : data
  var items = [String: (PubBox, PubParsingCallback)]()

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    /// Init R2.
    // Set logging minimum level.
    R2StreamerEnableLog(withMinimumSeverityLevel: .debug)
    
    //Init R2 publication server
    guard let publicationServer = PublicationServer() else {
      print("Error while connect to R2 server")
      return false }
    
    self.publicationServer = publicationServer
    
    //init parser
    cbzParser = CbzParser()
    
    lightParseSamplePublications()
    
    return true
  }
}

extension AppDelegate {
  
  fileprivate func lightParseSamplePublications() {
    
    //parse publication from folders
    let locations = locationsFromSamples()
    
    //load the publication
    for location in locations {
      if !lightParsPublications(at: location) {
        print("Error loading publication ********************.")
      }
    }
  }
  
  // MARK: Get locations out of the application
  /////
  //// - Returns: locatoins array
  fileprivate func locationsFromSamples() -> [Location] {
    
    let samples = ["1", "2", "3", "4"]
    var sampleUrls = [URL]()
    
    for sample in samples {
      if let path = Bundle.main.path(forResource: sample, ofType: "epub") {
        let url = URL.init(fileURLWithPath: path)
        
        sampleUrls.append(url)
        print(url.absoluteString)
      }
    }
    
    //Find the types associated to the files or unknown
    let locations = sampleUrls.map({url -> Location in
      let publicationType = getTypeForPublicationsAt(url: url)
      
      return Location(absolutePath: url.path, relativePath: "sample", type: publicationType)
    })
    
    return locations
  }
  
  internal func lightParsPublications(at location: Location) -> Bool {
    let publication : Publication
    let container   : Container
    
    do {
      switch location.type {
      case .epub:
        let parseResult = try EpubParser.parse(fileAtPath: location.absolutePath)
        publication     = parseResult.0.publication
        container       = parseResult.0.associatedContainer
        
        guard let id    = publication.metadata.identifier else {
          return false
        }
        items[id]       = (parseResult.0, parseResult.1)
      
      case .cbz:
          print("disapled")
        let parseResult = try cbzParser.parse(fileAtPath: location.absolutePath)
        
        publication     = parseResult.publication
        container       = parseResult.associatedContainer
        
      case .unknown:
        return false
      }
      
      //Add the publication to server
      try publicationServer.add(publication, with: container)
    } catch {
      print("Error parsing publication at path ***\(location.relativePath)***: \(error)")
      return false
    }
    return true
  }
  
  // MARK: Find the type epub of the publication at url
  ////
  ////
  internal func getTypeForPublicationsAt(url: URL) -> PublicationType {
    
    let fileName = url.lastPathComponent
    let fileType = fileName.contains(".") ? fileName.components(separatedBy: ".").last : ""
    var publicationType = PublicationType.unknown
    
    // If directory.
    if fileType!.isEmpty {
      let mimetypePath = url.appendingPathComponent("mimetype").path
      if let mimetype = try? String(contentsOfFile: mimetypePath, encoding: String.Encoding.utf8) {
        switch mimetype {
        case EpubConstant.mimetype:
          publicationType = PublicationType.epub
        case EpubConstant.mimetypeOEBPS:
          publicationType = PublicationType.epub
        case CbzConstant.mimetype:
          publicationType = PublicationType.cbz
        default:
          publicationType = PublicationType.unknown
        }
      }
    } else /* Determine type with file extension */ {
      publicationType = PublicationType(rawValue: fileType!) ?? PublicationType.unknown
    }
    return publicationType
  }
}

//extension AppDelegate: LibraryViewControllerDelegate {
//
//  func loadPublication(withId id: String?, completion: @escaping (Drm?, Error?) -> Void) throws {
//    guard let id = id, let item = items[id] else {
//
//      print("Error no ID")
//      return
//    }

    ////Check for DRM
//    let parsingCallBack = item.1
//    guard let drm = item.0.associatedContainer.drm else {
//
//      try parsingCallBack(nil)
//      completion(nil, nil)
//      return
//    }
//
//    let publicationPath = item.0.associatedContainer.rootFile.rootPath
    
//  }
//}

  

  

