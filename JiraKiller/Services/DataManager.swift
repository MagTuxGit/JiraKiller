//
//  DataManager.swift
//  JiraKiller
//
//  Created by Andriy Trubchanin on 12/11/18.
//  Copyright © 2018 Andrij Trubchanin. All rights reserved.
//

import Foundation

class Project: NSObject, NSCoding
{
    static var maxId: Int = 0
    
    var id: Int
    var name: String
    var tasks = [Task]()
    
    init(id: Int, name: String, tasks: [Task]) {
        self.id = id
        self.name = name
        self.tasks = tasks
    }
    
    convenience init(name: String) {
        self.init(id: Project.maxId, name: name, tasks: [])
        Project.maxId += 1
    }
    
    // NSCoding
    required convenience init(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeInteger(forKey: "id")
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let tasks = aDecoder.decodeObject(forKey: "tasks") as! [Task]
        self.init(id: id, name: name, tasks: tasks)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(tasks, forKey: "tasks")
    }
}

class Task: NSObject, NSCoding
{
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    // NSCoding
    required convenience init(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        self.init(name: name)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
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
    
    func saveData() {
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: projects)
        UserDefaults.standard.set(encodedData, forKey: "projects")
        UserDefaults.standard.synchronize()
    }
    
    func restoreData() {
        if let decoded  = UserDefaults.standard.object(forKey: "projects") as? Data {
            projects = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [Project]
        }
    }
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
        saveData()
    }
    
    func putProject(project: Project) {
        saveData()
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
        saveData()
    }
    
    func putTask(task: Task) {
        saveData()
    }
}
