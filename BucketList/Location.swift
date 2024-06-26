//
//  Location.swift
//  BucketList
//
//  Created by Álvaro Gascón on 26/6/24.
//

import Foundation
import MapKit


struct Location: Codable, Equatable, Identifiable {
    let id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    
    #if DEBUG // Para evitar que se incluya en las versiones de la App Store
    static let example = Location(id: UUID(), name: "El Fadrí", description: "One of the most emblematic buildings in our city", latitude: 39.9862753, longitude: -0.0379784)
    #endif
    
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
