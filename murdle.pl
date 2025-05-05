% Reasoning about height.
% left_taller([F1, I1], [F2, I2]) :- (F1 > F2); (F1=:=F2, I1 > I2).
% same_height([F1, I1], [F2, I2]) :- F1 =:= F2, I1 =:= I2.
% left_shorter([F1, I1], [F2, I2]) :- (F1 < F2); (F1=:=F2, I1 < I2).

left_taller(P1, P2) :- 
  height(P1, [F1, I1]), height(P2, [F2, I2]), (F1 > F2);
  height(P1, [F1, I1]), height(P2, [F2, I2]), F1==F2, I1 > I2.

same_height(P1, P2) :- height(P1, [F1, I1]), height(P2, [F2, I2]), F1 == F2, I1 == I2.

left_shorter(P1, P2) :- 
  height(P1, [F1, I1]), height(P2, [F2, I2]), (F1 < F2);
  height(P1, [F1, I1]), height(P2, [F2, I2]), F1==F2, I1 < I2.


tallest([P|[]], P).
tallest([P|[P1|T]], M) :- tallest([P|T], M), left_taller(P, P1); tallest([P|T], M), same_height(P, P1); tallest([P1|T], M), left_shorter(P, P1).


% Biographical Info
% I wonder if this information is always the same for each of these people.
% I'll add to this as each day's clues make the info relevant.  Eventually,
% I'll have a full roster of info on all the people that exist and all the
% weapons that exist.
% I mean, assuming the info isn't randomly generated for each puzzle.

right_handed(president_amaranth).
right_handed(vice_president_mauve).
right_handed(babyface_blue).
right_handed(silverton_the_legend).
left_handed(signor_emerald).
left_handed(mx_tangerine).

height(president_amaranth, [5,10]).
height(vice_president_mauve, [5,8]).
height(babyface_blue, [7,8]).
height(silverton_the_legend, [6,4]).
height(signor_emerald, [5,8]).
height(mx_tangerine, [5,5]).


% Weapon data
medium_weight(bottle).
medium_weight(cake).
light_weight(key).
light_weight(shiv).
light_weight(cufflinks).
heavy_weight(lawyer).


% This solves 2025-05-04.
% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L) :-
  % Basic setup.
  % Who is there
  L=[[president_amaranth, _, _],
     [vice_president_mauve, _, _],
     [babyface_blue, _, _],
     [silverton_the_legend, _, _],
     [signor_emerald, _, _],
     [mx_tangerine, _, _]],

  % What are the weapons
  member([_, bottle, _], L),
  member([_, cake, _], L),
  member([_, key, _], L),
  member([_, shiv, _], L),
  member([_, cufflinks, _], L),
  member([_, lawyer, _], L),

  % Where are the locations
  member([_, _, rec_room], L),
  member([_, _, private_suite], L),
  member([_, _, guard_tower], L),
  member([_, _, spa], L),
  member([_, _, cafeteria], L),
  member([_, _, theater], L),

  % Clues.
  member([P1, _, spa], L), left_handed(P1),
  member([silverton_the_legend, _, theater], L),
  member([_, cufflinks, guard_tower], L),
  member([signor_emerald, _, rec_room], L), % The suspect with the same height as vice president mauve
  member([Tallest, _, private_suite], L), findall(P2, height(P2, _), People), tallest(People, Tallest),
  member([mx_tangerine, key, _], L),
  member([_, cake, rec_room], L),
  member([president_amaranth, W1, _], L), medium_weight(W1),
  member([_, shiv, private_suite], L)
.

murdler(P, W, L) :-
  solution(S),
  member([P, W, L], S),
  [P, W, L]=[_, _, cafeteria]
.
