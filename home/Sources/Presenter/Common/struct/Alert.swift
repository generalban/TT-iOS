//
//  Alert.swift
//  home
//
//  Created by 반성준 on 2/4/24.
//

import UIKit

enum AlertType {
    case feedback
    case invite
    case sendTicket
    case resend
}

struct Alert {
    let sender: String
    let team: String
    let type: AlertType
    let ticket: Ticket?
    let feedback: Feedback?
    let resendComment: String?
    let ago: String
    
    init(sender: String, 
         team: String,
         type: AlertType,
         ticket: Ticket? = nil,
         feedback: Feedback? = nil,
         resendComment: String? = nil,
         ago: String) {
        self.sender = sender
        self.team = team
        self.type = type
        self.ticket = ticket
        self.feedback = feedback
        self.resendComment = resendComment
        self.ago = ago
    }
}

extension Alert {
    static let dummy: [Alert] = [
        Alert(sender: "이준영",
              team: "Ticket-Taka",
              type: .resend,
              ticket: Ticket.dummy[1],
              resendComment: "홈 화면 구성 그리드로 정렬 맞추고 참여중인 팀 빼는 방향으로 다시 수정 부탁드립니다!",
              ago: "1분 전"),
        Alert(sender: "오연서",
              team: "Ticket-Taka",
              type: .feedback,
              ticket: Ticket.dummy[1],
              feedback: Feedback.dummy,
              ago: "1분 전"),
        Alert(sender: "",
              team: "Ticket-Taka",
              type: .invite, 
              ticket: Ticket.dummy[2],
              ago: "2분 전"),
        Alert(sender: "이준영",
              team: "UMC 5th TT",
              type: .sendTicket,
              ticket: Ticket.dummy[3],
              ago: "1시간 전"),
        Alert(sender: "김두현", 
              team: "UMC 5th TT",
              type: .sendTicket,
              ticket: Ticket.dummy[4],
              ago: "11/07")
    ]
}
