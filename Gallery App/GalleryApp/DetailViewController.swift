//
//  DetailViewController.swift
//  GalleryApp
//
//  Created by N. Mompi Devi on 05/07/18.
//  Copyright © 2018 momiv. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var image:UIImage?
    var interactor:Interactor?
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tappedOnBack(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func panGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: sender.view)
        let percent = translation.y/(sender.view?.bounds.height)!
        switch sender.state {
        case .began:
            interactor?.hasStarted = true
            dismiss(animated: true, completion: nil)
        case .changed:
            interactor?.shouldFinish = percent > 0.3
            interactor?.update(percent)
        case .cancelled:
            interactor?.hasStarted = false
            interactor?.cancel()
        case .ended:
            interactor?.hasStarted = false
            if(interactor?.shouldFinish)!{
                interactor?.finish()
            } else {
                interactor?.cancel()
            }
        default:
            break
        }
    }
}
