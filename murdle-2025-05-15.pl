% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  L=[[baron_maroon, _, _],
     [dean_glaucous, _, _],
     [principal_applegreen, _, _],
     [officer_copper, _, _]],

  % What are the weapons
  member([_, poisoned_tea, _], L),
  member([_, glass_of_wine, _], L),
  member([_, heavy_painting, _], L),
  member([_, rare_vase, _], L),

  % Where are the locations
  member([_, _, art_studio], L),
  member([_, _, rooftop_garden], L),
  member([_, _, gift_shop], L),
  member([_, _, entry_hall], L),

  % Clues.
  eyes(PaintingPerson, brown), member([PaintingPerson, heavy_painting, _], L),
  \+member([officer_copper, _, entry_hall], L),
  made_of(ApplegreensWeapon, glass), member([principal_applegreen, ApplegreensWeapon, _], L),
  \+member([_, glass_of_wine, entry_hall], L),
  member([dean_glaucous, _, art_studio], L),
  one_is_lie([
    member([principal_applegreen, glass_of_wine, _], L),
    member([_, rare_vase, gift_shop], L)
  ]),
  light_weight(EntryHallWeapon), member([_, EntryHallWeapon, entry_hall], L)
.

murdler(P, W, L) :-
  solution(S),
  member([P, W, L], S),
  [P, W, L]=[_, _, rooftop_garden]
.
