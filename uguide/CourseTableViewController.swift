//
//  CourseTableViewController.swift
//  uguide
//
//  Created by Sebastian Frelle Koch on 4/16/18.
//  Copyright © 2018 Sebastian Frelle Koch. All rights reserved.
//

import UIKit
import os.log
import FirebaseAuth
import FirebaseFirestore

class CourseTableViewController: UITableViewController {
    
    //MARK: Properties
    private var courses = [Course]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        populate()
        // Load the sample data
//        loadCourses()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return courses.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CourseTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CourseTableViewCell else {
            fatalError("The dequeued cell is not an instance of CourseTableViewCell")
        }
        
        let course = courses[indexPath.row]
        
        cell.populate(course: course)
        
        return cell
    }
    //
    @IBAction func unwindToCourseList(sender: UIStoryboardSegue) {
        guard let sourceViewController = sender.source as? AddCourseViewController, let course = sourceViewController.course else {
            os_log("Course not set", log: .default, type: .error)
            return
        }
        let newIndexPath = IndexPath(row: courses.count, section: 0)
        courses.append(course)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        
        switch (segue.identifier ?? "") {
        case "AddItem":
            os_log("Adding a new course.", log: .default, type: .debug)
        case "ShowDetail":
            // Make sure the segue has the intended destination
            guard let courseDetailViewController = segue.destination as? CourseViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedCourseCell = sender as? CourseTableViewCell else {
                fatalError("Unexpected sender: \(sender!)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedCourseCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            // Get the meal selected by the user and update the property on the MealViewController instance
            let selectedCourse = courses[indexPath.row]
            courseDetailViewController.course = selectedCourse
        default:
            fatalError("Unexpected Segue Identifier: \(segue.identifier!)")
        }
    }
    
    //MARK: Dummy data
    
//    private func loadCourses() {
//        // Load photos before initializing meals
//
//        let campusLyngby = Campus(name: "Lyngby")
//        let building_324 = Building(name: "324")
//        let room_23 = Room(name: "23")
//
//        guard let course1 = Course(name: "IntroStat",
//                                   id: "02323",
//                                   campus: campusLyngby,
//                                   building: building_324,
//                                   room: room_23) else {
//            fatalError("Unable to instantiate course1")
//        }
//
//        guard let course2 = Course(name: "Algoritmer og datastrukturer",
//                                   id: "02324",
//                                   campus: campusLyngby,
//                                   building: building_324,
//                                   room: room_23) else {
//            fatalError("Unable to instantiate course2")
//        }
//
//        guard let course3 = Course(name: "Matematik 1",
//                                   id: "02325",
//                                   campus: campusLyngby,
//                                   building: building_324,
//                                   room: room_23) else {
//            fatalError("Unable to instantiate course3")
//        }
//
//        courses += [course1, course2, course3]
//    }
    
    private func populate() {
        guard let user = Auth.auth().currentUser else {
            fatalError("Authorized user not set")
        }
        
        guard let email = user.email else {
            fatalError("Authorized user has no email")
        }
        
        let db = Firestore.firestore()
        db.collection("users").whereField("email", isEqualTo: email).getDocuments { [unowned self] (snapshot, error) in
            if let error = error {
                print("Query executed with error \(error)")
                return
            }
            
            guard let snapshot = snapshot else {
                os_log("snapshot not set", log: .default, type: .error)
                return
            }
            
            let users = snapshot.documents
            guard users.count == 1, let user = users.first else {
                os_log("Unexpected number of users with specified e-mail", log: .default, type: .error)
                return
            }
            
            db.collection("users").document(user.documentID).collection("courses").getDocuments { (snapshot, error) in
                if let error = error {
                    print("Query executed with error \(error)")
                    return
                }
                
                guard let snapshot = snapshot else {
                    os_log("snapshot not set", log: .default, type: .error)
                    return
                }
                
                let models = snapshot.documents.map { document -> Course in
                    if let course = Course(dictionary: document.data()) {
                        return course
                    } else {
                        fatalError("Could not initialize course from dictionary")
                    }
                }
                
                self.courses = models
                
                self.tableView.reloadData()
            }
        }
    }
}
