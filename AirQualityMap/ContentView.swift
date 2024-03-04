//
//  ContentView.swift
//  AirQualityMap
//
//  Created by Vefa Kosova on 3.03.2024.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @State var vm = AppViewModel()
    
    var body: some View {
        Map(position: $vm.position) {
            Marker("My Location", coordinate: vm.currentLocation!)
        }
        .mapStyle(.hybrid(elevation: .flat, pointsOfInterest: .all, showsTraffic: false))
        .mapControls {
            MapUserLocationButton()
            MapCompass()
        }
        .navigationTitle("Air Quality Map")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
    }
}

#Preview {
    NavigationStack {
        ContentView()
    }
}
