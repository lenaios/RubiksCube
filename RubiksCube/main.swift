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
print("무작위 섞기는 Z를 입력해주세요.")

// 무작위 섞기를 위한 딕셔너리
let dict: [UInt32: String] = [0: "F", 1: "F'", 2: "R", 3: "R'", 4: "U", 5: "U'",
            6: "B", 7: "B'", 8: "L", 9: "L", 10: "D", 11: "D'"]

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
        print("이용해주셔서 감사합니다. 뚜뚜뚜.")
        break
    }
    
    if input == "Z" {
        print("무작위로 섞기")
        random()
    } else {
        // 입력값에 따라 큐브 맞추기
        let arr = format(input: input)
        moves += arr.count
        for dir in arr {
            print(dir) // 방향 출력
            cubing(direction: dir)
            printCube() // 결과 출력
        }
        // check cube match
        if checkCube() {
            let end = Date()
            
            // 소요 시간 계산
            let timeInterval = end.timeIntervalSince(start)
            let min: Int = Int(timeInterval / 60)
            let sec: Int = Int(timeInterval.truncatingRemainder(dividingBy: 60))
            
            let time = String(format: "%02d:%02d", min, sec) // 두자리 수로 표현
            print("경과시간: \(time)")
            print("조작갯수: \(moves)")
            print("축하합니다! 프로그램을 종료합니다.")
            break
        }
    }
}

func checkCube() -> Bool {
    for row in side1 {
        if row != ["B", "B", "B"] {
            return false
        }
    }
    
    for row in side2 {
        if row != ["W", "W", "W"] {
            return false
        }
    }
    
    for row in side3 {
        if row != ["O", "O", "O"] {
            return false
        }
    }
    
    for row in side4 {
        if row != ["G", "G", "G"] {
            return false
        }
    }
    
    for row in side5 {
        if row != ["Y", "Y", "Y"] {
            return false
        }
    }
    
    for row in side6 {
        if row != ["R", "R", "R"] {
            return false
        }
    }
    return true
}

func cubing(direction: String) {
    switch direction {
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
        print("방향키는 F, F', R, R', U, U', B, B', L, L', D, D'만 가능합니다.")
        moves -= 1 // 방향키가 아닌 경우 조작 개수에서 제외
    }
}

func random() {
    for _ in 0..<5 { // 무작위로 5번 섞기
        let randomNumber = arc4random_uniform(12)
        if let randomString = dict[randomNumber] {
            cubing(direction: randomString)
        }
    }
    printCube() // 결과 출력
}

// readLine 함수 호출
func input() -> String? {
    print("CUBE> ", terminator: "")
    return readLine()
}

// 입력받은 문자열 배열로 리턴
func format(input: String) -> [String] { // FRR'U2R
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
        } else if str == "2" { // double turn
            if let index = arr.firstIndex(of: str) {
                arr[index] = arr[index-1]
            }
        }
    }
  
    return arr
}

func turnF() {
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
}

func turnR() {
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
}

func turnU() {
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
}

func turnB() {
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
}

func turnL() {
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
}

func turnD() {
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
}

func reverseF() {
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
}

func reverseR() {
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
}

func reverseU() {
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
}

func reverseB() {
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
}

func reverseL() {
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
}

func reverseD() {
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
}

func printCube() -> Void {
    print()
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
    print()
}

