% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  L=[[amazing_aureolin, _, _],
     [judge_pine, _, _],
     [admiral_navy, _, _],
     [brother_brownstone, _, _]],

  % What are the weapons
  member([_, clapboard, _], L),
  member([_, prop_knife, _], L),
  member([_, toxic_makeup, _], L),
  member([_, antique_typewriter, _], L),

  % Where are the locations
  member([_, _, luxury_theater], L),
  member([_, _, prop_shop], L),
  member([_, _, studio_tour_check_in_stand], L),
  member([_, _, statue_of_midnight_i], L),

  % Clues.
  \+member([_, prop_knife, prop_shop], L),
  made_of(StatueWeapon, wood), member([_, StatueWeapon, statue_of_midnight_i], L),
  \+member([admiral_navy, _, luxury_theater], L),
  eyes(TypewriterPerson, green), member([TypewriterPerson, antique_typewriter, _], L),
  member([brother_brownstone, clapboard, _], L),
  outdoors(JudgePinePlace), member([judge_pine, _, JudgePinePlace], L)
.

murdler(P, W, L) :-
  solution(S),
  member([P, W, L], S),
  [P, W, L]=[_, toxic_makeup, _]
.
