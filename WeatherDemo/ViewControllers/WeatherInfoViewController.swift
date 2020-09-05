//
//  WeatherInfoViewController.swift
//  WeatherDemo
//
//  Created by Karan Saglani on 05/09/20.
//  Copyright © 2020 Karan Saglani. All rights reserved.
//

import UIKit

class WeatherInfoViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    var arrConfirmDetail : Array<Any>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadXIB()
    }
    
    func loadXIB() {
        
        self.tableView.register(UINib(nibName: "ConfirmationViewCell", bundle: nil), forCellReuseIdentifier: "ConfirmationViewCell")
    }
}

// MARK: - UITableViewDataSource  -

extension WeatherInfoViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrConfirmDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell : ConfirmationViewCell = self.tableView.dequeueReusableCell(withIdentifier: "ConfirmationViewCell", for: indexPath)as? ConfirmationViewCell else {
            return UITableViewCell()
        }
        
        if let dictPayeeDetail = arrConfirmDetail? [indexPath.row] as? [String : String]{
            
            cell.labelSubTitle.text  =  String.getString(dictPayeeDetail["confirmValue"])
            cell.labelTitle.text  = String.getString(dictPayeeDetail["confirmKey"])
        }
        return cell
    }
}
