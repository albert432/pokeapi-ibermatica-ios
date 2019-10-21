//
//  DetailViewController.swift
//  Ibermatica-iOS
//
//  Copyright © 2019 Albert. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import Loaf
import ImageLoader
import SnapKit

class DetailViewController: UIViewController {
    
    // MARK: - OUTLETS
    @IBOutlet weak var pokemonImageView: UIImageView!
  
    @IBOutlet weak var heightLabel: UILabel! {
        didSet {
            heightLabel.text = "height.label".fromTable("Detail")
        }
    }
    
    @IBOutlet weak var weightLabel: UILabel! {
        didSet {
            weightLabel.text = "weight.label".fromTable("Detail")
        }
    }
    
    @IBOutlet weak var abilitiesLabel: UILabel! {
        didSet {
            abilitiesLabel.text = "abilities.label".fromTable("Detail")
        }
    }
    
    @IBOutlet weak var abilitiesStackView: UIStackView!
    
    @IBOutlet weak var heightValueLabel: UILabel!
    
    @IBOutlet weak var weightValueLabel: UILabel!
    
    
    // MARK: - PROPERTIES
    var id: Int?
    // MARK: - ACTIONS
    // MARK: - FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Montserrat-Bold", size: 17) ?? UIFont.systemFont(ofSize: 17)]


        getDetail()
    }
    

    
    func getDetail() {
        guard let id = id else {
            showError()
            return
        }
        
       _ = NetworkProvider<DetailSpecs>.requestString(.all(id: id)) { (response, specs) in
            switch response.result {
            case .success(_):
                do {
                    // Get response data
                    guard let data = response.data else {
                        self.showError()
                        return
                    }
                    
                    let detailJSON = try JSON(data: data)
                    
                    if let url = URL(string: detailJSON["sprites"]["front_default"].stringValue) {
                        self.pokemonImageView.load.request(with: url)
                    }
                    
                    self.heightValueLabel.text = "\(detailJSON["height"].int ?? 0)"
                    self.weightValueLabel.text = "\(detailJSON["weight"].int ?? 0)"
                    
                    let abilities = detailJSON["abilities"].arrayValue
                    for ability in abilities {
                        let label = UILabel()
                        label.font = UIFont(name: "Montserrat-Light", size: 17) ?? UIFont.systemFont(ofSize: 17)
                        label.text = "> \(ability["ability"]["name"].stringValue)"
                        self.abilitiesStackView.addArrangedSubview(label)
                        
                    }
                    self.abilitiesStackView.snp.remakeConstraints { (make) in
                        make.height.equalTo(self.abilitiesStackView.arrangedSubviews.count * 25 + 5)
                    }
                    
                   
                } catch {
                    self.showError()
                }
                
            case .failure(let error):
                self.showError(error.localizedDescription)
            }
        }
        
        
    }
    
    func showError(_ message: String = "error.getting.detail".fromTable("Detail")) {
        Loaf.init(message, state: .error, location: .bottom, presentingDirection: .vertical, dismissingDirection: .vertical, sender: self).show()
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
