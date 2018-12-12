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
    var tasks = [Task]()
    
    init(name: String) {
        self.id = Project.maxId
        Project.maxId += 1
        self.name = name
    }
}

class Task
{
    var name: String
    
    init(name: String) {
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
        
        var project1 = Project(name: "House work")
        project1.tasks.append(Task(name: "Do dishes"))
        project1.tasks.append(Task(name: "Clean the room"))
        project1.tasks.append(Task(name: "Feed the cat"))
        project1.tasks.append(Task(name: "Call mom"))
        project1.tasks.append(Task(name: "Buy presents"))
        data.append(project1)
        
        var project2 = Project(name: "Onlinico project")
        project2.tasks.append(Task(name: "Fork another similar project"))
        project2.tasks.append(Task(name: "Publish to AppStore"))
        project2.tasks.append(Task(name: "Claim money from client"))
        project2.tasks.append(Task(name: "Profit"))
        data.append(project2)
        
        var project3 = Project(name: "iOS Club")
        project3.tasks.append(Task(name: "Read some articles"))
        project3.tasks.append(Task(name: "Prepare some code"))
        data.append(project3)
        
        return data
    }()
}

extension DataManager
{
    func getProject(projectId: Int) -> Project? {
        return projects.first(where: { $0.id == projectId })
    }
    
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

extension DataManager
{
    func getTasks(projectId: Int) -> [Task] {
        return getProject(projectId: projectId)?.tasks ?? []
    }
    
    func postTask(projectId: Int, task: Task) {
        let project = getProject(projectId: projectId)
        project?.tasks.append(task)
    }
    
    func putTask(task: Task) {
    }
}
