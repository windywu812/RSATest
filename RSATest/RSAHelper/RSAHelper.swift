//
//  RSAHelper.swift
//  RSATest
//
//  Created by Windy on 23/09/21.
//

import Foundation

enum ReturnType {
    case base64Encoded
    case hexEncoded
}

class RSAHelper {
    
    /// Encrypt the give string
    /// - Parameters:
    ///   - plainText: String to be encrypted
    ///   - publicKey: Public key to encrypt
    ///   - type: Return type either base64EncodedString or hexEncodedString
    /// - Returns: Encrypted String
    static func encrypt(
        plainText: String,
        publicKey: RSAPublicKey,
        type: ReturnType = .base64Encoded
    ) -> String {
        
        var error: Unmanaged<CFError>?
        
        let data = Data(plainText.utf8)
        
        let encryptedData = SecKeyCreateEncryptedData(
            publicKey.key,
            .rsaEncryptionPKCS1,
            data as CFData, &error)! as Data
        
        switch type {
        case .base64Encoded:
            return encryptedData.base64EncodedString()
        case .hexEncoded:
            return encryptedData.hexEncodedString()
        }
        
    }
    
    /// Decrypt the ChiperText
    /// - Parameters:
    ///   - chiperText: String to be decrypted
    ///   - privateKey: Private key to decrypt
    ///   - type: Base64 Encoded or HexEncoded String
    /// - Returns: Decrypted String
    static func decrypt(
        chiperText: String,
        privateKey: RSAPrivateKey,
        type: ReturnType = .base64Encoded
    ) -> String {
        
        var data: Data!
        
        switch type {
        case .base64Encoded:
            data = Data(base64Encoded: chiperText)
        case .hexEncoded:
            data = Data(fromHexEncodedString: chiperText)
        }

        guard let decryptData = SecKeyCreateDecryptedData(
            privateKey.key,
            .rsaEncryptionPKCS1,
            data as CFData, nil) else {
            return "Not supported format"
        }
        
        let decryptString = String(data: decryptData as Data, encoding: .utf8)
        
        return decryptString ?? ""
    }
    
}

/// Helper Extension
private extension Data {

    struct HexEncodingOptions: OptionSet {
        let rawValue: Int
        static let upperCase = HexEncodingOptions(rawValue: 1 << 0)
    }

    /// Convert data to hexEncodedString
    func hexEncodedString(options: HexEncodingOptions = []) -> String {
        let format = options.contains(.upperCase) ? "%02hhX" : "%02hhx"
        return self.map { String(format: format, $0) }.joined()
    }
    
    /// Create data with the gvien hexEncodedString
    // From http://stackoverflow.com/a/40278391:
    init?(fromHexEncodedString string: String) {

        // Convert 0 ... 9, a ... f, A ...F to their decimal value,
        // return nil for all other input characters
        func decodeNibble(u: UInt16) -> UInt8? {
            switch(u) {
            case 0x30 ... 0x39:
                return UInt8(u - 0x30)
            case 0x41 ... 0x46:
                return UInt8(u - 0x41 + 10)
            case 0x61 ... 0x66:
                return UInt8(u - 0x61 + 10)
            default:
                return nil
            }
        }

        self.init(capacity: string.utf16.count/2)
        var even = true
        var byte: UInt8 = 0
        for c in string.utf16 {
            guard let val = decodeNibble(u: c) else { return nil }
            if even {
                byte = val << 4
            } else {
                byte += val
                self.append(byte)
            }
            even = !even
        }
        guard even else { return nil }
    }
    
}
