//
//  ZTableViewController.swift
//  Zeroban
//
//  Created by Elias on 2018-04-04.
//  Copyright © 2018 Zero distance. All rights reserved.
//

import UIKit

class ZTableViewController: UITableViewController {
    
    var data: (sections: [String], values: [ReportRow])?
    var editMode: Bool = false
    
    @IBOutlet weak var plusButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = ZColors.BackgroundColor
        tableView.separatorStyle = .none
        
        // footer
        plusButton.backgroundColor = ZColors.ActionColor
        plusButton.titleLabel?.text = "+"

        //self.navigationController?.setNavigationBarHidden(true, animated: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector(handleBarClick))
        
        // Tap outside keyboard dissmiss
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.values.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "zcell", for: indexPath) as! ZTableViewCell
        let reportRowObject = data?.values[indexPath.row]
        cell.entity = reportRowObject
        cell.fieldsDisabled = editMode
        return cell
    }
    
    @objc func handleBarClick() {
        // set edit mode
        editMode = !editMode
        if(!editMode) {
            _ = CoreDataHandler.saveContext()
            fetchData()
        }
        tableView.reloadData()
        navigationItem.rightBarButtonItem?.title = editMode ? "Done" : "Edit"
    }
    
    @IBAction func handlePlusClick() {
        let lastDate = self.data?.values.last?.date
        let lastDone = self.data?.values.last?.done
        let newDate = lastDate != nil ? Calendar.current.date(byAdding: .day, value: 1, to: lastDate! as Date) : Date.init()
        if CoreDataHandler.saveReportRowObject(date: newDate!, todo: 0, inProgress: 0, done: lastDone) {
            fetchData()
            tableView.reloadData()
        } else {
            print("couldn't save")
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerStackView = ZStackView()
        if let keys = data?.sections {
            keys.forEach({
                let label = ZTableViewController.createLabel()
                label.text = String.init(describing: $0)
                headerStackView.addArrangedSubview(label)
            })
        }
        return headerStackView
    }
    
    private static func createLabel() -> UILabel {
        let label = UILabel.init()
        label.textAlignment = .center
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        label.textColor = .white
        return label
    }
    
    private func fetchData() {
        data = CoreDataHandler.fetchData()
        if data != nil {
            BoardCalculations.validateData(entities: data!.values)
        }
    }
    
    // Set the spacing between sections
    /*override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }*/
}
