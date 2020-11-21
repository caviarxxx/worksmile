import MapKit

final class MapView: MKMapView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createPolyline(from points: Array<Point>) {
        let coordinates = points
            .filter { $0.isValid }
            .map { CLLocationCoordinate2D(latitude: Double($0.latitude)!, longitude: Double($0.longitude)!) }
        
        let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
        self.addOverlay(polyline)
       
        let annotationStart = MKPointAnnotation()
        annotationStart.coordinate = coordinates.first!
        self.addAnnotation(annotationStart)
        
        let annotationLast = MKPointAnnotation()
        annotationLast.coordinate = coordinates.last!
        self.addAnnotation(annotationLast)
    }
}

extension MapView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let render = MKPolylineRenderer(overlay: overlay)
            render.strokeColor = .blue
            render.lineWidth = 1
            return render
        }
        
        return MKOverlayRenderer()
    }
}
