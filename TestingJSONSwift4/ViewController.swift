//
//  ViewController.swift
//  TestingJSONSwift4
//
//  Created by Ahmed on 02/02/18.
//  Copyright © 2018 Ahmed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var reportData=[ModelData]()
    @IBOutlet weak var tableView: UITableView!
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
    }

    func fetchData(){
        let urlString="https://jsonplaceholder.typicode.com/users"
        let request=URLRequest(url: URL(string: urlString)!)
        let task=URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil, let usableData=data else{
                return
            }
            do{
            self.reportData=try JSONDecoder().decode([ModelData].self, from: usableData)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
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
        cell?.nameLabel.text=reportData[indexPath.row].name
        cell?.companyName.text=reportData[indexPath.row].company.name
        cell?.addressLabel.text=reportData[indexPath.row].address.geo.lat
        return cell!
    }
}

