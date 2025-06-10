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
% End of weapon_composition

% We'll incorporate this info into the new format as we encounter it.
heavy_weight(bear_trap).
heavy_weight(crystal_ball).
heavy_weight(golf_cart).
heavy_weight(heavy_painting).
heavy_weight(oar).
heavy_weight(stage_light).

light_weight(ancient_plague).
light_weight(crazed_squirrel).
light_weight(cufflinks).
light_weight(glass_of_wine).
light_weight(gloves).
light_weight(poisoned_tea).

medium_weight(bottle).
medium_weight(dagger).
medium_weight(ordinary_brick).

made_of(ancient_anchor, metal).
made_of(bear_trap, metal).
made_of(boiling_pot, metal).
made_of(boiling_pot, water).
made_of(brick_of_coal, rock).
made_of(brick, clay).
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
