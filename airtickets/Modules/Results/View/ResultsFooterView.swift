//
//  ResultsFooterView.swift
//  airtickets
//
//  Created by Paulo Rodrigues on 31/12/17.
//  Copyright © 2017 MaxMilhas. All rights reserved.
//

import UIKit

class ResultsFooterView: UIView {
    
    var view: UIView!
    
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var btnSort: UIButton!

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
        
        borders(for: [.top], width: 1.0, color: UIColor.silver)
        
        btnFilter.borders(for: [.right], width: 1.0, color: UIColor.silver)
        
        btnFilter.setTitleColor(UIColor.steelGrey, for: .normal)
        btnSort.setTitleColor(UIColor.steelGrey, for: .normal)
        
        btnFilter.setTitleColor(UIColor.coolGrey, for: .highlighted)
        btnSort.setTitleColor(UIColor.coolGrey, for: .highlighted)
    }
    
    func loadViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        view.backgroundColor = UIColor.white
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(view)
    }

}
