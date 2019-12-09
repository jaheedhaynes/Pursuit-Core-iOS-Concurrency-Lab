//
//  CountryDetailViewController.swift
//  ConcurrencyLab
//
//  Created by Jaheed Haynes on 12/9/19.
//  Copyright © 2019 Jaheed Haynes. All rights reserved.
//

import UIKit

class CountryDetailController: UIViewController {
    
    @IBOutlet var flagImage: UIImageView!
    @IBOutlet var countryNameLabel: UILabel!
    @IBOutlet var capitalLabel: UILabel!
    @IBOutlet var populationLabel: UILabel!
    
    var country: FlagImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    func updateUI() {
        guard let Country = country else {
            fatalError("could not load country")
        }
        
        countryNameLabel.text = Country.name
        capitalLabel.text = "Capital: \(Country.capital)"
        populationLabel.text = "Population: \(Country.population.description)"
        
        ImageAPIClient.getImage(for: Country.flag) { [weak self] (result) in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.flagImage.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
