//
//  APIManager.swift
//  NetworkDemo
//
//  Created by Alex Tarragó on 18/11/2019.
//  Copyright © 2019 Dribba GmbH. All rights reserved.
//

import Foundation


//https://openweathermap.org/current
private let baseURL = "https://api.openweathermap.org/data/2.5/weather?appid=08389b845ce6720d39c29f748834b001&q="
private let forecastURL = "https://api.openweathermap.org/data/2.5/forecast?appid=08389b845ce6720d39c29f748834b001&q="
private let locationURL = "https://api.openweathermap.org/data/2.5/forecast?appid=08389b845ce6720d39c29f748834b001&"



class APIManager {
    static let shared = APIManager()
    
    func forecast (_ city: String, _ countryCode: String, callback: @escaping (_ data: [ResponseDataForecast]) -> Void){
        
        
        let request = NSMutableURLRequest(url: NSURL(string: "\(forecastURL)\(city)")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print("error: \(error)")
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse!.statusCode) // only 200 is a valid response
                var responseDatas = [ResponseDataForecast]()

                if (httpResponse!.statusCode == 200){
                    if let data = data {
                        if let jsonString = String(data: data, encoding: .utf8) {
                            
                            let data = self.convertToDictionary(text: jsonString)
                            for i in 0...4{
                                let hora = (data!["list"]! as! Array<Dictionary<String, Any>>)[i*8]["dt"]!
                                let main = (data!["list"]! as! Array<Dictionary<String, Any>>)[i*8]["main"]! as! [String:Any]
                                let tempMin = main["temp_min"]!
                                let tempMax = main["temp_max"]!
                                let temp = main["temp"]!
                                let weather = (data!["list"]! as! Array<Dictionary<String, Any>>)[i*8]["weather"]! as! Array<Dictionary<String, Any>>
                                let mainWeather = weather.first!["main"]!
                                let descWeather = weather.first!["description"]!
                                let code = (data!["city"]! as! Dictionary<String, Any>)["country"]
                                
                                responseDatas.append(ResponseDataForecast(hora: hora as!Int, description: descWeather as! String, temp: temp as! NSNumber, tempMax: tempMax as! NSNumber, tempMin: tempMin as! NSNumber, main: mainWeather as! String, error: false, ciutat: city, countryCode : code as! String))
                            }
            
                            callback(responseDatas)
                            
                        }
                    }
                }else{
                    let responseData = ResponseDataForecast(hora: -1, description: "", temp: -1, tempMax: -1, tempMin: -1, main: "", error: false, ciutat: "", countryCode : "")
 
                    callback(responseDatas)
                }
            }
        })
        dataTask.resume()
    }
    
    
    func requestCityLocation (_ latitude: Double, _ longitude: Double, callback: @escaping (_ data: [ResponseDataForecast]) -> Void){
        
        let request = NSMutableURLRequest(url: NSURL(string: "\(locationURL)lat=\(latitude)&lon=\(longitude)")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print("error: \(error)")
            } else {
                let httpResponse = response as? HTTPURLResponse
                print("alive?")
                print(httpResponse!.statusCode) // only 200 is a valid response
                var responseDatas = [ResponseDataForecast]()
                print("1")
                if (httpResponse!.statusCode == 200){
                    print("2")

                    if let data = data {
                        print("3")

                        if let jsonString = String(data: data, encoding: .utf8) {
                            print(jsonString)
                            
                            let data = self.convertToDictionary(text: jsonString)
                            for i in 0...4{
                                let hora = (data!["list"]! as! Array<Dictionary<String, Any>>)[i*8]["dt"]!
                                let main = (data!["list"]! as! Array<Dictionary<String, Any>>)[i*8]["main"]! as! [String:Any]
                                let tempMin = main["temp_min"]!
                                let tempMax = main["temp_max"]!
                                let temp = main["temp"]!
                                let weather = (data!["list"]! as! Array<Dictionary<String, Any>>)[i*8]["weather"]! as! Array<Dictionary<String, Any>>
                                let mainWeather = weather.first!["main"]!
                                let descWeather = weather.first!["description"]!
                                let city = (data!["city"]! as! Dictionary<String, Any>)["name"]
                                let code = (data!["city"]! as! Dictionary<String, Any>)["country"]
                                
                                responseDatas.append(ResponseDataForecast(hora: hora as!Int, description: descWeather as! String, temp: temp as! NSNumber, tempMax: tempMax as! NSNumber, tempMin: tempMin as! NSNumber, main: mainWeather as! String, error: false, ciutat: city as! String, countryCode: code as! String))
                            }
                            
                            callback(responseDatas)
                            
                        }
                    }
                }else{
                    let responseData = ResponseDataForecast(hora: -1, description: "", temp: -1, tempMax: -1, tempMin: -1, main: "", error: false, ciutat : "", countryCode: "")
                    
                    callback(responseDatas)
                }
            }
        })
        dataTask.resume()
    }
    
    init(){ }

    // Network requests
    func requestWeatherForCity(_ city: String, callback: @escaping (_ data: ResponseData) -> Void) {
        
        
        
        let request = NSMutableURLRequest(url: NSURL(string: "\(baseURL)\(city)")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        
        
        request.httpMethod = "GET"

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse!.statusCode) // only 200 is a valid response
                if (httpResponse!.statusCode == 200){
                    if let data = data {
                        if let jsonString = String(data: data, encoding: .utf8) {
                            
                            print(jsonString)
                            
                            let data = self.convertToDictionary(text: jsonString)
                            
                            
                            
                            let main = (data!["weather"]! as! Array<Dictionary<String, Any>>).first!["main"]!
                            let desc = (data!["weather"]! as! Array<Dictionary<String, Any>>).first!["description"]!
                            
                            
                            let temp = "\((data!["main"]! as! Dictionary<String, Any>)["temp"]!)"
                            let miTp = "\((data!["main"]! as! Dictionary<String, Any>)["temp_max"]!)"
                            let mxTp = "\((data!["main"]! as! Dictionary<String, Any>)["temp_min"]!)"
                            
                            
                            let responseData = ResponseData(main: main as! String, description: desc as! String, temp: temp, tempMax: mxTp, tempMin: miTp, error: false)
                            
                            callback(responseData)
                            
                        }
                    }
                }else{
                    
                    let responseData = ResponseData(main: "", description: "", temp: "", tempMax: "", tempMin: "", error: true)
                    callback(responseData)
                }
            }
            })
        dataTask.resume()
    }
    
    // Helpers
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }

}

struct ResponseData {
    var main: String
    var description: String
    var temp: String
    var tempMax: String
    var tempMin: String
    var error: Bool
}

struct ResponseDataForecast {
    var hora: Int
    var description: String
    var temp: NSNumber
    var tempMax: NSNumber
    var tempMin: NSNumber
    var main: String
    var error: Bool
    var ciutat: String
    var countryCode: String
}
