//
//  DataManager.swift
//  JiraKiller
//
//  Created by Andriy Trubchanin on 12/11/18.
//  Copyright © 2018 Andrij Trubchanin. All rights reserved.
//

class Project
{
    static var maxId: Int = 0
    
    var id: Int
    var name: String
    
    init(name: String) {
        self.id = Project.maxId
        Project.maxId += 1
        self.name = name
    }
}

class DataManager
{
    static let shared = DataManager()
    private init() {}

    private var projects = [Project]()
    
    private let initialProjects: [Project] = {
        var data = [Project]()
        
        data.append(Project(name: "House work"))
        data.append(Project(name: "Onlinico project"))
        data.append(Project(name: "iOS Club"))
        
        return data
    }()
}

extension DataManager
{
    func getProjects() -> [Project] {
        if projects.isEmpty {
            projects = initialProjects
        }
        return projects
    }
    
    func postProject(project: Project) {
        projects.append(project)
    }
    
    func putProject(project: Project) {
    }
}
