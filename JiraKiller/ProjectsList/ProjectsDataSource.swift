//
//  ProjectsDataSource.swift
//  JiraKiller
//
//  Created by Andriy Trubchanin on 12/11/18.
//  Copyright © 2018 Andrij Trubchanin. All rights reserved.
//

class ProjectsDataSource
{
    static let shared = ProjectsDataSource()
    private init() {}
    
    private let dataManager = DataManager.shared
    
    func getProjects() -> [Project] {
        return dataManager.getProjects()
    }
    
    func postProject(project: Project) {
        dataManager.postProject(project: project)
    }
    
    func putProject(project: Project) {
        dataManager.putProject(project: project)
    }
}
