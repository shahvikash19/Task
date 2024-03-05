//
//  ViewController.swift
//  Task
//
//  Created by Vikas Hareram Shah on 04/03/24.
//

import UIKit

struct Data : Codable{
    var image : String
    var Title : String
    var Description : String
}
struct Data2 : Codable{
    var image1 : String
    var Title1 : String
    var Description1 : String
}
var userArray: [Data] =
[
    Data(image: "First", Title: "Day 2:Steps", Description: "Meditation\nCoach-Muskaan"),
    Data(image: "Second", Title: "Training", Description: "Workout"),
    Data(image: "Third", Title: "Title 3", Description: "Description 3"),
]

var RoutineArray: [Data2] =
[
    Data2(image1: "Gratitude", Title1: "Gratitude", Description1: "Journal"),
    Data2(image1: "Image2", Title1: "For Inner Peace", Description1: "Music"),
    Data2(image1: "Image1", Title1: "Title 3", Description1: "Description 3"),
]

class ViewController: UIViewController {

    
    @IBOutlet weak var stackview: UIStackView!
    @IBOutlet weak var perimg: UIImageView!
    @IBOutlet weak var exploreview: UIView!
    
    @IBOutlet weak var CollectionView: UICollectionView!
    
    @IBOutlet weak var CollectionView2: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CollectionView.register(UINib(nibName: "GoalsCVC", bundle: .main), forCellWithReuseIdentifier: "GoalsCVC")
        CollectionView2.register(UINib(nibName: "GoalsCVC", bundle: .main), forCellWithReuseIdentifier: "GoalsCVC")
//        self.stackview.layer.borderWidth = 2
//        self.stackview.layer.borderColor = UIColor.cyan.cgColor
//        self.stackview.layer.cornerRadius = 10
        self.exploreview.layer.borderWidth = 2
        self.exploreview.layer.borderColor = UIColor.cyan.cgColor
        self.exploreview.layer.cornerRadius = 10
//        self.perimg.layer.borderWidth = 2
//        self.perimg.layer.borderColor = UIColor.cyan.cgColor
//        self.perimg.layer.cornerRadius = 10
        
    }

    @IBAction func ReminderBtn(_ sender: UIButton) {
        
        let vc = storyboard?.instantiateViewController(identifier: "ReminderVC") as! ReminderVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.CollectionView{
            return userArray.count
        }else if collectionView == self.CollectionView2 {
            return RoutineArray.count
        } else {
            
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.CollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GoalsCVC", for: indexPath) as! GoalsCVC
            cell.HeadLabel.text = userArray[indexPath.row].Title
            cell.SubtitleLabel.text = userArray[indexPath.row].Description
            cell.Imageview.image = UIImage(named: userArray[indexPath.row].image)
            cell.layer.cornerRadius = 10
            return cell
            
        }else if collectionView == self.CollectionView2{
            let cell = CollectionView2.dequeueReusableCell(withReuseIdentifier: "GoalsCVC", for: indexPath) as! GoalsCVC
            cell.HeadLabel.text = RoutineArray[indexPath.row].Title1
            cell.SubtitleLabel.text = RoutineArray[indexPath.row].Description1
            cell.Imageview.image = UIImage(named: RoutineArray[indexPath.row].image1)
            cell.layer.cornerRadius = 10
            return cell

        }
        else{
            return UICollectionViewCell()
        }
    }
}
extension ViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.CollectionView{
            let width = ((collectionView.frame.width)-20)
            let height = collectionView.frame.height
            return CGSize(width: width, height: height)
        }else if collectionView == self.CollectionView2 {
            
            let width = ((collectionView.frame.width)-20)
            let height = (collectionView.frame.height)/2
            return CGSize(width: width, height: height)
        } else {
            // Return a default value or handle the case where neither condition is met
            return CGSize(width: 0, height: 0)
        }
    }
}
