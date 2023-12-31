:- use_module(library(lists)).
:- use_module(library(between)).
:- use_module(library(system), [now/1]).
:- consult(utils).
:- consult(data).
:- consult(board).

% choose_difficulty(+Bot)
% Choose Bot difficulty (1 or 2)
choose_difficulty(Bot) :-
    write('+---------------------------------------------------+\n'),
    format('| Please select ~a difficulty:                 |\n', [Bot]),
    write('+---------------------------------------------------+\n'),
    write('| 1 - Random                                        |\n'),
    write('| 2 - Greedy                                        |\n'),
    write('+---------------------------------------------------+\n'),
    get_option(1, 2, 'Difficulty', Option), !,
    asserta((difficulty(Bot, Option))).

% menu_option(+N)
% Main menu options. Each represents a game mode.
menu_option(1):-
    write('Human vs Human\n'),
    get_username(player1),
    get_username(player2).
menu_option(2):-
    write('Human vs Bot\n'),
    get_username(player1),
    asserta((name_of(player2, 'Bot'))), !,
    choose_difficulty(player2).
menu_option(3):-
    write('Bot vs Bot\n'),
    asserta((name_of(player1, 'Bot1'))),
    asserta((name_of(player2, 'Bot2'))), !,
    choose_difficulty(player1),
    choose_difficulty(player2).

% choose_player(-Player)
% Chooses the player that will start the game
choose_player(Player):-
    name_of(player1, Name1),
    name_of(player2, Name2),
    format('~a is WHITE and ~a is BLACK\n', [Name1, Name2]),
    asserta((player_color(player1, white))),
    asserta((player_color(player2, black))), !,
    write('White pieces start!\n'),
    nth1(1, [player1, player2], Player).

% game_header/0
% Game header display
game_header:-
    write('+---------------------------------------------------+\n'),
    write('|                      DIFFERO                      |\n'),
    write('+---------------------------------------------------+\n').

% menu/0
% Main menu
menu:-
    write('| Please select game mode:                          |\n'),
    write('+---------------------------------------------------+\n'),
    write('| 1 - Human vs Human                                |\n'),
    write('| 2 - Human vs Bot                                  |\n'),
    write('| 3 - Bot vs Bot                                    |\n'),
    write('+---------------------------------------------------+\n').

% set_mode/0
% Game mode choice
set_mode :-
    menu,
    get_option(1, 3, 'Mode', Option), !,
    menu_option(Option).

% configuration(-GameState)
% Initialize GameState with Board and first Player
configurations([Board, Player, 0]):-
    game_header,
    set_mode,
    choose_player(Player),
    initial_state(9, [Board, Player, 0]).
