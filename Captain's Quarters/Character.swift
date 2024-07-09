//
//  Character.swift
//  Captain's Quarters
//
//  Created by Robert Usher on 7/8/24.
//

import Foundation
import SwiftData

@Model
class Character {
    var alliance: Alliance?
    var birthday: Date?
    var bloodlineID: Int
    var corporation: Corporation?
    var descriptiont: String
    var gender: String
    var id: Int
    var name: String
    var raceID: Int
    var securityStatus: Double
    
    init(alliance: Alliance? = nil, birthday: Date? = nil, bloodlineID: Int, corporation: Corporation? = nil , descriptiont: String, gender: String, id: Int, name: String, raceID: Int, securityStatus: Double) {
        self.alliance = alliance
        self.birthday = birthday
        self.bloodlineID = bloodlineID
        self.corporation = corporation
        self.descriptiont = descriptiont
        self.gender = gender
        self.id = id
        self.name = name
        self.raceID = raceID
        self.securityStatus = securityStatus
    }
}
