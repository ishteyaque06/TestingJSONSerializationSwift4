//
//  ViewController.swift
//  TestingJSONSwift4
//
//  Created by Ahmed on 02/02/18.
//  Copyright © 2018 Ahmed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var reportData=[Report]()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        fetchData()
    }
    func initialSetup(){
        let cellNib=UINib(nibName:"CustomTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier:"Cell")
        tableView.estimatedRowHeight=tableView.rowHeight
        tableView.rowHeight=UITableViewAutomaticDimension
        self.view.bringSubview(toFront: indicator)
    }

    func fetchData(){
        indicator.startAnimating()
        let urlString="https://jsonplaceholder.typicode.com/users"
        let request=URLRequest(url: URL(string: urlString)!)
        let task=URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil, let usableData=data else{
                return
            }
            do{
            let report=try JSONDecoder().decode([ModelData].self, from: usableData)
                for item in report{
                   let companyDetails=item.company.name+","+item.company.catchPhrase+","+item.company.bs
                    let address=item.address.street+","+item.address.suite+","+item.address.city+"\n"+item.address.zipcode+"\n"+item.address.geo.lat+","+item.address.geo.lng
                    self.reportData.append(Report(name: item.name, companyDetails: companyDetails, address: address))
                    
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.indicator.stopAnimating()
                }
            }catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }


}

extension ViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reportData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)as?CustomTableViewCell
        cell?.report=reportData[indexPath.row]
        return cell!
    }
}

