% The idea for this implementation came from this blog post:
% https://bennycheung.github.io/using-prolog-to-solve-logic-puzzles
solution(L) :-
  % Basic setup.
  consult(murdle),

  % Who is there
  L=[[president_amaranth, _, _],
     [sir_rulean, _, _],
     [lord_lavendar, _, _],
     [chancellor_tuscany, _, _]],

  % What are the weapons
  member([_, surgical_scalpel, _], L),
  member([_, vial_of_acid, _], L),
  member([_, heavy_microscope, _], L),
  member([_, heavy_codebook, _], L),

  % Where are the locations
  member([_, _, waiting_room], L),
  member([_, _, roof], L),
  member([_, _, break_room], L),
  member([_, _, richest_patients_room], L),

  % Clues.
  right_handed(RoofPerson), member([RoofPerson, _, roof], L),
  made_of(SirRuleanWeapon, metal), member([sir_rulean, SirRuleanWeapon, _], L),
  one_is_lie([
    member([chancellor_tuscany, vial_of_acid, _], L),
    member([sir_rulean, _, break_room], L)
  ]),
  \+member([president_amaranth, heavy_codebook, _], L),
  member([lord_lavendar, _, richest_patients_room], L),
  sign(MicroscopePerson, libra), member([MicroscopePerson, heavy_microscope, _], L)
.

murdler(P, W, L) :-
  solution(S),
  member([P, W, L], S),
  [P, W, L]=[_, _, waiting_room]
.
