//
//  main.swift
//  RubiksCube
//
//  Created by Ador on 2020/12/11.
//

import Foundation

var side1: [[Character]] = [["B", "B", "B"], ["B", "B", "B"], ["B", "B", "B"]]
var side2: [[Character]] = [["W", "W", "W"], ["W", "W", "W"], ["W", "W", "W"]]
var side3: [[Character]] = [["O", "O", "O"], ["O", "O", "O"], ["O", "O", "O"]]
var side4: [[Character]] = [["G", "G", "G"], ["G", "G", "G"], ["G", "G", "G"]]
var side5: [[Character]] = [["Y", "Y", "Y"], ["Y", "Y", "Y"], ["Y", "Y", "Y"]]
var side6: [[Character]] = [["R", "R", "R"], ["R", "R", "R"], ["R", "R", "R"]]
printCube()

// 조작 횟수
var moves = 0

// 시작 시간
let start = Date()

while(true) {
    guard let input = input()?.uppercased(), input != "Q" else {
        let end = Date()
        
        // 소요 시간 계산
        let timeInterval = end.timeIntervalSince(start)
        let min: Int = Int(timeInterval / 60)
        let sec: Int = Int(timeInterval.truncatingRemainder(dividingBy: 60))
        
        let time = String(format: "%02d:%02d", min, sec) // 두자리 수로 표현
        print("경과시간: \(time)")
        print("조작갯수: \(moves)")
        break
    }
    
    // 입력값에 따라 큐브 맞추기
    let arr = format(input: input)
    moves += arr.count
    for dir in arr {
        switch dir {
        case "F":
            turnF()
        case "F'":
            reverseF()
        case "R":
            turnR()
        case "R'":
            reverseR()
        case "U":
            turnU()
        case "U'":
            reverseU()
        case "B":
            turnB()
        case "B'":
            reverseB()
        case "L":
            turnL()
        case "L'":
            reverseL()
        case "D":
            turnD()
        case "D'":
            reverseD()
        default:
            print("잘못 입력하셨습니다 :(")
        }
    }
}

// readLine 함수 호출
func input() -> String? {
    print("CUBE> ", terminator: "")
    return readLine()
}

// 입력받은 문자열 배열로 리턴
func format(input: String) -> [String] { // uu'r
    var arr = [String]()
    for char in input {
        arr.append(String(char))
    }
    
    for str in arr {
        if str == "'" { // '를 만나면
            if let index = arr.firstIndex(of: str) {
                arr[index-1] = arr[index-1] + "'" // 그 앞 인덱스에 ' 붙여주고
                arr.remove(at: index) // ' 문자는 배열에서 삭제
            }
        }
    }
  
    return arr
}

func turnF() -> Void {
    print("F")
    let temp0 = side2[0][2]
    let temp1 = side2[1][2]
    let temp2 = side2[2][2]
    
    side2[0][2] = side6[0][0]
    side2[1][2] = side6[0][1]
    side2[2][2] = side6[0][2]
    
    side6[0][0] = side4[2][0]
    side6[0][1] = side4[1][0]
    side6[0][2] = side4[0][0]
    
    side4[0][0] = side1[2][0]
    side4[1][0] = side1[2][1]
    side4[2][0] = side1[2][2]
    
    side1[2][0] = temp2
    side1[2][1] = temp1
    side1[2][2] = temp0
    printCube()
}

func turnR() {
    print("R")
    let temp0 = side3[0][2]
    let temp1 = side3[1][2]
    let temp2 = side3[2][2]
    
    side3[0][2] = side6[0][2]
    side3[1][2] = side6[1][2]
    side3[2][2] = side6[2][2]
    
    side6[0][2] = side5[2][0]
    side6[1][2] = side5[1][0]
    side6[2][2] = side5[0][0]
    
    side5[0][0] = side1[2][2]
    side5[1][0] = side1[1][2]
    side5[2][0] = side1[0][2]
    
    side1[0][2] = temp0
    side1[1][2] = temp1
    side1[2][2] = temp2
    printCube()
}

