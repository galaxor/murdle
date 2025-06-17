% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  suspects([
    sir_rulean,
    president_amaranth,
    bishop_azure
  ], L),

  % What are the weapons
  weapons([
    rare_vase,
    aluminum_pipe,
    heavy_candle
  ], L),

  % Where are the locations
  locations([
    screening_room,
    grounds,
    bedroom
  ], L),

  % Why are the motives
  motives([
    escape_blackmail,
    silence_a_witness,
    win_an_argument
  ], L),

  % Clues.
  location_motive(screening_room, escape_blackmail, L),
  \+suspect_had_weapon(president_amaranth, heavy_candle, L),
  made_of(WinAnArgumentWeapon, metal), weapon_motive(WinAnArgumentWeapon, win_an_argument, L),
  one_is_lie([
    weapon_at_location(rare_vase, grounds, L),
    suspect_had_weapon(bishop_azure, rare_vase, L)
  ]),
  second_tallest_suspect(SecondTallest, L),
    made_of(SecondTallestWeapon, ceramic),
    suspect_had_weapon(SecondTallest, SecondTallestWeapon, L)
.

murdler(P, W, L, M) :-
  solution(S),
  member([P, W, L, M], S),
  [P, W, L, M]=[_, aluminum_pipe, _, _]
.
