//
//  ReminderVC.swift
//  Task
//
//  Created by Vikas Hareram Shah on 04/03/24.
//

import UIKit

class ReminderVC: UIViewController {
    var task : String?
    var detailtask : String?
    var recentTexts : [Reminder] = []
    @IBOutlet weak var tabelview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tabelview.register(UINib(nibName: "ReminderTVC", bundle: .main), forCellReuseIdentifier: "ReminderTVC")
        // Do any additional setup after loading the view.
        print("datas",recentTexts)
        fetchdata()
    }
    func fetchdata(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            recentTexts = try context.fetch(Reminder.fetchRequest()) as! [Reminder]
            tabelview.reloadData()
        }
        catch{
            print("error in catch fav")
        }
    }
    func savetocoredata(categoryname:String,result:Int32){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let details = Reminder(context: context)
        details.task = task
        details.detailedtask = detailtask
        
        do {
            try context.save()
            recentTexts.append(details)
            tabelview.reloadData()
        }catch{
            print("error in xcatch")
        }
    }

    @IBAction func plusBTN(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "SetReminderPG") as! SetReminderPG
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func BackBtn(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    

}
extension ReminderVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentTexts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderTVC", for: indexPath) as! ReminderTVC
        cell.TaskLabel.text = recentTexts[indexPath.row].task
        cell.DetailLabel.text = recentTexts[indexPath.row].detailedtask
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            context.delete(recentTexts[indexPath.row])
            do {
                try context.save()
                recentTexts.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade
                )
                
            } catch {
                print ("Error" )
            }
        }
        
        
    }

}
