//
//  Survey Controller.swift
//  Survey
//
//  Created by Collin Cannavo on 6/15/17.
//  Copyright © 2017 Collin Cannavo. All rights reserved.
//

import Foundation
import UIKit

class SurveyController {
    
    static let shared = SurveyController()
    static var baseURL = URL(string: "https://suvey4.firebaseio.com/")
    
    func putSurveyIntoAPI(survey: Survey) {
        guard let url = SurveyController.baseURL?.appendingPathComponent(survey.identifier).appendingPathExtension("json") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = survey.jsonData
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data,
                let responseDataString = String(data:data, encoding: .utf8) else { return print("No data returned from data task") }
            
            if let error = error {
                print("Error: \(error)")
            }else if responseDataString.contains("error") {
                print("Error: \(responseDataString)")
            } else {
                print("Successfully saved data to endpoint.")
            }
        }
        
        dataTask.resume()
    }
    
    func fetchResponses(completion: @escaping() -> Void) {
        guard let url = SurveyController.baseURL?.appendingPathExtension("json") else {
            completion()
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            defer { completion() }
            
            if let error = error {
                print(error.localizedDescription)
                completion()
                return
            }
            
            guard let data = data,
                let responseDatatString = String(data:data, encoding: .utf8) else { return print("No datat returned") }
            
            guard let jsonDictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: [String:Any]] else {
                print("Error decoding json: \(responseDatatString)")
                return
            }
            let surveys = jsonDictionary.flatMap { Survey(dictionary: $0.value, identifier: $0.key) }
            
            self.surveys = surveys
        }
        dataTask.resume()
    }
    
    private(set) var surveys = [Survey]()
    
}

