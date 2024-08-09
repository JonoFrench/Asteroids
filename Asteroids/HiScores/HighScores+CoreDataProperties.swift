//
//  HighScores+CoreDataProperties.swift
//  
//
//  Created by Jonathan French on 22/01/2020.
//
//

import Foundation
import CoreData


extension HighScores {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HighScores> {
        return NSFetchRequest<HighScores>(entityName: "HighScores")
    }

    @NSManaged public var initials: String?
    @NSManaged public var score: Int32

}
