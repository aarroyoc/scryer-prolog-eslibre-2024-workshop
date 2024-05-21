:- use_module(library(clpz)).
:- use_module(library(lists)).
:- use_module(library(debug)).

clpz:monotonic.

kenken(Board) :-
    Board = kenken(Size, Vars, Boxes),
    append(Vars, Vs),
    Vs ins 1..Size, % Fill the grid with numbers between 1 and GridSize
    % Do not repeat numbers on a row
    maplist(all_different, Vars),
    % Do not repeat numbers on a column
    transpose(Vars, Columns),
    maplist(all_different, Columns),
    % The digits within te box produce the target number using that operation
    maplist(box_restriction(Vars), Boxes),
    labeling([ffc], Vs).

box_restriction(Vars, box(Target, [X-Y])) :-
    cell(Vars, X-Y, Cell),
    #Cell #= #Target.

box_restriction(Vars, box(Target, sum, Nums)) :-
    maplist(cell(Vars), Nums, Cells),
    sum(Cells, #=, Target).

box_restriction(Vars, box(Target, sub, Nums)) :-
    maplist(cell(Vars), Nums, Cells),
    Cells = [A, B],
    #A - #B #= #Target #\ #B - #A #= #Target.

box_restriction(Vars, box(Target, mul, Nums)) :-
    maplist(cell(Vars), Nums, Cells),
    mul_cells(Cells, Target).

box_restriction(Vars, box(Target, div, Nums)) :-
    maplist(cell(Vars), Nums, Cells),
    Cells = [A, B],
    #A // #B #= #Target #\ #B // #A #= #Target.

mul_cells([A], Target) :-
    #A #= Target.
mul_cells([A, B|Cells], Target) :-
    #C #= #A * #B,
    mul_cells([C|Cells], Target).
	
cell(Vars, X-Y, Cell) :-
    nth1(Y, Vars, Row),
    nth1(X, Row, Cell).

gen_kenken_board(Board) :-
    length(Vars, 4),
    maplist(same_length(Vars), Vars),
    Board = kenken(4, Vars,
		   [
		       box(8, sum, [1-1, 2-1, 2-2]),
		       box(9, sum, [3-1, 3-2, 4-2]),
		       box(1, [4-1]),
		       box(2, sub, [1-2, 1-3]),
		       box(7, sum, [2-3, 3-3, 3-4]),
		       box(6, sum, [4-3, 4-4]),
		       box(1, sub, [1-4, 2-4])
		   ]).


gen_kenken_board_complex(Board) :-
    length(Vars, 6),
    maplist(same_length(Vars), Vars),
    Board = kenken(6, Vars,
		   [
		       box(2, sub, [1-1, 2-1]),
		       box(120, mul, [3-1, 4-1, 5-1, 3-2]),
		       box(1, sub, [6-1, 6-2]),
		       box(144, mul, [1-2, 1-3, 1-4, 1-5]),
		       box(3, div, [2-2, 2-3]),
		       box(6, [3-3]),
		       box(20, mul, [4-2, 4-3, 5-2]),
		       box(25, mul, [5-3, 6-3, 6-4]),
		       box(10, sum, [2-4, 2-5, 3-5]),
		       box(6, sum, [3-4, 4-4, 5-4]),
		       box(3, [4-5]),
		       box(1, sub, [5-5, 5-6]),
		       box(3, div, [6-5, 6-6]),
		       box(120, mul, [1-6, 2-6, 3-6, 4-6])
		   ]).
