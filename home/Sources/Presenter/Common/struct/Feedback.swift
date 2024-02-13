//
//  Feedback.swift
//  home
//
//  Created by 반성준 on 2/4/24.
//

import Foundation

struct Feedback {
    let title: String
    let content: String
    let files: [String]
    let links: [String]
}

extension Feedback {
    static let dummy: Feedback = Feedback(title: "와이어프레임 수정 요청",
                                   content: """
프로젝트 홈 화면 주요 프로젝트 바로가기 부분, 참여중인 팀
부분 와이어프레임 수정 부탁드립니다!

알림창 화면에서 팀 초대는 다른 화면으로 모아서 보게 하고
전체 알림을 최신순으로 볼 수 있게 하는 방향으로 수정하면
좋을 것 같습니다.
""", 
                                   files: ["202411......png", "수정1.png", "수정2.png"],
                                   links: ["링크1", "링크2", "링크3"])
}
