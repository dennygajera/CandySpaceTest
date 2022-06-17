//
//  ImageListVC.swift
//  Candyspace_Test_Darshan
//
//  Created by Darshan Gajera
//

import UIKit

class ImageListVC: UIViewController {

    @IBOutlet weak var clvImageList : UICollectionView? {
        didSet {
            clvImageList?.delegate = self
            clvImageList?.dataSource = self
            clvImageList?.register(UINib(nibName: ImageDataCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: ImageDataCell.reuseIdentifier)
        }
    }

    
    var searchText = ""
    private let imageDataViewModel = ImageDataViewModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getDataFromWebService()
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        self.navigationItem.title = "Gallery"
    }
    
    func getDataFromWebService() {
        imageDataViewModel.GetSearchedResult(searchedText: searchText) {
            print("success")
            DispatchQueue.main.async {
                self.clvImageList?.reloadData()
            }
        }
    }
}

extension ImageListVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageDataViewModel.imageDataResponse?.hits?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageDataCell.reuseIdentifier, for: indexPath) as? ImageDataCell else {
            return UICollectionViewCell()
        }
        
        cell.configureCell = imageDataViewModel.imageDataResponse?.hits?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/3.0
        let yourHeight = yourWidth

        return CGSize(width: yourWidth, height: yourHeight)
    }
}
