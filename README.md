# Step 1

## Mission
1. 입력: 사용자로부터 단어 하나, 정수 숫자 하나( -100 <= N < 100) , L 또는 R을 입력받는다. L 또는 R은 대소문자 모두 입력 가능하다.  
2. 주어진 단어를 L이면 주어진 숫자 갯수만큼 왼쪽으로, R이면 오른쪽으로 밀어낸다. 
3. 밀려나간 단어는 반대쪽으로 채워진다.  

## Solution
`readLine()` 함수로 입력값을 받습니다.
```swift
if let input = readLine() {
    print(input)
}
```
입력받은 단어`word`, 숫자`number`, 방향`leftOrRight`을 스페이스 공백 하나로 분리해서 배열에 저장합니다.  
숫자`number`는 `Int형으로 casting 합니다.
```swift
var word: String
var number: Int = 0
var leftOrRight: String

let arr = input.components(separatedBy: " ")
word = arr[0]
leftOrRight = arr[2].lowercased()
if let inputNumber = Int(arr[1]) {
    number = inputNumber
}
```
숫자가 음수면 반대 방향으로 밀어야 하므로 조건문을 추가합니다.
```swift
// 음수는 반대 방향
if number < 0 {
    number = -number
    if leftOrRight == "l" {
        leftOrRight = "r"
    } else {
        leftOrRight = "l"
    }
}
```
L(l)이면 첫 번째 인덱스의 문자를 제거해서 마지막 인덱스에 insert 합니다.  
R(r)이면 마지막 인덱스의 문자를 제거하고 첫 번째 인덱스에 insert 합니다.  
```swift
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
```
단어의 길이만큼 반복되는 경우는 연산에서 제외합니다.
```swift
// 반복되는 경우 제외
number = number % word.count
```
