//  CMPT 276 Project Group 12 - Smart Apps
//  ChartViewController.swift
//
//
//  Created by MJ Jeon on 2018-07-04.
//  Copyright © 2018 cherrycat. All rights reserved.
//
// Updates the chart by retrieving the info from the Firebase database
import UIKit
import Charts
import Firebase
import FirebaseAuth


class ChartViewController: UIViewController,ChartViewDelegate{
    
    @IBOutlet weak var chtChart: LineChartView!
    
    var systolic_data : [Double] = [] // systolic holder
    var bg_data : [Double] = [] // glucose holder
    
    //high contrast mode
    @IBAction func clrSwitch(_ sender: UISwitch) {
        if  (sender.isOn == true){
            view.backgroundColor = .black
        }
        else{
            view.backgroundColor = #colorLiteral(red: 1, green: 0.5490196078, blue: 0.5803921569, alpha: 1)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        read()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // retrive from firebase
    func read()
    {
        var ref: DatabaseReference!
        
        // Getting the current userID logged in
        let userID = Auth.auth().currentUser?.uid
        
        ref = Database.database().reference().child(userID!)
        
        ref.observe(DataEventType.value, with: { (snapshot) in
            
            for log in snapshot.children.allObjects as![DataSnapshot]{
                let logObject = log.value as? [String: AnyObject]
                let logBloodGlucose = logObject?["bloodGlucose"]
                let logSystolicBP = logObject?["systolicBP"]
                
                
                self.bg_data.append(logBloodGlucose as! Double)
                self.systolic_data.append(logSystolicBP as! Double)
                print(self.bg_data)
                print(self.systolic_data)
            }
        }) { (err: Error) in
            
            print("\(err.localizedDescription)")
            
        }
        
    }
    
    // Generate graph button
    @IBAction func testbutt(_ sender: UIButton) {
        updateGraph()
    }
    
    // updating the graph viewer with the new data entries
    func updateGraph(){
        var lineChartEntry = [ChartDataEntry]() //array to be displayed - insulin
        var lineChartEntry1 = [ChartDataEntry]() // blood glucose
        
        for i in 0..<systolic_data.count {
            let systolic_value = ChartDataEntry(x: Double(i), y: systolic_data[i]) // set x and y
            lineChartEntry.append(systolic_value) // here to add data set
        }
        
        for i in 0..<bg_data.count {
            let bg_value = ChartDataEntry(x: Double(i), y: bg_data[i]) // set x and y
            lineChartEntry1.append(bg_value) // here to add data set
        }
        
        let systolic = LineChartDataSet(values: lineChartEntry, label: "Blood Pressure") // convert lineChartEntry to a LineChartDataSet for insulin data sets
        
        let bloodGlucose = LineChartDataSet(values: lineChartEntry1, label: "Blood Glucose") // convert lineChartEntry to a LineChartDataSet for insulin data sets
        
        systolic.setColor(UIColor.blue) // set to blue
        systolic.setCircleColor(UIColor.blue)
        
        bloodGlucose.setColor(UIColor.cyan) // set to cyan
        
        var dataSets : [LineChartDataSet] = [LineChartDataSet]()
        dataSets.append(systolic)
        dataSets.append(bloodGlucose)
        
        let data : LineChartData = LineChartData(dataSets: dataSets)
        
        self.chtChart.data = data
        
        chtChart.chartDescription?.text = "Glucose & Blood pressure level" // graph description
    }
}

/*
 // MARK: - Navigation
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */
