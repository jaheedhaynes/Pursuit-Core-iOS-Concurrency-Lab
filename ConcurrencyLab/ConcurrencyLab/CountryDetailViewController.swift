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
        guard let validCountry = country else {
            fatalError("could not load country")
        }
        
        countryNameLabel.text = validCountry.name
        capitalLabel.text = "Capital: \(validCountry.capital)"
        populationLabel.text = "Population: \(validCountry.population.description)"
        
        ImageClient.fetchImage(for: validCountry.flag) { [weak self] (result) in
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
