//
//  String+Exts.swift
//  RSATest
//
//  Created by Windy on 23/09/21.
//

import Foundation

extension String {
    
    func convertToCorrectFormat() -> String {
           
        let keyArray = self.components(separatedBy: "\n")
        
        var keyOutput : String = ""
        
        for item in keyArray {
            if !item.contains("-----") {
                keyOutput += item
            }
        }
        return keyOutput
    }
    
}
