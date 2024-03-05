//
//  SetReminderPG.swift
//  Task
//
//  Created by Vikas Hareram Shah on 04/03/24.
//

import UIKit
import UserNotifications

protocol RecentReminder: AnyObject {
    func didTapSaveBtn(detailedTask: String, task: String)
}


class SetReminderPG: UIViewController {

    var delegate: RecentReminder?
    var appdelegate = UIApplication.shared.delegate as! AppDelegate
    var recentText = [Reminder](){
        didSet{
            
        }
    }

    @IBOutlet weak var Datepicker: UIDatePicker!
    @IBOutlet weak var dtTF: UITextField!
    @IBOutlet weak var taskTF: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func saveBTN(_ sender: UIButton) {
        guard let taskText = dtTF.text, !taskText.isEmpty,
              let detailText = taskTF.text, !detailText.isEmpty else {
            return
        }
        delegate?.didTapSaveBtn(detailedTask: detailText, task: taskText)
        let context = appdelegate.persistentContainer.viewContext
        let details = Reminder(context: context)
        details.detailedtask = detailText
        details.task = taskText

        appdelegate.saveContext()
        recentText.append(details)

        let reminderDate = Datepicker.date // Get the selected date from the date picker

        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "Task: \(taskText)\nTaskDetail: \(detailText)"
        content.sound = UNNotificationSound.default
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: reminderDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully.")
            }
        }

        delegate?.didTapSaveBtn(detailedTask: detailText, task: taskText)

        let vc = storyboard?.instantiateViewController(withIdentifier: "ReminderVC") as! ReminderVC      
        vc.task = taskText
        vc.detailtask = detailText
       self.navigationController?.pushViewController(vc, animated: true)
    }

    func fetchData() {
        let context = appdelegate.persistentContainer.viewContext
        do {
            recentText = try context.fetch(Reminder.fetchRequest()) as! [Reminder]
        } catch {
            print("Error fetching data: \(error.localizedDescription)")
        }
    }
}
