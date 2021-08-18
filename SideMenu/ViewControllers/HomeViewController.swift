//
//  HomeViewController.swift
//  SideMenu
//
//  Created by Felipe Ignacio Zapata Riffo on 18-08-21.
//

import UIKit

protocol  HomeViewControllerDelegate: AnyObject {
    func didTapMenu()
}

class HomeViewController: UIViewController {
    weak var delegate:HomeViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Home"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"),
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(didTapMenu))
    }
    
    @objc func didTapMenu (){
        delegate?.didTapMenu()
    }
 
}
