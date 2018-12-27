//
//  CustomTransition.swift
//  GalleryApp
//
//  Created by N. Mompi Devi on 12/07/18.
//  Copyright © 2018 momiv. All rights reserved.
//

import UIKit

class CustomTransition: NSObject,UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController:ViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! ViewController
        let toViewController:DetailViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! DetailViewController
        let finalFrame = transitionContext.finalFrame(for: toViewController)
        let containerView = transitionContext.containerView
        let indexPath = fromViewController.collectionView.indexPathsForSelectedItems?.first
        let cell:CustomCollectionViewCell = fromViewController.collectionView.cellForItem(at: indexPath!) as! CustomCollectionViewCell
        let tempImage = cell.ImageView.snapshotView(afterScreenUpdates: false)
        tempImage?.frame  = containerView.convert(cell.ImageView.frame, from: cell.ImageView.superview)
        tempImage?.contentMode = UIViewContentMode.scaleAspectFit
        containerView.addSubview(toViewController.view)
        containerView.addSubview(tempImage!)
        toViewController.imageView.isHidden = true
        UIView.animate(withDuration: 0.5, animations: {
            tempImage?.frame = finalFrame
        }) { (finished) in
            toViewController.imageView.isHidden = false
            tempImage?.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
    }
    
    

}
