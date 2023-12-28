//
//  DetailViewController.swift
//  Project1
//
//  Created by Jonathan Paul on 12/28/23.
//

import UIKit

class DetailViewController: UIViewController {
    var imageView = UIImageView()
    var selectedImage: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }

    override func loadView() {
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        view = imageView
    }
}
