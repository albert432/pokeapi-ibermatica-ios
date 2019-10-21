//
//  HomeViewController.swift
//  Ibermatica-iOS
//
//  Copyright © 2019 Albert. All rights reserved.
//

import UIKit
import Alamofire
import Loaf

class HomeViewController: UIViewController {
    
    // MARK: - OUTLETS
    @IBOutlet weak var loadPokemonsButton: UIButton! {
        didSet {
            loadPokemonsButton.titleLabel?.numberOfLines = 0
            loadPokemonsButton.titleLabel?.textAlignment = .center
            loadPokemonsButton.setTitle("no.pokemons.button".fromTable("Home"), for: UIControl.State())
            loadPokemonsButton.setTitleColor(Color.text, for: UIControl.State())
            loadPokemonsButton.isHidden = Pokemon.all.count > 0
        }
    }
    
    @IBOutlet weak var pokemonsTableView: UITableView! {
        didSet {
            pokemonsTableView.delegate = self
            pokemonsTableView.dataSource = self
            pokemonsTableView.tableFooterView = UIView()
            pokemonsTableView.separatorColor = Color.primaryDark
            pokemonsTableView.isHidden = Pokemon.all.count == 0
        }
    }
    
    // MARK: - PROPERTIES
    var pokemonsToShow: [Pokemon] = [] {
        didSet {
            pokemonsTableView.reloadData()
        }
    }
    
    // MARK: - ACTIONS
    @IBAction func loadPokemonsAction(_ sender: UIButton) {
        loadPokemons()
    }
    
    // MARK: - FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let logo = UIImageView(image: #imageLiteral(resourceName: "pokeapi"))
        logo.contentMode = .scaleAspectFit
        navigationItem.titleView = logo
        
        // Search controller
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.definesPresentationContext = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "searchbar.placeholder".fromTable("Home")
        navigationItem.searchController = searchController
        
        // Register cell
        let pokemonCell = UINib(nibName: "PokemonCell", bundle: nil)
        pokemonsTableView.register(pokemonCell, forCellReuseIdentifier: "PokemonCell")
        
        pokemonsToShow = Array(Pokemon.all)
                
    }
    
    func loadPokemons() {
        _ = Pokemon.all({ (success, error) in
            switch success {
            case true:
                Loaf.init("pokemons.load.success".fromTable("Home"), sender: self).show()
                self.loadPokemonsButton.isHidden = true
                self.pokemonsTableView.isHidden = false
                self.pokemonsToShow = Array(Pokemon.all)
            case false:
                Loaf.init("pokemons.load.failure".fromTable("Home"), sender: self).show()
            }
        })
    }
    
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard let cell = tableView.cellForRow(at: indexPath) as? PokemonCell else { return }
        guard let id = cell.pokemonID else { return }

        let detailController = DetailViewController(nibName: "DetailViewController", bundle: nil)
        detailController.id = id
        detailController.title = cell.nameLabel.text
        
        
        navigationController?.pushViewController(detailController, animated: true)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonsToShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as! PokemonCell
        cell.prepareForReuse()
        
        let pokemon = pokemonsToShow[indexPath.row]
        
        cell.nameLabel.text = pokemon.name.capitalized
        
        cell.pokemonID = pokemon.id

        return cell
    }
}


extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        
        pokemonsToShow = text.isEmpty ? Array(Pokemon.all) : Array(Pokemon.all.filter("name CONTAINS[cd] %@", text))
    }
    
    
}
