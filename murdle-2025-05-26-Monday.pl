% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  L=[[miss_ruby, _, _],
     [viscount_eminence, _, _],
     [signor_emerald, _, _],
     [duchess_of_vermillion, _, _]],

  % What are the weapons
  member([_, snowglobe, _], L),
  member([_, hammer_and_sickle, _], L),
  member([_, climbing_rope, _], L),
  member([_, walking_stick, _], L),

  % Where are the locations
  member([_, _, real_estate_office], L),
  member([_, _, gift_shop], L),
  member([_, _, trailhead], L),
  member([_, _, five_star_restaurant], L),

  % Clues.
  made_of(MissRubyWeapon, fiber), member([miss_ruby, MissRubyWeapon, _], L),
  made_of(GiftShopWeapon, glass), member([_, GiftShopWeapon, gift_shop], L),
  member([signor_emerald, snowglobe, _], L),
  member([duchess_of_vermillion, _, five_star_restaurant], L),
  \+member([_, hammer_and_sickle, trailhead], L),
  \+member([viscount_eminence, walking_stick, _], L)
.

murdler(P, W, L) :-
  solution(S),
  member([P, W, L], S),
  [P, W, L]=[_, climbing_rope, _]
.
