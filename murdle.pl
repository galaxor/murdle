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


% Biographical Info
dossier(secretary_celadon,
  height(5,6),
  handed(left),
  eyes(green),
  hair(brown),
  sign(leo)
).

dossier(principal_applegreen,
  height(5,11),
  handed(right),
  eyes(blue),
  hair(none),
  sign(libra)
).

dossier(grandmaster_rose,
  height(5,7),
  handed(left),
  eyes(brown),
  hair(brown),
  sign(scorpio)
).

dossier(signor_emerald,
  height(5,8),
  handed(left),
  eyes(brown),
  hair(black),
  sign(sagittarius)
).

dossier(officer_copper,
  height(5,5),
  handed(right),
  eyes(blue),
  hair(blond),
  sign(aries)
).

dossier(coach_raspberry,
  height(6,0),
  handed(left),
  eyes(blue),
  hair(blond),
  sign(aries)
).

dossier(baron_maroon,
  height(6,2),
  handed(right),
  eyes(hazel),
  hair(red),
  sign(scorpio)
).

dossier(captain_slate,
  height(5,5),
  handed(left),
  eyes(brown),
  hair(brown),
  sign(aquarius)
).

dossier(mx_tangerine,
  height(5,5),
  handed(left),
  eyes(hazel),
  hair(blond),
  sign(pisces)
).

dossier(mayor_honey,
  height(6,0),
  handed(left),
  eyes(hazel),
  hair(brown),
  sign(scorpio)
).

dossier(amazing_aureolin,
  height(5,6),
  handed(left),
  eyes(green),
  hair(blond),
  sign(aries)
).

dossier(dean_glaucous,
  height(5,6),
  handed(right),
  eyes(brown),
  hair(brown),
  sign(virgo)
).

dossier(lord_lavendar,
  height(5,9),
  handed(right),
  eyes(green),
  hair(grey),
  sign(virgo)
).

dossier(miss_ruby,
  height(5,6),
  handed(right),
  eyes(green),
  hair(red),
  sign(libra)
).

dossier(viscount_eminence,
  height(5,2),
  handed(left),
  eyes(grey),
  hair(brown),
  sign(pisces)
).

dossier(duchess_of_vermillion,
  height(5,9),
  handed(left),
  eyes(grey),
  hair(white),
  sign(pisces)
).

dossier(uncle_midnight,
  height(5,8),
  handed(left),
  eyes(blue),
  hair(brown),
  sign(sagittarius)
).

dossier(sister_lapis,
  height(5,2),
  handed(right),
  eyes(brown),
  hair(brown),
  sign(cancer)
).

dossier(babyface_blue,
  height(7,8),
  handed(right),
  eyes(blue),
  hair(blond),
  sign(gemini)
).

dossier(chancellor_tuscany,
  height(5,5),
  handed(left),
  eyes(green),
  hair(grey),
  sign(libra)
).

dossier(judge_pine,
  height(5,6),
  handed(right),
  eyes(brown),
  hair(black),
  sign(taurus)
).

dossier(admiral_navy,
  height(5,9),
  handed(right),
  eyes(blue),
  hair(brown),
  sign(cancer)
).

dossier(brother_brownstone,
  height(5,4),
  handed(left),
  eyes(brown),
  hair(brown),
  sign(capricorn)
).

dossier(sir_rulean,
  height(5,8),
  handed(right),
  eyes(blue),
  hair(red),
  sign(leo)
).

dossier(agent_fuchsia,
  height(5,8),
  handed(left),
  eyes(brown),
  hair(brown),
  sign(virgo)
).

dossier(general_coffee,
  height(6,0),
  handed(right),
  eyes(brown),
  hair(none),
  sign(sagittarius)
).

dossier(miss_saffron,
  height(5,2),
  handed(left),
  eyes(hazel),
  hair(blond),
  sign(libra)
).

dossier(president_amaranth,
  height(5,10),
  handed(right),
  eyes(grey),
  hair(red),
  sign(gemini)
).

dossier(chef_aubergine,
  height(5,2),
  handed(right),
  eyes(blue),
  hair(blond),
  sign(libra)
).

dossier(father_mango,
  height(5,10),
  handed(left),
  eyes(brown),
  hair(none),
  sign(taurus)
).

dossier(lady_violet,
  height(5,10),
  handed(right),
  eyes(blue),
  hair(blond),
  sign(virgo)
).

% End of dossiers


left_handed(Person) :- dossier(Person, height(_,_), handed(left), eyes(_), hair(_), sign(_)).
left_handed(major_red).

right_handed(Person) :- dossier(Person, height(_,_), handed(right), eyes(_), hair(_), sign(_)).
right_handed(silverton_the_legend).
right_handed(vice_president_mauve).

height(Person, [Feet, Inches]) :- dossier(Person, height(Feet, Inches), handed(_), eyes(_), hair(_), sign(_)).
height(deacon_verdigris, [5,3]).
height(dr_crimson, [5,9]).
height(earl_grey, [5,9]).
height(silverton_the_legend, [6,4]).
height(vice_president_mauve, [5,8]).

