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
        detailsVC.delegate = self
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}
