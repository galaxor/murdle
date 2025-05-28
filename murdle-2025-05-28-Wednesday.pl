% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L, Liar) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  L=[[grandmaster_rose, _, _],
     [babyface_blue, _, _],
     [chancellor_tuscany, _, _]],

  % What are the weapons
  member([_, axe, _], L),
  member([_, chainsaw, _], L),
  member([_, angry_llama, _], L),

  % Where are the locations
  member([_, _, stone_bridge], L),
  member([_, _, locked_gate], L),
  member([_, _, meeting_house], L),

  % Clues.
  \+member([chancellor_tuscany, _, meeting_house], L),
  eyes(AxePerson, brown), member([AxePerson, axe, _], L),
  statements_liar([
    statement(grandmaster_rose, member([babyface_blue, chainsaw, _], L)),
    statement(babyface_blue, member([_, axe, locked_gate], L)),
    statement(chancellor_tuscany, member([_, angry_llama, stone_bridge], L))
  ], Liar)
.

murdler(Liar, W, L) :-
  solution(S, Liar),
  member([Liar, W, L], S)
.
