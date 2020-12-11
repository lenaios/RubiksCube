//
//  main.swift
//  RubiksCube
//
//  Created by Ador on 2020/12/11.
//

import Foundation

var cube: [[Character]] = [["R", "R", "W"], ["G", "C", "W"], ["G", "B", "B"]]
printCube()

func input() -> String? {
    print("CUBE> ", terminator: "")
    return readLine()
}

while(true) {
    print()
    guard let input = input()?.uppercased(), input != "Q" else {
        print("Bye~")
        break
    }
    cubing(input: format(input: input))
}

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

func cubing(input: [String]) -> Void {
    print()
    for str in input {
        switch str {
        case "U":
            print("U")
            // 가장 윗줄 왼쪽으로 밀기
            let temp = cube[0][0]
            cube[0][0] = cube[0][1]
            cube[0][1] = cube[0][2]
            cube[0][2] = temp
            printCube()
        case "U'":
            // 가장 윗줄 오른쪽으로 밀기
            print("U'")
            let temp = cube[0][2]
            cube[0][2] = cube[0][1]
            cube[0][1] = cube[0][0]
            cube[0][0] = temp
            printCube()
        case "R":
            // 가장 오른쪽줄 위로 밀기
            print("R")
            let temp = cube[0][2]
            cube[0][2] = cube[1][2]
            cube[1][2] = cube[2][2]
            cube[2][2] = temp
            printCube()
        case "R'":
            // 가장 오른쪽줄 아래로 밀기
            print("R'")
            let temp = cube[2][2]
            cube[2][2] = cube[1][2]
            cube[1][2] = cube[0][2]
            cube[0][2] = temp
            printCube()
        case "L":
            // 가장 왼쪽줄 아래로 밀기
            print("L")
            let temp = cube[2][0]
            cube[2][0] = cube[1][0]
            cube[1][0] = cube[0][0]
            cube[0][0] = temp
            printCube()
        case "L'":
            // 가장 왼쪽줄 위로 밀기
            print("L'")
            let temp = cube[0][0]
            cube[0][0] = cube[1][0]
            cube[1][0] = cube[2][0]
            cube[2][0] = temp
            printCube()
        case "B":
            // 가장 아랫줄 오른쪽으로 밀기
            print("B")
            let temp = cube[2][2]
            cube[2][2] = cube[2][1]
            cube[2][1] = cube[2][0]
            cube[2][0] = temp
            printCube()
        case "B'":
            // 가장 아랫줄 왼쪽으로 밀기
            print("B'")
            let temp = cube[2][0]
            cube[2][0] = cube[2][1]
            cube[2][1] = cube[2][2]
            cube[2][2] = temp
            printCube()
        default:
            print("잘못 누르셨습니다 :(")
        }
    }
}

func printCube() -> Void {
    for row in cube {
        print(row[0], row[1], row[2])
    }
    
}

