//
//  ResponsesTableViewController.swift
//  Survey
//
//  Created by Collin Cannavo on 6/15/17.
//  Copyright © 2017 Collin Cannavo. All rights reserved.
//

import UIKit

class ResponsesTableViewController: UITableViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        SurveyController.shared.fetchResponses {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return SurveyController.shared.surveys.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResponseCell", for: indexPath)

        let survey = SurveyController.shared.surveys[indexPath.row]
        
        cell.textLabel?.text = survey.response
        cell.detailTextLabel?.text = survey.name

        return cell
    }

}
