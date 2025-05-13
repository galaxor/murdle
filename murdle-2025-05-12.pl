% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  L=[[chef_aubergine, _, _],
     [lord_lavendar, _, _],
     [mayor_honey, _, _],
     [brother_brownstone, _, _]],

  % What are the weapons
  member([_, corgi_stampede, _], L),
  member([_, climbing_axe, _], L),
  member([_, brick, _], L),
  member([_, venemous_spider, _], L),

  % Where are the locations
  member([_, _, old_pine], L),
  member([_, _, high_end_tent], L),
  member([_, _, party_lake], L),
  member([_, _, hot_springs_spa], L),

  % Clues.
  member([mayor_honey, climbing_axe, _], L),
  made_of(ChefAubergineWeapon, corgis), member([chef_aubergine, ChefAubergineWeapon, _], L),
  made_of(TentWeapon, live_animal), member([_, TentWeapon, high_end_tent], L),
  \+member([_, corgi_stampede, hot_springs_spa], L),
  member([brother_brownstone, _, old_pine], L)
.

murdler(P, W, L) :-
  solution(S),
  member([P, W, L], S),
  [P, W, L]=[_, brick, _]
.
