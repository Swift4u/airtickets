//
//  ListPickerView.swift
//  airtickets
//
//  Created by Paulo Rodrigues on 30/12/17.
//  Copyright © 2017 MaxMilhas. All rights reserved.
//

import UIKit
import ObjectMapper

class ListPickerView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var btnCancel: UIBarButtonItem!
    @IBOutlet weak var btnDone: UIBarButtonItem!
    
    var textField: UITextField?
    var selected: String?
    var selectedIndex: Int = 0
    
    var headers: [String] = []
    var items: [String] = []
    
    init(_ field: UITextField?, list: [String], current: String?) {
        super.init(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 258.0))
        
        textField = field
        items = list
        selected = current
        
        setupLayout()
        
        if let current = current {
            guard let index = items.index(where: { (item) -> Bool in
                return item == current
            }) else { return }
            
            selectedIndex = index
            
            pickerView.selectRow(index, inComponent: 0, animated: false)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupLayout()
    }
    
    func setupLayout() {
        loadViewFromNib()
        
        toolBar.tintColor = UIColor.white
        toolBar.barTintColor = UIColor.blueGreen
        
        guard let montserrat = UIFont(name: Constants.Font.MontserratRegular, size: 19.0), let montserratBold = UIFont(name: Constants.Font.MontserratBold, size: 19.0) else { return }
        
        let titleDoneBarAttributes = [NSAttributedStringKey.font: montserratBold as Any]
        let titleCancelBarAttributes = [NSAttributedStringKey.font: montserrat as Any]
        
        btnCancel.setTitleTextAttributes(titleCancelBarAttributes, for: .normal)
        btnDone.setTitleTextAttributes(titleDoneBarAttributes, for: .normal)
        
        textField?.inputView = self
    }
    
    func loadViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        
        if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            view.backgroundColor = UIColor.clear
            view.frame = bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            addSubview(view)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return headers.count > 0 ? 45.0 : 32.0
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label: UILabel = UILabel()
        
        label.font = UIFont(name: Constants.Font.MontserratRegular, size: 24.0)
        label.textAlignment = .center
        label.text = items[row]
        
        return label
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        if let textField = textField {
            textField.resignFirstResponder()
        }
    }
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        selected = items[pickerView.selectedRow(inComponent: 0)]
        
        selectedIndex = pickerView.selectedRow(inComponent: 0)
        
        if let textField = textField {
            textField.text = selected
            textField.resignFirstResponder()
        }
    }

}
