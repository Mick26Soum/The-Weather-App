//
//  ViewController.swift
//  The Weather App 62
//
//  Created by MICK SOUMPHONPHAKDY on 1/6/16.
//  Copyright © 2016 MICK SOUMPHONPHAKDY. All rights reserved.
//	What's The Weather App
//  :::::::::::::::::::::::: Overview of App :::::::::::::::::::::::::
/*

Users will be able to enter a city into the search bar, the app will then make a request to a website to retrieve the weather
for that particular city at the following URL

Level: Beginner to Intermediate
- Skills Required:
- Advanced String Manipulation and Processing Web Data
- Making and NSURL Request
- Error Handling
- Closures and Blocks in Swift
- Navigation Bar

::: Source Geeking Lemon::: Youtube
- Keeps your project organized and files easy to find down the road, yourself and future devs reviewing your comment
- Xcode Tips To Keep Projects Tidy and Organized
- i.e.
- Images Folder will be under Supporting Files
- Sounds F
- Put Note and Marks on top of Functions
- Classes Folders will contain all classes

- RailsCast - do this for iOS

*/

//  :::::::::::::::::::::::: End of Overview :::::::::::::::::::::::::

//	http://www.weather-forecast.com



import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var cityInputText: UITextField!
  
  @IBOutlet weak var weatherSummaryLabel: UILabel!
  
  @IBAction func weatherAction(sender: AnyObject) {
    
        // create an NSURL object from the url string
        // http://www.weather-forecast.com/locations/London/forecasts/latest
        
        var wasSuccessful = false
        
        let attemptedUrl = NSURL(string: "http://www.weather-forecast.com/locations/" + cityInputText.text!.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest")
        
        if let url = attemptedUrl{
          
          let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            
            if let dataContent = data{
              
              let urlContent = NSString(data: dataContent, encoding: NSUTF8StringEncoding)
              
              let urlTextArray = urlContent?.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
              
              if urlTextArray!.count > 1 {
                
                let weatherArray = urlTextArray![1].componentsSeparatedByString("</span>")
                
                if weatherArray.count > 1{
                  
                  wasSuccessful = true
                  
                  let weatherSummary = weatherArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                  
                  dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    self.weatherSummaryLabel.text = weatherSummary
                    
                  })
                  
                }
                
              }
              
            }
            
            if wasSuccessful == false{
              
              self.weatherSummaryLabel.text = " Couldn't find the weather for that city - please try again"
              
            }
            
          }
          
        task.resume()
            
        } else {
            
            self.weatherSummaryLabel.text  = " Couldn't find the weather for that city - please try again"
            
        }
    
   }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}

