//
//  ViewController.swift
//  Sample
//
//  Created by Meniny on 2018-01-21.
//  Copyright © 2018年 Meniny. All rights reserved.
//

import UIKit
import SuperAlertController
import SuperAlertControllerPickers

public enum SuperAlertType {
    case imagePicker(direction: UICollectionViewScrollDirection)
    case datePicker
    case phoneCodePicker
    case localePicker
    case currencyPicker
    case colorPicker
    case normal
    case customPicker
    case loginPanel
    case inputPanel
    case imagePreview
    case webView
    
    var title: String {
        switch self {
        case .imagePicker(let direction):
            switch direction {
            case .vertical:
                return "Image Picker (Vertical)"
            default:
                return "Image Picker (Horizontal)"
            }
        case .datePicker:
            return "Date Picker"
        case .phoneCodePicker:
            return "Phone Code Picker"
        case .localePicker:
            return "Local Picker"
        case .currencyPicker:
            return "Currency Picker"
        case .colorPicker:
            return "Color Picker"
        case .normal:
            return "Normal Alert"
        case .customPicker:
            return "Custom Picker"
        case .loginPanel:
            return "Login Panel"
        case .inputPanel:
            return "Input Panel"
        case .imagePreview:
            return "Image Preview"
        case .webView:
            return "Web View"
        }
    }
    
    var icon: SuperAlertControllerPickerIcon {
        switch self {
        case .imagePicker(_):
            return .library
        case .datePicker:
            return .calendar
        case .phoneCodePicker:
            return .telephone
        case .localePicker:
            return .planet
        case .currencyPicker:
            return .currency
        case .colorPicker:
            return .colors
        case .normal:
            return .title
        case .customPicker:
            return .picker
        case .loginPanel:
            return .user
        case .inputPanel:
            return .pen
        case .imagePreview:
            return .clip
        case .webView:
            return .globe
        }
    }
}

let azure = #colorLiteral(red: 0.05, green:0.49, blue:0.98, alpha:1.00)

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    let dataSource: [SuperAlertType] = [
        .imagePicker(direction: .horizontal),
        .imagePicker(direction: .vertical),
        .datePicker,
        .phoneCodePicker,
        .localePicker,
        .currencyPicker,
        .colorPicker,
        .normal,
        .customPicker,
        .loginPanel,
        .inputPanel,
        .imagePreview,
        .webView
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "SuperAlertController"
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.tableFooterView = UIView.init()
    }
    
    func alert(type: SuperAlertType) {
        let alertController = SuperAlertController.init(style: .alert, source: self.view, title: "SuperAlertController", message: "This is a \(type.title)", tintColor: azure)
        
        switch type {
        case .imagePicker(let direction):
            let images: [UIImage] = [#imageLiteral(resourceName: "sample-1"), #imageLiteral(resourceName: "sample-2"), #imageLiteral(resourceName: "sample-3"), #imageLiteral(resourceName: "sample-4"), #imageLiteral(resourceName: "sample-5") ]
            alertController.addImagePicker(direction, paging: true, height: 320, images: images, selection: .single({ img in
                print(String.init(describing: img))
            }))
            break
        case .datePicker:
            alertController.addDatePicker(mode: .dateAndTime, date: Date(), minimumDate: nil, maximumDate: nil, action: { (date) in
                print(date)
            })
            break
        case .phoneCodePicker, .currencyPicker, .localePicker:
            let kind: LocalePickerViewController.Kind
            switch type {
            case .phoneCodePicker:
                kind = .phoneCode
                break
            case .currencyPicker:
                kind = .currency
                break
            default:
                kind = .country
                break
            }
            alertController.addLocalePicker(type: kind, action: { (info) in
                print(String.init(describing: info))
            })
            break
        case .colorPicker:
            alertController.addColorPicker(color: azure, action: { (color) in
                print(color)
            })
            break
        case .normal:
            alertController.addAction(image: SuperAlertControllerPickerIcon.globe.image, title: "Global", color: #colorLiteral(red: 1.00, green:0.25, blue:0.35, alpha:1.00), style: .default, isEnabled: true, handler: nil)
            break
        case .customPicker:
            let colLeft: PickerViewColumnSet = [
                "Abel",
                "Bob",
                "Cathrin",
                "Daniel",
                "Elias",
                "Frank",
                "Geissler",
                "Hohenheim"
            ]
            let colRight: PickerViewColumnSet = [
                "Male",
                "Female"
            ]
            alertController.addPickerView(values: [colLeft, colRight], initialSelection: (0, 4), action: { (_, _, index, value) in
                print(value.row(at: index))
            })
            break
        case .loginPanel:
            alertController.addTwoTextFields(height: 49, hInset: 5, vInset: 5, textFieldOne: { (uname) in
                uname.keyboardType = .emailAddress
                uname.placeholder = "E-mail"
                uname.text = "admin@meniny.cn"
                uname.clearButtonMode = .whileEditing
            }, textFieldTwo: { (password) in
                password.isSecureTextEntry = true
                password.keyboardType = .asciiCapableNumberPad
                password.placeholder = "Password"
                password.clearButtonMode = .whileEditing
            })
            break
        case .inputPanel:
            alertController.addOneTextField(configuration: { (textField) in
                textField.borderStyle = .roundedRect
                textField.keyboardType = .default
                textField.placeholder = "Enter your name"
                textField.text = "Elias Abel"
                textField.clearButtonMode = .whileEditing
            })
            break
        case .imagePreview:
            alertController.addImagePreview(image: #imageLiteral(resourceName: "sample-5"))
            break
        case .webView:
            alertController.addWebView(url: URL.init(string: "https://meniny.cn/")!)
            break
        }
        
        alertController.addAction(image: nil, title: "Done", color: azure, style: .default, isEnabled: true) { (_) in
            alertController.hide(completion: nil)
        }
        alertController.addAction(image: nil, title: "Cancel", color: azure, style: .cancel, isEnabled: true, handler: nil)
        
        alertController.show(animated: true, vibrate: true, serial: false, completion: nil)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        let type = dataSource[indexPath.row]
        cell?.textLabel?.text = type.title
        cell?.selectionStyle = .none
        cell?.accessoryType = .disclosureIndicator
        cell?.imageView?.image = type.icon.image
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = dataSource[indexPath.row]
        alert(type: type)
    }
}

