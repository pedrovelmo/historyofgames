//
//  StoreViewController.swift
//  HistoryOfGames
//
//  Created by Pedro Velmovitsky on 24/11/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import UIKit

class StoreViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
    @IBOutlet weak var menuB: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var textView: UITextView!
    @IBAction func menuButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var games = ["odessaRunframe1", "KingArth4"]
    var selectedCell: Int = 1
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        //menuB.imageView?.image = UIImage(named: "menu")
//        var color = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
//        menuB.tintColor = color
      //  menuB.layer.backgroundColor = .none
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseIdentifier",
                                                      for: indexPath) as! StoreCollectionViewCell
        //2
        cell.imageView.image = UIImage(named: games[indexPath.row])
        selectedCell = indexPath.row
        updateTextView()
        return cell
    }
    
    func updateTextView() {
        
        switch(selectedCell){
        case 0:
            textView.text = "Odessa is an awesome game developed by Apple Developer Academy Rio! Click here to see more information"
            
        case 1:
            textView.text = "King Arth game"
        default:
            textView.text = ""
            
        }
        
    }

}
