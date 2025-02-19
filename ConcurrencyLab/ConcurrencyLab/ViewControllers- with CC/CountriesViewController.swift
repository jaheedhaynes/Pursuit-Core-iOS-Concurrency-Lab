//
//  ViewController.swift
//  ConcurrencyLab
//
//  Created by Jaheed Haynes on 12/9/19.
//  Copyright © 2019 Jaheed Haynes. All rights reserved.
//

import UIKit

class CountriesViewController: UIViewController {
    
    @IBOutlet var CountryTableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    var countryArr = [Country]() {
        didSet {
            DispatchQueue.main.async {
                self.CountryTableView.reloadData()
            }
        }
    }
    
    var flagArr = [FlagImage]() {
        didSet {
            CountryTableView.reloadData()
        }
    }
    
    var searchQuery = "" {
        didSet {
            if !searchQuery.isEmpty {
                flagArr = FlagImage.getFlags().filter { $0.name.lowercased().contains(searchQuery.lowercased()) }
            }
        }
    }
    
    
//--------------------------------------------------------------------------------------------------

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CountryTableView.dataSource = self
        CountryTableView.delegate = self
        searchBar.delegate = self
        loadCountries()
        loadFlags()
    }
    

//--------------------------------------------------------------------------------------------------

    
    func loadCountries() {
        CountryAPIClient.getCountries { (result) in
            switch result {
            case .failure(let appError):
                print(appError)
            case .success(let countries):
                print(countries.count)
                self.countryArr = countries
            }
        }
    }
    
    func loadFlags() {
        flagArr = FlagImage.getFlags()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let countryVC = segue.destination as? CountryDetailController, let indexPath = CountryTableView.indexPathForSelectedRow else {
            fatalError("could not load")
        }
        countryVC.country = flagArr[indexPath.row]
    }
    
}


//--------------------------------------------------------------------------------------------------


extension CountriesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flagArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath) as? CountryCellTableViewCell else {
            fatalError()
        }
        
        let country = flagArr[indexPath.row]
        
        cell.configureCell(for: country)
        
        return cell
    }
}

extension CountriesViewController: UISearchBarDelegate {
    
    func searchBarSearchAction(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
        guard let searchText = searchBar.text else {
            return
        }
        searchQuery = searchText

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard !searchText.isEmpty else {
            loadFlags()
            return
        }
        
        searchQuery = searchText
    }
}

extension CountriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
