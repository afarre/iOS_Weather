//
//  TableViewController.swift
//  Weather
//
//  Created by Alumne on 19/11/19.
//  Copyright © 2019 salle. All rights reserved.
//

import UIKit
import CoreLocation

class TableViewController: UITableViewController, CLLocationManagerDelegate {
    
    var resposta : ResponseData!
    var cityByLocation : [ResponseDataForecast]!
    var respostaForecast : [ResponseDataForecast]!
    var ciutats:[String] = [String]()
    var locationManager:CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.test = false
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.didReceiveMemoryWarning()
        
    }
    
      var newTaskCreated: (_ newTask: String) -> Void = {arg in}
    
    @IBAction func addButton(_ sender: Any) {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Ciutat", message: "Escriu el nom d'una ciutat.", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = "Nom ciutat"
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            //self.test = false
            self.searchCity((textField?.text)!)
            while(self.resposta == nil){
                //nop
            }
           
           
            if !self.resposta.error {
                //afegirlo a la taula
                print("OK")
                print(self.resposta)
                self.ciutats.append((textField?.text)!)
                self.tableView.reloadData()
                //self.dismiss(animated: true, completion: nil)
                //self.tableView.reloadData()
            }else{
                print("ELSE")
                let errorPop = UIAlertController(title: "Error", message: "La ciutat no existeix!", preferredStyle: .alert)
                
                errorPop.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action: UIAlertAction!) in
                }))
                self.present(errorPop, animated: true, completion: nil)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Localitzacio actual", style: .default, handler: { (action: UIAlertAction!) in
            print("Localitzacio actual")
            self.determineMyCurrentLocation()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))

        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    func determineMyCurrentLocation(){
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.startUpdatingHeading()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        getCityFromLocation(userLocation.coordinate.latitude, userLocation.coordinate.longitude)
        
        while(self.cityByLocation == nil){
            //nop
        }
        
        print(self.cityByLocation)
        self.ciutats.append((self.cityByLocation[0].ciutat))
        self.tableView.reloadData()
        
    }
    
    func getCityFromLocation(_ latitude: Double, _ longitude: Double){
        APIManager.shared.requestCityLocation(latitude, longitude) { (response) in
            //self.resposta = response
            self.cityByLocation = response
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error)")
    }
    
    func searchCity(_ cityName: String) {
        self.resposta = nil
        APIManager.shared.requestWeatherForCity(cityName) { (response) in
            //self.resposta = response
            self.testFunc(response)
        }
    }
    
    func testFunc(_ response: ResponseData){
        self.resposta = response
    }
   
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ciutats.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Task Table View Cell", for: indexPath) as! TaskTableViewCell

        cell.taskLabel.text = ciutats[indexPath.row]
        //cell.taskSelect.image = UIImage(named: "ic_done_task")
    
        
        // Configure the cell...
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath)
        print(currentCell?.textLabel?.text)
        print("test: ")
        print(ciutats[indexPath.row])
        
        self.respostaForecast = nil
        
        APIManager.shared.forecast(ciutats[indexPath.row], "es") { (response) in
            self.respostaForecast = response
            
            
        }
        while(self.respostaForecast == nil){
            //nop
        }
  
        performSegue(withIdentifier: "ForecastSegue", sender: self)
                
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        print("should perform")
        if identifier == "ForecastSegue" {
            if self.respostaForecast == nil {
                print("should perform es bien")
                return false
            }else {
                return true
            }
        }
        	return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ForecastSegue"{
            print("segue identifier es bien")
            let fvc = segue.destination as! ForecastViewController
            fvc.response = self.respostaForecast
        }
    }
    
}
