//
//  ContentView.swift
//  BucketList
//
//  Created by Álvaro Gascón on 20/6/24.
//

import MapKit
import SwiftUI

struct Location: Codable, Equatable, Identifiable {
    let id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
}


struct ContentView: View {
    
    @State private var locations = [Location]()

    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 39.98567, longitude: -0.04935),
            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        )
    )
    
    var body: some View {
        MapReader { proxy in
            Map(initialPosition: startPosition) {
                ForEach(locations) { location in
                    Marker(location.name, coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
                }
            }
            .onTapGesture { position in
                if let coordinate = proxy.convert(position, from: .local) {
                    let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: coordinate.latitude, longitude: coordinate.longitude)
                    locations.append(newLocation)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
