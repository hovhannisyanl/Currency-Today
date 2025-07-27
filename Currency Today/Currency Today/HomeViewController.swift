//
//  HomeViewController.swift
//  Currency Today
//
//  Created by Student on 18.07.25.
//

import UIKit

class CourseOption {
    var name: String
    var currency: String
    var backgroundImage: UIImage
    var backgroundColor: UIColor
    var course: String
    
    init(name: String, currency: String, backgroundImage: UIImage, backgroundColor: UIColor, course: String) {
        self.name = name
        self.currency = currency
        self.backgroundImage = backgroundImage
        self.backgroundColor = backgroundColor
        self.course = course
    }
}

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var navBar: UINavigationBar!
    var models = [CourseOption]()
    var currencyCode: [String] = []
    var volues: [Double] = []
 

    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        getCurrentDate()
        configure()
        fetchJson()
    }
    
    func fetchJson(){

            guard let url = URL(string: "https://open.er-api.com/v6/latest/AMD") else {return}

            URLSession.shared.dataTask(with: url) {[self] (data, response, error) in

                if error != nil {

                    print(error!.localizedDescription)

                    return

                }

                guard let safeData = data else {return}

                do{

                    let rezults = try JSONDecoder().decode(ExchangeRates.self, from: safeData)

                    self.currencyCode.append(contentsOf: rezults.rates.keys)

                    self.volues.append(contentsOf: rezults.rates.values)

                    rezults.rates.forEach { (key, value) in

                        self.models = self.models.map {

                            if $0.name == key {

                                let courseKey = (Double(models[0].course) ?? 0)/value

                                $0.course = "\(Double(round(100 * courseKey) / 100))"

                            }

                            return $0

                        }

                    }

                    DispatchQueue.main.async {

                        self.tableview.reloadData()

                    }

                }

                catch {

                    print(error)

                }

            }.resume()

        }
    func configure(){
        models.append(contentsOf:[
            CourseOption(name: "AMD", currency: "Armenia", backgroundImage: UIImage(named:"ARM" )!, backgroundColor: .white, course: "1"),
            CourseOption(name: "USD", currency: "USA", backgroundImage: UIImage(named:"USA")!, backgroundColor: .white, course: "1"),
            CourseOption(name: "RUB", currency: "Russia", backgroundImage: UIImage(named:"RU")!, backgroundColor: .white, course: "1"),
            CourseOption(name: "GBP", currency: "UK", backgroundImage: UIImage(named:"UK")!, backgroundColor: .white, course: "1"),
            CourseOption(name: "GEL", currency: "Georgia", backgroundImage: UIImage(named:"Geo")!, backgroundColor: .white, course: "1"),
            CourseOption(name: "EUR", currency: "European Union", backgroundImage: UIImage(named:"EU")!, backgroundColor: .white, course: "1"),
            CourseOption(name: "AED", currency: "UAE", backgroundImage: UIImage(named:"UAE")!, backgroundColor: .white, course: "1"),
            CourseOption(name: "CNY", currency: "China", backgroundImage: UIImage(named:"CHINA")!, backgroundColor: .white, course: "1"),
            CourseOption(name: "JPY", currency: "Japan", backgroundImage: UIImage(named:"japan")!, backgroundColor: .white, course: "1"),
            CourseOption(name: "CAD", currency: "Canada", backgroundImage: UIImage(named:"Cnd")!, backgroundColor: .white, course: "1"),
            CourseOption(name: "IRR", currency: "Iran", backgroundImage: UIImage(named:"IR")!, backgroundColor: .white, course: "1"),
            CourseOption(name: "KZT", currency: "Kazakhstan", backgroundImage: UIImage(named:"Kaz")!, backgroundColor: .white, course: "1"),
            CourseOption(name: "MXN", currency: "Mexico", backgroundImage: UIImage(named:"MEX")!, backgroundColor: .white, course: "1"),
            CourseOption(name: "ALL", currency: "Albania", backgroundImage: UIImage(named:"alb")!, backgroundColor: .white, course: "1"),
            CourseOption(name: "ARS", currency: "Argentina", backgroundImage: UIImage(named:"arg")!, backgroundColor: .white, course: "1"),
            CourseOption(name: "AUD", currency: "Australia", backgroundImage: UIImage(named:"aus")!, backgroundColor: .white, course: "1"),
            CourseOption(name: "BRL", currency: "Brazil", backgroundImage: UIImage(named:"br")!, backgroundColor: .white, course: "1"),
            CourseOption(name: "BYN", currency: "Belorussia", backgroundImage: UIImage(named:"blr")!, backgroundColor: .white, course: "1"),
            
            
            
            
            
        ])
    }
    func getCurrentDate(){
        var now = Date()
        var nowComponents = DateComponents()
        let calendar = Calendar.current
        nowComponents.year = Calendar.current.component(.year,from  :now)
        nowComponents.month = Calendar.current.component(.month,from  :now)
        nowComponents.day = Calendar.current.component(.day,from  :now)
        nowComponents.timeZone = NSTimeZone.local
        now = calendar.date(from:nowComponents)!
        navBar.topItem?.title = "\(nowComponents.day!).\(nowComponents.month!).\(nowComponents.year!)"
        
        
    }

    @IBAction func change(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ChangeViewController") as? ChangeViewController
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


extension HomeViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section:
        Int) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        guard let cell = tableview.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell
        else{
            return UITableViewCell()
        }
        cell.configue(with: model)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableview.deselectRow(at: indexPath, animated: true)
    }
}
