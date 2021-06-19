import Foundation

func identity<A>(_ a:A) -> A {
    return a
}

func identity<A,B>(_ a:A,_ b:B) -> (A,B){
    return (a,b)
}

public func permute<T>(_ array:[T],by n:Int)-> [T] {
    var permutedArray:[T] = []
    
    for i in 0..<array.count {
        let index = (array.count + i - n) % array.count
        
        permutedArray.append(array[index])
    }
    
    return permutedArray
}

extension Array where Element:Equatable {
    func isEqualUpToPermutation(other:[Element]) -> Bool {
        for i in (0..<count) {
            if self == permute(other, by: i) {
                return true
            }
        }
        return false
    }
}
