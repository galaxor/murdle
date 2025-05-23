% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  L=[[secretary_celadon, _, _],
     [principal_applegreen, _, _],
     [grandmaster_rose, _, _],
     [signor_emerald, _, _],
     [officer_copper, _, _]],

  % What are the weapons
  member([_, walking_stick, _], L),
  member([_, climbing_rope, _], L),
  member([_, murdle_volume_3, _], L),
  member([_, snowglobe, _], L),
  member([_, laptop, _], L),

  % Where are the locations
  member([_, _, trailhead], L),
  member([_, _, boutique_hotel], L),
  member([_, _, five_star_restaurant], L),
  member([_, _, real_estate_office], L),
  member([_, _, gift_shop], L),

  % Clues.
  one_is_lie([
    member([_, walking_stick, five_star_restaurant], L),
    member([_, climbing_rope, boutique_hotel], L)
  ]),
  made_of(RealEstateOfficeWeapon, fiber), member([_, RealEstateOfficeWeapon, real_estate_office], L),
  hair(WalkingStickPerson, black), member([WalkingStickPerson, walking_stick, _], L),
  made_of(SecretaryCeladonWeapon, fiber), member([secretary_celadon, SecretaryCeladonWeapon, _], L),
  member([grandmaster_rose, snowglobe, _], L),
  birthday_sign(november, 17, TrailheadPersonSign), sign(TrailheadPerson, TrailheadPersonSign), member([TrailheadPerson, _, trailhead], L),
  member([_, laptop, boutique_hotel], L),
  \+member([officer_copper, laptop, _], L)
.

murdler(P, W, L) :-
  solution(S),
  member([P, W, L], S),
  [P, W, L]=[_, _, gift_shop]
.
