# Step 2
## Mission
1. 처음 시작하면 초기 상태를 출력한다.
2. 간단한 프롬프트 (CLI에서 키보드 입력받기 전에 표시해주는 간단한 글자들 - 예: CUBE> )를 표시해 준다.
3. 한 번에 여러 문자를 입력받은 경우 순서대로 처리해서 매 과정을 화면에 출력한다.  

## Solution
cube를 출력하기 위한 `printCube()` 함수를 구현합니다.
```swift
var cube: [[Character]] = [["R", "R", "W"], ["G", "C", "W"], ["G", "B", "B"]]
printCube()

func printCube() -> Void {
    for row in cube {
        print(row[0], row[1], row[2])
    }
}
```

프롬프트`cube> ` 표시와 함께 입력값을 받는 `input()` 함수를 구현합니다.  
```swift
func input() -> String? {
    print("CUBE> ", terminator: "")
    return readLine()
}
```
입력받은 값이 `Q`일 때 프로그램을 종료하고, 이외에는 `cubing(input:)` 함수를 호출해서 평면 큐브를 맞춥니다.
```swift
while(true) {
    print()
    guard let input = input()?.uppercased(), input != "Q" else {
        print("Bye~")
        break
    }
    cubing(input: format(input: input))
}
```
`'`를 포함하는 입력값 처리를 위해 `format(input:)` 함수를 구현합니다.  
```swift
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
```
사용자 입력에 따라 큐브 배열을 변경하는 `cubing(input:)` 함수를 구현합니다.  
```swift
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
```
