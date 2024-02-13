//
//  AttachedItem.swift
//  home
//
//  Created by 반성준 on 2/4/24.
//

import Foundation

enum AttachedItemType {
    case file
    case link
}

struct AttachedItem {
    let name: String
    let type: AttachedItemType
}

extension AttachedItem {
    static let dummyFiles: [AttachedItem] = [AttachedItem(name: "2024...1234124.png",
                                                          type: .file),
                                             AttachedItem(name: "수정1.png",
                                                                                                   type: .file),
                                             AttachedItem(name: "수정2.png",
                                                                                                   type: .file),
                                             AttachedItem(name: "2024...1234124.png",
                                                                                                   type: .file),]
    
    static let dummyLinks: [AttachedItem] = [AttachedItem(name: "링크1",
                                                          type: .link),
                                             AttachedItem(name: "링크2",
                                                                                                   type: .link),
                                             AttachedItem(name: "링크3",
                                                                                                   type: .file),
                                             AttachedItem(name: "링크5",
                                                                                                   type: .link)]
}
