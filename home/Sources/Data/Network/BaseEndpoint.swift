//
//  BaseEndpoint.swift
//  home
//
//  Created by 오연서 on 2/13/24.
//

import Foundation

enum BaseEndpoint {
    
    case teams
    case project
    case timeline
    case ticket
    case community
    case calendar
    case alarm

    var requestURL: String {
        switch self {
        case.teams: return URL.makeEndPointString("/teams")
        case.project: return URL.makeEndPointString("/teams/{teamId}/projects")
        case.timeline: return URL.makeEndPointString("/teams/{teamId}/projects/{projectId}/timelines")
        case.ticket: return URL.makeEndPointString("/teams/{teamId}/projects/{projectId}/timelines")
        case.community: return URL.makeEndPointString("/community")
        case.calendar: return URL.makeEndPointString("/calendar")
        case.alarm: return URL.makeEndPointString("/alarms")
        }
    }
}
