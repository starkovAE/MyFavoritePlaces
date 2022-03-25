//
//  NewPlaceTableViewController.swift
//  MyFavoritePlaces
//
//  Created by Александр Старков on 24.03.2022.
//

import UIKit

class NewPlaceTableViewController: UITableViewController {
    
  
    var imageIsChanged = false
    
    @IBOutlet weak var placeImage: UIImageView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var placeName: UITextField!
    
    @IBOutlet weak var placeLocation: UITextField!
    
    @IBOutlet weak var placeType: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        tableView.tableFooterView = UIView() //чтобы не было разлиновки! ниже ячеек
    }
    private func setupViews() {
        saveButton.isEnabled = false
        placeName.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    //MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {//если ячейка имеет индекс ноль, то мы должны будем вызвать меню, чтобы пользователь выбрал изображение
            let cameraIcon = UIImage(named: "camera1")
            let photoIcon = UIImage(named: "photo1")
            
            let actionSheet = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)
            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                //вызвать метод для выбора изображения chooseImagePicker
                self.choseImagePicker(source: .camera)
            }
            camera.setValue(cameraIcon, forKey: "image")
            camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let photo = UIAlertAction(title: "Photo", style: .default) { _ in
                //вызвать метод для выбора изображения chooseImagePicker
                self.choseImagePicker(source: .photoLibrary)
            }
            photo.setValue(photoIcon, forKey: "image")
            photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let cancel  = UIAlertAction(title: "Cancel", style: .cancel)
            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)
            present(actionSheet, animated: true)
        } else { //если мы будет тапать за пределами 0 ячейки, то будет скрываться клава
            view.endEditing(true)
            
        }
    }
    func saveNewPlace() {
      
        
        var imagePlaces: UIImage?
        
        if imageIsChanged { //если изображение было измененно пользователем
            imagePlaces = placeImage.image
        } else {//если нет добавляем свое стандартное
            imagePlaces = UIImage(named: "imagePlaceholder")
        }
        
        let imageData = imagePlaces?.pngData() //для преобразования в нужный тип
        
        let newPlace = Place(name: placeName.text ?? "" , location: placeLocation.text, type: placeType.text, imageData: imageData)
        //сохранянем объект в базе данных
        StorageManager.saveObject(newPlace)
    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}
//MARK: - TextFieldDelegate
extension NewPlaceTableViewController: UITextFieldDelegate {
    //скрываем клавиатуру по нажатию на done
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @objc private func textFieldChanged() {
        
        if placeName.text?.isEmpty == false { //если поле не пустое
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
}
//MARK: - WorkWithImage
extension NewPlaceTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func choseImagePicker(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) { //если данный источник будет доступе
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true //редактирование выбранного изображения
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        placeImage.image = info[.editedImage] as? UIImage
        placeImage.contentMode = .scaleAspectFill
        placeImage.clipsToBounds = true
        
        imageIsChanged = true
        dismiss(animated: true)
    }
}
