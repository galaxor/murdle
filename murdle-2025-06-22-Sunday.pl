% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  suspects([
    officer_copper,
    president_amaranth,
    comrade_champagne,
    lord_lavendar,
    secretary_celadon,
    dean_glaucous
  ], L),

  % What are the weapons
  weapons([
    skeleton_key,
    lawyer,
    rope_of_clothes,
    gold_watch,
    chainsaw,
    shiv
  ], L),

  % Where are the locations
  locations([
    spa,
    tennis_court,
    michelin_starred_cafeteria,
    guard_tower,
    movie_theater,
    rec_room
  ], L),

  % Clues.
  \+suspect_at_location(lord_lavendar, spa, L),
  suspect_at_location(dean_glaucous, guard_tower, L),
  \+weapon_at_location(chainsaw, rec_room, L),
  suspect_at_location(president_amaranth, rec_room, L),
  same_height_suspect(dean_glaucous, LawyerPerson, L), suspect_had_weapon(LawyerPerson, lawyer, L),
  hair(GoldWatchPerson, brown), suspect_had_weapon(GoldWatchPerson, gold_watch, L),
  suspect_at_location(secretary_celadon, michelin_starred_cafeteria, L),
  suspect_had_weapon(comrade_champagne, rope_of_clothes, L),
  suspect_at_location(officer_copper, movie_theater, L),
  hair(SkeletonKeyPerson, blond), suspect_had_weapon(SkeletonKeyPerson, skeleton_key, L)
.

murdler(P, W, L) :-
  solution(S),
  member([P, W, L], S),
  [P,W,L]=[_, _, tennis_court]
.
