//
//  WeatherGetter.swift
//  MyWeatherApp
//
//  Created by Florian DOUSSIN on 09/05/2016.
//  Copyright © 2016 Florian DOUSSIN. All rights reserved.
//
import Foundation

protocol WeatherGetterDelegate {
    func didGetWeather(weather: Weather)
    func didNotGetWeather(error: NSError)
}


//recuperation données

class WeatherGetter {
    
    private let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/weather"
    private let openWeatherMapAPIKey = "bd5f79266e8afac0b75f5ce71ea35a59"
    
    private var delegate: WeatherGetterDelegate
    
    init(delegate: WeatherGetterDelegate) {
        self.delegate = delegate
    }
    
    func getWeather(city: String) {
        
        //Appel reseau
        let session = NSURLSession.sharedSession()
        
        let weatherRequestURL = NSURL(string: "\(openWeatherMapBaseURL)?APPID=\(openWeatherMapAPIKey)&q=\(city)&lang=fr")!
        
        //Appel + récup données
        let dataTask = session.dataTaskWithURL(weatherRequestURL) {
            (data: NSData?, response: NSURLResponse?, error: NSError?) in
            if let networkError = error {
                // Case erreur réseau
                self.delegate.didNotGetWeather(networkError)
            }
            else {
                print("Succès")
                //Case succès et recup json
                do {
                    // recup json dans dictionnaire swift
                    let weatherData = try NSJSONSerialization.JSONObjectWithData(
                        data!,
                        options: .MutableContainers) as! [String: AnyObject]
                    
                    //Initialisation du dictionnaire
                    let weather = Weather(weatherData: weatherData)
                    
                    // envoie au ViewController
                    self.delegate.didGetWeather(weather)
                }
                catch let jsonError as NSError {
                    // Cas d'erreur si JSON >/ dictionnaire
                    self.delegate.didNotGetWeather(jsonError)
                }
            }
        }
        
        //Données récupérées
        dataTask.resume()
    }
    
}