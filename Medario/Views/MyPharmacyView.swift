//
//  MyPharmacyView.swift
//  Medario
//
//  Created by Lilly on 2021-11-02.
//

import SwiftUI
import MapKit

struct Location : Identifiable{
    let id = UUID()
    let name : String
    let coordinate : CLLocationCoordinate2D
}

struct RouteSteps : Identifiable{
    let id = UUID()
    let step : String
}

struct MyPharmacyView: View {
    @State var preferredPharmacy = ""
    @State private var home = CLLocationCoordinate2D(latitude: 40.748440, longitude: -73.985664)
    //Coordiate default set to Sheridan College trafalger
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 43.655500, longitude: -79.738470), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)) //Delta stuff how much of the area to show on the map

    //Annotations
    @State var annotations = [
        Location(name: "Sheridan College - Trafalger", coordinate: CLLocationCoordinate2D(latitude: 43.655500, longitude: -79.738470))
    ]

    
    @State var routeSteps : [RouteSteps] = [
        RouteSteps(step: "Directions")
    ]
    
//    @State var defaultAddress = ""
    
    var body: some View {
        ZStack{
            Image("LimeGreenGradient")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                Text("Enter the address of your preferred pharmacy:").foregroundColor(Color.black)
                Section{
                TextField("Preferred Pharmacy Address", text: $preferredPharmacy).background(Color.white) .textFieldStyle(.roundedBorder) .padding(.vertical, 10)
                        .padding(.horizontal, 16)
                }
                Button(action: {self.findNewLocation()}){Text("Go!")}
                //TODO: Save pharmacy + directions to database?
                
                //Display's the Map
                Map(coordinateRegion: $region, annotationItems: annotations){
                    item in MapPin(coordinate: item.coordinate)
                }.frame(width: 300, height: 300, alignment: .center)
                
                //TODO: Add Button To View Directions of how to get to pharmacy
//                List(routeSteps){r in Text(r.step)}
            }
        }
    }
    
    func findNewLocation(){
        let locEnterdText = preferredPharmacy
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(locEnterdText, completionHandler: {
            //placemarks is an array
            (placemarks, error) -> Void in
            if(error != nil){
                print("Error")
            }
            //going to take the first item from list
            if let placemark  = placemarks?.first{
                let coordinates : CLLocationCoordinate2D =
                    placemark.location!.coordinate
                
                annotations.append(Location(name: placemark.name!, coordinate: placemark.location!.coordinate))
                
                region = MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
                
                let request = MKDirections.Request()
                request.source = MKMapItem(placemark: MKPlacemark(coordinate: self.home))
                request.destination = MKMapItem(placemark: MKPlacemark(coordinate: coordinates))
                request.requestsAlternateRoutes = false
                request.transportType = .automobile
                
                let directions = MKDirections(request: request)
                //still have to do a loop even though its gonna show one result since we set alternative routes to false
                directions.calculate(completionHandler: {response, error in
                    for route in (response?.routes)!{
                        self.routeSteps = []
                        for step in route.steps {
                            self.routeSteps
                                .append(RouteSteps(step: step.instructions))
                        }
                }
            }
        )}
    }
)}
}

//struct MyPharmacyView_Previews: PreviewProvider {
//    static var previews: some View {
//        MyPharmacyView()
//    }
//}
