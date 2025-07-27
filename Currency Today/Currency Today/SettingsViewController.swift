//
//  SettingsViewController.swift
//  Currency Today
//
//  Created by Student on 18.07.25.
//

import UIKit

class SettingsOption {
    var name : String
    var backgroundColor : UIColor
    var backgroundImage : UIImage
    init(name: String, backgroundColor: UIColor, backgroundImage: UIImage) {
        self.name = name
        self.backgroundColor = backgroundColor
        self.backgroundImage = backgroundImage
    }

}

class SettingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var models = [SettingsOption]()
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        configure()
    }
    func configure(){
        models.append(contentsOf: [
            SettingsOption(name: "About Program", backgroundColor: .systemTeal, backgroundImage: UIImage(systemName:"info.circle" )!),
            SettingsOption(name: "Share", backgroundColor: .systemTeal, backgroundImage: UIImage(systemName:"square.and.arrow.up.circle.fill" )!),
            SettingsOption(name: "Author", backgroundColor: .systemTeal, backgroundImage: UIImage(systemName:"person.circle.fill" )!),
            SettingsOption(name: "Contacts", backgroundColor: .systemTeal, backgroundImage: UIImage(systemName:"person.crop.circle.fill.badge.plus" )!)
        ])
    }
    
    @IBAction func home(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: true)
    
    }
    
    @IBAction func change(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ChangeViewController") as? ChangeViewController
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: true)
    
    }
    
}

extension SettingsViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as? SettingsTableViewCell
                
        else {
            
            return UITableViewCell()
            
        }
        
        cell.configure(with: model)
        return cell    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        if models[indexPath.item].name == "Contacts" {
            
            let actionSheet = UIAlertController(title: "Contacts", message: nil, preferredStyle: .actionSheet)
            
            actionSheet.addAction(UIAlertAction(title: "Facebook", style: .default, handler: { (action) in
                
                UIApplication.shared.openURL(NSURL(string: "https://www.instagram.com/_hovhannisyannnnnn_/")! as URL)
                
            }))
            
            actionSheet.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
            
            present(actionSheet, animated: true, completion: nil)
            
        } else if models[indexPath.item].name == "Author" {
            
            let alert = UIAlertController(title: "Author", message: "By Pox Poxo", preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "", style: .destructive, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        }else if models[indexPath.item].name == "Share" {
            
            let activityVC = UIActivityViewController(activityItems: [""], applicationActivities: nil)
            
            activityVC.popoverPresentationController?.sourceView = self.view
            
            self.present(activityVC, animated: true, completion: nil)
            
        }else if models[indexPath.item].name == "About Program" {
            
            let alert = UIAlertController(title: "About Program", message: "The program was created by Lili Hovhannisyan from July 17 to July 27.Currency Today is an application designed to quickly and conveniently provide exchange rate information for different currencies. The app provides current exchange rates between various countries' currencies, such as the dollar, euro, pound, and more. You can view real-time data that helps make the management of your financial transactions easier and more reliable։The main features of this program include.A comprehensive list of currency exchange rates,Currency conversions and calculations,Independent selection between different currencies,Exchange rate history and trends,A user-friendly interface and clear visibility,Currency Today is suitable for any individual or business that wants to obtain exchange rate information without complications.", preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        }
    }
}
