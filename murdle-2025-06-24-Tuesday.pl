% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  suspects([
    comrade_champagne,
    uncle_midnight,
    dr_crimson
  ], L),

  % What are the weapons
  weapons([
    stone_dagger,
    climbing_rope,
    walking_stick
  ], L),

  % Where are the locations
  locations([
    real_estate_office,
    trailhead,
    boutique_hotel
  ], L),

  % Why are the motives
  motives([
    rage_with_jealousy,
    silence_a_witness,
    kill
  ], L),

  % Clues.
  made_of(KillWeapon, metal), weapon_motive(KillWeapon, kill, L),
  eyes(WalkingStickPerson, hazel), suspect_had_weapon(WalkingStickPerson, walking_stick, L),
  indoors(JealousyLocation), location_motive(JealousyLocation, rage_with_jealousy, L),
  one_is_lie([
    suspect_at_location(uncle_midnight, boutique_hotel, L),
    suspect_had_weapon(uncle_midnight, stone_dagger, L)
  ]),
  \+weapon_motive(climbing_rope, silence_a_witness, L),
  suspect_at_location(dr_crimson, trailhead, L)
.

murdler(P, W, L, M) :-
  solution(S),
  member([P, W, L, M], S),
  [P, W, L, M]=[_, _, real_estate_office, _]
.
