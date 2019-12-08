//
//  ForecastViewController.swift
//  Weather
//
//  Created by NEREA FARRE on 5/12/19.
//  Copyright © 2019 salle. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController {

    @IBOutlet weak var ciutat1: UILabel!
    @IBOutlet weak var data1: UILabel!
    @IBOutlet weak var temp1: UILabel!
    @IBOutlet weak var min1: UILabel!
    @IBOutlet weak var max1: UILabel!
    @IBOutlet weak var temps1: UILabel!
    @IBOutlet weak var desc1: UILabel!
    
    @IBOutlet weak var ciutat2: UILabel!
    @IBOutlet weak var data2: UILabel!
    @IBOutlet weak var temp2: UILabel!
    @IBOutlet weak var min2: UILabel!
    @IBOutlet weak var max2: UILabel!
    @IBOutlet weak var temps2: UILabel!
    @IBOutlet weak var desc2: UILabel!
    
    @IBOutlet weak var ciutat3: UILabel!
    @IBOutlet weak var data3: UILabel!
    @IBOutlet weak var temp3: UILabel!
    @IBOutlet weak var min3: UILabel!
    @IBOutlet weak var max3: UILabel!
    @IBOutlet weak var temps3: UILabel!
    @IBOutlet weak var desc3: UILabel!
    
    @IBOutlet weak var ciutat4: UILabel!
    @IBOutlet weak var data4: UILabel!
    @IBOutlet weak var temp4: UILabel!
    @IBOutlet weak var min4: UILabel!
    @IBOutlet weak var max4: UILabel!
    @IBOutlet weak var temps4: UILabel!
    @IBOutlet weak var desc4: UILabel!
    
    @IBOutlet weak var ciutat5: UILabel!
    @IBOutlet weak var data5: UILabel!
    @IBOutlet weak var temp5: UILabel!
    @IBOutlet weak var min5: UILabel!
    @IBOutlet weak var max5: UILabel!
    @IBOutlet weak var temps5: UILabel!
    @IBOutlet weak var desc5: UILabel!
    
    
    
    //@IBOutlet var swipe: UISwipeGestureRecognizer!
    var response : [ResponseDataForecast]!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeData()

        // Do any additional setup after loading the view.
    }
    
    
   
    
    func changeData(){
        print("response: \(response[0])")
        print("response: \(response[1])")
        print("response: \(response[2])")
        print("response: \(response[3])")
        print("response: \(response[4])")
    
        ciutat1.text = response[0].ciutat
        ciutat2.text = response[1].ciutat
        ciutat3.text = response[2].ciutat
        ciutat4.text = response[3].ciutat
        ciutat5.text = response[4].ciutat
        
        data1.text = dateFormatter(epochData: response[0].hora)
        data2.text = dateFormatter(epochData: response[1].hora)
        data3.text = dateFormatter(epochData: response[2].hora)
        data4.text = dateFormatter(epochData: response[3].hora)
        data5.text = dateFormatter(epochData: response[4].hora)
        
        temp1.text = String(format: "%.1f ºC", response[0].tempMin.doubleValue - 273.15)
        temp2.text = String(format: "%.1f ºC", response[1].tempMin.doubleValue - 273.15)
        temp3.text = String(format: "%.1f ºC", response[2].tempMin.doubleValue - 273.15)
        temp4.text = String(format: "%.1f ºC", response[3].tempMin.doubleValue - 273.15)
        temp5.text = String(format: "%.1f ºC", response[4].tempMin.doubleValue - 273.15)

        min1.text = String(format: "%.1f ºC", response[0].tempMin.doubleValue - 273.15)
        min2.text = String(format: "%.1f ºC", response[1].tempMin.doubleValue - 273.15)
        min3.text = String(format: "%.1f ºC", response[2].tempMin.doubleValue - 273.15)
        min4.text = String(format: "%.1f ºC", response[3].tempMin.doubleValue - 273.15)
        min5.text = String(format: "%.1f ºC", response[4].tempMin.doubleValue - 273.15)

        max1.text = String(format: "%.1f ºC", response[0].tempMax.doubleValue - 273.15)
        max2.text = String(format: "%.1f ºC", response[1].tempMax.doubleValue - 273.15)
        max3.text = String(format: "%.1f ºC", response[2].tempMax.doubleValue - 273.15)
        max4.text = String(format: "%.1f ºC", response[3].tempMax.doubleValue - 273.15)
        max5.text = String(format: "%.1f ºC", response[4].tempMax.doubleValue - 273.15)
        
        temps1.text = response[0].main
        temps2.text = response[1].main
        temps3.text = response[2].main
        temps4.text = response[3].main
        temps5.text = response[4].main
        
        desc1.text = response[0].description
        desc2.text = response[1].description
        desc3.text = response[2].description
        desc4.text = response[3].description
        desc5.text = response[4].description

        
        
        //temp.text = response[0].temp.stringValue
    }

    
    func dateFormatter(epochData: Int) -> String{
        let dataFormated = NSDate(timeIntervalSince1970: TimeInterval(epochData))
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myString = formatter.string(from: Date())
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = "dd-MM-yyyy"
        let myStringFormatted = formatter.string(from: yourDate!)
        return myStringFormatted
    }
    
    /*@IBAction func swipeAction(_ sender: UISwipeGestureRecognizer) {
        print("right")
    }*/
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
