//
//  ProjectsListVC.swift
//  JiraKiller
//
//  Created by Andriy Trubchanin on 12/11/18.
//  Copyright © 2018 Andrij Trubchanin. All rights reserved.
//

import UIKit

class ProjectsListVC: UIViewController
{
    @IBOutlet weak var tableView: UITableView!
    
    private var projectsList: [Project] {
        return ProjectsDataSource.shared.getProjects()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Projects"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setupNavigationBar()
    }
    
    @objc private func addNewItem(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Add New Project", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Project Name"
        }
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { [weak self] _ in
            if let projectName = alertController.textFields?[0].text {
                ProjectsDataSource.shared.postProject(project: Project(name: projectName))
                self?.tableView.reloadData()
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func setupNavigationBar() {
        let rightButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewItem(_:)))
        self.navigationItem.setRightBarButton(rightButtonItem, animated: false)
    }
}

extension ProjectsListVC: UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projectsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = projectsList[indexPath.row].name
        return cell
    }
}

extension ProjectsListVC: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showTasksList(project: projectsList[indexPath.row])
    }
}