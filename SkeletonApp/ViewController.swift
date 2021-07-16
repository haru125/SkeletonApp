//
//  ViewController.swift
//  SkeletonApp
//
//  Created by Satoshi Ota on 2021/07/15.
//

import UIKit
import SkeletonView

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, SkeletonTableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var data = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 120
        tableView.estimatedRowHeight = 120
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            for _ in 0..<30 {
                self.data.append("Some text")
            }
            
            self.tableView.stopSkeletonAnimation()
            self.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
            
            self.tableView.reloadData()
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.isSkeletonable = true
        tableView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .systemTeal), animation: nil, transition: .crossDissolve(0.25))
//        tableView.showAnimatedSkeleton(usingColor: .concrete, transition: .crossDissolve(0.25))
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return MyTableViewCell.identifier
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.identifier,
                                                 for: indexPath) as! MyTableViewCell
        if !data.isEmpty {
            cell.myLabel.text = data[indexPath.row]
            cell.myImageView.image = UIImage(systemName: "star")
        }
        return cell
    }

}

