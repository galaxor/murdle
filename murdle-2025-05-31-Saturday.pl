% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L, Liar) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  L=[[mx_tangerine, _, _, _],
     [miss_saffron, _, _, _],
     [president_amaranth, _, _, _],
     [chef_aubergine, _, _, _]],

  % What are the weapons
  member([_, briefcase_full_of_money, _, _], L),
  member([_, angry_moose, _, _], L),
  member([_, antique_vase, _, _], L),
  member([_, pencil, _, _], L),

  % Where are the locations
  member([_, _, docks, _], L),
  member([_, _, cliffs, _], L),
  member([_, _, garden_maze, _], L),
  member([_, _, main_house, _], L),

  % Why are the motives
  member([_, _, _, rob_the_victim], L),
  member([_, _, _, escape_blackmail], L),
  member([_, _, _, rage_with_jealousy], L),
  member([_, _, _, inherit_a_fortune], L),

  % Clues.
  member([_, pencil, _, rob_the_victim], L),
  left_handed(BlackmailPerson), member([BlackmailPerson, _, _, escape_blackmail], L),
  member([_, antique_vase, garden_maze, _], L),
  \+member([chef_aubergine, angry_moose, _, _], L),
  made_of(InheritWeapon, moose), member([_, InheritWeapon, _, inherit_a_fortune], L),
  member([miss_saffron, _, main_house, _], L),
  member([_, briefcase_full_of_money, docks, _], L),
  statements_liar([
    statement(mx_tangerine, \+member([_, briefcase_full_of_money, main_house, _], L)),
    statement(miss_saffron, member([miss_saffron, _, main_house, _], L)),
    statement(president_amaranth, member([president_amaranth, _, docks, _], L)),
    statement(chef_aubergine, member([mx_tangerine, angry_moose, _, _], L))
  ], Liar)
.

murdler(Liar, W, L, M) :-
  solution(S, Liar),
  member([Liar, W, L, M], S)
.
