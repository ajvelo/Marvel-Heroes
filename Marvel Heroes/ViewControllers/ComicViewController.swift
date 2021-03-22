//
//  ComicViewController.swift
//  Marvel Heroes
//
//  Created by Andreas Velounias on 22/03/2021.
//

import UIKit

class ComicViewController: UIViewController {
    
    
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var heroDescription: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedHero: HeroModel?
    var heroes: HeroViewModelProtocol?
    fileprivate var currentPage = 0
    
    convenience init(heroes: HeroViewModelProtocol, selectedHero: HeroModel) {
        self.init()
        self.heroes = heroes
        self.selectedHero = selectedHero
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "ComicCell", bundle: nil), forCellWithReuseIdentifier: "comicCell")
        self.title = selectedHero?.name
        if let currentHero = selectedHero {
            displayHero(description: currentHero.description, image: currentHero.thumbnail.fullName)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchComicsForHero(page: currentPage, heroId: 1)
    }
    
    func fetchComicsForHero(page: Int, heroId: Int) {
        guard let heroId = selectedHero?.id else { return }
        heroes?.getHeroComics(page: currentPage, heroId: heroId, complete: { [weak self] (result) in
            switch result {
            case .Success(_, _):
                self?.collectionView.reloadData()
            case .Error(let message, let statusCode):
                print("Error \(message) \(statusCode ?? 0)")
            }
        })
    }
    
    func displayHero(description: String, image: String) {
        if description.isEmpty {
            heroDescription.text = "No description found"
        } else {
            heroDescription.text = description
        }
        heroImageView.kf.setImage(with: URL(string: image))
    }
}

extension ComicViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heroes?.comicList.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ComicCell = collectionView.dequeueReusableCell(withReuseIdentifier: "comicCell", for: indexPath) as! ComicCell
        cell.comicTitle.text = heroes?.comicList[indexPath.row].title
        if let thumbnail = heroes?.comicList[indexPath.row].thumbnail.fullName {
            if let imageURL = URL(string: thumbnail) {
                cell.comicImageView.kf.setImage(with: imageURL)
                
            }
        }
        return cell

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 300)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let comicList = heroes?.comicList {
            guard let heroId = selectedHero?.id else { return }
            if (indexPath.row == comicList.count - 1 ) {
                currentPage += 1
                fetchComicsForHero(page: currentPage, heroId: heroId)
             }
        }
    }
}
