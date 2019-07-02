//
//  Extensions.swift
//  PromobiTechnologiesIosTest
//
//  Created by Kondya on 02/07/19.
//  Copyright © 2019 Fortune4. All rights reserved.
//

import UIKit

extension String {
    
    func decorateText(sub:String)->NSAttributedString{
        let textAttributesOne = [NSAttributedString.Key.foregroundColor: UIColor.darkText, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)]
        let textAttributesTwo = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]
        
        let textPartOne = NSMutableAttributedString(string: sub, attributes: textAttributesOne)
        let textPartTwo = NSMutableAttributedString(string: self, attributes: textAttributesTwo)
        
        let textCombination = NSMutableAttributedString()
        textCombination.append(textPartOne)
        textCombination.append(textPartTwo)
        return textCombination
    }
    
}

extension Date {
    
    func toString () -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat="dd-MMM-yyyy, 'at' hh:mm:ss"
        return dateFormatter.string(from: self)
    }
}
