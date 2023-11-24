import Foundation

struct PriorityQueue<Element: Equatable> {
    
    private var elements: [Element] = []
    private let sort: (Element, Element) -> Bool
    
    var isEmpty: Bool {
        return self.elements.isEmpty
    }
    
    var count: Int {
        return self.elements.count
    }
    
    private var lastIndex: Int {
        return self.elements.count - 1
    }
    
    init(elements: [Element] = [], sort: @escaping (Element, Element) -> Bool) {
        self.sort = sort
        self.elements = elements
        
        if !elements.isEmpty {
            for i in stride(from: elements.count / 2 - 1, through: 0, by: -1) {
                self.siftDown(from: i)
            }
        }
    }
    
    func peek() -> Element? {
        return self.elements.first
    }
    
    mutating func pop() -> Element? {
        guard !self.isEmpty else { return nil }
        self.elements.swapAt(0, self.lastIndex)
        defer {
            self.siftDown(from: 0)
        }
        return self.elements.removeLast()
    }
    
    mutating func insert(_ element: Element) {
        self.elements.append(element)
        self.siftUp(from: self.lastIndex)
    }
    
    mutating func remove(at index: Int) -> Element? {
        guard index < self.elements.count else {
            return nil
        }
        if index == self.lastIndex {
            return self.elements.removeLast()
        } else {
            self.elements.swapAt(index, self.lastIndex)
            defer {
                self.siftDown(from: index)
                self.siftUp(from: index)
            }
            return self.elements.removeLast()
        }
    }
    
    mutating func removeAll() {
        self.elements.removeAll()
    }
    
    private mutating func siftUp(from index: Int) {
        var child = index
        var parent = child.parent
        while child > 0 && self.sort(self.elements[child], self.elements[parent]) {
            self.elements.swapAt(child, parent)
            child = parent
            parent = child.parent
        }
    }
    
    private mutating func siftDown(from index: Int) {
        var parent = index
        while true {
            let left = parent.leftChild
            let right = parent.rightChild
            var candidate = parent
            
            if left < self.count && self.sort(self.elements[left], self.elements[candidate]) {
                candidate = left
            }
            if right < self.count && self.sort(self.elements[right], self.elements[candidate]) {
                candidate = right
            }
            if candidate == parent {
                break
            }
            self.elements.swapAt(parent, candidate)
            parent = candidate
        }
    }
}

fileprivate extension Int {
    var leftChild: Int {
        return (2 * self) + 1
    }
    
    var rightChild: Int {
        return (2 * self) + 2
    }
    
    var parent: Int {
        return (self - 1) / 2
    }
}
