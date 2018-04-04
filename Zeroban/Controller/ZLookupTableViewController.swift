//
//  ZLookupTableViewController.swift
//  Zeroban
//
//  Created by Elias on 2018-04-04.
//  Copyright © 2018 Zero distance. All rights reserved.
//

import UIKit

class ZLookupTableViewController: UITableViewController {
    
    var data: [(rfs: Date, leadTime: Int)]?
    let sections = ["RfS", "Lead time (days)"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = ZColors.BackgroundColor
        tableView.separatorStyle = .none
        
        self.tableView.register(ZLookupTableViewCell.self, forCellReuseIdentifier: "zlookupcell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        data = CoreDataHandler.getLookupRows()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "zlookupcell", for: indexPath) as! ZLookupTableViewCell
        //TODO: cell.data = [tuple.rfs, tuple.leadTime]
        cell.lookupData = data![indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerStackView = ZStackView()
        sections.forEach({
            let label = UILabel.init()
            label.text = String.init(describing: $0)
            label.textAlignment = .center
            label.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
            label.textColor = .white
            headerStackView.addArrangedSubview(label)
        })
        return headerStackView
    }
}
