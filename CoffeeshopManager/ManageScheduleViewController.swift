//
//  ManageScheduleViewController.swift
//  CoffeeshopManager
//
//  Created by Admin on 21.08.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import FSCalendar

class ManageScheduleViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,FSCalendarDelegate, FSCalendarDataSource {
    
    //var staffArray = [String]()
    
    //DELETE FOR PRODACTION
    var staffArray = ["Joe", "Jack", "Tom", "Joe2", "Jack2", "Tom2"]
    //******
    
    
    
    @IBOutlet weak var calendar: FSCalendar!
    
    
    @IBOutlet weak var staffCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //CollectionView Setup
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return staffArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = staffCollection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! StaffCollectionViewCell
        cell.staffName.text = staffArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        print("selected \(staffArray[indexPath.row])")
    }
    
    //Calendar
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("selected \(date)")
    }
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("deselected \(date)")
    }
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.frame = CGRect(origin: calendar.frame.origin, size: bounds.size)
    }
}
