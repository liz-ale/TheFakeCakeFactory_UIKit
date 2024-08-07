//
//  StorageProvider.swift
//  TheFakecakeFactory_new
//
//  Created by lizbeth.alejandro on 07/08/24.
//

import Foundation
import CoreData

class StorageProvider {
    let persistenceContainer: NSPersistentContainer
    var currentUser: User?
    
    init(){
        persistenceContainer = NSPersistentContainer(name: "Login")
        persistenceContainer.loadPersistentStores { description, error  in
            if let error {
                fatalError("CoreData fail to load with error: \(error)")
            }
        }
    }
}

extension StorageProvider {
    func saveUser(name: String, email: String, password: String, address: String, phone: String) {
        
        let user = User(context: persistenceContainer.viewContext)
        user.name = name
        user.email = email
        user.password = password
        user.address = address
        user.phone = phone
        
        do {
            try persistenceContainer.viewContext.save()
            print("User saved suceessfully")
            
        } catch {
            print("Failed to save \(error)")
        }
    }
    
    func validUser( email: String, password: String) -> Bool? {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@ AND password == %@", email, password)
        do {
            let user = try persistenceContainer.viewContext.fetch(fetchRequest)
            currentUser = user.first
            return !user.isEmpty
        } catch {
            print("Failed to fetch \(error)")
            return nil
        }
    }
    
    func fetchUserByEmail(_ email: String) -> User? {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        fetchRequest.fetchLimit = 1 // Limitar a un solo resultado
        
        do {
            let users = try persistenceContainer.viewContext.fetch(fetchRequest)
            currentUser = users.first
            return currentUser
        } catch {
            print("Failed to fetch user: \(error)")
            return nil
        }
    }
    
    
    func deleteUser() {
        persistenceContainer.viewContext.delete(currentUser!)
        do {
            try persistenceContainer.viewContext.save()
        } catch {
            persistenceContainer.viewContext.rollback()
            print("Failed to delete \(error)")
        }
    }
    
    func updateUser(name: String, email: String, address: String, phone: String) {
        if let user = currentUser {
            user.name = name
            user.email = email
            user.address = address
            user.phone = phone
            
            do {
                try persistenceContainer.viewContext.save()
                print("User updated successfully")
            } catch {
                print("Failed to update \(error)")
            }
        }
    }
}

