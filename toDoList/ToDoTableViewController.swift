//
//  ToDoTableViewController.swift
//  toDoList
//
//  Created by Ilana Rubin on 5/31/20.
//  Copyright © 2020 Ilana Rubin. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController {
//    var toDos : [ToDo] = []
      var toDos : [ToDoCD] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        toDos = createToDos()
//        getToDos()
    }
    
// Not using anymore since we're woking with core data!
//
//    func createToDos() -> [ToDo] {
//        let swift = ToDo()
//        swift.name = "Learn Swift"
//        swift.important = true
//
//        let dog = ToDo()
//        dog.name = "Walk the dog"
//
//        let clean = ToDo()
//        clean.name = "Do the laundry"
//
//        return [swift , dog, clean]
//
//    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return toDos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let toDo = toDos[indexPath.row]
        
        if let name = toDo.name {
            if toDo.important {
                 cell.textLabel?.text = "🌟 " + name
            }
            
        }
        else {
            cell.textLabel?.text = toDo.name
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let toDo = toDos[indexPath.row]
        
        performSegue(withIdentifier: "moveToComplete", sender: toDo)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let addVC = segue.destination as? AddToDoViewController {
            addVC.previousVC = self;
        }
        
        if let completeVC = segue.destination as? CompleteToDoViewController {
            if let toDo = sender as? ToDoCD {
                completeVC.selectedToDo = toDo
                completeVC.previousVC = self
            }
        }
        
    }
    
    func getToDos(){
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let coreDataToDos = try? context.fetch(ToDoCD.fetchRequest()) as? [ToDoCD] {
                       toDos = coreDataToDos
                       tableView.reloadData()
               }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
      getToDos()
    }
}
