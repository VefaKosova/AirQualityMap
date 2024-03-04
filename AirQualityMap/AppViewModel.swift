//
//  AppVıewModel.swift
//  AirQualityMap
//
//  Created by Vefa Kosova on 3.03.2024.
//

import Foundation
import MapKit
import Observation
import SwiftUI
import XCAAQI

struct Location: Identifiable {
    var id = UUID()
    var coordinate: CLLocationCoordinate2D
    var aqIndex: String
}

@Observable
class AppViewModel {
    
    let aqiClient = AirQualityClient(apiKey: "")
    let coordinatesFinder = CoordinatesFinder()
    
    var currentLocation: CLLocationCoordinate2D?
    var position: MapCameraPosition = .automatic
    var annotations: [Location] = []
    
    var radiusNArray: [(Double, Int)] = [(4000, 6), (8000, 12)]
    
    init(radiusNArray: [(Double, Int)] = [(4000, 6), (8000, 12)]) {
        self.radiusNArray = radiusNArray
        self.currentLocation = .init(latitude: 38.42048, longitude: 27.1384576)
        self.handleCoordinateChange(currentLocation!)
    }
    
    func handleCoordinateChange(_ coordinate: CLLocationCoordinate2D) {
        self.position = .region(.init(center: currentLocation!, latitudinalMeters: 0, longitudinalMeters: 6000))
        self.annotations = getCoordinatesAround(coordinate).map {
            Location(coordinate: $0, aqIndex: "\((50...150).randomElement()!)")
        }
    }
    
    func getCoordinatesAround(_ coordinate: CLLocationCoordinate2D) -> [CLLocationCoordinate2D] {
        var results: [CLLocationCoordinate2D] = [coordinate]
        radiusNArray.forEach {
            results += coordinatesFinder.findCoordinates(coordinate, r: $0.0, n: $0.1)
        }
        return results
    }
}
