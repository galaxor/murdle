% This solves 2025-05-08.
% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  L=[[mayor_honey, _, _],
     [lady_violet, _, _],
     [deacon_verdigris, _, _],
     [earl_grey, _, _]],

  % What are the weapons
  member([_, first_place_trophy, _], L),
  member([_, golf_balls, _], L),
  member([_, bookie, _], L),
  member([_, wine, _], L),

  % Where are the locations
  member([_, _, tennis_court], L),
  member([_, _, caddy_shack], L),
  member([_, _, lounge], L),
  member([_, _, pool], L),

  % Clues.
  eyes(GolfBallPerson, brown), member([GolfBallPerson, golf_balls, _], L),
  (
    (member([mayor_honey, _, tennis_court], L), \+member([deacon_verdigris, _, caddy_shack], L))
    ; (\+member([mayor_honey, _, tennis_court], L), member([deacon_verdigris, _, caddy_shack], L))
  ),
  \+member([lady_violet, bookie, _], L),
  member([_, bookie, lounge], L),
  sign(CaddyShackPerson, capricorn), member([CaddyShackPerson, _, caddy_shack], L),
  findall(Person, member([Person, _, _], L), People),
    shortest(People, ShortestPerson),
    \+member([ShortestPerson, wine, _], L)
.

murdler(P, W, L) :-
  solution(S),
  member([P, W, L], S),
  [P, W, L] = [P, W, pool]
.
