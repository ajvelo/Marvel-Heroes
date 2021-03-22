//
//  ViewController.swift
//  Marvel Heroes
//
//  Created by Andreas Velounias on 22/03/2021.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate var heroes = HeroViewModel()
    fileprivate var currentPage = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "HeroCell", bundle: nil), forCellWithReuseIdentifier: "heroCell")
        self.title = "Marvel Heroes"

    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchHeroes(page: currentPage)
    }
    
    func fetchHeroes(page: Int) {
        heroes.networkService = NetworkService.shared
        heroes.getHeroes(page: page) { [weak self] (result) in
            switch result {
            case .Success(_, _):
                self?.collectionView.reloadData()
            case .Error(let message, let statusCode):
                print("Error \(message) \(statusCode ?? 0)")
            }
        }
        
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heroes.heroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HeroCell = collectionView.dequeueReusableCell(withReuseIdentifier: "heroCell", for: indexPath) as! HeroCell
        cell.heroNameLabel.text = heroes.heroes[indexPath.row].name
        cell.heroImageView.kf.setImage(with: URL(string: heroes.heroes[indexPath.row].thumbnail.fullName))
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row == heroes.heroes.count - 1 ) {
            currentPage += 1
            fetchHeroes(page: currentPage)
         }
    }
}
