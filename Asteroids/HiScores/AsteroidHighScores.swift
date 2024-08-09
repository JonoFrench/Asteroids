//
//  AsteroidHighScores.swift
//  Asteroids
//
//  Created by Jonathan French on 9.08.24.
//

import Foundation
import CoreData

var coreDataStack = CoreDataStack(modelName: "HighScores")

public class AsteroidHighScores {
    lazy var managedObjectContext: NSManagedObjectContext = {
        var coreDataStack = CoreDataStack(modelName: "HighScores")
        return CoreDataStack.moc
    }()

    var highScoreLetters:[Character] = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    var hiScores:[HighScores] = []
    
    public init(){
        getScores()
    }
    
    public func getScores(){
        
        let fetchRequest: NSFetchRequest<HighScores> = HighScores.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: HighScores.sortByScoreKey,
                                                         ascending: false)]
        fetchRequest.fetchLimit = 10
        do {
            hiScores = try managedObjectContext.fetch(fetchRequest)

        } catch {
            fatalError("Data Fetch Error")
        }

    }
    
    public func addScores(score:Int,initials:String){
        
    let newHighScore:HighScores = HighScores.init(entity: NSEntityDescription.entity(forEntityName: "HighScores", in:managedObjectContext)!, insertInto: managedObjectContext)
        newHighScore.initials = initials
        newHighScore.score = Int32(score)
        self.managedObjectContext.insert(newHighScore)
        do {
            try self.managedObjectContext.save()
        }
        catch {
            print("Error saving new score")
        }
    }
    
    public func removeScores(){
        
    }
    
    public func isNewHiScore(score:Int) -> Bool {
        for s in hiScores {
            if s.score < Int16(score) {
            return true
            }
        }
        return false
    }
    
}
