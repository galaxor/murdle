% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  L=[[officer_copper, _, _, _],
     [miss_saffron, _, _, _],
     [babyface_blue, _, _, _]],

  % What are the weapons
  member([_, poisoned_goblet, _, _], L),
  member([_, murdle_volume_1, _, _], L),
  member([_, old_heavy_tome, _, _], L),

  % Where are the locations
  member([_, _, lonely_tower, _], L),
  member([_, _, secret_chamber, _], L),
  member([_, _, screaming_forest, _], L),

  % Why are the motives
  member([_, _, _, break_into_the_industry], L),
  member([_, _, _, fight_for_the_revolution], L),
  member([_, _, _, rage_with_jealousy], L),

  % Clues.
  one_is_lie([
    member([miss_saffron, old_heavy_tome, _, _], L),
    member([babyface_blue, old_heavy_tome, _, _], L)
  ]),
  made_of(RevolutionWeapon, cloth), member([_, RevolutionWeapon, _, fight_for_the_revolution], L),
  \+member([officer_copper, _, lonely_tower, _], L),
  made_of(JealousyWeapon, metal), member([_, JealousyWeapon, _, rage_with_jealousy], L),
  eyes(JealousyPerson, hazel), member([JealousyPerson, _, _, rage_with_jealousy], L),
  member([babyface_blue, _, secret_chamber, _], L)
.

murdler(P, W, L, M) :-
  solution(S),
  member([P, W, L, M], S),
  [P, W, L, M]=[_, _, screaming_forest, _]
.
