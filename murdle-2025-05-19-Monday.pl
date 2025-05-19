% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  L=[[miss_saffron, _, _],
     [mayor_honey, _, _],
     [deacon_verdigris, _, _],
     [silverton_the_legend, _, _]],

  % What are the weapons
  member([_, karate_hands, _], L),
  member([_, poisoned_champagne, _], L),
  member([_, steering_wheel, _], L),
  member([_, ancient_anchor, _], L),

  % Where are the locations
  member([_, _, dining_hall], L),
  member([_, _, captains_quarters], L),
  member([_, _, amazon_river], L),
  member([_, _, boiler_room], L),

  % Clues.
  member([_, ancient_anchor, amazon_river], L),
  \+member([deacon_verdigris, karate_hands, _], L),
  made_of(CaptainsQuartersWeapon, hands), member([_, CaptainsQuartersWeapon, captains_quarters], L),
  hair(BoilerRoomPerson, blond), member([BoilerRoomPerson, _, boiler_room], L),
  member([mayor_honey, poisoned_champagne, _], L)
.

murdler(P, W, L) :-
  solution(S),
  member([P, W, L], S),
  [P, W, L]=[_, _, dining_hall]
.
