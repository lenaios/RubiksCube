

# Step 3
## Mission
- 참고 링크를 참고해서 루빅스 큐브를 구현한다.
- 큐브는 W, B, G, Y, O, R의 6가지 색깔을 가지고 있다.
- 입력: 각 조작법을 한 줄로 입력받는다.
- 출력: 큐브의 6면을 펼친 상태로 출력한다.
- Q를 입력받으면 프로그램을 종료하고, 조작 받은 명령의 갯수를 출력시킨다.    
- 프로그램 종료 시 경과 시간 출력
- 큐브의 무작위 섞기 기능
- 모든 면을 맞추면 축하 메시지와 함께 프로그램을 자동 종료
## Solution
큐브의 6면을 펼친 상태로 출력하기 위한 `printCube()` 함수를 구현합니다.  
출력할 큐브 면을 순서대로 side1, side2, side3, side4, side5, side6 배열로 선언해주고, 순차적으로 출력합니다.  
```swift
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
```
입력값이 `"Q"`일 경우 프로그램을 종료하고, 그렇지 않을 경우 입력값에 따라 큐브를 맞추는 함수를 호출합니다.  
```swift
while(true) {
    guard let input = input()?.uppercased(), input != "Q" else {
        // ...
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
    }
}
```
입력값으로 받은 조작 방향 중 반대 방향 `'`과 더블 턴 `2`의 문자열 처리를 위해 `format(input:)` 함수를 구현합니다.  
`FRR'U2R`를 입력받으면 `["F", "R", "R'", "U", "U", "R"]` 문자열 배열을 리턴합니다.  
```swift
// 입력받은 문자열 배열로 리턴
func format(input: String) -> [String] {
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
```
`format(input:)` 함수가 리턴한 문자열 배열을 `for`문으로 돌면서 해당 방향으로 `cubing(direction:)` 함수를 호출합니다.  
```swift
// 입력값에 따라 큐브 맞추기
let arr = format(input: input)
moves += arr.count
for dir in arr {
    print(dir) // 방향 출력
    cubing(direction: dir)
    printCube() // 결과 출력
```
조작 방향에 따라 큐브를 맞추는 `cubing(direction:)` 함수는 `switch`문을 이용해서 구현합니다.  
```swift
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
        print("방향키는 F, F', R, R', U, U', B, B', L, L', D, D', Z(무작위)만 가능합니다.")
    }
}
```
`turnF()`, `turnR()`, `turnU()`, `turnB()`, `turnL()`, `turnD()`, `reverseF()`, `reverseR()`, `reverseU()`, `reverseB()`, `reverseL()`, `reverseD()` 함수는 방향에 따라 이차원 배열의 값을 변경합니다.  
```swift
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

// ...

```
`Z`를 입력받으면 큐브를 무작위로 섞는 `random()` 함수를 호출합니다.  
`random()` 함수는 `arc4random_uniform()` 함수를 사용해서 랜덤한 방향으로 5번 큐브를 돌립니다.  
```swift
// 무작위 섞기를 위한 딕셔너리
let dict: [UInt32: String] = [0: "F", 1: "F'", 2: "R", 3: "R'", 4: "U", 5: "U'",
            6: "B", 7: "B'", 8: "L", 9: "L", 10: "D", 11: "D'"]
            
func random() {
    for _ in 0..<5 { // 무작위로 5번 섞기
        let randomNumber = arc4random_uniform(12)
        if let randomString = dict[randomNumber] {
            cubing(direction: randomString)
        }
    }
    printCube() // 결과 출력
}
```
큐브의 모든 면을 맞췄는지 체크하는 `checkCube()` 함수를 구현합니다.  
모든 면을 맞췄을 때 `true`를 리턴하고, 그렇지 않으면 `false`를 리턴합니다.  
```swift
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
```
프로그램의 소요시간과 조작 개수를 출력하는 `printPlayTimeAndMoves()`를 구현합니다.  
조작 개수는 입력 문자열의 개수를 더해서 구하고, 방향키가 아닌 값이 입력될 경우에는 개수를 차감합니다.  
`moves += arr.count`
```swift
let start = Date()

func printPlayTimeAndMoves() {
    let end = Date()
    
    // 소요 시간 계산
    let timeInterval = end.timeIntervalSince(start)
    let min: Int = Int(timeInterval / 60)
    let sec: Int = Int(timeInterval.truncatingRemainder(dividingBy: 60))
    
    let time = String(format: "%02d:%02d", min, sec) // 두자리 수로 표현
    print("경과시간: \(time)")
    print("조작갯수: \(moves)")
}
```
