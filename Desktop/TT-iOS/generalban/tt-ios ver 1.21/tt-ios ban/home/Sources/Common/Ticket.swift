//
//  Ticket.swift
//  home
//
//  Created by 반성준 on 1/19/24.
//

import UIKit

enum TicketStatus: String {
    case done = "Done"
    case inProgress = "In progress"
    case toDo = "To Do"
}

struct Ticket {
    let status: TicketStatus
    let color: UIColor
    let name: String
    let description: String
    let date: String
    let move: Bool
}
