//
//  giveRatingViewController.swift
//  MealRater
//
//  Created by Samujjwal Kumar on 10/28/23.
//

import UIKit
protocol giveRatingViewControllerDelegate: AnyObject {
    func mealIsRated(_ rating: Int)
}

class giveRatingViewController: UIViewController {

    @IBOutlet weak var ratingBar: UISegmentedControl!
    weak var delegate: giveRatingViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButton(_ sender: Any) {
        let selected_rating = ratingBar.selectedSegmentIndex + 1
        delegate?.mealIsRated(selected_rating)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
