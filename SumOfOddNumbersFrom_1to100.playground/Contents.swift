import UIKit

//*** main ***
func oddSum(startFrom:Int,endAt:Int) -> Int{
    
    var sum = 0

    if startFrom > endAt {
        print("Sorry, the startFrom should smaller than the endAt.")
        return 0
    }else{
        for i in startFrom...endAt{
            if i % 2 != 0{
                sum = sum + i
            }
        }
    }
    return sum
}

//*** test ***
oddSum(startFrom: 0, endAt: 0)
oddSum(startFrom: 0, endAt: 1)
oddSum(startFrom: 3, endAt: 0) // other
oddSum(startFrom: 1, endAt: 5)
oddSum(startFrom: 0, endAt: 10)
oddSum(startFrom: 0, endAt: 100)
oddSum(startFrom: 0, endAt: 99)
oddSum(startFrom: 1, endAt: 99)
oddSum(startFrom: 0, endAt: 101)