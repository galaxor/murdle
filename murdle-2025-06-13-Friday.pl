% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  suspects([
    president_amaranth,
    miss_ruby,
    general_coffee,
    lady_violet,
    dr_crimson
  ], L),

  % What are the weapons
  weapons([
    karate_hands,
    crazed_squirrel,
    ancient_plague,
    old_heavy_tome,
    poisoned_goblet
  ], L),

  % Where are the locations
  locations([
    screaming_forest,
    lonely_tower,
    great_hall,
    dungeon,
    secret_chamber
  ], L),

  % Clues.
  heavy_weight(MissRubyWeapon), suspect_had_weapon(miss_ruby, MissRubyWeapon, L),
  one_is_lie([
    weapon_at_location(poisoned_goblet, secret_chamber, L),
    suspect_at_location(president_amaranth, secret_chamber, L)
  ]),
  hair(LonelyTowerPerson, red), suspect_at_location(LonelyTowerPerson, lonely_tower, L),
  suspect_at_location(miss_ruby, dungeon, L),
  sign(ScreamingForestPerson, aquarius), suspect_at_location(ScreamingForestPerson, screaming_forest, L),
  right_handed(KarateHandsPerson), suspect_had_weapon(KarateHandsPerson, karate_hands, L),
  suspect_had_weapon(general_coffee, ancient_plague, L)
.

murdler(P, W, L) :-
  solution(S),
  member([P, W, L], S),
  [P, W, L]=[_, _, great_hall]
.
