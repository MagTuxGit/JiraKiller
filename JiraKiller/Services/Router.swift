//
//  Router.swift
//  JiraKiller
//
//  Created by Andriy Trubchanin on 12/12/18.
//  Copyright © 2018 Andrij Trubchanin. All rights reserved.
//

import UIKit

extension UIViewController
{
    func showTasksList(project: Project) {
        guard let tasksListVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TasksListVC") as? TasksListVC else {
            return
        }
        tasksListVC.project = project
        self.navigationController?.pushViewController(tasksListVC, animated: true)
    }
    
    func showTaskDetails(task: Task?) {
        guard let detailsVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TaskDetailsVC") as? TaskDetailsVC else {
            return
        }
        detailsVC.name = task?.name ?? ""
        detailsVC.delegate = self as? NameEditorDelegate
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}
