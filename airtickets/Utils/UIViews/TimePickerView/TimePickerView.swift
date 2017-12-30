//
//  TimePickerView.swift
//  airtickets
//
//  Created by Paulo Rodrigues on 30/12/17.
//  Copyright © 2017 MaxMilhas. All rights reserved.
//

import UIKit

class TimePickerView: UIView {
    var view: UIView!
    var hasText: Bool = false

    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var pickerView: UIDatePicker!
    @IBOutlet weak var btnCancel: UIBarButtonItem!
    @IBOutlet weak var btnDone: UIBarButtonItem!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
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
    }
    
    func loadViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        view.backgroundColor = UIColor.clear
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(view)
    }
}
