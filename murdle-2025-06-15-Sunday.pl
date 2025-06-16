% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  suspects([
    mx_tangerine,
    sir_rulean,
    uncle_midnight,
    secretary_celadon,
    general_coffee,
    father_mango
  ], L),

  % What are the weapons
  weapons([
    exploding_cufflinks,
    lawyer,
    shiv,
    cabernet_toilet_wine,
    skeleton_key,
    rope_of_clothes
  ], L),

  % Where are the locations
  locations([
    private_suite,
    movie_theater,
    spa,
    rec_room,
    michelin_starred_cafeteria,
    guard_tower
  ], L),

  % Clues.
  made_of(GuardTowerWeapon, greed), weapon_at_location(GuardTowerWeapon, guard_tower, L),
  weapon_at_location(skeleton_key, spa, L),
  suspect_at_location(general_coffee, michelin_starred_cafeteria, L),
  weapon_at_location(cabernet_toilet_wine, rec_room, L),
  suspect_at_location(father_mango, rec_room, L),
  suspect_had_weapon(uncle_midnight, rope_of_clothes, L),
  findall(Person, member([Person, _, _], L), People),
    shortest(People, ShortestPerson), 
    made_of(ShortestPersonWeapon, alcohol),
    suspect_had_weapon(ShortestPerson, ShortestPersonWeapon, L),
  suspect_at_location(secretary_celadon, movie_theater, L),
  left_handed(CufflinksPerson), suspect_had_weapon(CufflinksPerson, exploding_cufflinks, L)
.

murdler(P, W, L) :-
  solution(S),
  member([P, W, L], S),
  [P,W,L]=[_, shiv, _]
.
