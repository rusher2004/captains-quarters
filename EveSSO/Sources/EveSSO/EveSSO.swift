//
//  EveSSO.swift
//  
//
//  Created by Robert Usher on 7/9/24.
//

//
//  SSO.swift
//
//
//  Created by Robert Usher on 7/8/24.
//

import Foundation
import OSLog

enum GrantType: String {
    case authorizationCode = "authorization_code"
    case refreshToken = "refresh_token"
}

struct OAuthToken: Codable {
    let accessToken: String
    let expiresIn: Int
    let refreshToken, tokenType: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
        case tokenType = "token_type"
    }
}

@available(iOS 14.0, *)
private let logger = Logger(subsystem: "EveSSO", category: "SSO")

func fetchOAuthToken(code: String, grantType: GrantType) throws -> OAuthToken {
    let parameters = "grant_type=authorization_code"
    let postData =  parameters.data(using: .utf8)

    var request = URLRequest(url: URL(string: "https://login.eveonline.com/v2/oauth/token")!,timeoutInterval: Double.infinity)
    request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.addValue("login.eveonline.com", forHTTPHeaderField: "Host")
    request.addValue("Basic dXNlcm5hbWU6cGFzc3dvcmQ=", forHTTPHeaderField: "Authorization")

    request.httpMethod = "POST"
    request.httpBody = postData

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data = data else {
        print(String(describing: error))
        return
      }
      print(String(data: data, encoding: .utf8)!)
    }

    task.resume()

    return OAuthToken(accessToken: "", expiresIn: 0, refreshToken: "", tokenType: "")
}

public enum Thing {
    case One, Two
}

public let Scopes = [
    "publicData",
    "esi-location.read_location.v1",
    "esi-location.read_ship_type.v1",
    "esi-skills.read_skills.v1",
    "esi-skills.read_skillqueue.v1",
    "esi-wallet.read_character_wallet.v1",
    "esi-wallet.read_corporation_wallet.v1",
    "esi-search.search_structures.v1",
    "esi-clones.read_clones.v1",
    "esi-universe.read_structures.v1",
    "esi-killmails.read_killmails.v1",
    "esi-assets.read_assets.v1",
    "esi-planets.manage_planets.v1",
    "esi-fittings.read_fittings.v1",
    "esi-markets.structure_markets.v1",
    "esi-characters.read_loyalty.v1",
    "esi-characters.read_chat_channels.v1",
    "esi-characters.read_medals.v1",
    "esi-characters.read_standings.v1",
    "esi-characters.read_agents_research.v1",
    "esi-industry.read_character_jobs.v1",
    "esi-markets.read_character_orders.v1",
    "esi-characters.read_blueprints.v1",
    "esi-location.read_online.v1",
    "esi-contracts.read_character_contracts.v1",
    "esi-clones.read_implants.v1",
    "esi-characters.read_fatigue.v1",
    "esi-wallet.read_corporation_wallets.v1",
    "esi-assets.read_corporation_assets.v1",
    "esi-corporations.read_blueprints.v1",
    "esi-contracts.read_corporation_contracts.v1",
    "esi-corporations.read_standings.v1",
    "esi-industry.read_corporation_jobs.v1",
    "esi-markets.read_corporation_orders.v1",
    "esi-industry.read_character_mining.v1",
    "esi-corporations.read_medals.v1",
    "esi-characters.read_titles.v1",
    "esi-characters.read_fw_stats.v1",
    "esi-corporations.read_fw_stats.v1",
    "esi-characterstats.read.v1",
]
