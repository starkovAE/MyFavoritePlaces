//
//  MainVC.swift
//  MyFavoritePlaces
//
//  Created by Александр Старков on 24.03.2022.
//

import UIKit
import RealmSwift
class MainVC: UITableViewController {

    var places: Results<Place>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        places = realm.objects(Place.self) // self пишется, чтобы сообщить, что мы используем не сам объект (экземпляр типа) Place, а именно тип данных Place 
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.isEmpty ? 0: places.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        let place = places[indexPath.row]
        cell.nameLabel?.text = place.name
        cell.locationLabel.text = place.location
        cell.typeLabel.text = place.type
        cell.imageOfPlace.image = UIImage(data: place.imageData!)

        cell.imageOfPlace?.layer.cornerRadius = cell.imageOfPlace.frame.size.height / 2
        cell.imageOfPlace?.clipsToBounds = true
        return cell
    }
//MARK: - TableView Delegate
    //слишком избыточный метод, реализуем только одно пользовательское действие
//    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//        let place = places[indexPath.row]
//
//        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
//            StorageManager.deleteObject(place) //удаляем объект из базы
//            tableView.deleteRows(at: [indexPath], with: .automatic) //удаляем из таблицы
//
//        }
//
//        return UISwipeActionsConfiguration(actions: [deleteAction])
//    }
    //поэтому используем вот этот
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let place = places[indexPath.row]
            StorageManager.deleteObject(place)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    
    
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "snowDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let place = places[indexPath.row]
            guard let newPlaceVC = segue.destination as? NewPlaceTableViewController else { return }
            newPlaceVC.currentPlace = place //передаем тип place из выбранной ячейки во VC newPlaceVC
        }
    }
  
    //при нажаьии на save, будет происходить обратный переход и вызов метода для сохранения новых place
    @IBAction func unwingSegue(_ segue: UIStoryboardSegue) {
        //передаем данные через сегвей, обращаемся к источнику
        guard let newPlaceVC = segue.source as? NewPlaceTableViewController else { return }
        newPlaceVC.savePlace()
       
        tableView.reloadData()
    }
}
