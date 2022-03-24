//
//  MainVC.swift
//  MyFavoritePlaces
//
//  Created by Александр Старков on 24.03.2022.
//

import UIKit

class MainVC: UITableViewController {
    
//    let restaurantNames = [
//        "Burger Heroes", "Kitchen", "Bonsai", "Дастархан",
//        "Индокитай", "X.O", "Балкан Гриль", "Sherlock Holmes",
//        "Speak Easy", "Morris Pub", "Вкусные истории",
//        "Классик", "Love&Life", "Шок", "Бочка"
//    ]
    let places = Place.getPlaces()//вернули массиы данных (статичный метод структуры, который возвращает массив)
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
       
        cell.nameLabel?.text = places[indexPath.row].name
        cell.locationLabel.text = places[indexPath.row].location
        cell.typeLabel.text = places[indexPath.row].type
        cell.imageOfPlace?.image = UIImage(named: places[indexPath.row].image)
        cell.imageOfPlace?.layer.cornerRadius = cell.imageOfPlace.frame.size.height / 2
        cell.imageOfPlace?.clipsToBounds = true
        return cell
    }
//MARK: - TableView Delegate
    //метод отвечает за высоту строк
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 85
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
