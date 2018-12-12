//
//  TaskDetailsVC.swift
//  JiraKiller
//
//  Created by Andriy Trubchanin on 12/10/18.
//  Copyright © 2018 Andrij Trubchanin. All rights reserved.
//

import UIKit

protocol NameEditorDelegate: class {
    func nameDidChange(name: String)
}

class TaskDetailsVC: UIViewController
{
    @IBOutlet private weak var taskNameTextField: UITextField!
    
    weak var delegate: NameEditorDelegate?
    var name: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskNameTextField.text = name
        
        setupNavigationBar()
    }
    
    @objc private func onCancel(_ button: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func onSave(_ button: UIBarButtonItem) {
        name = taskNameTextField.text ?? ""
        
        delegate?.nameDidChange(name: name)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setupNavigationBar() {
        let leftButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(onCancel(_:)))
        self.navigationItem.setLeftBarButton(leftButtonItem, animated: false)
        
        let rightButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(onSave(_:)))
        self.navigationItem.setRightBarButton(rightButtonItem, animated: false)
    }
}
