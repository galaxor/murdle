% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  L=[[mayor_honey, _, _],
     [amazing_aureolin, _, _],
     [dean_glaucous, _, _],
     [lord_lavendar, _, _],
     [officer_copper, _, _],
     [baron_maroon, _, _]],

  % What are the weapons
  member([_, poisoned_birthday_cake, _], L),
  member([_, golden_handcuffs, _], L),
  member([_, skeleton_key, _], L),
  member([_, lawyer, _], L),
  member([_, shiv, _], L),
  member([_, rope_of_clothes, _], L),

  % Where are the locations
  member([_, _, private_suite], L),
  member([_, _, rec_room], L),
  member([_, _, guard_tower], L),
  member([_, _, tennis_court], L),
  member([_, _, cafeteria], L),
  member([_, _, spa], L),

  % Clues.
  member([dean_glaucous, _, rec_room], L),
  made_of(SpaWeapon, silk), member([_, SpaWeapon, spa], L),
  member([_, lawyer, tennis_court], L),
  made_of(PrivateSuiteWeapon, frosting), member([_, PrivateSuiteWeapon, private_suite], L),
  member([officer_copper, shiv, _], L),
  member([lord_lavendar, _, tennis_court], L),
  member([baron_maroon, poisoned_birthday_cake, _], L),
  left_handed(GuardTowerPerson), member([GuardTowerPerson, _, guard_tower], L),
  member([amazing_aureolin, skeleton_key, _], L)
.

murdler(P, W, L) :-
  solution(S),
  member([P, W, L], S),
  [P,W,L]=[_, _, cafeteria]
.
