//: Playground - noun: a place where people can play

var numbers = [4,3,2,1]

let mappedNumbers = numbers.map({ number in 3 * number })

println(mappedNumbers)

let sortedNumbers = sorted(numbers) { $1 > $0 }

println(sortedNumbers)
