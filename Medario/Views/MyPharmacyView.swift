//
//  ContentView.swift
//  A3_Map
//
//  Created by Natalie Sahadeo on 2021-11-09.
//

import SwiftUI
import MapKit
import CoreLocation

struct MyPharmacyView: View {
    @StateObject private var viewModel = ContentViewModel()
    @State var preferredPharmacy = ""
    @State var location: CLLocationCoordinate2D?
    @State var toggleDirections = false

    struct Location : Identifiable{
        let id = UUID()
        let name : String
        let coordinate : CLLocationCoordinate2D
    }

    struct RouteSteps : Identifiable{
        let id = UUID()
        let step : String
    }

    @State var routeSteps : [RouteSteps] = [
        RouteSteps(step: "Directions")
    ]
    //Array of annotations
    @State var annotations = [
        Location(name: "Empire State Building", coordinate: CLLocationCoordinate2D(latitude: 40.748440, longitude: -73.985664))
    ]

    //Set the location to tbe the user's location
   

    var body: some View {
        VStack{
            Section{
                Text("Please enter your preferred pharmacy")
                TextField("First Stop", text: $preferredPharmacy).background(Color.white) .textFieldStyle(.roundedBorder) .padding(.vertical, 10)
                        .padding(.horizontal, 99)

                //Show Map
                Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: annotations){
                    item in MapPin(coordinate: item.coordinate)
                }.ignoresSafeArea().accentColor(Color(.systemPink)).frame(width: 300, height: 300, alignment: .center).onAppear{viewModel.checkIfLocationServiceIsEnabled()}.padding(.vertical, 25)

                List(routeSteps){r in Text(r.step)}
                //Save Address Button
//                Button(action: {self.findNewLocation()}){Text("Save Pharmacy")}

                Button(action: {
                    routeSteps.removeAll()
                    let sourceLoc = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: CLLocationManager().location!.coordinate.latitude, longitude: CLLocationManager().location!.coordinate.longitude))
                    findNewLocation(source: sourceLoc)
                    toggleDirections = true
                    //Display directions using the .sheet
                }){Text("Get Directions")}.sheet(isPresented: $toggleDirections, content: {
                            VStack(spacing: 0) {
                                Text("Directions")
                                        .font(.largeTitle)
                                        .bold()
                                        .padding()

                                Divider().background(Color(UIColor.systemBlue))

                                List(routeSteps){r in Text(r.step)}
                            }
                        }

                        ).frame(width: 129, height: 54, alignment: .center)
                        .font(.headline)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.pink)).foregroundColor(Color.white)
            }
        }



    }


    //Get the location coordinates
    func getLocation(from enteredLocation: String, completion: @escaping (_ location: CLLocationCoordinate2D?)-> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(enteredLocation) { (placemarks, error) in
            guard let placemarks = placemarks,
                  let location = placemarks.first?.location?.coordinate else {
                completion(nil)
                return
            }
            completion(location)
        }
    }

    func findNewLocation(source: MKPlacemark){
        let geocoder = CLGeocoder()
        let locEntered = preferredPharmacy
        geocoder.geocodeAddressString(locEntered, completionHandler: {
            //placemarks is an array
            (placemarks, error) -> Void in
            if(error != nil){
                print("Error")
            }
            //going to take the first item from list
            if let placemark  = placemarks?[0]{
                let coordinates : CLLocationCoordinate2D =
                        placemark.location!.coordinate

                annotations.append(Location(name: placemark.name!, coordinate: placemark.location!.coordinate))
                
                viewModel.region = MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))

                let request = MKDirections.Request()
                request.source = MKMapItem(placemark: MKPlacemark(coordinate: source.coordinate))
                request.destination = MKMapItem(placemark: MKPlacemark(coordinate: coordinates))
                request.requestsAlternateRoutes = false
                request.transportType = .automobile

                let directions = MKDirections(request: request)
                //still have to do a loop even though its gonna show one result since we set alternative routes to false
                directions.calculate(completionHandler: {response, error in
                    for route in (response?.routes)!{
                        for step in route.steps {
                            routeSteps.append(RouteSteps(step: step.instructions))
                        }
                    }
                }
                )
            }
        }
        )}


    //For accessing the location permissions
    final class ContentViewModel: NSObject, ObservableObject, CLLocationManagerDelegate{
        @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 43.60648, longitude: -79.58988), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        var locationManager : CLLocationManager?
        func checkIfLocationServiceIsEnabled(){

            if CLLocationManager.locationServicesEnabled(){
                locationManager = CLLocationManager()
                locationManager!.delegate = self

            } else{
                print("Location is off")
            }
        }
        private func checkLocationAuthorization(){
            guard let locationManager = locationManager else {
                return
            }
            switch locationManager.authorizationStatus{

            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
                print("Location is restricted")
            case .denied:
                print("Location denied")
            case .authorizedAlways,.authorizedWhenInUse:
                region = MKCoordinateRegion(center: locationManager.location!.coordinate, span:MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            @unknown default:
                break
            }
        }

        func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            checkLocationAuthorization()
        }


    }



}
