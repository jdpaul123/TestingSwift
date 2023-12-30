//
//  ViewController.swift
//  Project1
//
//  Created by Jonathan Paul on 12/27/23.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    var pictureSelectAction: ((String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)

        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }

        // NOTE: For testing you need to register the reuse identifier in code because the storyboard is not loaded.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        navigationController?.navigationBar.prefersLargeTitles = true

        title = "Storm Viewer"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pictureSelectAction?(pictures[indexPath.row])
    }
}

