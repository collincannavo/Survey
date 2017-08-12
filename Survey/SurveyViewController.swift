//
//  SurveyViewController.swift
//  Survey
//
//  Created by Collin Cannavo on 6/15/17.
//  Copyright © 2017 Collin Cannavo. All rights reserved.
//

import UIKit

class SurveyViewController: UIViewController {

    @IBAction func submit(_ sender: Any) {
        guard let name = nameTextField.text,
            let response = responseTextField.text,
            !name.isEmpty && !response.isEmpty else {
                return
        }
        
        let survey = Survey(name: name, response: response)
        SurveyController.shared.putSurveyIntoAPI(survey: survey)
        
        nameTextField.text = ""
        responseTextField.text = ""
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var responseTextField: UITextField!

}
