//
//  TasksListRouter.swift
//  JiraKiller
//
//  Created by Andriy Trubchanin on 12/13/18.
//  Copyright © 2018 Andrij Trubchanin. All rights reserved.
//

import UIKit

extension TasksListVC
{
    func showTaskDetails(task: Task?) {
        guard let detailsVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TaskDetailsVC") as? TaskDetailsVC else {
            return
        }
        detailsVC.name = task?.name ?? ""
        detailsVC.nameDidChange = { [weak self] name in
            guard let `self` = self else { return }
            
            if let currentTask = self.currentTask {
                let task = self.tasksList[currentTask]
                task.name = name
                TasksDataSource.shared.putTask(task: task)
            } else {
                let task = Task(name: name)
                TasksDataSource.shared.postTask(projectId: self.project!.id, task: task)
            }
        }
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}
