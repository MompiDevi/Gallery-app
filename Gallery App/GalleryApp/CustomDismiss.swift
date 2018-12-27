//
//  CustomDismiss.swift
//  GalleryApp
//
//  Created by N. Mompi Devi on 28/07/18.
//  Copyright © 2018 momiv. All rights reserved.
//

import UIKit

class CustomDismiss: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toViewController:ViewController = transitionContext.viewController(forKey: .to) as! ViewController
        let fromViewController:DetailViewController = transitionContext.viewController(forKey: .from) as! DetailViewController
        let container = transitionContext.containerView
        
        let indexpath = toViewController.collectionView.indexPathsForSelectedItems?.first
        let cell:CustomCollectionViewCell = toViewController.collectionView.cellForItem(at: indexpath!) as! CustomCollectionViewCell
        
        let snapshot = fromViewController.imageView.snapshotView(afterScreenUpdates: false)
        snapshot?.contentMode = UIViewContentMode.scaleAspectFill
        
        let cellFrame = container.convert(cell.ImageView.frame, from: cell.ImageView.superview)
        
        let whiteLayer = UIView(frame: toViewController.view.frame)
        whiteLayer.backgroundColor = UIColor.white
        
        container.addSubview(toViewController.view)
        container.addSubview(whiteLayer)
        container.addSubview(snapshot!)
        
        whiteLayer.alpha = 1
        cell.isHidden = true
        
        UIView.animate(withDuration: 0.5, animations: {
            snapshot?.frame = cellFrame
            whiteLayer.alpha = 0.5
        }) { (completed) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            if(!transitionContext.transitionWasCancelled){
                cell.isHidden = false
            } else {
                container.addSubview(fromViewController.view)
            }
            snapshot?.removeFromSuperview()
            whiteLayer.removeFromSuperview()
            
            
            
        }
    }
    

}
