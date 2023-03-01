var alive = false
var mapRepeating = false

//one in chance
var chance = 5

//how many times the program evolves 
var cycles = 25

var arrayWidth = 10
var arrayHeight = 10
var arrayTime = 0

var time = 0

var arrayX = 0
var arrayY = 0

var plantSeed = 0
var valueToPrint = 0
var neighborCount = 0

var valueToTranslate = 0
var repeatingCells = 0

var valueRandomizer = Int()

var valueMap = Array(repeating: Array(repeating: 0, count: arrayWidth), count: arrayHeight)
var newMap = Array(repeating: Array(repeating: 0, count: arrayWidth), count: arrayHeight)
var repetitionMap = Array(repeating: Array(repeating: 2, count: arrayWidth), count: arrayHeight)

func randomizeValues() {
    arrayX = 0
    arrayY = 0

    for _ in 1 ... arrayHeight {
        arrayX = 0
        for _ in 1 ... arrayWidth {
            let plantSeed = Int.random(in: 1 ... chance)

            if plantSeed == 1 {
                //print("T")
                valueMap[arrayY][arrayX] = 1
            } else {
                //print("F")
                valueMap[arrayY][arrayX] = 0
            }

            arrayX += 1
        }

        arrayY += 1
    }
}

func printToScreen() {
    arrayX = 0
    arrayY = 0
    
    for _ in 1 ... arrayHeight {
        print("")
        
        for _ in 1 ... arrayWidth {  
            let valueToPrint = valueMap[arrayY][arrayX]

            if valueToPrint == 0 {
                print("⬛", terminator: "")
                
            } else if valueToPrint == 1 {
                print("⬜", terminator: "")
            }
            
            //print(valueToPrint, terminator: "")
            arrayX = arrayX + 1
        }
        
        arrayX = 0
        arrayY = arrayY + 1
    }
}

func checkForRepetition() {
    arrayX = 0
    arrayY = 0
    repeatingCells = 0

    mapRepeating = false

    for _ in 1 ... arrayHeight {
        arrayX = 0

        for _ in 1 ... arrayWidth {
            valueToTranslate = newMap[arrayY][arrayX]

            if valueToTranslate == repetitionMap[arrayY][arrayX] {
                repeatingCells += 1
            }
            
            repetitionMap[arrayY][arrayX] = valueToTranslate

            arrayX += 1
        }
        
        arrayY += 1
    }

    //print(repeatingCells)
    
    if repeatingCells == arrayWidth * arrayHeight {
        mapRepeating = true
    }
}

func checkIfAlive() {
    alive = false

    arrayX = 0
    arrayY = 0
    
    for _ in 1 ... arrayHeight {
        arrayX = 0
        for _ in 1 ... arrayWidth {
            if valueMap[arrayY][arrayX] == 1 {
                alive = true
                break
            }
            
            arrayX += 1
        }

        arrayY += 1
    } 


    if alive == true {
        //print("\nAlive!")
    } else {
        //print("\nDead")
    }
}

func checkSide(xSide: Int, ySide: Int) {
    
    if valueMap[arrayY + ySide][arrayX + xSide] == 1 {
        neighborCount += 1       
    } 
}

