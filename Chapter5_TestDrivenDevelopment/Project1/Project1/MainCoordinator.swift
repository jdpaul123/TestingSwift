//
//  MainCoordinator.swift
//  Project1
//
//  Created by Jonathan Paul on 12/28/23.
//

import UIKit

class MainCoordinator {
    var navigationController = UINavigationController()

    func start() {
        // NOTE: In this app we have a storyboard but we are not directly using it
        // I deleted the Main Interface property in the Project1 info tab in settings
        // Then I added code to the SceneDelegate to attatch the scene to set it's
        // window's scene to have a rootViewController value that is the instance of
        // the ViewController class that is instantiated in this start() method
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        guard let viewController = storyboard.instantiateInitialViewController() as? ViewController else {
            fatalError("Missing initial view controller in Main.storyboard.")
        }

        viewController.pictureSelectAction = { [weak self] fileName in
            self?.showDetail(for: fileName)
        }

        navigationController.pushViewController(viewController, animated: false)
    }

    func showDetail(for filename: String) {
        let vc = DetailViewController()
        vc.selectedImage = filename
        navigationController.pushViewController(vc, animated: true)
    }
}
