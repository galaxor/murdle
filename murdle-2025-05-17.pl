% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L, Liar) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  L=[[miss_ruby, _, _, _],
     [secretary_celadon, _, _, _],
     [general_coffee, _, _, _],
     [deacon_verdigris, _, _, _]],

  % What are the weapons
  member([_, corgi_stampede, _, _], L),
  member([_, metal_straw, _, _], L),
  member([_, boiling_pot, _, _], L),
  member([_, brick, _, _], L),

  % Where are the locations
  member([_, _, parking_lot, _], L),
  member([_, _, counter, _], L),
  member([_, _, bathroom, _], L),
  member([_, _, courtyard, _], L),

  % Why are the motives
  member([_, _, _, rob_the_victim], L),
  member([_, _, _, to_kill], L),
  member([_, _, _, inherit_a_fortune], L),
  member([_, _, _, escape_blackmail], L),

  % Clues.
  \+member([_, boiling_pot, counter, _], L),
  sign(KillPerson, sagittarius), member([KillPerson, _, _, to_kill], L),
  member([_, corgi_stampede, _, escape_blackmail], L),
  member([miss_ruby, _, parking_lot, _], L),
  member([deacon_verdigris, _, bathroom, _], L),
  \+member([_, metal_straw, _, rob_the_victim], L),
  made_of(CeladonWeapon, wood), member([secretary_celadon, CeladonWeapon, _, _], L),
  statements_liar([
    statement(miss_ruby, member([_, metal_straw, courtyard, _], L)),
    statement(secretary_celadon, \+member([secretary_celadon, _, counter, _], L)),
    statement(general_coffee, \+member([_, brick, courtyard, _], L)),
    statement(deacon_verdigris, member([deacon_verdigris, boiling_pot, _, _], L))
  ], Liar)
.

murdler(Liar, W, L, M) :-
  solution(S, Liar),
  member([Liar, W, L, M], S)
.
