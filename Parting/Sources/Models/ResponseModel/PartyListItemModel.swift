//
//  PartyModel.swift
//  Parting
//
//  Created by 김민규 on 2023/07/22.
//

import Foundation

struct PartyListItemModel {
	let id: Int
	let title: String
	let location: String
	let distance: String
	let currentPartyMemberCount: Int
	let maxPartyMemberCount: Int
	let partyDuration: String
	let tags: [String]
	let status: PartyStatus
	let imgURL: String
}

enum PartyStatus: String {
	case recruiting = "RECRUIT"
	case closed = "CLOSED"
	
	static func strToStatus(_ str: String) -> PartyStatus {
		if str == "RECRUIT" {
			return .recruiting
		} else {
			return .closed
		}
	}
	
	
}
