//
//  ViewController.swift
//  ios-swift-collapsible-table-section-in-grouped-section
//
//  Created by Yong Su on 5/31/16.
//  Copyright © 2016 Yong Su. All rights reserved.
//

import UIKit

class JaringanViewController: UITableViewController {
    
    //
    // MARK: - Data
    //
   
    struct Section {
        var name: String!
        var items: [String]!
        var collapsed: Bool!
        
        init(name: String, items: [String], collapsed: Bool = false) {
            self.name = name
            self.items = items
            self.collapsed = collapsed
        }
    }
    
    var sections = [Section]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the sections array
        // Here we have three sections: Mac, iPad, iPhone
        sections = [
            Section(name: "Bengkulu", items: ["MacBook", "MacBook Air", "MacBook Pro", "iMac", "Mac Pro", "Mac mini", "Accessories", "OS X El Capitan"]),
            Section(name: "DKI Jakarta", items: ["iPad Pro", "iPad Air 2", "iPad mini 4", "Accessories"]),
            Section(name: "Jawa Barat", items: ["iPhone 6s", "iPhone 6", "iPhone SE", "Accessories"]),
            Section(name: "Kepulauan Bangka Belitung", items: ["MacBook", "MacBook Air", "MacBook Pro", "iMac", "Mac Pro", "Mac mini", "Accessories", "OS X El Capitan"]),
            Section(name: "Lampung", items: ["iPad Pro", "iPad Air 2", "iPad mini 4", "Accessories"]),
            Section(name: "Sumatra Selatan", items: ["iPhone 6s", "iPhone 6", "iPhone SE", "Accessories"])
        ]
    }

    //
    // MARK: - Table view delegate
    //
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    


    public override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {
            return 5.0
        }
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        
        // For section 1, the total count is items count plus the number of headers
        var count = sections.count
        
        for section in sections {
            count += section.items.count
        }
        
        return count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return tableView.rowHeight
        }
        
        // Calculate the real section index and row index
        let section = getSectionIndex(indexPath.row)
        let row = getRowIndex(indexPath.row)
        
        // Header has fixed height
        if row == 0 {
            return 50.0
        }
        
        return sections[section].collapsed! ? 0 : 44.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "title") as UITableViewCell!
            cell?.textLabel?.text = "Cabang Lautan Berlian"
            return cell!
        }
        
        // Calculate the real section index and row index
        let section = getSectionIndex(indexPath.row)
        let row = getRowIndex(indexPath.row)
        
        if row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "header") as! HeaderCell
            cell.titleLabel.text = sections[section].name
            cell.toggleButton.tag = section
            cell.collapse.tag = section
//            cell.toggleButton.setTitle(sections[section].collapsed! ? ">" : ">", for: UIControlState())
            
            let imgName = sections[section].collapsed! ? "up" : "down"
            let image1 = UIImage(named: "\(imgName).png")
            cell.toggleButton.setImage(image1, for: UIControlState())
//            cell.toggleButton.setImage(sections[section].collapsed! ?(UIImage(named: "up" : "down")!, for: UIControlState()))
            cell.toggleButton.addTarget(self, action: #selector(JaringanViewController.toggleCollapse), for: .touchUpInside)
            cell.collapse.addTarget(self, action: #selector(JaringanViewController.toggleCollapse), for: .touchUpInside)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!
            cell?.textLabel?.text = sections[section].items[row - 1]
            return cell!
        }
    }
    
    //
    // MARK: - Event Handlers
    //
    @objc func toggleCollapse(_ sender: UIButton) {
        let section = sender.tag
        let collapsed = sections[section].collapsed
        
        // Toggle collapse
        sections[section].collapsed = !collapsed!
        
        let indices = getHeaderIndices()
        
        let start = indices[section]
        let end = start + sections[section].items.count
        
        tableView.beginUpdates()
        for i in start ..< end + 1 {
            tableView.reloadRows(at: [IndexPath(row: i, section: 1)], with: .automatic)
        }
        tableView.endUpdates()
    }
    
    //
    // MARK: - Helper Functions
    //
    
   
    
    func getSectionIndex(_ row: NSInteger) -> Int {
        let indices = getHeaderIndices()
        
        for i in 0..<indices.count {
            if i == indices.count - 1 || row < indices[i + 1] {
                return i
            }
        }
        
        return -1
    }
    
    func getRowIndex(_ row: NSInteger) -> Int {
        var index = row
        let indices = getHeaderIndices()
        
        for i in 0..<indices.count {
            if i == indices.count - 1 || row < indices[i + 1] {
                index -= indices[i]
                break
            }
        }
        
        return index
    }
    
    func getHeaderIndices() -> [Int] {
        var index = 0
        var indices: [Int] = []
        
        for section in sections {
            indices.append(index)
            index += section.items.count + 1
        }
        
        return indices
    }

}