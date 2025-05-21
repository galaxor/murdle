% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L, Liar) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  L=[[dean_glaucous, _, _],
     [brother_brownstone, _, _],
     [dame_obsidian, _, _]],

  % What are the weapons
  member([_, holy_drakonian_award, _], L),
  member([_, war_poetry, _], L),
  member([_, ghost_detector, _], L),

  % Where are the locations
  member([_, _, statue_of_lord_violet], L),
  member([_, _, docks], L),
  member([_, _, cliffs], L),

  % Clues.
  sign(WarPoetryPerson, virgo), member([WarPoetryPerson, war_poetry, _], L),
  \+member([brother_brownstone, _, statue_of_lord_violet], L),
  statements_liar([
    statement(dean_glaucous, member([dean_glaucous, _, docks], L)),
    statement(brother_brownstone, member([dame_obsidian, _, cliffs], L)),
    statement(dame_obsidian, member([_, holy_drakonian_award, docks], L))],
    Liar
  )
.

murdler(Liar, W, L) :-
  solution(S, Liar),
  member([Liar, W, L], S)
.
