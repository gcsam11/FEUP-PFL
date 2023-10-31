% name_of(+Player, -Name)
% Find the Players name
:- dynamic name_of/2.

% difficulty(+Bot,-Difficulty)
% Find the Bot difficulty
:- dynamic difficulty/2.

% board(+Size,+Matrix)
% Board initial structure
board(9, [
                    [bgoal, bgoal, bgoal, bgoal, bgoal],
                [empty, white, white, white, white, empty],
            [empty, white, empty, white, empty, white, empty],
        [empty, white, white, white, white, white, white, empty],
    [empty, empty, empty, empty, empty, empty, empty, empty, empty],
        [empty, black, black, black, black, black, black, empty],
            [empty, black, empty, black, empty, black, empty],
                [empty, black, black, black, black, empty],
                    [wgoal, wgoal, wgoal, wgoal, wgoal]
]).

% piece_info(?Type, ?Player, +Piece)
% It allows to generalize the type of piece and to know the player that uses it
piece_info(white, player1, white).
piece_info(black, player2, black).
piece_info(empty, neutral).
piece_info(wgoal, neutral).
piece_info(bgoal, neutral).

% change_turn(+CurrentPlayer,-NextPlayer)
% Change player turn
change_turn(player1, player2).
change_turn(player2, player1).

% symbol(+Piece,-Symbol)
% Translates the piece to a visible symbol on the board
symbol(black, 'B') :- !.
symbol(white, 'W') :- !.
symbol(empty, ' ') :- !.
symbol(bgoal, 'b') :- !.
symbol(wgoal, 'w') :- !.

% print_cell(+Piece)
% Predicate to print a single cell
print_cell(Cell) :-
    write(Cell).

% display_dash(+List)
% Predicate to print a dash if there are still members in the list.
display_dash([_|_]) :-
    write(' — ').
display_dash([]).

% print_row(+Row)
% Predicate to print a row of cells
print_row([]) :- nl.
print_row([Cell | Rest]) :-
    print_cell(Cell),
    display_dash(Rest),
    print_row(Rest).

% print_board/0
% Predicate to print the entire hexagonal board
print_board :-
    board(9, Board),
    print_board(Board, 1, 9).

% print_bar1(+RowNumber)
% prints the first bar from row 2 to 8
print_bar1(N) :-
    between(2, 8, N),
    write('| ').

% printb_bar2(+RowNumber)
% prints the second bar from row 2 to 8
print_bar2(N) :-
    between(2, 8, N),
    write(' |').

% print_board(+Row, +NOfRow, +Size)
% Predicate to print the entire hexagonal board
print_board([], _).
print_board([Row | Rest], N, Size) :-
    SpaceCount is abs(Size - N),
    NextN is N + 1,
    print_bar1(N),
    print_spaces(SpaceCount),
    print_row(Row),
    print_bar2(N),
    print_board(Rest, NextN).

% Predicate to print spaces before a row of cells
print_spaces(0).
print_spaces(N) :-
    N > 0,
    write(' '),
    NextN is N - 1,
    print_spaces(NextN).

/**
 *
 *  Board structure
 *
 *  I --------------   w — w — w — w — w
 *                    
 *  H ------------ |   — B — B — B — B —   | 
 *                                                            
 *  G ---------- |   — B —   — B —   — B —   |
 *                                                  
 *  F -------- |   — B — B — B — B — B — B —   |
 *                                                        
 *  E ------  |   —   —   —   —   —   —   —   —   |
 *                                                     
 *  D -------- |   — W — W — W — W — W — W —   | \
 *                                                \
 *  C ---------- |   — W —   — W —   — W —   | \   \
 *                                              \   \ 
 *  B ------------ |   — W — W — W — W —   | \   \   \
 *                                            \   \   \
 *  A --------------   b — b — b — b — b   \   \   \   \
 *                                          \   \   \   \
 *                       \   \   \   \   \   \   \   \   \
 *                        \   \   \   \   \   \   \   \   \
 *                         1   2   3   4   5   6   7   8   9                  
**/