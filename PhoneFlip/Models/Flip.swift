//
//  Flip.swift
//  PhoneFlip
//
//  Created by Talmage Sharp on 4/5/24.
//

import Foundation

struct FlipThreshold {
    let min: [Int]
    let max: [Int]
}

enum Flip: String, CaseIterable, Identifiable {
    case notSet, kickflip, heelflip, threeSixty, reverseThreeSixty, full, inverseFull
    
    var id: Self {self}
    
    var displayName: String {
        switch self{
        case .notSet: return "Do A Flip"
        case .kickflip: return "Kickflip"
        case .heelflip: return "Heelfip"
        case .threeSixty: return "360"
        case .reverseThreeSixty: return "Reverse 360"
        case .full: return "Full"
        case .inverseFull: return "Inverse Full"
        }
    }
    
    var description: String {
        switch self{
        case .notSet: return "EXCLUDE THIS ONE!"
        case .kickflip: return "Flip your phone in a kickflip like way to the right. Flip it on the long side"
        case .heelflip: return "Flip your phone in a kickflip like way to the left. Flip it on the long side"
        case .threeSixty: return "Rotate your phone 360 degrees clockwise."
        case .reverseThreeSixty: return "Rotate your phone 360 degrees counter-clockwise"
        case .full: return "This is a 360 + a heelflip. Flip the phone while spinning it. Push the top right corner towards you."
        case .inverseFull: return "This is a 360 + a kickflip. Flip the phone inwards with your thumb on the bottom right corner."
        }
    }
    
    var score: Int{
        switch self{
        case .notSet: return 0
        case .kickflip: return 25
        case .heelflip: return 50
        case .threeSixty: return 25
        case .reverseThreeSixty: return 50
        case .full: return 75
        case .inverseFull: return 100
        }
    }
    
    var thresholds: FlipThreshold {
        switch self {
        case .notSet:
            return FlipThreshold(min: [Int.min, Int.min, Int.min], max: [Int.max, Int.max, Int.max])
        case .kickflip:
            return FlipThreshold(min: [Int.min, Int.min, Int.min], max: [Int.max, 600, Int.max])
        case .heelflip:
            return FlipThreshold(min: [Int.min, -250, Int.min], max: [Int.max, Int.max, Int.max])
        case .threeSixty:
            return FlipThreshold(min: [Int.min, Int.min, -250], max: [Int.max, Int.max, Int.max])
        case .reverseThreeSixty:
            return FlipThreshold(min: [Int.min, Int.min, Int.min], max: [Int.max, Int.max, 400])
        case .full:
            return FlipThreshold(min: [Int.min, -300, Int.min], max: [100, Int.max, 100])
        case .inverseFull:
            return FlipThreshold(min: [Int.min, Int.min, Int.min], max: [100, 600, 100])
        }
    }
    
    func WhatTrick(max: [Int], min: [Int]) -> Flip {
        print("Checking Flip with min \(min) and max \(max)")
        if(min[1] < -300 && max[0] > 100 /*&& max[2] > 100*/){
            return .full
        } else if(max[1] > 600 && max[0] > 100 && max[2] > 100){
            return .inverseFull
        } else if (max[1] >  600){
            return .kickflip
        } else if (min[1] < -250){
            return.heelflip
        } else if(max[2] > 400){
            return .reverseThreeSixty
        } else if(min[2] < -210){
            return .threeSixty
        } else {
            return .notSet
        }
        /*
        let allFlips = Flip.allCases
        for flip in allFlips {
            let thresholds = flip.thresholds
            if min[1] < thresholds.min[1] && max[0] > thresholds.max[0] && max[2] > thresholds.max[2] {
                print("Detected flip: \(flip.displayName)")
                return flip
            } else {
                print("This was not a \(flip.displayName) because it doesnt match \(thresholds)")
            }
        }
        return .notSet
         */
    }
}
