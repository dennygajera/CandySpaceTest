//
//  ViewController.swift
//  Candyspace_Test_Darshan
//
//  Created by Darshan Gajera
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var txtSearch : UITextField? {
        didSet {
            txtSearch?.autocorrectionType = .no
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupUI() {
        self.navigationItem.title = "Search"
    }
}

//MARK: Button Actions
extension HomeViewController {
    @IBAction func searchNow_tapped(_ sender : UIButton) {
        guard let searchText = txtSearch?.text else {
            return
        }
        if validation() {
            let vc = AppStoryboard.Main.viewController(ImageListVC.self)
            vc.searchText = searchText
            self.navigationController?.pushViewController(vc, animated: true)
            txtSearch?.text = ""
        }
    }
    
    func validation() -> Bool {
        if txtSearch?.text == "" {
            ErrorReporting.shared.showAlertMessage(msg: "Please enter search text")
            return false
        }
        return true
    }
}

