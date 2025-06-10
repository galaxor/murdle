% Predicates to define the scenario for the day.

suspects(Suspects, SolutionList) :- 
    suspects_without_motive(Suspects, SolutionList) 
  ; suspects_with_motive(Suspects, SolutionList)
.
  suspects_without_motive([], []).
  suspects_without_motive([Suspect|Suspects], L) :- L = [[Suspect, _, _] | Rest], suspects_without_motive(Suspects, Rest).

  suspects_with_motive([], []).
  suspects_with_motive([Suspect|Suspects], L) :- L = [[Suspect, _, _, _] | Rest], suspects_with_motive(Suspects, Rest).

weapons(Weapons, SolutionList) :-
    weapons_without_motive(Weapons, SolutionList)
  ; weapons_with_motive(Weapons, SolutionList)
.
  weapons_without_motive([], _).
  weapons_without_motive([Weapon|Weapons], L) :- member([_, Weapon, _], L), weapons_without_motive(Weapons, L).

  weapons_with_motive([], _).
  weapons_with_motive([Weapon|Weapons], L) :- member([_, Weapon, _, _], L), weapons_with_motive(Weapons, L).

locations(Locations, SolutionList) :-
    locations_without_motive(Locations, SolutionList)
  ; locations_with_motive(Locations, SolutionList)
.
locations_without_motive([], _).
locations_without_motive([Location|Locations], L) :- member([_, _, Location], L), locations_without_motive(Locations, L).

locations_with_motive([], _).
locations_with_motive([Location|Locations], L) :- member([_, _, Location, _], L), locations_with_motive(Locations, L).

motives([], _).
motives([Motive|Motives], L) :- member([_, _, _, Motive], L), motives(Motives, L).

% Predicates to describe the clues.
suspect_had_weapon(Suspect, Weapon, SolutionList) :-
    member([Suspect, Weapon, _], SolutionList)
  ; member([Suspect, Weapon, _, _], SolutionList)
.
suspect_at_location(Suspect, Location, SolutionList) :-
    member([Suspect, _, Location], SolutionList)
  ; member([Suspect, _, Location, _], SolutionList)
.
weapon_at_location(Weapon, Location, SolutionList) :-
    member([_, Weapon, Location], SolutionList)
  ; member([_, Weapon, Location, _], SolutionList)
.
suspect_motive(Suspect, Motive, SolutionList) :- member([Suspect, _, _, Motive], SolutionList).
weapon_motive(Weapon, Motive, SolutionList) :- member([_, Weapon, _, Motive], SolutionList).
location_motive(Location, Motive, SolutionList) :- member([_, _, Location, Motive], SolutionList).


% The puzzle can be solved without this specification.
% This is only a performance enhancement so that we don't have to search as
% many potential solutions.
no_motives(SolutionList) :- \+member([_, _, _, _], SolutionList).
with_motives(SolutionList) :- \+member([_, _, _], SolutionList).


% Reasoning about height.
left_taller(P1, P2) :- 
  height(P1, [F1, _]), height(P2, [F2, _]), (F1 > F2);
  height(P1, [F1, I1]), height(P2, [F2, I2]), F1==F2, I1 > I2.

same_height(P1, P2) :- height(P1, [F1, I1]), height(P2, [F2, I2]), F1 == F2, I1 == I2, P1 \== P2.

left_shorter(P1, P2) :- 
  height(P1, [F1, _]), height(P2, [F2, _]), (F1 < F2);
  height(P1, [F1, I1]), height(P2, [F2, I2]), F1==F2, I1 < I2.

shortest([P|[]], P).
shortest([P|[P1|T]], M) :- left_shorter(P, P1), shortest([P|T], M); same_height(P, P1), shortest([P|T], M); left_taller(P, P1), shortest([P1|T], M).

tallest([P|[]], P).
tallest([P|[P1|T]], M) :- left_taller(P, P1), tallest([P|T], M); same_height(P, P1), tallest([P|T], M); left_shorter(P, P1), tallest([P1|T], M).

second_tallest(People, Person) :- 
  findall(H, (member(P, People), height(P, H)), Heights),
  sort(Heights, SortedHeights),
  SortedHeights=[_|[SecondHeight|_]],
  member(Person, People),
  height(Person, SecondHeight)
.

% include/3 is in SWI-Prolog, but not in gprolog.
% Define a polyfill here, I guess??
include(_, [], []).
include(Goal, [A|Rest], [A|TrueRest]) :- call(Goal, A), include(Goal, Rest, TrueRest).
include(Goal, [A|Rest], TrueRest) :- \+call(Goal, A), include(Goal, Rest, TrueRest).


