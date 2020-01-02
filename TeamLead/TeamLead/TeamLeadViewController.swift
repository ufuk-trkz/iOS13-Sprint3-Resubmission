//
//  TeamLeadViewController.swift
//  TeamLead
//
//  Created by Ufuk Türközü on 13.12.19.
//  Copyright © 2019 Ufuk Türközü. All rights reserved.
//

import UIKit

class TeamLeadViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var teamLeads: [TeamLead] = [
        TeamLead(image: UIImage(named: "cc")!, name: "CC"),
        TeamLead(image: UIImage(named: "tom")!, name: "Tom"),
        TeamLead(image: UIImage(named: "austin")!, name: "Austin")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TeamLeadViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        teamLeads.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TLCell", for: indexPath) as? TeamLeadTableViewCell else { fatalError("error") }
        
        let tl = teamLeads[indexPath.row]
        cell.teamLead = tl
        
        return cell
    }
    
    
}
