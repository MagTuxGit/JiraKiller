//
//  TasksListVC.swift
//  JiraKiller
//
//  Created by Andriy Trubchanin on 12/12/18.
//  Copyright © 2018 Andrij Trubchanin. All rights reserved.
//

import UIKit

class TasksListVC: UIViewController
{
    @IBOutlet private weak var tableView: UITableView!
    
    var project: Project?
    
    private var tasksList: [Task] {
        return project?.tasks ?? []
    }
    private var currentTask: Int? = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Tasks"

        tableView.delegate = self
        tableView.dataSource = self
        
        TasksDataSource.shared.delegate = self
        
        setupNavigationBar()
    }
    
    @objc private func addNewTask(_ sender: UIBarButtonItem) {
        currentTask = nil
        showTaskDetails(task: nil)
    }
    
    @objc private func onDismiss(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setupNavigationBar() {
        let leftButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(onDismiss(_:)))
        self.navigationItem.backBarButtonItem = leftButtonItem
        
        let rightButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTask(_:)))
        self.navigationItem.setRightBarButton(rightButtonItem, animated: false)
    }
}

extension TasksListVC: TasksDataSourceDelegate
{
    func tasksListDidUpdate() {
        self.tableView.reloadData()
    }
}

extension TasksListVC: UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = tasksList[indexPath.row].name
        return cell
    }
}

extension TasksListVC: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentTask = indexPath.row
        showTaskDetails(task: tasksList[indexPath.row])
    }
}

extension TasksListVC: NameEditorDelegate {
    func nameDidChange(name: String) {
        if let currentTask = currentTask {
            let task = tasksList[currentTask]
            task.name = name
            TasksDataSource.shared.putTask(task: task)
        } else {
            let task = Task(name: name)
            TasksDataSource.shared.postTask(projectId: project!.id, task: task)
        }
    }
}