sign(Person, Sign) :- dossier(Person, height(_,_), handed(_), eyes(_), hair(_), sign(Sign)).
sign(dame_obsidian, leo).
sign(deacon_verdigris, leo).
sign(dr_crimson, aquarius).
sign(earl_grey, capricorn).
sign(secretary_celadon, leo).
sign(vice_president_mauve, taurus).


eyes(Person, Color) :- dossier(Person, height(_,_), handed(_), eyes(Color), hair(_), sign(_)).
eyes(bishop_azure, brown).
eyes(deacon_verdigris, blue).
eyes(dr_crimson, green).
eyes(earl_grey, brown).
eyes(major_red, brown).
eyes(silverton_the_legend, blue).
eyes(vice_president_mauve, brown).

hair(Person, Color) :- dossier(Person, height(_,_), handed(_), eyes(_), hair(Color), sign(_)).
hair(bishop_azure, brown).
hair(deacon_verdigris, grey).
hair(dr_crimson, red).
hair(silverton_the_legend, silver).


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


% End of weapon_composition
  

heavy_weight(Weapon) :- weapon_composition(Weapon, weight(heavy), made_of(_)).
heavy_weight(bear_trap).
heavy_weight(crystal_ball).
heavy_weight(golf_cart).
heavy_weight(heavy_painting).
heavy_weight(oar).
heavy_weight(stage_light).

light_weight(Weapon) :- weapon_composition(Weapon, weight(light), made_of(_)).
light_weight(ancient_plague).
light_weight(crazed_squirrel).
light_weight(cufflinks).
light_weight(glass_of_wine).
light_weight(gloves).
light_weight(poisoned_tea).

medium_weight(Weapon) :- weapon_composition(Weapon, weight(medium), made_of(_)).
medium_weight(award).
medium_weight(bottle).
medium_weight(camera).
medium_weight(dagger).
medium_weight(ordinary_brick).

made_of(Weapon, Substance) :- weapon_composition(Weapon, weight(_), made_of(Substances)), member(Substance, Substances).
made_of(ancient_anchor, metal).
made_of(award, metal).
made_of(bear_trap, metal).
made_of(boiling_pot, metal).
made_of(boiling_pot, water).
made_of(brick_of_coal, rock).
made_of(brick, clay).
made_of(camera, glass).
made_of(camera, metal).
made_of(camera, plastic).
made_of(climbing_axe, metal).
made_of(climbing_axe, wood).
made_of(corgi_stampede, corgis).
made_of(glass_of_wine, alcohol).
made_of(glass_of_wine, chemicals).
made_of(glass_of_wine, glass).
made_of(golf_cart, metal).
made_of(golf_cart, plastic).
made_of(golf_cart, rubber).
made_of(heavy_painting, canvas).
made_of(heavy_painting, paint).
made_of(heavy_painting, wood).
made_of(holy_relic, bone).
made_of(italian_knife, leather).
made_of(italian_knife, metal).
made_of(karate_hands, hands).
made_of(metal_straw, metal).
made_of(metal_straw, wood).
made_of(oar, wood).
made_of(ordinary_brick, brick).
made_of(poisoned_champagne, glass).
made_of(poisoned_champagne, toxins).
made_of(poisoned_tea, ceramic).
made_of(poisoned_tea, liquid).
made_of(stage_light, glass).
made_of(stage_light, metal).
made_of(steering_wheel, wood).
made_of(venemous_spider, live_animal).
made_of(wine, glass).
made_of(yarn, wool).

% Location data
indoors(bedroom).
indoors(break_room).
indoors(close_up_table).
indoors(enormous_bathroom).
indoors(guard_tower).
indoors(locked_stage).
indoors(lonely_tower).
indoors(luxury_theater).
indoors(main_house).
indoors(main_stage).
indoors(meeting_house).
indoors(michelin_starred_cafeteria).
indoors(mysterious_mansion).
indoors(observatory).
indoors(piano_room).
indoors(private_library).
indoors(private_suite).
indoors(prop_shop).
indoors(rec_room).
indoors(richest_patients_room).
indoors(screening_room).
indoors(secret_chamber).
indoors(spa).
indoors(waiting_room).
indoors(watertower_bar_grill).
outdoors(ancient_ruins).
outdoors(city_backlot).
outdoors(cliffs).
outdoors(docks).
outdoors(entrance_gate).
outdoors(garden_maze).
outdoors(grounds).
outdoors(haunted_grove).
outdoors(hedge_maze).
outdoors(locked_gate).
outdoors(minigolf_course).
outdoors(roof).
outdoors(screaming_forest).
outdoors(statue_of_midnight).
outdoors(stone_bridge).
outdoors(studio_tour_check_in_stand).
outdoors(tennis_court).
outdoors(upstairs_balcony).
