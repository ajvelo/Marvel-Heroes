//
//  HeroesViewController.swift
//  Marvel Heroes
//
//  Created by Andreas Velounias on 22/03/2021.
//

import UIKit
import Kingfisher

class HeroesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate var heroes = HeroViewModel()
    fileprivate var currentPage = 0
    fileprivate var selectedHero: HeroViewModel?
    fileprivate var isLoadingList = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "HeroCell", bundle: nil), forCellWithReuseIdentifier: "heroCell")
        self.title = "Marvel Heroes"
        fetchHeroes(page: currentPage)
    }
    
    func fetchHeroes(page: Int) {
        isLoadingList = true
        heroes.networkService = NetworkService.shared
        heroes.getHeroes(page: page) { [weak self] (result) in
            self?.isLoadingList = false
            switch result {
            case .Success(_, _):
                self?.collectionView.reloadData()
            case .Error(let message, let statusCode):
                if let alert = self?.handleError(message: message, statusCode:  String(statusCode ?? 0)) {
                    self?.present(alert, animated: true, completion: nil)
                }

                
            }
        }
        
    }
    
    func handleError(message: String, statusCode: String) -> UIAlertController {
        let alert = UIAlertController(title: "No internet connection - status code \(statusCode)", message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Retry", style: .default) { (action) in
            self.fetchHeroes(page: self.currentPage)
        }
        alert.addAction(action)
        return alert
    }
}

extension HeroesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heroes.heroes.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HeroCell = collectionView.dequeueReusableCell(withReuseIdentifier: "heroCell", for: indexPath) as! HeroCell
        cell.heroNameLabel.text = heroes.heroes[indexPath.row].name
        cell.heroImageView.kf.setImage(with: URL(string: heroes.heroes[indexPath.row].thumbnail.fullName))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        heroes.selectedHero = heroes.heroes[indexPath.row]
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let comicsViewController = storyBoard.instantiateViewController(withIdentifier: "comicsvc") as! ComicViewController
        comicsViewController.heroes = self.heroes
        comicsViewController.selectedHero = heroes.selectedHero
        self.navigationController?.pushViewController(comicsViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (((collectionView.contentOffset.y + collectionView.frame.size.height) > collectionView.contentSize.height ) && !isLoadingList) {
            currentPage += 1
            fetchHeroes(page: currentPage)
        }
    }
}
