
import CoreData

class CoreDataStack {

  private let modelName: String

    
    lazy var managedObjectModel: NSManagedObjectModel = {
            let frameworkBundleIdentifier = "com.jaypeeff.Asteroids"
        let customKitBundle = Bundle(identifier: frameworkBundleIdentifier)!
        let modelURL = customKitBundle.url(forResource: "HighScores", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
  init(modelName: String) {
    self.modelName = modelName
    CoreDataStack.managedObjectContext = persistentContainer.viewContext
  }
  
  private lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: self.modelName, managedObjectModel: managedObjectModel)
    // seed data if the database does not exist
    var shouldSeedData = false
        
    if let url = container.persistentStoreDescriptions.first?.url {
        print(url)
      if !FileManager.default.fileExists(atPath: url.path) {
        shouldSeedData = true
      }
    }
    container.loadPersistentStores {
      (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Failed to create Persistent Store")
      }
    }
    if shouldSeedData {
      CoreDataStack.seedData(managedContext: container.viewContext)
    }
    return container
  }()
  
  private static var managedObjectContext: NSManagedObjectContext!
  static var moc: NSManagedObjectContext! {
    if managedObjectContext == nil {
      fatalError("Core Data Stack has not been initialized")
    }
    return managedObjectContext
  }
  
}

extension CoreDataStack {
class func seedData(managedContext: NSManagedObjectContext) {
    print("Seeding Data")
    for _ in 1...10{
        let h1:HighScores = HighScores.init(entity: NSEntityDescription.entity(forEntityName: "HighScores", in:managedContext)!, insertInto: managedContext)
    h1.score = 0
    h1.initials = "AAA"
        managedContext.insert(h1)
    }
    do {
    try managedContext.save()
    } catch
    {
        print("Error seeding hiscores")
    }
}
}

