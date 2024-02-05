//
//  UserDefaulsWrapper.swift
//  home
//
//  Created by 반성준 on 2/3/24.
//

import Foundation

@propertyWrapper
struct UserDefaultsWrapper<T: Codable> {
    private let key: String
    private let defaultValue: T?
    
    init(_ keyString: String, defaultValue: T?) {
        self.key = keyString
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T? {
        get {
            if let savedData = UserDefaults.standard.object(forKey: key) as? Data {
                let decoder = JSONDecoder()
                if let lodedObejct = try? decoder.decode(T.self, from: savedData) {
                    return lodedObejct
                }
            }
            return defaultValue
        }
        set {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(newValue) {
                UserDefaults.standard.setValue(encoded, forKey: key)
            }
        }
    }
}
