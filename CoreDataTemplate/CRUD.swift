//
//  CRUD.swift
//  CoreDataTemplate
//
//  Created by Matheus Gois on 03/05/19.
//  Copyright © 2019 Matheus Gois. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CRUD: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    }
    
    @IBAction func createData(_ sender: Any) {
        print("CREATE")
        createData()
    }
    
    @IBAction func retrieveData(_ sender: Any) {
        print("READ")
        findAll()
//        findByID("1")
    }
    
    @IBAction func updateData(_ sender: Any) {
        print("UPDATE")
        updateByID("1")
    }
    
    @IBAction func deleteData(_ sender: Any) {
        print("DELETE")
//        deleteByID("5")
        deleteAll()
    }
    
    
    
    
    
    func createData(){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
    
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Now let’s create an entity and new user records.
        let userEntity = NSEntityDescription.entity(forEntityName: "Dishes", in: managedContext)!
        
        //final, we need to add some data to our newly created record for each keys using
        //here adding 5 data with loop
        
        for i in 1...5 {
            
            let dish = NSManagedObject(entity: userEntity, insertInto: managedContext)
            dish.setValue("Ankur\(i)", forKeyPath: "name")
            dish.setValue("sdasd\(i)", forKey: "price")
            dish.setValue("\(i)", forKey: "id")
        }
        
        //Now we have set all the values. The next step is to save them inside the Core Data
        
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    
    func findByID(_ id:String){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Dishes")
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "name") as! String, data.value(forKey: "id") as! String)
            }
            
        } catch {
            print("Failed")
        }
    }
    
    func findAll() {
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Prepare the request of type NSFetchRequest  for the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Dishes")
        
        //        fetchRequest.fetchLimit = 1
        //        fetchRequest.predicate = NSPredicate(format: "username = %@", "Ankur")
        //        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "email", ascending: false)]
        //
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "name") as! String, data.value(forKey: "id") as! String)
            }
            
        } catch {
            print("Failed")
        }
    }
    
    func updateByID(_ id:String){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Dishes")
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            if(test.count != 0){
                let objectUpdate = test[0] as! NSManagedObject
                objectUpdate.setValue("newName", forKey: "name")
                objectUpdate.setValue("newmail", forKey: "price")
                objectUpdate.setValue("newpassword", forKey: "id")
            } else {
                print("Object not found")
            }
            
            
            do{
                try managedContext.save()
            }
            catch
            {
                print(error)
            }
        }
        catch
        {
            print(error)
        }
        
    }
    
    func deleteByID(_ id:String){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Dishes")
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)
        
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            if(test.count != 0){
                let objectToDelete = test[0] as? NSManagedObject
                
                if(objectToDelete != nil){
                    managedContext.delete(objectToDelete!)
                    do{
                        try managedContext.save()
                    }
                    catch
                    {
                        print(error)
                    }
                }
            }
            else {
                print("Object not found")
            }
            
            
        }
        catch
        {
            print(error)
        }
    }
    
    func deleteAll(){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Dishes")
        do {
            let test = try managedContext.fetch(fetchRequest)
            
            if(test.count != 0){
                for data in test as! [NSManagedObject] {
                    let objectToDelete = data as? NSManagedObject
                    if(objectToDelete != nil){
                        managedContext.delete(objectToDelete!)
                        do{
                            try managedContext.save()
                        }
                        catch
                        {
                            print(error)
                        }
                    }
                }
            } else {
                print("Not found objects")
            }
            
        } catch {
            print("Failed")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
