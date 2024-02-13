//
//  Project.swift
//  home
//
//  Created by 반성준 on 2/3/24.
//

import UIKit

struct Project {
    let team: String
    let title: String
    let cardImage: UIImage?
}

extension Project {
    static let dummy: [Project] = [
        Project(team: "",
                title: "프로젝트1",
                cardImage: UIImage(named: "card_color1")),
        Project(team: "Ticket-Taka 팀",
                title: "프로젝트2",
                cardImage: UIImage(named: "card_main")),
        Project(team: "",
                title: "프로젝트3",
                cardImage: UIImage(named: "card_color2")),
        Project(team: "팀명",
                title: "프로젝트4",
                cardImage: UIImage(named: "card_color1")),
        Project(team: "",
                title: "프로젝트1",
                cardImage: UIImage(named: "card_main"))
    ]
}