% Succeeds if exactly one of the statements is a lie.
one_is_lie(StatementList) :- include(call, StatementList, TrueStatements), 
  length(StatementList, NumStatements), length(TrueStatements, NumTrueStatements),
  NumStatements =:= NumTrueStatements + 1
.

% Statements are of the form: statement(Speaker, TheirClaim).

% Given a list of statements like
%   [statement(coach_raspberry, sky(blue)), statement(dame_obsidian, delicious(soup))],
% L will become just the statement part, with the speaker extracted:
% In the example above, L would be
%   [sky(blue), delicious(soup)].
% The truth of the statements won't be checked.
statements_list([], []).
statements_list([statement(_, Statement)|StatementsWithSpeaker], L) :-
  L=[Statement|FurtherStatements], statements_list(StatementsWithSpeaker, FurtherStatements)
.

% Given a list of statements like
%   [statement(coach_raspberry, sky(blue)), statement(dame_obsidian, delicious(soup))],
% Liar will become the speaker of the single statement that is false.
% For example, if the soup is not, in fact, delicious, then delicious(soup) fails, and Liar=dame_obsidian.
% If there is more than one liar, then the predicate will fail.
% If there are zero liars, then the predicate will fail.
statements_liar([], _) :- false.
statements_liar([statement(Speaker, Statement)|StatementsWithSpeaker], Liar) :-
    % If the first statement is a lie and all the others are true.
  (\+call(Statement),
    statements_list(StatementsWithSpeaker, Statements),
    include(call, Statements, Truths), 
    length(Truths, N), length(Statements, N), Liar=Speaker)
    % If the first statement is true, check the rest.
  ; (call(Statement), statements_liar(StatementsWithSpeaker, Liar))
.

% What birthdays correspond to what signs?
birthday_sign(Month, Day, aries) :- (Month=march, Day >= 21) ; (Month=april, Day =< 19).
birthday_sign(Month, Day, taurus) :- (Month=april, Day >= 20) ; (Month=may, Day =< 20).
birthday_sign(Month, Day, gemini) :- (Month=may, Day >= 21) ; (Month=june, Day =< 20).
birthday_sign(Month, Day, cancer) :- (Month=june, Day >= 21) ; (Month=july, Day =< 22).
birthday_sign(Month, Day, leo) :- (Month=july, Day >= 23) ; (Month=august, Day =< 22).
birthday_sign(Month, Day, virgo) :- (Month=august, Day >= 23) ; (Month=september, Day =< 22).
birthday_sign(Month, Day, libra) :- (Month=september, Day >= 23) ; (Month=october, Day =< 22).
birthday_sign(Month, Day, scorpio) :- (Month=october, Day >= 23) ; (Month=november, Day =< 21).
birthday_sign(Month, Day, sagittarius) :- (Month=november, Day >= 22) ; (Month=december, Day =< 21).
birthday_sign(Month, Day, capricorn) :- (Month=december, Day >= 22) ; (Month=january, Day =< 19).
birthday_sign(Month, Day, aquarius) :- (Month=january, Day >= 20) ; (Month=february, Day =< 18).
birthday_sign(Month, Day, pisces) :- (Month=february, Day >= 19) ; (Month=march, Day =< 20).


left_handed(Person) :- dossier(Person, height(_,_), handed(left), eyes(_), hair(_), sign(_)).
right_handed(Person) :- dossier(Person, height(_,_), handed(right), eyes(_), hair(_), sign(_)).

height(Person, [Feet, Inches]) :- dossier(Person, height(Feet, Inches), handed(_), eyes(_), hair(_), sign(_)).

sign(Person, Sign) :- dossier(Person, height(_,_), handed(_), eyes(_), hair(_), sign(Sign)).

eyes(Person, Color) :- dossier(Person, height(_,_), handed(_), eyes(Color), hair(_), sign(_)).

hair(Person, Color) :- dossier(Person, height(_,_), handed(_), eyes(_), hair(Color), sign(_)).


% Weapon data
weapon_composition(walking_stick, 
  weight(medium),
  made_of([metal])
).
weapon_composition(climbing_rope,
  weight(light),
  made_of([fiber])
).
weapon_composition(murdle_volume_1,
  weight(medium),
  made_of([paper])
).
weapon_composition(murdle_volume_3,
  weight(medium),
  made_of([paper])
).
weapon_composition(snowglobe,
  weight(medium),
  made_of([metal, glass, water])
).
weapon_composition(laptop,
  weight(medium),
  made_of([metal, plastic])
).
weapon_composition(trained_orangutan,
  weight(heavy),
  made_of([ape_stuff])
).
weapon_composition(magnifying_glass,
  weight(medium),
  made_of([metal, glass])
).
weapon_composition(booby_trapped_fedora,
  weight(medium),
  made_of([redacted])
).
weapon_composition(antique_chess_clock,
  weight(heavy),
  made_of([wood, metal])
).

