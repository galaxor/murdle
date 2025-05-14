% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L, Liar) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  L=[[coach_raspberry, _, _],
     [agent_fuchsia, _, _],
     [viscount_eminence, _, _]],

  % What are the weapons
  member([_, monster_costume, _], L),
  member([_, crazed_squirrel, _], L),
  member([_, poisoned_goblet, _], L),

  % Where are the locations
  member([_, _, great_hall], L),
  member([_, _, dungeon], L),
  member([_, _, lonely_tower], L),

  % Clues.
  \+member([coach_raspberry, _, dungeon], L),
  eyes(GobletPerson, grey), member([GobletPerson, poisoned_goblet, _], L),
  speakers_statements_liar(
    [coach_raspberry, agent_fuchsia, viscount_eminence],
    [member([coach_raspberry, _, great_hall], L),
      \+member([_, monster_costume, great_hall], L),
      \+member([agent_fuchsia, crazed_squirrel, _], L)
    ],
    Liar
  )
.

murdler(Liar, W, L) :-
  solution(S, Liar),
  member([Liar, W, L], S)
.
