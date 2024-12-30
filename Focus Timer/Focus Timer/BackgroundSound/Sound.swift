//
//  Sound.swift
//  Focus Timer
//
//  Created by CANSU ARAR on 27.12.2024.
//

import Foundation

struct Sound {
    let name: String
    let fileType: String

    static let allSounds: [Sound] = [
        Sound(name: "Close", fileType: ""),
        Sound(name: "Rain", fileType: "mp3"),
        Sound(name: "Bird",  fileType: "mp3"),
        Sound(name: "Library",  fileType: "mp3"),
        Sound(name: "Cafe",  fileType: "mp3"),
        Sound(name: "Ocean",  fileType: "mp3")
    ]
}







