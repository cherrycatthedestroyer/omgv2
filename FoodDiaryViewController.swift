//
//  FoodDiaryViewController.swift
//  
//
//  Created by cherrycat on 2018-07-29.
//

import UIKit
import Firebase
import FirebaseDatabase

class FoodDiaryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var refDiary: DatabaseReference!
    
    @IBOutlet weak var tblDiary: UITableView!
    
    //The list containing all the entries
    var diaryList = [DiaryModel]()
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diaryList.count
    }
    
    //populating the table with cells based off entries
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        
        let diaryIn: DiaryModel
        
        diaryIn = diaryList[indexPath.row]
        
        cell.lblDate.text = diaryIn.date

        if diaryIn.foodSgrLvl == "Low"{
            cell.imgSgrLvl.image = #imageLiteral(resourceName: "foodLow")
        }
        else if diaryIn.foodSgrLvl == "Medium"{
            cell.imgSgrLvl.image = #imageLiteral(resourceName: "foodMedium")
        }
        else if diaryIn.foodSgrLvl == "High"{
            cell.imgSgrLvl.image = #imageLiteral(resourceName: "foodHigh")
        }
        else{
            cell.imgSgrLvl.image = #imageLiteral(resourceName: "LogLogo")
        }
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        // Getting the current userID logged in
        let userID = Auth.auth().currentUser?.uid
        refDiary = Database.database().reference().child(userID!)
        // Reading in food and date values and adding them to the diaryList
        refDiary.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0{
                self.diaryList.removeAll()
                for log in snapshot.children.allObjects as![DataSnapshot]{
                    let diaryObject = log.value as? [String: AnyObject]
                    
                    //check to see if entry contains food info or not
                    if diaryObject?["foodSgrLvl"] == nil{
                            print("No sugar value present")
                    }
                    else{
                        //adding the data to the list if food info is present
                        let diaryDate = diaryObject?["date"]
                        let diaryLvl = diaryObject?["foodSgrLvl"]
                        let diary = DiaryModel(date: diaryDate as! String, foodSgrLvl: diaryLvl as! String)
                        self.diaryList.append(diary)
                    }
                }
            }
            self.tblDiary.reloadData()
        })
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
