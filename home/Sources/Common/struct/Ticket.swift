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
    let code: String
    let title: String
    let content: String
    let date: String
    let move: Bool
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
                                         date: "11/11",
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
                                         date: "11/12",
                                         move: true),
                                  Ticket(status: .toDo,
                                         color: UIColor(hexCode: "49A0A0"),
                                         code: "TT-3",
                                         title: "회의록 전달",
                                         content: """
프로젝트 홈 화면 주요 프로젝트 바로가기 부분, 참여중인 팀
부분 와이어프레임 수정 부탁드립니다!

알림창 화면에서 팀 초대는 다른 화면으로 모아서 보게 하고
전체 알림을 최신순으로 볼 수 있게 하는 방향으로 수정하면
좋을 것 같습니다.
""",
                                         date: "11/14",
                                         move: false),
                                  Ticket(status: .inProgress,
                                         color: UIColor(hexCode: "54FFF3"),
                                         code: "DD-2",
                                         title: "화면설계서 수정",
                                         content: """
프로젝트 홈 화면 주요 프로젝트 바로가기 부분, 참여중인 팀
부분 와이어프레임 수정 부탁드립니다!

알림창 화면에서 팀 초대는 다른 화면으로 모아서 보게 하고
전체 알림을 최신순으로 볼 수 있게 하는 방향으로 수정하면
좋을 것 같습니다.
""",
                                         date: "11/18",
                                         move: true),
                                  Ticket(status: .toDo,
                                         color: UIColor(hexCode: "49A0A0"),
                                         code: "TT-3",
                                         title: "회의록 전달",
                                         content: """
프로젝트 홈 화면 주요 프로젝트 바로가기 부분, 참여중인 팀
부분 와이어프레임 수정 부탁드립니다!

알림창 화면에서 팀 초대는 다른 화면으로 모아서 보게 하고
전체 알림을 최신순으로 볼 수 있게 하는 방향으로 수정하면
좋을 것 같습니다.
""",
                                         date: "11/13",
                                         move: true),
                                  Ticket(status: .done,
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
                                         date: "11/10",
                                         move: true),
                                  Ticket(status: .done,
                                         color: UIColor(hexCode: "49A0A0"),
                                         code: "TT-3",
                                         title: "회의록 전달",
                                         content: """
                              프로젝트 홈 화면 주요 프로젝트 바로가기 부분, 참여중인 팀
                              부분 와이어프레임 수정 부탁드립니다!
                              
                              알림창 화면에서 팀 초대는 다른 화면으로 모아서 보게 하고
                              전체 알림을 최신순으로 볼 수 있게 하는 방향으로 수정하면
                              좋을 것 같습니다.
                              """,
                                         date: "11/12",
                                         move: true),
                                  Ticket(status: .done,
                                         color: UIColor(hexCode: "49A0A0"),
                                         code: "TT-3",
                                         title: "회의록 전달",
                                         content: """
                              프로젝트 홈 화면 주요 프로젝트 바로가기 부분, 참여중인 팀
                              부분 와이어프레임 수정 부탁드립니다!
                              
                              알림창 화면에서 팀 초대는 다른 화면으로 모아서 보게 하고
                              전체 알림을 최신순으로 볼 수 있게 하는 방향으로 수정하면
                              좋을 것 같습니다.
                              """,
                                         date: "11/14",
                                         move: false),
                                  Ticket(status: .done,
                                         color: UIColor(hexCode: "54FFF3"),
                                         code: "DD-2",
                                         title: "화면설계서 수정",
                                         content: """
                              프로젝트 홈 화면 주요 프로젝트 바로가기 부분, 참여중인 팀
                              부분 와이어프레임 수정 부탁드립니다!
                              
                              알림창 화면에서 팀 초대는 다른 화면으로 모아서 보게 하고
                              전체 알림을 최신순으로 볼 수 있게 하는 방향으로 수정하면
                              좋을 것 같습니다.
                              """,
                                         date: "11/18",
                                         move: true),
                                  Ticket(status: .done,
                                         color: UIColor(hexCode: "49A0A0"),
                                         code: "TT-3",
                                         title: "회의록 전달",
                                         content: """
                              프로젝트 홈 화면 주요 프로젝트 바로가기 부분, 참여중인 팀
                              부분 와이어프레임 수정 부탁드립니다!
                              
                              알림창 화면에서 팀 초대는 다른 화면으로 모아서 보게 하고
                              전체 알림을 최신순으로 볼 수 있게 하는 방향으로 수정하면
                              좋을 것 같습니다.
                              """,
                                         date: "11/13",
                                         move: true)]
}
