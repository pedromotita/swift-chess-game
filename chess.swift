import Foundation

extension String {
    func parseToPoint() -> Point {
        let coordenates = self.components(separatedBy: " ").map { Int($0)! }
        return Point(x: coordenates[1], y: coordenates[0])
    }
}

func getHorizontalDistance(_ a: Point, _ b: Point) -> Int {
    return abs(a.x - b.x)
}

func getVerticalDistance(_ a: Point, _ b: Point) -> Int {
    return abs(a.y - b.y)
}

func getManhattanDistance(_ a: Point, _ b: Point) -> Int {
    let horizontalDistance = getHorizontalDistance(a, b)
    let verticalDistance = getVerticalDistance(a, b)
    
    return horizontalDistance + verticalDistance
}

func isHorizontal(_ a: Point, _ b: Point) -> Bool {
    return a.y == b.y
}

func isVertical(_ a: Point, _ b: Point) -> Bool {    
    return a.x == b.x
}

func isOrthogonal(_ a: Point, _ b: Point) -> Bool {    
    return isHorizontal(a, b) || isVertical(a, b)
}

func isDiagonal(_ a: Point, _ b: Point) -> Bool {
    let horizontalDistance = getHorizontalDistance(a, b)
    let verticalDistance = getVerticalDistance(a, b)

    return horizontalDistance == verticalDistance
}

struct Point {
    var x: Int
    var y: Int
}

struct Move {
    var start: Point
    var end: Point
    var chessPiece: ChessPiece
}

class ChessPiece {

    var position: Point = Point(x: 0, y: 0)
    var icon: String = "."

    func isMoveValid(_ chessBoard: Chessboard, _ start: Point, _ end: Point) -> Bool {
        return false
    }
}

class WhitePawn: ChessPiece {

    var isFirstMove: Bool = true
    
    override init() {
        super.init()
        self.icon = "♟"
    }
    
    func setFirstMove(_ boolValue: Bool) {
        isFirstMove = boolValue
    }
    
    override func isMoveValid(_ chessBoard: Chessboard, _ start: Point, _ end: Point) -> Bool {
        if (isVertical(start, end)) {
            let distance = end.y - start.y
            
            if (distance < -2) {
                return false
            }
            else if (distance == -2 && isFirstMove) {
                setFirstMove(false)
                return true
            }
            else if (distance == -1) {
                setFirstMove(false)
                return true
            }
        }

        return false
    }
    
}

class BlackPawn: ChessPiece {
    var isFirstMove: Bool = true
    
    override init() {
        super.init()
        self.icon = "♙"
    }
    
    func setFirstMove(_ boolValue: Bool) {
        isFirstMove = boolValue
    }
    
    override func isMoveValid(_ chessBoard: Chessboard, _ start: Point, _ end: Point) -> Bool {
        
        if (isVertical(start, end)) {
            let distance = end.y - start.y

            if (distance > 2) {
                return false
            }
            else if (distance == 2 && isFirstMove) {
                setFirstMove(false)
                return true
            }
            else if (distance == 1) {
                setFirstMove(false)
                return true
            }            
        }

        return false
    }
}

class Bishop: ChessPiece {
    
    override func isMoveValid(_ chessBoard: Chessboard, _ start: Point, _ end: Point) -> Bool {
        return isDiagonal(start, end)
    }
}

class Tower: ChessPiece {
    override func isMoveValid(_ chessBoard: Chessboard, _ start: Point, _ end: Point) -> Bool {
        print(start, end, isOrthogonal(start, end))
        return isOrthogonal(start, end)
    }
}

class Horse: ChessPiece {
    override func isMoveValid(_ chessBoard: Chessboard, _ start: Point, _ end: Point) -> Bool {
        let manhattanDistance = getManhattanDistance(start, end)

        return !isOrthogonal(start, end) && manhattanDistance == 2
    }
}

class Queen: ChessPiece {
    override func isMoveValid(_ chessBoard: Chessboard, _ start: Point, _ end: Point) -> Bool {
        return isOrthogonal(start, end) || isDiagonal(start, end)
    }
}

