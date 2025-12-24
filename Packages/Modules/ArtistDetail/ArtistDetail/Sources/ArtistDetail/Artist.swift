//
//  Artist.swift
//
//
//  Created by Aritra on 23/12/25.
//
import CommonModels
import Foundation

struct Artist: Codable {
    let name: String
    let birthDate: Date
    let songs: [Song]
}
