//
//  MenuViewController.swift
//  SideMenu
//
//  Created by Felipe Ignacio Zapata Riffo on 18-08-21.
//

import UIKit

protocol MenuViewControllerDelegate:AnyObject {
    func didSelect(menuItem: MenuViewController.MenuOptions)
}
class MenuViewController: UIViewController {
    weak var delegate : MenuViewControllerDelegate?
    enum MenuOptions : String, CaseIterable{
        
        case home = "Home"
        case settings = "Settings"
        case info = "Information"
        case appRating = "App Rating"
        case shareAp = "Share App"
        
        var imageName : String {
            switch self {
            case .home:
                return "house"
            case .settings:
                return "airplane"
            case .info:
                return "star"
            case .appRating:
                return "message"
            case .shareAp:
                return "gear"
            }
        }
        
    }
    
    private let tableView : UITableView = {
       let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    let grayColor = UIColor(red: 33/225, green: 33/225, blue: 33/225, alpha: 1)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = grayColor
        tableView.backgroundColor = nil
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.bounds.size.width, height: view.bounds.size.height)
    }

}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        
        cell.textLabel?.text = MenuOptions.allCases[indexPath.row].rawValue
        cell.backgroundColor = grayColor
        cell.contentView.backgroundColor = grayColor
        cell.textLabel?.textColor = .white
         
        cell.imageView?.image =  UIImage(systemName: MenuOptions.allCases[indexPath.row].imageName)
        cell.imageView?.tintColor = .white
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = MenuOptions.allCases[indexPath.row]
        delegate?.didSelect(menuItem: item)
    }
    
    
}