func turnU() {
    print("U")
    let temp0 = side3[0][0]
    let temp1 = side3[0][1]
    let temp2 = side3[0][2]
    
    side3[0][0] = side4[0][0]
    side3[0][1] = side4[0][1]
    side3[0][2] = side4[0][2]
    
    side4[0][0] = side5[0][0]
    side4[0][1] = side5[0][1]
    side4[0][2] = side5[0][2]
    
    side5[0][0] = side2[0][0]
    side5[0][1] = side2[0][1]
    side5[0][2] = side2[0][2]
    
    side2[0][0] = temp0
    side2[0][1] = temp1
    side2[0][2] = temp2
    printCube()
}

func turnB() {
    print("B")
    let temp0 = side4[0][2]
    let temp1 = side4[1][2]
    let temp2 = side4[2][2]
    
    side4[0][2] = side6[2][2]
    side4[1][2] = side6[2][1]
    side4[2][2] = side6[2][0]
    
    side6[2][0] = side2[0][0]
    side6[2][1] = side2[1][0]
    side6[2][2] = side2[2][0]
    
    side2[0][0] = side1[0][2]
    side2[1][0] = side1[0][1]
    side2[2][0] = side1[0][0]
    
    side1[0][0] = temp0
    side1[0][1] = temp1
    side1[0][2] = temp2
    printCube()
}

func turnL() {
    print("L")
    let temp0 = side3[0][0]
    let temp1 = side3[1][0]
    let temp2 = side3[2][0]
    
    side3[0][0] = side1[0][0]
    side3[1][0] = side1[1][0]
    side3[2][0] = side1[2][0]
    
    side1[0][0] = side5[2][2]
    side1[1][0] = side5[1][2]
    side1[2][0] = side5[0][2]
    
    side5[0][2] = side6[2][0]
    side5[1][2] = side6[1][0]
    side5[2][2] = side6[0][0]
    
    side6[0][0] = temp0
    side6[1][0] = temp1
    side6[2][0] = temp2
    printCube()
}

func turnD() {
    print("D")
    let temp0 = side3[2][0]
    let temp1 = side3[2][1]
    let temp2 = side3[2][2]
    
    side3[2][0] = side2[2][0]
    side3[2][1] = side2[2][1]
    side3[2][2] = side2[2][2]
    
    side2[2][0] = side5[2][0]
    side2[2][1] = side5[2][1]
    side2[2][2] = side5[2][2]
    
    side5[2][0] = side4[2][0]
    side5[2][1] = side4[2][1]
    side5[2][2] = side4[2][2]
    
    side4[2][0] = temp0
    side4[2][1] = temp1
    side4[2][2] = temp2
    printCube()
}

func reverseF() -> Void {
    print("F'")
    let temp0 = side2[0][2]
    let temp1 = side2[1][2]
    let temp2 = side2[2][2]
    
    side2[0][2] = side1[2][2]
    side2[1][2] = side1[2][1]
    side2[2][2] = side1[2][0]
    
    side1[2][0] = side4[0][0]
    side1[2][1] = side4[1][0]
    side1[2][2] = side4[2][0]
    
    side4[0][0] = side6[0][2]
    side4[1][0] = side6[0][1]
    side4[2][0] = side6[0][0]
    
    side6[0][0] = temp0
    side6[0][1] = temp1
    side6[0][2] = temp2
    printCube()
}

func reverseR() {
    print("R'")
    let temp0 = side3[0][2]
    let temp1 = side3[1][2]
    let temp2 = side3[2][2]
    
    side3[0][2] = side1[0][2]
    side3[1][2] = side1[1][2]
    side3[2][2] = side1[2][2]
    
    side1[0][2] = side5[2][0]
    side1[1][2] = side5[1][0]
    side1[2][2] = side5[0][0]
    
    side5[2][0] = side6[0][2]
    side5[1][0] = side6[1][2]
    side5[0][0] = side6[2][2]
    
    side6[0][2] = temp0
    side6[1][2] = temp1
    side6[2][2] = temp2
    printCube()
}

