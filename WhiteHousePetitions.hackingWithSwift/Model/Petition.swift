//
//  Petition.swift
//  WhiteHousePetitions.hackingWithSwift
//
//  Created by Илья Шаповалов on 28.06.2022.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
    var signaturesNeeded: Int
    var url: String
}
