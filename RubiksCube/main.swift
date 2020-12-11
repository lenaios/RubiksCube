//
//  main.swift
//  RubiksCube
//
//  Created by Ador on 2020/12/11.
//

import Foundation

if let input = readLine() {
    var word: String
    var number: Int = 0
    var leftOrRight: String
    
    let arr = input.components(separatedBy: " ")
    word = arr[0]
    leftOrRight = arr[2].lowercased()
    if let inputNumber = Int(arr[1]) {
        number = inputNumber
    }
    
    // 음수는 반대 방향
    if number < 0 {
        number = -number
        if leftOrRight == "l" {
            leftOrRight = "r"
        } else {
            leftOrRight = "l"
        }
    }
    
    // 반복되는 경우 제외
    number = number % word.count
    
    // 단어 밀어내기
    if leftOrRight == "l" {
        for _ in 0..<number {
            let removed = word.remove(at: word.startIndex)
            word.insert(removed, at: word.endIndex)
        }
    }
    
    if leftOrRight == "r" {
        for _ in 0..<number {
            let removed = word.remove(at: word.index(before: word.endIndex))
            word.insert(removed, at: word.startIndex)
        }
    }
    print(word)
}

