//
//  ViewController.swift
//  RSATest
//
//  Created by Windy on 30/08/21.
//

import UIKit
import Security

class ViewController: UIViewController {
    
    let PUBLIC_KEY = ""
    let PRIVATE_KEY = ""
    
    @IBOutlet weak var messageData: UILabel!
    @IBOutlet weak var decryptingSwitch: UISwitch!
    @IBOutlet weak var messageTextField: UITextField!
    
    let hexEncodedString = "2f7aef67c0bdbb3acc39b5605b77bfd9f019c5c9b284161bad13570bbe3000e3da8b6dcc648dbc2878b9c8120cfbe417496b6870d74801e6bc21577c7afaa036794107839d33d8915914df815d247dd81bdbe9559332026726edef1af073291f6e66d975a0b20cf8f270c6b481feb5e68989fbc17539526899ce6a8f4d74472a9ce32cb0064cc7e1eda6ee7de8e4233b9a85e087c35aed6733a469c04d5e1e32dc6a1e9caed40364778c3e64577045d5834554de2a3c068a35d46274dd0649fcfb188f62ed7de268571e00a0628ead0fb092a368c4bdf5a0397608caca718bea7ea109dadbf652b9021853c7875e1e5402904960bae09ffc0c1e91b00feed0b5f55b9ff03e01fbf15cc8ed4c919247e1a50ed8ce7bc0a0502770bb12c22ecfae6f86967929f4610e0f88078ee393f5107718d7a70a2b86692aa97c29fc6e7cb0ab2483a38ac7e59f2857bc2b0a3f7f9fbf3feddb429d91c0682af9f6deee1f05fbaff9fa4aaae0c22f76efd564d95ecc55caf7873c3c613623d6f9d2894b919e8b51cd3822ee9082f6f2bcfcf5aec9810e393e2037b1dd4480a0a822eb3194bfe28c5ecdc5026dd3fc5e174baee34396cbb6fc2043d03a924437b6e74ce6f7228110e4c8e7914759d76c8521c2cd1f503c26d93bd9908bec8ceea71b4bfe77b16e7031f79403fe33e8423ed1c6291110253d40eb85dd037b6bb956bed2034162"

    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Create a RSA PublicKey
        let publicKey = RSAPublicKey(pemEncoded: PUBLIC_KEY)
        
        // Create a RSA PrivateKey
        let privateKey = RSAPrivateKey(pemEncoded: PRIVATE_KEY)
    
        let encrypted = RSAHelper.encrypt(
            plainText: "Azrul Ganteng Banget",
            publicKey: publicKey)
        print("Encrypted: \(encrypted) \n")
        
        let decrypt = RSAHelper.decrypt(
            chiperText: encrypted,
            privateKey: privateKey,
            type: .base64Encoded)
        
        print("Decrypted: \(decrypt)")
        
        let decryptedHexString = RSAHelper.decrypt(
            chiperText: hexEncodedString,
            privateKey: privateKey,
            type: .hexEncoded)
        
        print("Hext Decrypted: \(decryptedHexString)")
    }
    
}
