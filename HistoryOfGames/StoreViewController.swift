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
    @IBOutlet weak var buyButton: UIButton!
    
    var games = ["didoStore", "odessaRunframe1", "KingArth4", "LumosStore"]
    var selectedCell: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
         textView.text = "Dido is the main character of Game of Games. He was playing in an arcade machine and got stuck in it. Play the game and help him to survive!"
        
        buyButton.setImage(UIImage(named: "SelectedButton"), for: UIControlState.normal)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: UICollectionViewScrollPosition.right)
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
        
        if (indexPath.row == 0) {
            cell.backgroundImageView.image = UIImage(named: "CellBackgroundSelected")
        }
        
        else {
            cell.backgroundImageView.image = UIImage(named: "CellBackground")
        }
        
        cell.imageView.image = UIImage(named: games[indexPath.row])

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCell = indexPath.row
        let cell = collectionView.cellForItem(at: indexPath) as! StoreCollectionViewCell
         cell.backgroundImageView.image = UIImage(named: "CellBackgroundSelected")
        
        updateTextView()
        updateBuyButtonImage()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! StoreCollectionViewCell
        cell.backgroundImageView.image = UIImage(named: "CellBackground")

    }
    
    func updateTextView() {
        
        switch(selectedCell){
            
        case 0:
            textView.text = "Dido is the main character of Game of Games. He was playing in an arcade machine and got stuck in it. Play the game and help him to survive!"
        case 1:
           
            textView.text = "Odessa is an awesome iOS game that is coming soon to the AppStore! Soon, you will be able to play with the character!"
            
        case 2:
            // You must set the formatting of the link manually
            let linkAttributes = [
                NSLinkAttributeName: NSURL(string: "https://itunes.apple.com/br/app/king-arth/id1257902286?mt=8")!,
                NSForegroundColorAttributeName: UIColor.blue,
                NSFontAttributeName:UIFont(name: "Gameplay", size: 14.0)!
                ] as [String : Any]
            let attributedString = NSMutableAttributedString(string: "King Arth is an awesome iOS game, already available on the AppStore! Soon, you will be able to play with the character. Click here to download the game", attributes:
                [NSForegroundColorAttributeName: UIColor.white,
                 NSFontAttributeName:UIFont(name: "Gameplay", size: 14.0)!])
            attributedString.setAttributes(linkAttributes, range: NSMakeRange(120,31))
            textView.attributedText =  attributedString
            
        case 3:
            // You must set the formatting of the link manually
            
            let linkAttributes = [
                NSLinkAttributeName: NSURL(string: "https://itunes.apple.com/br/app/lumos-the-game/id1291010716?mt=8")!,
                NSForegroundColorAttributeName: UIColor.blue,
                NSFontAttributeName:UIFont(name: "Gameplay", size: 14.0)!
                ] as [String : Any]
            let attributedString = NSMutableAttributedString(string: "Lumos presents the vision of how the world can change by certain circumstances. So, what can make this changes? Click here to download the game and find out", attributes:
                [NSForegroundColorAttributeName: UIColor.white,
                 NSFontAttributeName:UIFont(name: "Gameplay", size: 14.0)!])
            attributedString.setAttributes(linkAttributes, range: NSMakeRange(112,44))
            textView.attributedText =  attributedString
        default:
            textView.text = ""
            
        }
        
    }
    
    func updateBuyButtonImage() {
        switch(selectedCell) {
        case 0:
            buyButton.setImage(UIImage(named: "SelectedButton"), for: UIControlState.normal)
        case 1:
            buyButton.setImage(UIImage(named: "Soon"), for: UIControlState.normal)
        case 2:
            buyButton.setImage(UIImage(named: "Soon"), for: UIControlState.normal)
        default:
            buyButton.setImage(UIImage(named: "Soon"), for: UIControlState.normal)
            
            
        }
    }

}
