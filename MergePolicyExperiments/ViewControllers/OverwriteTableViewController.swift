//
//  OverwriteTableViewController.swift
//  MergePolicyExperiments
//
//  Created by Andrey Chuprina on 1/24/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//

import UIKit
import CoreData

class OverwriteTableViewController: TableViewController {

    override var container: NSPersistentContainer! {
        return AppDelegate.appDelegate.persistentContainerOverwrite
    }
}