class King: ChessPiece {
    override func isMoveValid(_ chessBoard: Chessboard, _ start: Point, _ end: Point) -> Bool {
        let manhattanDistance = getManhattanDistance(start, end)

        if (manhattanDistance == 1) {
            return true
        }
        if (manhattanDistance == 2) {
            return isDiagonal(start, end)
        }

        return false
    }
}

class WhiteBishop: Bishop {
    
    override init() {
        super.init()
        icon = "♝"
    }
}

class BlackBishop: Bishop {
    override init() {
        super.init()
        icon = "♗"
    }
}

class WhiteTower: Tower {
    override init() {
        super.init()
        icon = "♜"
    }
}

class BlackTower: Tower {
    override init() {
        super.init()
        icon = "♖"
    }
}

class WhiteHorse: Horse {
    override init() {
        super.init()
        icon = "♞"
    }
}

class BlackHorse: Horse {
    override init() {
        super.init()
        icon = "♘"
    }
}

class WhiteQueen: Queen {
    override init() {
        super.init()
        icon = "♛"
    }
}

class BlackQueen: Queen {
    override init() {
        super.init()
        icon = "♕"
    }
}

class WhiteKing: King {
    override init() {
        super.init()
        icon = "♚"
    }
}

class BlackKing: King {
    override init() {
        super.init()
        icon = "♔"
    }
}

struct Chessboard {
    
    var board: [[ChessPiece]] = [
        [BlackTower(), BlackHorse(), BlackBishop(), BlackKing(), BlackQueen(), BlackBishop(), BlackHorse(), BlackTower()],
        [BlackPawn(), BlackPawn(), BlackPawn(), BlackPawn(), BlackPawn(), BlackPawn(), BlackPawn(), BlackPawn()],
        [ChessPiece(), ChessPiece(), ChessPiece(), ChessPiece(), ChessPiece(), ChessPiece(), ChessPiece(), ChessPiece()],
        [ChessPiece(), ChessPiece(), ChessPiece(), ChessPiece(), ChessPiece(), ChessPiece(), ChessPiece(), ChessPiece()],
        [ChessPiece(), ChessPiece(), ChessPiece(), ChessPiece(), ChessPiece(), ChessPiece(), ChessPiece(), ChessPiece()],
        [ChessPiece(), ChessPiece(), ChessPiece(), ChessPiece(), ChessPiece(), ChessPiece(), ChessPiece(), ChessPiece()],
        [WhitePawn(), WhitePawn(), WhitePawn(), WhitePawn(), WhitePawn(), WhitePawn(), WhitePawn(), WhitePawn() ],
        [WhiteTower(), WhiteHorse(), WhiteBishop(), WhiteQueen(), WhiteKing(),WhiteBishop(), WhiteHorse(), WhiteTower()],
    ]
    
    func printBoard() {
        for row in board {
            for chessPiece in row {
                print(chessPiece.icon, terminator: " ")
            }
            print("\n")
        }
    }

    func clearTerminal() {
        print("\u{001B}[2J")
    }

    func getChessPiece(_ point: Point) -> ChessPiece {
        return board[point.y][point.x]
    }

    func getPoint() -> Point {
        let coordenatesAsString: String? = readLine()
        return coordenatesAsString!.parseToPoint()
    }

    func getMove() -> Move {
        let start: Point = getPoint()
        let end: Point = getPoint()
        let chessPiece = getChessPiece(start)

        return Move(start: start, end: end, chessPiece: chessPiece)
    }

    mutating func executeMove(_ move: Move) {
        board[move.start.y][move.start.x] = ChessPiece()
        board[move.end.y][move.end.x] = move.chessPiece
    }
    
    mutating func startMatch() {

        while true {
            self.printBoard()
            let move = getMove()

            if (move.chessPiece.isMoveValid(self, move.start, move.end)) {
                self.executeMove(move)
            }

            self.clearTerminal()
        }
    }
}

var board = Chessboard()
board.startMatch()