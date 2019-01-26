//
//  AppDelegate.swift
//  MergePolicyExperiments
//
//  Created by Andrey Chuprina on 1/24/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let appearance = UITabBarItem.appearance()
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 17)
        ]
        appearance.setTitleTextAttributes(attributes, for: .normal)
        return true
    }

    // MARK: - Core Data stack
    lazy var persistentContainerError = createContainer(name: "error", policy: .error)
    
    lazy var persistentContainerRollback = createContainer(name: "rollback", policy: .rollback)
    
    lazy var persistentContainerOverwrite = createContainer(name: "overwrite", policy: .overwrite)
    
    lazy var persistentContainerObjectTrump = createContainer(name: "objectTrump", policy: .mergeByPropertyObjectTrump)
    
    lazy var persistentContainerStoreTrump = createContainer(name: "storeTrump", policy: .mergeByPropertyStoreTrump)
    
    private func createContainer(name: String, policy: NSMergePolicy) -> NSPersistentContainer {
        let container = NSPersistentContainer(name: "MergePolicyExperiments")
        let url = container.persistentStoreDescriptions[0].url
        let newURL = url?.deletingLastPathComponent().appendingPathComponent("MergePolicyExperiments_\(name).sqlite")
        container.persistentStoreDescriptions[0].url = newURL
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            container.viewContext.automaticallyMergesChangesFromParent = true
            container.viewContext.mergePolicy = policy
        })
        setup(container: container)
        return container
    }
    
    private func setup(container: NSPersistentContainer) {
        container.viewContext.reset()
        try? container.viewContext.save()
        
        let data = NSDataAsset(name: "setup")!.data
        let decoder = JSONDecoder()
        decoder.userInfo[CodingUserInfoKey.context!] = container.viewContext
        do {
            _ = try decoder.decode([Item].self, from: data)
            try container.viewContext.save()
        } catch {
            debugPrint(error)
        }
    }
    
    class var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

}

