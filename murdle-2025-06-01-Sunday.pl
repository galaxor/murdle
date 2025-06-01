% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  L=[[miss_ruby, _, _],
     [uncle_midnight, _, _],
     [babyface_blue, _, _],
     [admiral_navy, _, _],
     [general_coffee, _, _],
     [chef_aubergine, _, _]],

  % What are the weapons
  member([_, gold_watch, _], L),
  member([_, lawyer, _], L),
  member([_, rope_of_clothes, _], L),
  member([_, exploding_cufflinks, _], L),
  member([_, golden_handcuffs, _], L),
  member([_, cabernet_toilet_wine, _], L),

  % Where are the locations
  member([_, _, private_suite], L),
  member([_, _, michelin_starred_cafeteria], L),
  member([_, _, guard_tower], L),
  member([_, _, rec_room], L),
  member([_, _, spa], L),
  member([_, _, tennis_court], L),

  % Clues.
  sign(SpaPerson, libra), member([SpaPerson, _, spa], L),
  member([miss_ruby, cabernet_toilet_wine, _], L),
  member([general_coffee, _, guard_tower], L),
  member([chef_aubergine, _, private_suite], L),
  eyes(ClothesPerson, brown), member([ClothesPerson, rope_of_clothes, _], L),
  findall(Person, member([Person, _, _], L), People),
    shortest(People, Shortest),
    member([Shortest, gold_watch, _], L),
  member([_, lawyer, michelin_starred_cafeteria], L),
  member([admiral_navy, exploding_cufflinks, _], L),
  member([babyface_blue, _, rec_room], L)
.

murdler(P, W, L) :-
  solution(S),
  member([P, W, L], S),
  [P,W,L]=[_, golden_handcuffs, _]
.
