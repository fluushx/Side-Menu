//
//  ViewController.swift
//  SideMenu
//
//  Created by Felipe Ignacio Zapata Riffo on 18-08-21.
//

import UIKit

class ContainerViewController: UIViewController {
    enum MenuState {
        case opened
        case closed
    }
    private var menuState :MenuState = .closed
    
    let menuVC = MenuViewController()
    let homeVC = HomeViewController()
    lazy var infoVC = InfoViewController()
    lazy var settingVC = SettingViewController()
    lazy var sharedVC = SharedViewController()
    lazy var appRatingVC = AppRatingViewController()
    
    var navVC : UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        addChildVC()
        
    }
    
    private func addChildVC (){
        //Menu
        menuVC.delegate = self
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
        //Home
        homeVC.delegate = self
        let navVC = UINavigationController(rootViewController: homeVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        self.navVC = navVC
    }

}

extension ContainerViewController:HomeViewControllerDelegate{
    func didTapMenu() {
        toggleMenu(complation: nil)
         
    }
    func toggleMenu (complation : (()->Void)?){
        //animated the menu
        switch menuState{
        case .closed:
            //open it
            print("opened")
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut) {
                self.navVC?.view.frame.origin.x = self.homeVC.view.frame.size.width - 180
            } completion: { done in
                if done {
                    self.menuState = .opened
                }
            }
            
        case .opened:
            //closed it
            print("closed")
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut) {
                self.navVC?.view.frame.origin.x = 0
            } completion: { done in
                if done {
                    self.menuState = .closed
                    DispatchQueue.main.async {
                        complation?()
                    }
                }
            }
            break
        }
    }
}
extension ContainerViewController:MenuViewControllerDelegate{
    func didSelect(menuItem: MenuViewController.MenuOptions) {
        toggleMenu { [weak self] in
            switch menuItem {
            case .home:
                self?.resetHome()
                break
            case .settings:
                self?.addSetting()
                break
            case .info:
                self?.addInfo()
                break
            case .appRating:
                self?.addSAppRating()
                break
            case .shareAp:
                self?.addShared()
                break
            }
        }
         
    }
    func addInfo(){
        let vc = self.infoVC
        homeVC.addChild(vc)
        homeVC.view.addSubview(vc.view)
        vc.view.frame = view.frame ?? .zero
        vc.didMove(toParent: homeVC)
        homeVC.title = vc.title
    }
    func resetHome (){
        infoVC.view.removeFromSuperview()
        infoVC.didMove(toParent: nil)
        homeVC.title = "Home"
    }
    
    func addSetting(){
        let vc = self.settingVC
        homeVC.addChild(vc)
        homeVC.view.addSubview(vc.view)
        vc.view.frame = view.frame ?? .zero
        vc.didMove(toParent: homeVC)
        homeVC.title = vc.title
    }
    func addSAppRating(){
        let vc = self.appRatingVC
        homeVC.addChild(vc)
        homeVC.view.addSubview(vc.view)
        vc.view.frame = view.frame ?? .zero
        vc.didMove(toParent: homeVC)
        homeVC.title = vc.title
    }
    
    func addShared(){
        let vc = self.sharedVC
        homeVC.addChild(vc)
        homeVC.view.addSubview(vc.view)
        vc.view.frame = view.frame ?? .zero
        vc.didMove(toParent: homeVC)
        homeVC.title = vc.title
    }
}
