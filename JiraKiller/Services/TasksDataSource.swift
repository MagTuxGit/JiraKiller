//
//  DataSource.swift
//  JiraKiller
//
//  Created by Andriy Trubchanin on 12/10/18.
//  Copyright © 2018 Andrij Trubchanin. All rights reserved.
//

class TasksDataSource
{
    static let shared = TasksDataSource()
    private init() {}
    
    private let dataManager = DataManager.shared
    
    func getTasks(projectId: Int) -> [Task] {
        return dataManager.getTasks(projectId:projectId)
    }
    
    func postTask(projectId: Int, task: Task) {
        dataManager.postTask(projectId: projectId, task: task)
    }
    
    func putTask(task: Task) {
        dataManager.putTask(task: task)
    }
}
