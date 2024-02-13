//
//  Ext + URL.swift
//  home
//
//  Created by 오연서 on 2/13/24.
//

import Foundation

extension URL {
    static let baseURL = "https://www.ticket-taka.site"
    
    static func makeEndPointString(_ endpoint:String) -> String {
        return baseURL + endpoint
    }
}
