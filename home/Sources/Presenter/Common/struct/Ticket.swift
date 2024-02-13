//
//  Ticket.swift
//  home
//
//  Created by 반성준 on 1/19/24.
//

import UIKit

enum TicketStatus: String {
    case all
    case done = "Done"
    case inProgress = "In progress"
    case toDo = "To Do"
}

struct Ticket {
    let status: TicketStatus
    let color: UIColor
    let code: String   //프로젝트명-티켓번호
    let title: String
    let content: String
    let startDate: Date
    let dueDate: Date  //마감 하루전이면 색깔 .red로
    let move: Bool
}

//let teamName: String       //팀명
//let userName: String       //티켓 소유자


func stringToDate(_ dateString: String) -> Date? {
    guard dateString.count == 8 else { return nil }
    
    guard let year = Int(dateString.prefix(4)),
          let month = Int(dateString.dropFirst(4).prefix(2)),
          let day = Int(dateString.dropFirst(6)) else { return nil }
    
    let calendar = Calendar.current
    var dateComponents = DateComponents()
    dateComponents.year = year
    dateComponents.month = month
    dateComponents.day = day
    
    return calendar.date(from: dateComponents)
}

func dateToString(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd"
    return dateFormatter.string(from: date)
}

extension Ticket {
    static let dummy: [Ticket] = [Ticket(status: .inProgress,
                                         color: UIColor(hexCode: "6361FF"),
                                         code: "DD-2",
                                         title: "화면설계서 수정",
                                         content: """
프로젝트 홈 화면 주요 프로젝트 바로가기 부분, 참여중인 팀
부분 와이어프레임 수정 부탁드립니다!

알림창 화면에서 팀 초대는 다른 화면으로 모아서 보게 하고
전체 알림을 최신순으로 볼 수 있게 하는 방향으로 수정하면
좋을 것 같습니다.
""",
                                         startDate: stringToDate("20240131")!,
                                         dueDate: stringToDate("20240211")!,
                                         move: true),
                                  Ticket(status: .toDo,
                                         color: UIColor(hexCode: "54FFF3"),
                                         code: "TT-3",
                                         title: "와이어프레임 수정 요청",
                                         content: """
프로젝트 홈 화면 주요 프로젝트 바로가기 부분, 참여중인 팀
부분 와이어프레임 수정 부탁드립니다!

알림창 화면에서 팀 초대는 다른 화면으로 모아서 보게 하고
전체 알림을 최신순으로 볼 수 있게 하는 방향으로 수정하면
좋을 것 같습니다.
""",
                                         startDate: stringToDate("20240204")!,
                                         dueDate: stringToDate("20240214")!,
                                         move: true),
                                  Ticket(status: .toDo,
                                         color: UIColor(hexCode: "49A0A0"),
                                         code: "TT-4",
                                         title: "회의록 전달",
                                         content: """
프로젝트 홈 화면 주요 프로젝트 바로가기 부분, 참여중인 팀
부분 와이어프레임 수정 부탁드립니다!

알림창 화면에서 팀 초대는 다른 화면으로 모아서 보게 하고
전체 알림을 최신순으로 볼 수 있게 하는 방향으로 수정하면
좋을 것 같습니다.
""",
                                         startDate: stringToDate("20240207")!,
                                         dueDate: stringToDate("20240210")!,
                                         move: false),
                                  Ticket(status: .inProgress,
                                         color: UIColor(hexCode: "6361FF"),
                                         code: "DD-3",
                                         title: "화면설계서 수정",
                                         content: """
프로젝트 홈 화면 주요 프로젝트 바로가기 부분, 참여중인 팀
부분 와이어프레임 수정 부탁드립니다!

알림창 화면에서 팀 초대는 다른 화면으로 모아서 보게 하고
전체 알림을 최신순으로 볼 수 있게 하는 방향으로 수정하면
좋을 것 같습니다.
""",
                                         startDate: stringToDate("20240215")!,
                                         dueDate: stringToDate("20240218")!,
                                         move: true),
                                  Ticket(status: .toDo,
                                         color: .blue,
                                         code: "TT-5",
                                         title: "회의록 전달",
                                         content: """
프로젝트 홈 화면 주요 프로젝트 바로가기 부분, 참여중인 팀
부분 와이어프레임 수정 부탁드립니다!

알림창 화면에서 팀 초대는 다른 화면으로 모아서 보게 하고
전체 알림을 최신순으로 볼 수 있게 하는 방향으로 수정하면
좋을 것 같습니다.
""",
                                         startDate: stringToDate("20240220")!,
                                         dueDate: stringToDate("20240222")!,
                                         move: true),
                                  Ticket(status: .done,
                                         color: UIColor(hexCode: "6361FF"),
                                         code: "DD-4",
                                         title: "화면설계서 수정",
                                         content: """
                              프로젝트 홈 화면 주요 프로젝트 바로가기 부분, 참여중인 팀
                              부분 와이어프레임 수정 부탁드립니다!
                              
                              알림창 화면에서 팀 초대는 다른 화면으로 모아서 보게 하고
                              전체 알림을 최신순으로 볼 수 있게 하는 방향으로 수정하면
                              좋을 것 같습니다.
                              """,
                                         startDate: stringToDate("20240206")!,
                                         dueDate: stringToDate("20240209")!,
                                         move: true),
                                  Ticket(status: .done,
                                         color: .purple,
                                         code: "TT-6",
                                         title: "회의록 전달",
                                         content: """
                              프로젝트 홈 화면 주요 프로젝트 바로가기 부분, 참여중인 팀
                              부분 와이어프레임 수정 부탁드립니다!
                              
                              알림창 화면에서 팀 초대는 다른 화면으로 모아서 보게 하고
                              전체 알림을 최신순으로 볼 수 있게 하는 방향으로 수정하면
                              좋을 것 같습니다.
                              """,
                                         startDate: stringToDate("20240206")!,
                                         dueDate: stringToDate("20240209")!,
                                         move: true),
                                  Ticket(status: .done,
                                         color: .coolGray1,
                                         code: "TT-7",
                                         title: "회의록 전달",
                                         content: """
                              프로젝트 홈 화면 주요 프로젝트 바로가기 부분, 참여중인 팀
                              부분 와이어프레임 수정 부탁드립니다!
                              
                              알림창 화면에서 팀 초대는 다른 화면으로 모아서 보게 하고
                              전체 알림을 최신순으로 볼 수 있게 하는 방향으로 수정하면
                              좋을 것 같습니다.
                              """,
                                         startDate: stringToDate("20240206")!,
                                         dueDate: stringToDate("20240209")!,
                                         move: false),
                                  Ticket(status: .done,
                                         color: UIColor(hexCode: "6361FF"),
                                         code: "DD-5",
                                         title: "화면설계서 수정",
                                         content: """
                              프로젝트 홈 화면 주요 프로젝트 바로가기 부분, 참여중인 팀
                              부분 와이어프레임 수정 부탁드립니다!
                              
                              알림창 화면에서 팀 초대는 다른 화면으로 모아서 보게 하고
                              전체 알림을 최신순으로 볼 수 있게 하는 방향으로 수정하면
                              좋을 것 같습니다.
                              """,
                                         startDate: stringToDate("20240206")!,
                                         dueDate: stringToDate("20240209")!,
                                         move: true),
                                  Ticket(status: .done,
                                         color: UIColor(hexCode: "49A0A0"),
                                         code: "TT-8",
                                         title: "회의록 전달",
                                         content: """
                              프로젝트 홈 화면 주요 프로젝트 바로가기 부분, 참여중인 팀
                              부분 와이어프레임 수정 부탁드립니다!
                              
                              알림창 화면에서 팀 초대는 다른 화면으로 모아서 보게 하고
                              전체 알림을 최신순으로 볼 수 있게 하는 방향으로 수정하면
                              좋을 것 같습니다.
                              """,
                                         startDate: stringToDate("20240206")!,
                                         dueDate: stringToDate("20240209")!,
                                         move: true)]
}
