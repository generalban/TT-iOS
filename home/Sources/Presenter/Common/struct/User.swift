//
//  User.swift
//  home
//
//  Created by 반성준 on 2/3/24.
//

import UIKit
import SwiftUI

struct Color : Codable {
    var red : CGFloat = 0.0,
        green: CGFloat = 0.0,
        blue: CGFloat = 0.0,
        alpha: CGFloat = 0.0
    
    var uiColor : UIColor {
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    init(uiColor : UIColor) {
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    }
}

struct User: Codable {
    let name: String
    let backgroundColor: UIColor
    
    init(name: String, backgroundColor: UIColor) {
        self.name = name
        self.backgroundColor = backgroundColor
    }
    
    private enum CodingKeys: String, CodingKey { case name, backgroundColor }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self,
                                    forKey: .name)
        backgroundColor = try container.decode(Color.self,
                                               forKey: .backgroundColor).uiColor
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name,
                             forKey: .name)
        try container.encode(Color(uiColor: backgroundColor),
                             forKey: .backgroundColor)
    }
}

extension User {
    static let dummyTeam: [User] = [
        User(name: "이준영", backgroundColor: UIColor(hexCode: "FFD7D7")),
        User(name: "김두현", backgroundColor: UIColor(hexCode: "44FF78")),
        User(name: "오연서", backgroundColor: UIColor(hexCode: "FF5AF9")),
        User(name: "반성준", backgroundColor: UIColor(hexCode: "BDE3FF")),
        User(name: "김태우", backgroundColor: UIColor(hexCode: "E4C1FF")),
        User(name: "김지민", backgroundColor: UIColor(hexCode: "49A0A0")),
        User(name: "황유진", backgroundColor: UIColor(hexCode: "FFEE53")),
        User(name: "정우현", backgroundColor: UIColor(hexCode: "B455FF"))
    ]
}