func checkNeighbors(sideCode: Int) {
    
    if sideCode == 1 {
        checkSide(xSide: -1, ySide: -1)
        checkSide(xSide: -1, ySide: 0)
        checkSide(xSide: -1, ySide: 1)
        
        checkSide(xSide: 0, ySide: -1)
        checkSide(xSide: 0, ySide: 1)
            
        checkSide(xSide: 1, ySide: -1)
        checkSide(xSide: 1, ySide: 0)
        checkSide(xSide: 1, ySide: 1)

    } else if sideCode == 2 {
        checkSide(xSide: 0, ySide: -1)
        checkSide(xSide: 0, ySide: 1)

        checkSide(xSide: -1, ySide: -1)
        checkSide(xSide: -1, ySide: 0)
        checkSide(xSide: -1, ySide: 1)

    } else if sideCode == 3 {
        checkSide(xSide: 0, ySide: -1)
        checkSide(xSide: 0, ySide: 1)

        checkSide(xSide: 1, ySide: -1)
        checkSide(xSide: 1, ySide: 0)
        checkSide(xSide: 1, ySide: 1)

    } else if sideCode == 4 {
        checkSide(xSide: -1, ySide: 0)
        checkSide(xSide: -1, ySide: -1)

        checkSide(xSide: 0, ySide: -1)

        checkSide(xSide: 1, ySide: 0)
        checkSide(xSide: 1, ySide: -1)
        
    } else if sideCode == 5 {
        checkSide(xSide: -1, ySide: 0)
        checkSide(xSide: -1, ySide: 1)

        checkSide(xSide: 0, ySide: 1)

        checkSide(xSide: 1, ySide: 0)
        checkSide(xSide: 1, ySide: 1)
        
    } else if sideCode == 6 {
        checkSide(xSide: 0, ySide: 1)
        
        checkSide(xSide: 1, ySide: 0)
        checkSide(xSide: 1, ySide: 1)
        
    } else if sideCode == 7 {
        checkSide(xSide: -1, ySide: 0)
        checkSide(xSide: -1, ySide: 1)

        checkSide(xSide: 0, ySide: 1)
        
    } else if sideCode == 8 {
        checkSide(xSide: -1, ySide: -1)
        checkSide(xSide: -1, ySide: 0)

        checkSide(xSide: 0, ySide: -1)
        
    } else if sideCode == 9 {
        checkSide(xSide: 0, ySide: -1)

        checkSide(xSide: 1, ySide: -1)
        checkSide(xSide: 1, ySide: 0)
    }
}

func evolve() {
    arrayX = 0
    arrayY = 0
    
    for _ in 1 ... arrayHeight {
        arrayX = 0
        
        for _ in 1 ... arrayWidth {
            neighborCount = 0

            //find neighborCount
            if arrayY - 1 < 0 {
                if arrayX - 1 < 0 {
                    checkNeighbors(sideCode: 6)
                } else if arrayX + 1 == arrayWidth {
                    checkNeighbors(sideCode: 7)
                } else {
                    checkNeighbors(sideCode: 5)
                }
                
            } else if arrayY + 1 == arrayHeight {
                if arrayX - 1 < 0 {
                    checkNeighbors(sideCode: 9)
                } else if arrayX + 1 == arrayWidth {
                    checkNeighbors(sideCode: 8)
                } else {
                    checkNeighbors(sideCode: 4)
                }  
                
            } else {
                if arrayX - 1 < 0 {
                    checkNeighbors(sideCode: 3)
                } else if arrayX + 1 == arrayWidth {
                    checkNeighbors(sideCode: 2)
                } else {
                    checkNeighbors(sideCode: 1)
                }
            }

            //evolve cell to newMap array
            if valueMap[arrayY][arrayX] == 1 {
                if neighborCount < 2 {
                    newMap[arrayY][arrayX] = 0
                } else if neighborCount > 3 {
                    newMap[arrayY][arrayX] = 0
                } else{
                    newMap[arrayY][arrayX] = 1
                }
            } else if valueMap[arrayY][arrayX] == 0 {
                if neighborCount == 3 {
                    newMap[arrayY][arrayX] = 1
                } else {
                    newMap[arrayY][arrayX] = 0
                }
            }
            
            arrayX += 1
        }

        arrayY += 1
    }
}

func translateArray() {
    arrayX = 0
    arrayY = 0

    for _ in 1 ... arrayHeight {
        arrayX = 0

        for _ in 1 ... arrayWidth {
            valueToTranslate = newMap[arrayY][arrayX]
            valueMap[arrayY][arrayX] = valueToTranslate

            arrayX += 1
        }
        
        arrayY += 1
    }
}

randomizeValues()
checkIfAlive()

while mapRepeating == false &&  alive == true && time < 100{
    //print("\u{001B}[2J")
    printToScreen()
    print("")
    evolve()
    checkIfAlive()
    checkForRepetition()
    translateArray()
    time += 1
}
