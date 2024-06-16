import UIKit
import CoreData

import Core

public struct PostureDetailModel {
    public var needMachine: Bool
    public var category: [String]
    public var simpleName, exactName: String
    public var thumbnail: String
    public var video: String
    public var simplePart, exactPart, startPose, exerciseWay: [String]
    public var breatheWay, caution: [String]
    public var pickleImage: [UIImage]

    public init(needMachine: Bool, category: [String], simpleName: String, exactName: String, thumbnail: String, video: String, simplePart: [String], exactPart: [String], startPose: [String], exerciseWay: [String], breatheWay: [String], caution: [String], pickleImage: [UIImage]) {
        self.needMachine = needMachine
        self.category = category
        self.simpleName = simpleName
        self.exactName = exactName
        self.thumbnail = thumbnail
        self.video = video
        self.simplePart = simplePart
        self.exactPart = exactPart
        self.startPose = startPose
        self.exerciseWay = exerciseWay
        self.breatheWay = breatheWay
        self.caution = caution
        self.pickleImage = pickleImage
    }
}

public struct PostureAllDataModel {
    public var id: Int
    public var category: [String]
    public var needMachine: Bool
    public var name: String
    public var simplePart: [String]
    public var exactPart: [String]
    public var thumbnail: String

    init(id: Int, category: [String], needMachine: Bool, name: String, simplePart: [String], exactPart: [String], thumbnail: String) {
        self.id = id
        self.category = category
        self.needMachine = needMachine
        self.name = name
        self.simplePart = simplePart
        self.exactPart = exactPart
        self.thumbnail = thumbnail
    }
}

public struct PostureAllModel {
    public var responses: [PostureAllDataModel]
    
    init(responses: [PostureAllDataModel]) {
        self.responses = responses
    }
}
//
//extension CoreDataStack {
//    public func savePostureAllModel(posture: PostureAllModel) {
//        guard let entity = NSEntityDescription.entity(forEntityName: "PostureAllModel", in: context) else {
//            fatalError("Failed to find entity description for PostureAllModel")
//        }
//        
//        for pose in posture.responses {
//            let postureObject = NSManagedObject(entity: entity, insertInto: context)
//            postureObject.setValue(pose.id, forKey: "id")
//            postureObject.setValue(pose.category, forKey: "category")
//            postureObject.setValue(pose.needMachine, forKey: "needMachine")
//            postureObject.setValue(pose.name, forKey: "name")
//            postureObject.setValue(pose.simplePart, forKey: "simplePart")
//            postureObject.setValue(pose.exactPart, forKey: "exactPart")
//            postureObject.setValue(pose.thumbnail, forKey: "thumbnail")
//        }
//        saveContext()
//    }
//
//    public func fetchPostureAllModels() -> PostureAllModel {
//        let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "PostureAllModel")
//
//        do {
//            let postureObjects = try context.fetch(fetchRequest)
//            var postures: PostureAllModel = PostureAllModel(responses: [])
//
//            for postureObject in postureObjects {
//                let id = postureObject.value(forKey: "id") as! Int
//                let category = postureObject.value(forKey: "category") as! [String]
//                let needMachine = postureObject.value(forKey: "needMachine") as! Bool
//                let name = postureObject.value(forKey: "name") as! String
//                let simplePart = postureObject.value(forKey: "simplePart") as! [String]
//                let exactPart = postureObject.value(forKey: "exactPart") as! [String]
//                let thumbnail = postureObject.value(forKey: "thumbnail") as! String
//
//                let posture = PostureAllDataModel(id: id, category: category, needMachine: needMachine, name: name, simplePart: simplePart, exactPart: exactPart, thumbnail: thumbnail)
//                postures.responses.append(posture)
//            }
//
//            return postures
//        } catch {
//            print("Failed to fetch postures: \(error)")
//            return PostureAllModel(responses: [])
//        }
//    }
//}
//
