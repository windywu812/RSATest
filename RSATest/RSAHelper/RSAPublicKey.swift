//
//  RSAPublicKey.swift
//  RSATest
//
//  Created by Windy on 23/09/21.
//

import Foundation

struct RSAPublicKey {

    private(set) var key: SecKey!
    
    init(pemEncoded: String) {
        self.key = createPublicKey(keyString: pemEncoded)
    }
    
    private func createPublicKey(keyString: String) -> SecKey {
        
        let keyData = Data(base64Encoded: keyString.convertToCorrectFormat())!
        let sizeInBits = keyData.count * 8

        let keyDict: [CFString: Any] = [
            kSecAttrKeyType: kSecAttrKeyTypeRSA,
            kSecAttrKeyClass: kSecAttrKeyClassPublic,
            kSecAttrKeySizeInBits: NSNumber(value: sizeInBits),
            kSecReturnPersistentRef: true
        ]
        
        var error: Unmanaged<CFError>?
        let key = SecKeyCreateWithData(keyData as CFData, keyDict as CFDictionary, &error)
        
        return key!
    }
    
}
