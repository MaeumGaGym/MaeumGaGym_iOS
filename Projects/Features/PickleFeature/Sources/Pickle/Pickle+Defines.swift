import Foundation

public struct Pickle {
    public enum ReuseIdentifier: String {
        case defualt = "PickleBase"
    }
    
    enum FetchResponse {
        case success
        case fail(Pickle.FetchError)
    }
    
    enum FetchPriority: Int {
        case low = 1
        case high = 10000
    }
    
    enum FetchError: Error {
        case image
    }
    
    enum VideoPriority {
        case high
        case low
    }
    
    struct PendingItem: Comparable {
        let url: URL
        let priority: Int
        
        static func < (lhs: PendingItem, rhs: PendingItem) -> Bool {
            return lhs.priority < rhs.priority
        }
    }
}
