//
//  ViewController.swift
//  MyWeatherApp
//
//  Created by Florian DOUSSIN on 09/05/2016.
//  Copyright © 2016 Florian DOUSSIN. All rights reserved.
//

import UIKit

class ViewController: UIViewController,
    WeatherGetterDelegate,
    UITextFieldDelegate
{
    //Labels du front
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cloudCoverLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var CommentaireLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var getCityWeatherButton: UIButton!
    
    
    var weather: WeatherGetter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //background de base
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "parisbg.jpg")!)

        weather = WeatherGetter(delegate: self)

        //Start des labels
        cityLabel.text = "MyWeatherApp"
        weatherLabel.text = ""
        temperatureLabel.text = ""
        cloudCoverLabel.text = ""
        windLabel.text = ""
        cityTextField.text = ""
        iconLabel.text = ""
        CommentaireLabel.text = "Quel temps fera-t-il aujourd\'hui ?"
        cityTextField.placeholder = "Entrez le nom de la ville"
        cityTextField.delegate = self
        cityTextField.enablesReturnKeyAutomatically = true
        getCityWeatherButton.enabled = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Action du bouton afficher la météo de la ville
    
    @IBAction func getWeatherForCityButtonTapped(sender: UIButton) {
        guard let text = cityTextField.text where !text.isEmpty else {
            return
        }
        weather.getWeather(cityTextField.text!.urlEncoded)
    }
    func didGetWeather(weather: Weather) {
        // Appel asynchrone
            dispatch_async(dispatch_get_main_queue()) {
            self.cityLabel.text = weather.city
            self.weatherLabel.text = weather.weatherDescription
            self.temperatureLabel.text = "\(Int(round(weather.tempCelsius)))°"
            self.cloudCoverLabel.text = "\(weather.cloudCover)%"
            self.windLabel.text = "\((weather.windSpeed)*3.6) km/h"
            self.iconLabel.text = "\(weather.weatherIconID)"
            
                //Affiche dynamique SOLEIL N1
                if self.iconLabel.text == "01d" {
                    //background
                    self.view.backgroundColor = UIColor(patternImage: UIImage(named: "soleil.jpg")!)
                    self.CommentaireLabel.text = "Il fait beau ! Attention aux coups de soleil"
                    //logo dynamique
                    if let url  = NSURL(string: "http://openweathermap.org/img/w/01d.png"),
                        data = NSData(contentsOfURL: url)
                    {
                        self.imageView.image = UIImage(data: data)
                    }
                }
                //Affiche dynamique ECLARCIE N2
                if self.iconLabel.text == "02d" {
                    //background
                    self.view.backgroundColor = UIColor(patternImage: UIImage(named: "semicloud.jpg")!)
                    self.CommentaireLabel.text = "Le soleil est là mais il joue à cache-cache avec la pluie !"
                    //logo dynamique
                    if let url  = NSURL(string: "http://openweathermap.org/img/w/02d.png"),
                        data = NSData(contentsOfURL: url)
                    {
                        self.imageView.image = UIImage(data: data)
                    }
                }
                //Affichage dynamique NUAGES MODERES N3
                if self.iconLabel.text == "03d" {
                    //background
                    self.view.backgroundColor = UIColor(patternImage: UIImage(named: "nuages.jpg")!)
                    self.CommentaireLabel.text = "Il y a quelques nuages... Rien de bien méchant"
                    //logo dynamique
                    if let url  = NSURL(string: "http://openweathermap.org/img/w/03d.png"),
                        data = NSData(contentsOfURL: url)
                    {
                        self.imageView.image = UIImage(data: data)
                    }
                }
                //Affichage dynamique GROS NUAGES N4
                if self.iconLabel.text == "04d" {
                    //background
                    self.view.backgroundColor = UIColor(patternImage: UIImage(named: "grosnuage.jpg")!)
                    self.CommentaireLabel.text = "T'as vu tous ces nuages ? Attention à la pluie ! Espérons que le temps va s'améliorer"
                    //logo dynamique
                    if let url  = NSURL(string: "http://openweathermap.org/img/w/04d.png"),
                        data = NSData(contentsOfURL: url)
                    {
                        self.imageView.image = UIImage(data: data)
                    }
                }
                //Affichage dynamique GROSSE PLUIE N5
                if self.iconLabel.text == "09d" {
                    //background
                    self.view.backgroundColor = UIColor(patternImage: UIImage(named: "pluie.jpg")!)
                    self.CommentaireLabel.text = "Tu as vu cette pluie ? Si tu sors prépare-toi à prendre une douche froide"
                    //logo dynamique
                    if let url  = NSURL(string: "http://openweathermap.org/img/w/09d.png"),
                        data = NSData(contentsOfURL: url)
                    {
                        self.imageView.image = UIImage(data: data)
                    }
                }
                //Affichage dynamique PLUIE + ECLAIRCIES N6
                if self.iconLabel.text == "10d" {
                    //background
                    self.view.backgroundColor = UIColor(patternImage: UIImage(named: "pluiefine.jpg")!)
                    self.CommentaireLabel.text = "Soleil-pluie Soleil-pluie Soleil-pluie. Ainsi est le rythme de la vie"
                    //logo dynamique
                    if let url  = NSURL(string: "http://openweathermap.org/img/w/10d.png"),
                        data = NSData(contentsOfURL: url)
                    {
                        self.imageView.image = UIImage(data: data)
                    }
                }
                //Affichage dynamique ORAGES N7
                if self.iconLabel.text == "11d" {
                    //background
                    self.view.backgroundColor = UIColor(patternImage: UIImage(named: "storm.jpg")!)
                    self.CommentaireLabel.text = "Le ciel gronde... Attention à l'orage ! Ne te mets pas sous les arbres surtout ! Sinon tu finis cuit !"
                    //logo dynamique
                    if let url  = NSURL(string: "http://openweathermap.org/img/w/11d.png"),
                        data = NSData(contentsOfURL: url)
                    {
                        self.imageView.image = UIImage(data: data)
                    }
                }
                //Affichage dynamique NEIGE N8
                if self.iconLabel.text == "13d" {
                    //background
                    self.view.backgroundColor = UIColor(patternImage: UIImage(named: "snow.jpg")!)
                    self.CommentaireLabel.text = "Le temps est parfait pour faire des bonhommes de neige ou une bataille de boule de neige ! Couvres toi bien !"
                    //logo dynamique
                    if let url  = NSURL(string: "http://openweathermap.org/img/w/13d.png"),
                        data = NSData(contentsOfURL: url)
                    {
                        self.imageView.image = UIImage(data: data)
                    }
                }
                //Affichage dynamique BROUILLARD N9
                if self.iconLabel.text == "50d" {
                    //background
                    self.view.backgroundColor = UIColor(patternImage: UIImage(named: "mist.jpg")!)
                    self.CommentaireLabel.text = "Il y a du brouillard... Fais attention à toi si tu prends la voiture !"
                    //logo dynamique
                    if let url  = NSURL(string: "http://openweathermap.org/img/w/50d.png"),
                        data = NSData(contentsOfURL: url)
                    {
                        self.imageView.image = UIImage(data: data)
                    }
                }
        }
    }
    
    func didNotGetWeather(error: NSError) {
        // Gestion erreur
        dispatch_async(dispatch_get_main_queue()) {
            self.showSimpleAlert(title: "Impossible de recevoir les infos météo",
                                 message: "Le service météo ne répond pas.")
        }
        print("Ne peut pas recevoir le temps: \(error)")
    }
    
    // Regex
    func textField(textField: UITextField,
                   shouldChangeCharactersInRange range: NSRange,
                                                 replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let prospectiveText = (currentText as NSString).stringByReplacingCharactersInRange(
            range,
            withString: string)
        getCityWeatherButton.enabled = prospectiveText.characters.count > 0
        print("Caractères: \(prospectiveText.characters.count)")
        return true
    }
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        textField.text = ""
        
        getCityWeatherButton.enabled = false
        return true
    }
    //bouton retour = refresh
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        getWeatherForCityButtonTapped(getCityWeatherButton)
        return true
    }
    
    //Debug
    
    func showSimpleAlert(title title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .Alert
        )
        let okAction = UIAlertAction(
            title: "OK",
            style:  .Default,
            handler: nil
        )
        alert.addAction(okAction)
        presentViewController(
            alert,
            animated: true,
            completion: nil
        )
    }
    
}

extension String {
    
    // Encodage URL de l'API
    var urlEncoded: String {
        return self.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLUserAllowedCharacterSet())!
    }
    
}