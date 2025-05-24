% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L, Liar) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  L=[[coach_raspberry, _, _, _],
     [baron_maroon, _, _, _],
     [captain_slate, _, _, _],
     [mx_tangerine, _, _, _]],

  % What are the weapons
  member([_, trained_orangutan, _, _], L),
  member([_, magnifying_glass, _, _], L),
  member([_, booby_trapped_fedora, _, _], L),
  member([_, antique_chess_clock, _, _], L),

  % Where are the locations
  member([_, _, rooftop_lookout, _], L),
  member([_, _, encyclopedia_room, _], L),
  member([_, _, conspiracy_corkboard_room, _], L),
  member([_, _, parking_garage, _], L),

  % Why are the motives
  member([_, _, _, win_an_argument], L),
  member([_, _, _, inherit_a_fortune], L),
  member([_, _, _, hide_an_affair], L),
  member([_, _, _, break_into_the_industry], L),

  % Clues.
  hair(FedoraPerson, blond), member([FedoraPerson, booby_trapped_fedora, _, _], L),
  member([_, antique_chess_clock, encyclopedia_room, _], L),
  member([mx_tangerine, _, parking_garage, _], L),
  \+member([baron_maroon, _, _, hide_an_affair], L),
  member([coach_raspberry, _, _, win_an_argument], L),
  heavy_weight(InheritWeapon), member([_, InheritWeapon, _, inherit_a_fortune], L),
  member([_, magnifying_glass, rooftop_lookout, _], L),
  sign(ConspiracyPerson, aquarius), member([ConspiracyPerson, _, conspiracy_corkboard_room, _], L),
  statements_liar([
    statement(coach_raspberry, \+member([captain_slate, _, encyclopedia_room, _], L)),
    statement(baron_maroon, member([coach_raspberry, magnifying_glass, _, _], L)),
    statement(captain_slate, member([_, booby_trapped_fedora, parking_garage, _], L)),
    statement(mx_tangerine, \+member([mx_tangerine, magnifying_glass, _, _], L))
  ], Liar)
.

murdler(Liar, W, L, M) :-
  solution(S, Liar),
  member([Liar, W, L, M], S)
.
