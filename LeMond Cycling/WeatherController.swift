//
//  WeatherController.swift
//  LeMond Cycling
//
//  Created by xiulan li on 8/26/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation
class WeatherController: UIViewController {
    
    let weatherMap = AWFWeatherMap(mapType: .Apple)
    var windButton = WindButton()
    var radarButton = RadarButton()
    var backToMapButton = BackToMapButton()
    var trackLocation = false
    var delegate: MainButtonsProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trackLocation = true
        
        weatherMap.weatherMapView.frame = view.bounds
        
        let pinch = UIPinchGestureRecognizer(target: self, action: Selector("handlePinch:"))
        weatherMap.weatherMapView.addGestureRecognizer(pinch)
        view.addSubview(weatherMap.weatherMapView)
        
        windButton.frame = CGRectMake(20,20,50,50)
        windButton.layer.cornerRadius = 0.5 * windButton.bounds.size.width
        windButton.titleLabel?.adjustsFontSizeToFitWidth = true
        // windButton.setTitle("WIND", forState: UIControlState.Normal)
        windButton.layer.removeAllAnimations()
        windButton.backgroundColor = UIColor.clearColor() //  UIColor(red: 0.650, green: 0.650, blue: 0.650, alpha: 0.547)
        windButton.titleLabel?.font = UIFont(name: "UnitedSansSemiExt-Bold", size: 12)
        windButton.addTarget(self, action: "displayWind:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        radarButton.frame = CGRectMake(20,80,50,50)
        radarButton.layer.cornerRadius = 0.5 * radarButton.bounds.size.width
        radarButton.titleLabel?.adjustsFontSizeToFitWidth = true
        // radarButton.setTitle("RADAR", forState: UIControlState.Normal)
        radarButton.layer.removeAllAnimations()
        radarButton.backgroundColor = UIColor.clearColor() //  UIColor(red: 0.650, green: 0.650, blue: 0.650, alpha: 0.547)
        radarButton.titleLabel?.font = UIFont(name: "UnitedSansSemiExt-Bold", size: 12)
        radarButton.addTarget(self, action: "displayRadar:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        backToMapButton.frame = CGRectMake( (ScreenSize.SCREEN_WIDTH / 2) - 25, ScreenSize.SCREEN_HEIGHT - 80, 50, 50)
        
        backToMapButton.addTarget(self, action: "backToMap:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        view.addSubview(windButton)
        view.addSubview(radarButton)
        view.addSubview(backToMapButton)
        
        // on default show the wind map
        showWind()
    }
    
    
    @IBAction func displayWind(sender: UIButton!) {
        showWind()
    }
    
    @IBAction func displayRadar(sender: UIButton!) {
        weatherMap.removeLayerType(.Winds)
        weatherMap.addLayerType(.Radar)
        
        if (trackLocation) {
            if ComputerRuntimeVariables.CurrentCoordinate != nil {
                weatherMap.setMapCenterCoordinate(ComputerRuntimeVariables.CurrentCoordinate, zoomLevel: 7, animated: false)
            }
        }
    }
    
    @IBAction func backToMap(sender: UIButton!) {
        
        self.delegate?.showMap()
        trackLocation = true
        
    }
    
    
    func showWind(){
        weatherMap.removeLayerType(.Radar)
        weatherMap.addLayerType(.Winds)
        
        if (trackLocation) {
            if ComputerRuntimeVariables.CurrentCoordinate != nil {
                weatherMap.setMapCenterCoordinate(ComputerRuntimeVariables.CurrentCoordinate, zoomLevel: 7, animated: false)
            }
        }
    }
    
    
    func updateLatLong(sLat: Double, sLon: Double) {
        if (trackLocation) {
            if ComputerRuntimeVariables.CurrentCoordinate != nil {
                weatherMap.setMapCenterCoordinate(ComputerRuntimeVariables.CurrentCoordinate, zoomLevel: 7, animated: false)
            }
        }
    }
    
    @IBAction func handlePinch(sender : UIPinchGestureRecognizer!){
        trackLocation = false
    }
    
}
