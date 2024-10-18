import Array "mo:base/Array";
import Nat32 "mo:base/Nat32";
import Nat8 "mo:base/Nat8";
import Iter "mo:base/Iter";

actor {
    type Cell = ?Nat8;
    type Row = [Cell];
    type Board = [Row];

    public func solveSudoku(board: Board) : async ?Board {
        let size = 9; 
        var rows = Array.init<Nat32>(size, 0);
        var cols = Array.init<Nat32>(size, 0);
        var boxes = Array.init<Nat32>(size, 0);

        // Time to play "Spot the Number" across the board
        for (i in Iter.range(0, size - 1)) {
            for (j in Iter.range(0, size - 1)) {
                switch (board[i][j]) {
                    case null { /* Empty cell, nothing to see here, move along */ };
                    case (?value) {
                        let num = Nat32.fromNat(Nat8.toNat(value));
                        let bitMask = Nat32.bitshiftLeft(1, num - 1); // gives a unique bit representation, a mask of sorts
                        let boxIndex = (i / 3) * 3 + (j / 3); // Magic formula to find which 3x3 box we're in
                        // Record the presence of the number in the corresponding row, column, and box
                        rows[i] := Nat32.bitor(rows[i], bitMask);
                        cols[j] := Nat32.bitor(cols[j], bitMask);
                        boxes[boxIndex] := Nat32.bitor(boxes[boxIndex], bitMask);
                    };
                };
            };
        };

        // Create a mutable board
        let mutableBoard = Array.tabulateVar<[var Cell]>(size, func(i) {
            Array.thaw<Cell>(board[i]) 
        });


        if (solve(mutableBoard, rows, cols, boxes, 0, 0)) {
            // Let's freeze this bad boy back up
            return ?Array.tabulate<Row>(size, func(i) {
                Array.freeze<Cell>(mutableBoard[i]) 
            });
        } else {
            return null; // No solution :-(
        };
    };

    func solve(board: [var [var Cell]], rows: [var Nat32], cols: [var Nat32], boxes: [var Nat32], row: Nat, col: Nat) : Bool {
        //we've won. we populated all 0-8 rows
        if (row == 9) {
            return true; 
        };
        // Calculate next cell
        let nextRow = if (col == 8) { row + 1 } else { row };
        let nextCol = (col + 1) % 9; // Making sure we don't fall off the edge of the board

        switch (board[row][col]) {
            case null {
                // Empty cell! Time to play "Guess the Number" (now with backtracking!)
                for (num in Iter.range(1, 9)) {
                    let bitMask = Nat32.bitshiftLeft(1, Nat32.fromNat(num) - 1);
                    let boxIndex = (row / 3) * 3 + (col / 3); // magic formula strikes again
                    
                    // Check if we can place the number here 
                    if (Nat32.bitand(rows[row], bitMask) == 0 and
                        Nat32.bitand(cols[col], bitMask) == 0 and
                        Nat32.bitand(boxes[boxIndex], bitMask) == 0) {
                        
                        // Record the presence of the number in the corresponding row, column, and box(again)
                        board[row][col] := ?Nat8.fromNat(num);
                        rows[row] := Nat32.bitor(rows[row], bitMask);
                        cols[col] := Nat32.bitor(cols[col], bitMask);
                        boxes[boxIndex] := Nat32.bitor(boxes[boxIndex], bitMask);

                        // Recursive. call to solve the next row and col
                        if (solve(board, rows, cols, boxes, nextRow, nextCol)) {
                            return true; // We found a solution!
                        };

                        // That didn't work. Time to erase our mistakes 
                        board[row][col] := null;
                        rows[row] := Nat32.bitand(rows[row], ^bitMask);
                        cols[col] := Nat32.bitand(cols[col], ^bitMask);
                        boxes[boxIndex] := Nat32.bitand(boxes[boxIndex], ^bitMask);
                    };
                };
                return false; // We've tried, nothing and we're all out of ideas
            };
            case _ {
                // This cell is already filled. Let's move on and pretend we did something useful here.
                return solve(board, rows, cols, boxes, nextRow, nextCol);
            };
        };
    };
};