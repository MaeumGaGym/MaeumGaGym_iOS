import Foundation

extension Array where Element: Equatable {
    mutating func move(_ item: Element, to newIndex: Index) {
        if let index = self.firstIndex(of: item) {
            self.move(at: index, to: newIndex)
        }
    }
    
    mutating func bringToFront(item: Element) {
        self.move(item, to: 0)
    }
    
    mutating func sendToBack(item: Element) {
        self.move(item, to: self.endIndex-1)
    }
}

extension Array {
    mutating func move(at index: Index, to newIndex: Index) {
        guard self.indices.contains(index),
              self.indices.contains(newIndex) else {
            return
        }
        self.insert(self.remove(at: index), at: newIndex)
    }
}
