//
//  ViewController.swift
//  Manga Demo
//
//  Created by Thien Vu Le on Jul/7/18.
//  Copyright © 2018 Thien Vu Le. All rights reserved.
//

import UIKit
import WebKit
import R2Shared
import R2Streamer
import R2Navigator
import Kingfisher
import PromiseKit
import ReadiumOPDS
import MobileCoreServices

//protocol LibraryViewControllerDelegate: class {
//  func loadPublication(withId id: String?, completion: @escaping (Drm?, Error?) -> Void) throws
//}

class LibraryViewController: UIViewController {
  
  var publications: [Publication]!
//  weak var delegate: LibraryViewControllerDelegate?
//  weak var lastFlippedCell: PublicationCell?
  
//  lazy var loadingIndicator = PublicationIndicator()
  
  @IBOutlet weak var collectionView: UICollectionView! {
    didSet {
      collectionView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
      collectionView.contentInset = UIEdgeInsets(top: 10, left: 10,
                                                 bottom: 10, right: 10)
      collectionView.register(PublicationCell.self,
                              forCellWithReuseIdentifier: "publicationCell")
      collectionView.delegate = self
      collectionView.dataSource = self
      //collectionView.reloadData()
      //collectionView.collectionViewLayout.invalidateLayout()
      
    }
  }
  
    
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    guard let appDelegate = UIApplication.shared.delegate as?  AppDelegate else {return}
//    delegate = appDelegate
    publications = appDelegate.items.compactMap() { $0.value.0.publication }.sorted { (pA, pB) -> Bool in
      pA.metadata.title < pB.metadata.title
    }
    appDelegate.libraryViewController = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    //configLayoutCollectionViewCell()
  }
  
  enum GeneralScreenOrientation: String {
    case landscape
    case portrait
  }
  
  static let iPadLayoutNumberPerRow:[GeneralScreenOrientation: Int] = [.portrait: 6, .landscape: 3]
  static let iPhoneLayoutNumberPerRow:[GeneralScreenOrientation: Int] = [.portrait: 3, .landscape: 4]
  
  static let layoutNumberPerRow:[UIUserInterfaceIdiom:[GeneralScreenOrientation: Int]] = [
    .pad : LibraryViewController.iPadLayoutNumberPerRow,
    .phone : LibraryViewController.iPhoneLayoutNumberPerRow
  ]
  
  private var previousScreenOrientation: GeneralScreenOrientation?
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    configLayoutCollectionViewCell()
  }
  
  func configLayoutCollectionViewCell(){
    
    let idiom = { () -> UIUserInterfaceIdiom in
      let tempIdion = UIDevice.current.userInterfaceIdiom
      return (tempIdion != .pad) ? .phone:.pad // ignnore carplay and others
    } ()
    var contentWith : CGFloat = 700.0 // ipad air OK
    let orientation = { () -> GeneralScreenOrientation in
      let deviceOrientation = UIDevice.current.orientation
      switch deviceOrientation {
      case .unknown, .portrait, .portraitUpsideDown:
        return GeneralScreenOrientation.portrait
      case .landscapeLeft, .landscapeRight:
        contentWith         = 950.0 // ipad air OK
        return GeneralScreenOrientation.landscape
      case .faceUp, .faceDown:
        return previousScreenOrientation ?? .portrait
      }
    } ()
    
    previousScreenOrientation = orientation
    
    guard let deviceLayoutNumberPerRow = LibraryViewController.layoutNumberPerRow[idiom] else {return}
    guard let numberPerRow = deviceLayoutNumberPerRow[orientation] else {return}
    
    guard let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {return}
    //let contentWith : CGFloat = collectionView.collectionViewLayout.collectionViewContentSize.width
    
    let minimumSpacing = CGFloat(5)
    let width = (contentWith - CGFloat(numberPerRow-1) * minimumSpacing) / CGFloat(numberPerRow)
    let height = width * 1.5 // Height/width ratio == 1.5
    
    flowLayout.minimumLineSpacing = minimumSpacing * 2
    flowLayout.minimumInteritemSpacing = minimumSpacing
    flowLayout.itemSize = CGSize(width: width, height: height)
  }
}


//MARK: CollectionView DataSource and delegate
extension LibraryViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    // No data to display.
    if publications.count == 0 {
      let noPublicationLabel = UILabel(frame: collectionView.frame)
      
      noPublicationLabel.text = "📖 Open EPUB/CBZ file to import"
      noPublicationLabel.textColor = UIColor.gray
      noPublicationLabel.textAlignment = .center
      collectionView.backgroundView = noPublicationLabel
    }
    return publications.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "publicationCell", for: indexPath) as! PublicationCell
    
    let publication = publications[indexPath.item]
    
    cell.accessibilityLabel = publication.metadata.title
    
    let updateCellImage = { (theImage: UIImage) -> Void in
      let currentPubInfo = self.publications[indexPath.item]
      if (currentPubInfo.coverLink === publication.coverLink) {
        cell.imageView.image = theImage
      }
    }
    
    // Load image and then apply the shadow.
    if let coverUrl = publication.uriTo(link: publication.coverLink) {
      
      let cacheKey = coverUrl.absoluteString
      if (ImageCache.default.imageCachedType(forKey: cacheKey).cached) {
        
        ImageCache.default.retrieveImage(forKey: cacheKey, options: nil) {
          image, cacheType in
          if let theImage = image {
            updateCellImage(theImage)
          } else {
            print("Not exist in cache.")
          }
        }
        
      } else {
        
        ImageDownloader.default.downloadImage(with: coverUrl, options: [], progressBlock: nil) { (image, error, url, data) in
          if error != nil {
            let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
            let textView = self.defaultCover(layout: flowLayout, publication: publication)
            cell.imageView.image = UIImage.imageWithTextView(textView: textView)
            
          } else {
            guard let newImage = image else {return}
            ImageCache.default.store(newImage, forKey: cacheKey)
            updateCellImage(newImage)
          }
        }
      } // check cache
      
    } else {
      
      let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
      let textView = defaultCover(layout: flowLayout, publication: publication)
      cell.imageView.image = UIImage.imageWithTextView(textView: textView)
    }
    cell.layoutIfNeeded()
    return cell
  }
  
  internal func defaultCover(layout: UICollectionViewFlowLayout?, publication: Publication) -> UITextView {
    let width = layout?.itemSize.width ?? 0
    let height = layout?.itemSize.height ?? 0
    let titleTextView = UITextView(frame: CGRect(x: 0, y: 0, width: width, height: height))
    
    titleTextView.layer.borderWidth = 5.0
    titleTextView.layer.borderColor = #colorLiteral(red: 0.08269290555, green: 0.2627741129, blue: 0.3623990017, alpha: 1).cgColor
    titleTextView.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
    titleTextView.textColor = #colorLiteral(red: 0.8639426257, green: 0.8639426257, blue: 0.8639426257, alpha: 1)
    titleTextView.text = publication.metadata.title.appending("\n_________") //Dirty styling.
    
    return titleTextView
  }
}




