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
  member([chancellor_tuscany, lawyer, _], L),
  indoors(GrandmasterRosePlace), member([grandmaster_rose, _, GrandmasterRosePlace], L),
  member([_, rope_of_clothes, private_suite], L),
  member([duchess_of_vermillion, murdle_board_game, _], L),
  member([_, skeleton_key, tennis_court], L),
  sign(PrivateSuitePerson, virgo), member([PrivateSuitePerson, _, private_suite], L),
  member([duchess_of_vermillion, _, michelin_starred_cafeteria], L),
  member([_, cabernet_toilet_wine, spa], L),
  member([MovieTheaterPerson, _, _], L),
    same_height(MovieTheaterPerson, duchess_of_vermillion),
    member([MovieTheaterPerson, _, movie_theater], L)
.

murdler(P, W, L) :-
  solution(S),
  member([P, W, L], S),
  [P,W,L]=[_, exploding_cufflinks, _]
.
