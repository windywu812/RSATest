//
//  RSAPrivateKey.swift
//  RSATest
//
//  Created by Windy on 23/09/21.
//

import Foundation

struct RSAPrivateKey {
    
    private(set) var key: SecKey!
    
    /// PCKS1 format
    init(pemEncoded: String) {
        self.key = createPrivateKey(keyString: pemEncoded)
    }
    
    private func createPrivateKey(keyString: String) -> SecKey? {
        
        let keyData = Data(base64Encoded: keyString.convertToCorrectFormat())!
        let sizeInBits = keyData.count * 8

        let keyDict: [CFString: Any] = [
            kSecAttrKeyType: kSecAttrKeyTypeRSA,
            kSecAttrKeyClass: kSecAttrKeyClassPrivate,
            kSecAttrKeySizeInBits: NSNumber(value: sizeInBits),
            kSecReturnPersistentRef: true
        ]
        
        var error: Unmanaged<CFError>?
        guard let key = SecKeyCreateWithData(keyData as CFData, keyDict as CFDictionary, &error) else {
            print(error!)
            return nil
        }
        
        return key
    }
    
}
