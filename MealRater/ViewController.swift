//
//  ViewController.swift
//  MealRater
//
//  Created by Samujjwal Kumar on 10/28/23.
//

import UIKit
import CoreData

class ViewController: UIViewController, giveRatingViewControllerDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var restaurantName: UITextField!
    
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var dishName: UITextField!
    
    var currentMeal: Meal?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var selected_rating: Int = 1
    
    var managedObjectContext: NSManagedObjectContext {
                if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                    return appDelegate.persistentContainer.viewContext
                }
                fatalError("Unable to access managed object context")
            }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        restaurantName.becomeFirstResponder()
        ratingLabel.isHidden = true
        
    }
    
    
    @IBAction func rateMealButton(_ sender: Any) {
        if areTextFieldsEmpty(){
            displayToast(message: "Fields can't be empty")
        }
        
        else{
            let giveRating = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ratingView") as! giveRatingViewController
            
            giveRating.delegate = self
            giveRating.modalPresentationStyle = .fullScreen
            present(giveRating, animated: true, completion: nil)
        }
    }
    
    func mealIsRated(_ rating: Int) {
        selected_rating = rating
        ratingLabel.isHidden = false
        ratingLabel.text = "\(selected_rating)"
    }
    
    func areTextFieldsEmpty() -> Bool {
        let isRestaurantNameEmpty = restaurantName.text?.isEmpty ?? true
        let isDishNameEmpty = dishName.text?.isEmpty ?? true
        return isRestaurantNameEmpty || isDishNameEmpty
    }
    
    func displayToast(message: String) {
        let toast = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        self.present(toast, animated: true, completion: nil)

        let duration: Double = 2.0 // Adjust the duration as needed
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
            toast.dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func saveButton(_ sender: Any) {
        let newMeal = Meal(context: managedObjectContext)
                    newMeal.restaurantName = restaurantName.text
                    newMeal.dishName = dishName.text
               if let ratingLabelText = ratingLabel.text, let rating = Int(ratingLabelText){
                   newMeal.rating = Int32(rating)
               }
               do{
                   try managedObjectContext.save()
                   displayToast(message: "Dish saved successfully!")
               }
               catch {
                   print("Error saving dish to Core Data: \(error)")
                       }
    }
    
    
}

