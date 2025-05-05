% This solves 2025-05-04.
% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  L=[[mx_tangerine, _, _],
     [sir_rulean, _, _],
     [father_mango, _, _],
     [agent_fuchsia, _, _]],

  % What are the weapons
  member([_, muffin, _], L),
  member([_, straw, _], L),
  member([_, coffee, _], L),
  member([_, butter_knife, _], L),

  % Where are the locations
  member([_, _, parking_lot], L),
  member([_, _, counter], L),
  member([_, _, bathroom], L),
  member([_, _, bean_room], L),

  % Clues.
  member([_, butter_knife, bean_room], L),
  member([_, coffee, bathroom], L),
  member([Virgo_Person, _, counter], L), sign(Virgo_Person, virgo),
  \+ member([father_mango, coffee, _], L),
  member([mx_tangerine, muffin, _], L)
.

murdler(P, W, L) :-
  solution(S),
  member([P, W, L], S),
  [P, W, L]=[_, _, parking_lot]
.