weapon_composition(poisoned_birthday_cake,
  weight(medium),
  made_of([frosting, chemicals])
).
weapon_composition(golden_handcuffs,
  weight(medium),
  made_of([metal])
).
weapon_composition(skeleton_key,
  weight(light),
  made_of([metal, diamonds])
).
weapon_composition(lawyer,
  weight(heavy),
  made_of([alcohol, greed])
).
weapon_composition(shiv,
  weight(light),
  made_of([metal, plastic])
).
weapon_composition(rope_of_clothes,
  weight(medium),
  made_of([silk])
).
weapon_composition(hammer_and_sickle,
  weight(heavy),
  made_of([metal])
).
weapon_composition(hyper_allergenic_oil,
  weight(light),
  made_of([oil])
).
weapon_composition(crystal_dagger,
  weight(medium),
  made_of([crystal])
).
weapon_composition(ghost_detector,
  weight(medium),
  made_of([metal, tech])
).
weapon_composition(axe,
  weight(medium),
  made_of([metal, wood])
).
weapon_composition(chainsaw,
  weight(heavy),
  made_of([metal, plastic])
).
weapon_composition(angry_llama,
  weight(heavy),
  made_of([hooves, fur])
).
weapon_composition(clapboard,
  weight(medium),
  made_of([wood])
).
weapon_composition(prop_knife,
  weight(light),
  made_of([metal, rubber])
).
weapon_composition(toxic_makeup,
  weight(light),
  made_of([toxins])
).
weapon_composition(antique_typewriter,
  weight(heavy),
  made_of([metal])
).
weapon_composition(piano_wire,
  weight(medium),
  made_of([metal])
).
weapon_composition(poisoned_klonopin,
  weight(light),
  made_of([chemicals])
).
weapon_composition(heavy_candle,
  weight(medium),
  made_of([glass, wax])
).
weapon_composition(murdle_board_game,
  weight(medium),
  made_of([paper])
).
weapon_composition(rare_vase,
  weight(heavy),
  made_of([ceramic])
).
weapon_composition(briefcase_full_of_money,
  weight(heavy),
  made_of([leather, money])
).
weapon_composition(angry_moose,
  weight(heavy),
  made_of([moose])
).
weapon_composition(antique_vase,
  weight(heavy),
  made_of([ceramic])
).
weapon_composition(pencil,
  weight(light),
  made_of([wood])
).
weapon_composition(gold_watch,
  weight(medium),
  made_of([metal])
).
weapon_composition(exploding_cufflinks,
  weight(light),
  made_of([metal])
).
weapon_composition(cabernet_toilet_wine,
  weight(medium),
  made_of([glass, alcohol])
).
weapon_composition(poisoned_goblet,
  weight(medium),
  made_of([metal])
).
weapon_composition(old_heavy_tome,
  weight(heavy),
  made_of([paper, cloth])
).
weapon_composition(surgical_scalpel,
  weight(light),
  made_of([metal])
).
weapon_composition(vial_of_acid,
  weight(light),
  made_of([glass, chemicals])
).
weapon_composition(heavy_microscope,
  weight(heavy),
  made_of([metal, plastic])
).
weapon_composition(heavy_codebook,
  weight(heavy),
  made_of([paper])
).
weapon_composition(trained_vicious_rabbit,
  weight(medium),
  made_of([rabbit, rabbit_fur])
).
weapon_composition(ace_of_spades,
  weight(light),
  made_of([paper])
).
weapon_composition(bottle_of_cheap_liquor,
  weight(light),
  made_of([glass, chemicals])
).
weapon_composition(saw,
  weight(medium),
  made_of([metal, wood])
).
weapon_composition(award,
  weight(medium),
  made_of([metal])
).
weapon_composition(bookie,
  weight(medium),
  made_of([metal])
).
weapon_composition(dvd_box_set,
  weight(medium),
  made_of([wood, paper, plastic])
).
weapon_composition(camera,
  weight(medium),
  made_of([plastic, metal, glass])
).
weapon_composition(aluminum_pipe,
  weight(medium),
  made_of([metal])
).
weapon_composition(jar_of_ashes,
  weight(medium),
  made_of([metal, human_remains])
).

heavy_weight(Weapon) :- weapon_composition(Weapon, weight(heavy), made_of(_)).
light_weight(Weapon) :- weapon_composition(Weapon, weight(light), made_of(_)).
medium_weight(Weapon) :- weapon_composition(Weapon, weight(medium), made_of(_)).

made_of(Weapon, Substance) :- weapon_composition(Weapon, weight(_), made_of(Substances)), member(Substance, Substances).

consult('knowledge-base-suspects.pl').
consult('knowledge-base-weapons.pl').
consult('knowledge-base-locations.pl').
