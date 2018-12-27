//
//  ViewController.swift
//  GalleryApp
//
//  Created by N. Mompi Devi on 28/06/18.
//  Copyright © 2018 momiv. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate ,UIViewControllerTransitioningDelegate{
    let customTransition = CustomTransition()
    let customDismiss = CustomDismiss()
    let interactor = Interactor()
    let pictures = [#imageLiteral(resourceName: "pic1"), #imageLiteral(resourceName: "pic2"), #imageLiteral(resourceName: "pic3"), #imageLiteral(resourceName: "pic4"), #imageLiteral(resourceName: "pic5")]
    var selectedCell:Int = 0
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:CustomCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        cell.ImageView.image = pictures[indexPath.row];
        return cell;
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCell = indexPath.row
        performSegue(withIdentifier: "detailViewSegue", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "detailViewSegue"){
            let vc = segue.destination as! DetailViewController
            vc.image = pictures[selectedCell]
            vc.transitioningDelegate = self
            vc.interactor = interactor
        }
    }
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customTransition
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customDismiss
    }
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor
    }
}

