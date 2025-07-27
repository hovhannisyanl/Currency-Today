//
//  ChangeViewController.swift
//  Currency Today
//
//  Created by Student on 18.07.25.
//

import UIKit

class ChangeOption {
    var name:String
    var backgroundColor:UIColor
    var backgroundImage:UIImage
    var api: String
     
    init(name: String, backgroundColor: UIColor, backgroundImage: UIImage, api: String) {
        self.name = name
        self.backgroundColor = backgroundColor
        self.backgroundImage = backgroundImage
        self.api = api
    }
    
}

class ChangeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var models = [ChangeOption]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ChangeTableViewCell.self, forCellReuseIdentifier: ChangeTableViewCell.identifier)
        configure()
    }
    func configure(){
        models.append(contentsOf: [
            ChangeOption(name: "AMD", backgroundColor: .white, backgroundImage: UIImage(named: "ARM")!, api: "https://open.er-api.com/v6/latest/AMD"),
            ChangeOption(name: "USD", backgroundColor: .white, backgroundImage: UIImage(named: "USA")!, api: "https://open.er-api.com/v6/latest/USD"),
            ChangeOption(name: "RUB", backgroundColor: .white, backgroundImage: UIImage(named: "RU")!, api: "https://open.er-api.com/v6/latest/RUB"),
            ChangeOption(name: "GBP", backgroundColor: .white, backgroundImage: UIImage(named: "UK")!, api: "https://open.er-api.com/v6/latest/GBP"),
            ChangeOption(name: "GEL", backgroundColor: .white, backgroundImage: UIImage(named: "Geo")!, api: "https://open.er-api.com/v6/latest/GEL"),
            ChangeOption(name: "EUR", backgroundColor: .white, backgroundImage: UIImage(named: "UK")!, api: "https://open.er-api.com/v6/latest/EUR"),
            ChangeOption(name: "AED", backgroundColor: .white, backgroundImage: UIImage(named: "UAE")!, api: "https://open.er-api.com/v6/latest/AED"),
            ChangeOption(name: "CNY", backgroundColor: .white, backgroundImage: UIImage(named: "CHINA")!, api: "https://open.er-api.com/v6/latest/CNY"),
            ChangeOption(name: "JPY", backgroundColor: .white, backgroundImage: UIImage(named: "japan")!, api: "https://open.er-api.com/v6/latest/JPY"),
            ChangeOption(name: "CAD", backgroundColor: .white, backgroundImage: UIImage(named: "Cnd")!, api: "https://open.er-api.com/v6/latest/CAD"),
            ChangeOption(name: "IRR", backgroundColor: .white, backgroundImage: UIImage(named: "IR")!, api: "https://open.er-api.com/v6/latest/IRR"),
            ChangeOption(name: "KZT", backgroundColor: .white, backgroundImage: UIImage(named: "Kaz")!, api: "https://open.er-api.com/v6/latest/KZT"),


        ])
    }
    
    @IBAction func home(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: true)
    }
    
    
    @IBAction func settings(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: true)
    }
    
    
}

extension ChangeViewController: UITableViewDelegate,
UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
         guard let cell = tableView.dequeueReusableCell(withIdentifier: ChangeTableViewCell.identifier,for: indexPath) as? ChangeTableViewCell
        else{
             return UITableViewCell()
         }
        cell.configure(with: model)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        if models[indexPath.item].name != "" {
            let vc = storyboard?.instantiateViewController(withIdentifier: "ConvertViewController")as? ConvertViewController
            vc?.ap = models[indexPath.item].api
            vc?.text = models[indexPath.item].name
            self.present(vc!,animated:true)
        }
    }
}
