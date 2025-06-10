% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L) :-
  % Basic setup.
  consult(murdle),
  consult('knowledge-base-suspects.pl'),
  consult('knowledge-base-weapons.pl'),
  consult('knowledge-base-locations.pl'),

  % Who is there
  suspects([
    sir_rulean,
    chef_aubergine,
    bishop_azure
  ], L),

  % What are the weapons
  weapons([
    aluminum_pipe,
    rare_vase,
    jar_of_ashes
  ], L),

  % Where are the locations
  locations([
    bedroom,
    enormous_bathroom,
    upstairs_balcony
  ], L),

  % Why are the motives
  motives([
    eliminate_a_spy,
    rage_with_jealousy,
    inherit_a_fortune
  ], L),

  % Clues.
  one_is_lie([
    weapon_at_location(jar_of_ashes, bedroom, L),
    suspect_at_location(bishop_azure, bedroom, L)
  ]),
  suspect_at_location(sir_rulean, enormous_bathroom, L),
  \+suspect_at_location(chef_aubergine, upstairs_balcony, L),
  made_of(InheritAFortuneWeapon, human_remains), weapon_motive(InheritAFortuneWeapon, inherit_a_fortune, L),
  made_of(EliminateASpyWeapon, ceramic), weapon_motive(EliminateASpyWeapon, eliminate_a_spy, L),
  indoors(RageWithJealousyLocation), location_motive(RageWithJealousyLocation, rage_with_jealousy, L)
.

murdler(P, W, L, M) :-
  solution(S),
  member([P, W, L, M], S),
  [P, W, L, M]=[_, aluminum_pipe, _, _]
.
