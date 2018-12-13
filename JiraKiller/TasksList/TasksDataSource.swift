//
//  DataSource.swift
//  JiraKiller
//
//  Created by Andriy Trubchanin on 12/10/18.
//  Copyright © 2018 Andrij Trubchanin. All rights reserved.
//

import Foundation

protocol TasksDataSourceDelegate: class {
    func tasksListDidUpdate()
}

class TasksDataSource
{
    static let shared = TasksDataSource()
    private init() {}
    
    weak var delegate: TasksDataSourceDelegate?
    
    private let dataManager = DataManager.shared
    
    func getTasks(projectId: String, completion: ([Task])->()) {
        dataManager.getTasks(projectId:projectId, completion: completion)
    }
    
    func postTask(projectId: String, task: Task) {
        dataManager.postTask(projectId: projectId, task: task)
        delegate?.tasksListDidUpdate()
        NotificationCenter.default.post(name: .ProjectsListDidUpdate, object: nil, userInfo: nil)
    }
    
    func putTask(task: Task) {
        dataManager.putTask(task: task)
        delegate?.tasksListDidUpdate()
    }
}
