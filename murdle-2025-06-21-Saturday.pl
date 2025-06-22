% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L, Liar) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  suspects([
    vice_president_mauve,
    duchess_of_vermillion,
    brother_brownstone,
    dean_glaucous
  ], L),

  % What are the weapons
  weapons([
    stone_dagger,
    pair_of_leather_gloves,
    snowglobe,
    climbing_rope
  ], L),

  % Where are the locations
  locations([
    boutique_hotel,
    five_star_restaurant,
    real_estate_office,
    trailhead
  ], L),

  % Why are the motives
  motives([
    kill,
    rage_with_jealousy,
    escape_blackmail,
    break_into_the_industry
  ], L),

  % Clues.
  weapon_motive(snowglobe, escape_blackmail, L),
  suspect_at_location(brother_brownstone, five_star_restaurant, L),
  \+suspect_motive(vice_president_mauve, kill, L),
  suspect_motive(dean_glaucous, rage_with_jealousy, L),
  location_motive(real_estate_office, break_into_the_industry, L),
  \+suspect_had_weapon(duchess_of_vermillion, stone_dagger, L),
  eyes(ClimbingRopePerson, brown), suspect_had_weapon(ClimbingRopePerson, climbing_rope, L),
  statements_liar([
    statement(vice_president_mauve, \+weapon_at_location(stone_dagger, boutique_hotel, L)),
    statement(duchess_of_vermillion, \+suspect_at_location(vice_president_mauve, five_star_restaurant, L)),
    statement(brother_brownstone, suspect_had_weapon(vice_president_mauve, snowglobe, L)),
    statement(dean_glaucous, suspect_at_location(vice_president_mauve, boutique_hotel, L))
  ], Liar)
.

murdler(Liar, W, L, M) :-
  solution(S, Liar),
  member([Liar, W, L, M], S)
.
