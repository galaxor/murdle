% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  suspects([
    duchess_of_vermillion,
    officer_copper,
    earl_grey,
    chancellor_tuscany,
    grandmaster_rose,
    lady_violet
  ], L),

  no_motives(L),
      
  % What are the weapons
  weapons([
    exploding_cufflinks,
    cabernet_toilet_wine,
    rope_of_clothes,
    murdle_board_game,
    skeleton_key,
    lawyer
  ], L),


  % Where are the locations
  locations([
    michelin_starred_cafeteria,
    movie_theater,
    spa,
    rec_room,
    private_suite,
    tennis_court
  ], L),

  % Clues.
  suspect_had_weapon(chancellor_tuscany, lawyer, L),
  indoors(GrandmasterRosePlace), suspect_at_location(grandmaster_rose, GrandmasterRosePlace, L),
  weapon_at_location(rope_of_clothes, private_suite, L),
  suspect_had_weapon(duchess_of_vermillion, murdle_board_game, L),
  weapon_at_location(skeleton_key, tennis_court, L),
  sign(PrivateSuitePerson, virgo), suspect_at_location(PrivateSuitePerson, private_suite, L),
  suspect_at_location(duchess_of_vermillion, michelin_starred_cafeteria, L),
  weapon_at_location(cabernet_toilet_wine, spa, L),
  member([MovieTheaterPerson, _, _], L),
    same_height(MovieTheaterPerson, duchess_of_vermillion),
    suspect_at_location(MovieTheaterPerson, movie_theater, L)
.

murdler(P, W, L) :-
  solution(S),
  member([P, W, L], S),
  [P,W,L]=[_, exploding_cufflinks, _]
.