func reverseU() {
    print("U'")
    let temp0 = side3[0][0]
    let temp1 = side3[0][1]
    let temp2 = side3[0][2]
    
    side3[0][0] = side2[0][0]
    side3[0][1] = side2[0][1]
    side3[0][2] = side2[0][2]
    
    side2[0][0] = side5[0][0]
    side2[0][1] = side5[0][1]
    side2[0][2] = side5[0][2]
    
    side5[0][0] = side4[0][0]
    side5[0][1] = side4[0][1]
    side5[0][2] = side4[0][2]
    
    side4[0][0] = temp0
    side4[0][1] = temp1
    side4[0][2] = temp2
    printCube()
}

func reverseB() {
    print("B'")
    let temp0 = side4[0][2]
    let temp1 = side4[1][2]
    let temp2 = side4[2][2]
    
    side4[0][2] = side1[0][0]
    side4[1][2] = side1[0][1]
    side4[2][2] = side1[0][2]
    
    side1[0][0] = side2[2][0]
    side1[0][1] = side2[1][0]
    side1[0][2] = side2[0][0]
    
    side2[0][0] = side6[2][0]
    side2[1][0] = side6[2][1]
    side2[2][0] = side6[2][2]
    
    side6[2][0] = temp2
    side6[2][1] = temp1
    side6[2][2] = temp0
    printCube()
}

func reverseL() {
    print("L'")
    let temp0 = side3[0][0]
    let temp1 = side3[1][0]
    let temp2 = side3[2][0]
    
    side3[0][0] = side6[0][0]
    side3[1][0] = side6[1][0]
    side3[2][0] = side6[2][0]
    
    side6[0][0] = side5[2][2]
    side6[1][0] = side5[1][2]
    side6[2][0] = side5[0][2]
    
    side5[0][2] = side1[2][0]
    side5[1][2] = side1[1][0]
    side5[2][2] = side1[0][0]
    
    side1[0][0] = temp0
    side1[1][0] = temp1
    side1[2][0] = temp2
    printCube()
}

func reverseD() {
    print("D'")
    let temp0 = side3[2][0]
    let temp1 = side3[2][1]
    let temp2 = side3[2][2]
    
    side3[2][0] = side4[2][0]
    side3[2][1] = side4[2][1]
    side3[2][2] = side4[2][2]
    
    side4[2][0] = side5[2][0]
    side4[2][1] = side5[2][1]
    side4[2][2] = side5[2][2]
    
    side5[2][0] = side2[2][0]
    side5[2][1] = side2[2][1]
    side5[2][2] = side2[2][2]
    
    side2[2][0] = temp0
    side2[2][1] = temp1
    side2[2][2] = temp2
    printCube()
}

func printCube() -> Void {

    // side1 출력
    for row in side1 {
        print("\t\t\t", terminator: " ")
        for char in row {
            print(char, terminator: " ")
        }
        print()
    }
    print()
    
    // side 2 ~ 5 출력
    for index in 0..<3 {
        for char in side2[index] {
            print(char, terminator: " ")
        }
        print("\t", terminator: " ")
        
        for char in side3[index] {
            print(char, terminator: " ")
        }
        print("\t", terminator: " ")
        
        for char in side4[index] {
            print(char, terminator: " ")
        }
        print("\t", terminator: " ")
        
        for char in side5[index] {
            print(char, terminator: " ")
        }
        print()
    }
    print()
    
    // side 6 출력
    for row in side6 {
        print("\t\t\t", terminator: " ")
        for char in row {
            print(char, terminator: " ")
        }
        print()
    }
}

