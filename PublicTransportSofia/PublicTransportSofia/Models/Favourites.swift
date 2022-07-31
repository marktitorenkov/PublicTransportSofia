//
//  Favourites.swift
//  PublicTransportSofia
//
//  Created by Mark Titorenkov on 30.07.22.
//

import Foundation

struct Favourites {
    var stopCodes: [String] = []
    var lineIds: [LineIdentifier] = []
    
    func getStop(code: String) -> Bool {
        return self.stopCodes.contains(where: { $0 == code })
    }
    
    func getLine(id: LineIdentifier) -> Bool {
        return self.lineIds.contains(where: { $0 == id })
    }
    
    mutating func updateStop(code: String, favourited: Bool) -> Void {
        self.stopCodes = updated(collection: stopCodes, value: code, favourited: favourited)
    }
    
    mutating func updateLine(id: LineIdentifier, favourited: Bool) -> Void {
        self.lineIds = updated(collection: lineIds, value: id, favourited: favourited)
    }
    
    private func updated<T: Equatable>(collection: [T], value: T, favourited: Bool) -> [T] {
        var collectionCopy = collection
        if favourited {
            if !collectionCopy.contains(value) {
                collectionCopy.append(value)
            }
        } else {
            collectionCopy.removeAll(where: { $0 == value })
        }
        return collectionCopy
    }
    
}
