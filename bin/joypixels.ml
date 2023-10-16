let step = function
  | 0x1faf6 :: 0x1f3ff :: rest -> Some ("heart_hands_tone5", rest)
  | 0x1faf6 :: 0x1f3fe :: rest -> Some ("heart_hands_tone4", rest)
  | 0x1faf6 :: 0x1f3fd :: rest -> Some ("heart_hands_tone3", rest)
  | 0x1faf6 :: 0x1f3fc :: rest -> Some ("heart_hands_tone2", rest)
  | 0x1faf6 :: 0x1f3fb :: rest -> Some ("heart_hands_tone1", rest)
  | 0x1faf6 :: rest -> Some ("heart_hands", rest)
  | 0x1faf5 :: 0x1f3ff :: rest ->
      Some ("index_pointing_at_the_viewer_tone5", rest)
  | 0x1faf5 :: 0x1f3fe :: rest ->
      Some ("index_pointing_at_the_viewer_tone4", rest)
  | 0x1faf5 :: 0x1f3fd :: rest ->
      Some ("index_pointing_at_the_viewer_tone3", rest)
  | 0x1faf5 :: 0x1f3fc :: rest ->
      Some ("index_pointing_at_the_viewer_tone2", rest)
  | 0x1faf5 :: 0x1f3fb :: rest ->
      Some ("index_pointing_at_the_viewer_tone1", rest)
  | 0x1faf5 :: rest -> Some ("index_pointing_at_the_viewer", rest)
  | 0x1faf4 :: 0x1f3ff :: rest -> Some ("palm_up_hand_tone5", rest)
  | 0x1faf4 :: 0x1f3fe :: rest -> Some ("palm_up_hand_tone4", rest)
  | 0x1faf4 :: 0x1f3fd :: rest -> Some ("palm_up_hand_tone3", rest)
  | 0x1faf4 :: 0x1f3fc :: rest -> Some ("palm_up_hand_tone2", rest)
  | 0x1faf4 :: 0x1f3fb :: rest -> Some ("palm_up_hand_tone1", rest)
  | 0x1faf4 :: rest -> Some ("palm_up_hand", rest)
  | 0x1faf3 :: 0x1f3ff :: rest -> Some ("palm_down_hand_tone5", rest)
  | 0x1faf3 :: 0x1f3fe :: rest -> Some ("palm_down_hand_tone4", rest)
  | 0x1faf3 :: 0x1f3fd :: rest -> Some ("palm_down_hand_tone3", rest)
  | 0x1faf3 :: 0x1f3fc :: rest -> Some ("palm_down_hand_tone2", rest)
  | 0x1faf3 :: 0x1f3fb :: rest -> Some ("palm_down_hand_tone1", rest)
  | 0x1faf3 :: rest -> Some ("palm_down_hand", rest)
  | 0x1faf2 :: 0x1f3ff :: rest -> Some ("leftwards_hand_tone5", rest)
  | 0x1faf2 :: 0x1f3fe :: rest -> Some ("leftwards_hand_tone4", rest)
  | 0x1faf2 :: 0x1f3fd :: rest -> Some ("leftwards_hand_tone3", rest)
  | 0x1faf2 :: 0x1f3fc :: rest -> Some ("leftwards_hand_tone2", rest)
  | 0x1faf2 :: 0x1f3fb :: rest -> Some ("leftwards_hand_tone1", rest)
  | 0x1faf2 :: rest -> Some ("leftwards_hand", rest)
  | 0x1faf1 :: 0x1f3ff :: 0x200d :: 0x1faf2 :: 0x1f3fe :: rest ->
      Some ("handshake_tone5_tone4", rest)
  | 0x1faf1 :: 0x1f3ff :: 0x200d :: 0x1faf2 :: 0x1f3fd :: rest ->
      Some ("handshake_tone5_tone3", rest)
  | 0x1faf1 :: 0x1f3ff :: 0x200d :: 0x1faf2 :: 0x1f3fc :: rest ->
      Some ("handshake_tone5_tone2", rest)
  | 0x1faf1 :: 0x1f3ff :: 0x200d :: 0x1faf2 :: 0x1f3fb :: rest ->
      Some ("handshake_tone5_tone1", rest)
  | 0x1faf1 :: 0x1f3ff :: rest -> Some ("rightwards_hand_tone5", rest)
  | 0x1faf1 :: 0x1f3fe :: 0x200d :: 0x1faf2 :: 0x1f3ff :: rest ->
      Some ("handshake_tone4_tone5", rest)
  | 0x1faf1 :: 0x1f3fe :: 0x200d :: 0x1faf2 :: 0x1f3fd :: rest ->
      Some ("handshake_tone4_tone3", rest)
  | 0x1faf1 :: 0x1f3fe :: 0x200d :: 0x1faf2 :: 0x1f3fc :: rest ->
      Some ("handshake_tone4_tone2", rest)
  | 0x1faf1 :: 0x1f3fe :: 0x200d :: 0x1faf2 :: 0x1f3fb :: rest ->
      Some ("handshake_tone4_tone1", rest)
  | 0x1faf1 :: 0x1f3fe :: rest -> Some ("rightwards_hand_tone4", rest)
  | 0x1faf1 :: 0x1f3fd :: 0x200d :: 0x1faf2 :: 0x1f3ff :: rest ->
      Some ("handshake_tone3_tone5", rest)
  | 0x1faf1 :: 0x1f3fd :: 0x200d :: 0x1faf2 :: 0x1f3fe :: rest ->
      Some ("handshake_tone3_tone4", rest)
  | 0x1faf1 :: 0x1f3fd :: 0x200d :: 0x1faf2 :: 0x1f3fc :: rest ->
      Some ("handshake_tone3_tone2", rest)
  | 0x1faf1 :: 0x1f3fd :: 0x200d :: 0x1faf2 :: 0x1f3fb :: rest ->
      Some ("handshake_tone3_tone1", rest)
  | 0x1faf1 :: 0x1f3fd :: rest -> Some ("rightwards_hand_tone3", rest)
  | 0x1faf1 :: 0x1f3fc :: 0x200d :: 0x1faf2 :: 0x1f3ff :: rest ->
      Some ("handshake_tone2_tone5", rest)
  | 0x1faf1 :: 0x1f3fc :: 0x200d :: 0x1faf2 :: 0x1f3fe :: rest ->
      Some ("handshake_tone2_tone4", rest)
  | 0x1faf1 :: 0x1f3fc :: 0x200d :: 0x1faf2 :: 0x1f3fd :: rest ->
      Some ("handshake_tone2_tone3", rest)
  | 0x1faf1 :: 0x1f3fc :: 0x200d :: 0x1faf2 :: 0x1f3fb :: rest ->
      Some ("handshake_tone2_tone1", rest)
  | 0x1faf1 :: 0x1f3fc :: rest -> Some ("rightwards_hand_tone2", rest)
  | 0x1faf1 :: 0x1f3fb :: 0x200d :: 0x1faf2 :: 0x1f3ff :: rest ->
      Some ("handshake_tone1_tone5", rest)
  | 0x1faf1 :: 0x1f3fb :: 0x200d :: 0x1faf2 :: 0x1f3fe :: rest ->
      Some ("handshake_tone1_tone4", rest)
  | 0x1faf1 :: 0x1f3fb :: 0x200d :: 0x1faf2 :: 0x1f3fd :: rest ->
      Some ("handshake_tone1_tone3", rest)
  | 0x1faf1 :: 0x1f3fb :: 0x200d :: 0x1faf2 :: 0x1f3fc :: rest ->
      Some ("handshake_tone1_tone2", rest)
  | 0x1faf1 :: 0x1f3fb :: rest -> Some ("rightwards_hand_tone1", rest)
  | 0x1faf1 :: rest -> Some ("rightwards_hand", rest)
  | 0x1faf0 :: 0x1f3ff :: rest ->
      Some ("hand_with_index_finger_and_thumb_crossed_tone5", rest)
  | 0x1faf0 :: 0x1f3fe :: rest ->
      Some ("hand_with_index_finger_and_thumb_crossed_tone4", rest)
  | 0x1faf0 :: 0x1f3fd :: rest ->
      Some ("hand_with_index_finger_and_thumb_crossed_tone3", rest)
  | 0x1faf0 :: 0x1f3fc :: rest ->
      Some ("hand_with_index_finger_and_thumb_crossed_tone2", rest)
  | 0x1faf0 :: 0x1f3fb :: rest ->
      Some ("hand_with_index_finger_and_thumb_crossed_tone1", rest)
  | 0x1faf0 :: rest -> Some ("hand_with_index_finger_and_thumb_crossed", rest)
  | 0x1fae7 :: rest -> Some ("bubbles", rest)
  | 0x1fae6 :: rest -> Some ("biting_lip", rest)
  | 0x1fae5 :: rest -> Some ("dotted_line_face", rest)
  | 0x1fae4 :: rest -> Some ("face_with_diagonal_mouth", rest)
  | 0x1fae3 :: rest -> Some ("face_with_peeking_eye", rest)
  | 0x1fae2 :: rest -> Some ("face_with_open_eyes_and_hand_over_mouth", rest)
  | 0x1fae1 :: rest -> Some ("saluting_face", rest)
  | 0x1fae0 :: rest -> Some ("melting_face", rest)
  | 0x1fad9 :: rest -> Some ("jar", rest)
  | 0x1fad8 :: rest -> Some ("beans", rest)
  | 0x1fad7 :: rest -> Some ("pouring_liquid", rest)
  | 0x1fad6 :: rest -> Some ("teapot", rest)
  | 0x1fad5 :: rest -> Some ("fondue", rest)
  | 0x1fad4 :: rest -> Some ("tamale", rest)
  | 0x1fad3 :: rest -> Some ("flatbread", rest)
  | 0x1fad2 :: rest -> Some ("olive", rest)
  | 0x1fad1 :: rest -> Some ("bell_pepper", rest)
  | 0x1fad0 :: rest -> Some ("blueberries", rest)
  | 0x1fac5 :: 0x1f3ff :: rest -> Some ("person_with_crown_tone5", rest)
  | 0x1fac5 :: 0x1f3fe :: rest -> Some ("person_with_crown_tone4", rest)
  | 0x1fac5 :: 0x1f3fd :: rest -> Some ("person_with_crown_tone3", rest)
  | 0x1fac5 :: 0x1f3fc :: rest -> Some ("person_with_crown_tone2", rest)
  | 0x1fac5 :: 0x1f3fb :: rest -> Some ("person_with_crown_tone1", rest)
  | 0x1fac5 :: rest -> Some ("person_with_crown", rest)
  | 0x1fac4 :: 0x1f3ff :: rest -> Some ("pregnant_person_tone5", rest)
  | 0x1fac4 :: 0x1f3fe :: rest -> Some ("pregnant_person_tone4", rest)
  | 0x1fac4 :: 0x1f3fd :: rest -> Some ("pregnant_person_tone3", rest)
  | 0x1fac4 :: 0x1f3fc :: rest -> Some ("pregnant_person_tone2", rest)
  | 0x1fac4 :: 0x1f3fb :: rest -> Some ("pregnant_person_tone1", rest)
  | 0x1fac4 :: rest -> Some ("pregnant_person", rest)
  | 0x1fac3 :: 0x1f3ff :: rest -> Some ("pregnant_man_tone5", rest)
  | 0x1fac3 :: 0x1f3fe :: rest -> Some ("pregnant_man_tone4", rest)
  | 0x1fac3 :: 0x1f3fd :: rest -> Some ("pregnant_man_tone3", rest)
  | 0x1fac3 :: 0x1f3fc :: rest -> Some ("pregnant_man_tone2", rest)
  | 0x1fac3 :: 0x1f3fb :: rest -> Some ("pregnant_man_tone1", rest)
  | 0x1fac3 :: rest -> Some ("pregnant_man", rest)
  | 0x1fac2 :: rest -> Some ("people_hugging", rest)
  | 0x1fac1 :: rest -> Some ("lungs", rest)
  | 0x1fac0 :: rest -> Some ("anatomical_heart", rest)
  | 0x1faba :: rest -> Some ("nest_with_eggs", rest)
  | 0x1fab9 :: rest -> Some ("empty_nest", rest)
  | 0x1fab8 :: rest -> Some ("coral", rest)
  | 0x1fab7 :: rest -> Some ("lotus", rest)
  | 0x1fab6 :: rest -> Some ("feather", rest)
  | 0x1fab5 :: rest -> Some ("wood", rest)
  | 0x1fab4 :: rest -> Some ("potted_plant", rest)
  | 0x1fab3 :: rest -> Some ("cockroach", rest)
  | 0x1fab2 :: rest -> Some ("beetle", rest)
  | 0x1fab1 :: rest -> Some ("worm", rest)
  | 0x1fab0 :: rest -> Some ("fly", rest)
  | 0x1faac :: rest -> Some ("hamsa", rest)
  | 0x1faab :: rest -> Some ("low_battery", rest)
  | 0x1faaa :: rest -> Some ("identification_card", rest)
  | 0x1faa9 :: rest -> Some ("mirror_ball", rest)
  | 0x1faa8 :: rest -> Some ("rock", rest)
  | 0x1faa7 :: rest -> Some ("placard", rest)
  | 0x1faa6 :: rest -> Some ("headstone", rest)
  | 0x1faa5 :: rest -> Some ("toothbrush", rest)
  | 0x1faa4 :: rest -> Some ("mouse_trap", rest)
  | 0x1faa3 :: rest -> Some ("bucket", rest)
  | 0x1faa2 :: rest -> Some ("knot", rest)
  | 0x1faa1 :: rest -> Some ("sewing_needle", rest)
  | 0x1faa0 :: rest -> Some ("plunger", rest)
  | 0x1fa9f :: rest -> Some ("window", rest)
  | 0x1fa9e :: rest -> Some ("mirror", rest)
  | 0x1fa9d :: rest -> Some ("hook", rest)
  | 0x1fa9c :: rest -> Some ("ladder", rest)
  | 0x1fa9b :: rest -> Some ("screwdriver", rest)
  | 0x1fa9a :: rest -> Some ("carpentry_saw", rest)
  | 0x1fa99 :: rest -> Some ("coin", rest)
  | 0x1fa98 :: rest -> Some ("long_drum", rest)
  | 0x1fa97 :: rest -> Some ("accordion", rest)
  | 0x1fa96 :: rest -> Some ("military_helmet", rest)
  | 0x1fa95 :: rest -> Some ("banjo", rest)
  | 0x1fa94 :: rest -> Some ("diya_lamp", rest)
  | 0x1fa93 :: rest -> Some ("axe", rest)
  | 0x1fa92 :: rest -> Some ("razor", rest)
  | 0x1fa91 :: rest -> Some ("chair", rest)
  | 0x1fa90 :: rest -> Some ("ringed_planet", rest)
  | 0x1fa86 :: rest -> Some ("nesting_dolls", rest)
  | 0x1fa85 :: rest -> Some ("pinata", rest)
  | 0x1fa84 :: rest -> Some ("magic_wand", rest)
  | 0x1fa83 :: rest -> Some ("boomerang", rest)
  | 0x1fa82 :: rest -> Some ("parachute", rest)
  | 0x1fa81 :: rest -> Some ("kite", rest)
  | 0x1fa80 :: rest -> Some ("yo_yo", rest)
  | 0x1fa7c :: rest -> Some ("crutch", rest)
  | 0x1fa7b :: rest -> Some ("x_ray", rest)
  | 0x1fa7a :: rest -> Some ("stethoscope", rest)
  | 0x1fa79 :: rest -> Some ("adhesive_bandage", rest)
  | 0x1fa78 :: rest -> Some ("drop_of_blood", rest)
  | 0x1fa74 :: rest -> Some ("thong_sandal", rest)
  | 0x1fa73 :: rest -> Some ("shorts", rest)
  | 0x1fa72 :: rest -> Some ("briefs", rest)
  | 0x1fa71 :: rest -> Some ("one_piece_swimsuit", rest)
  | 0x1fa70 :: rest -> Some ("ballet_shoes", rest)
  | 0x1f9ff :: rest -> Some ("nazar_amulet", rest)
  | 0x1f9fe :: rest -> Some ("receipt", rest)
  | 0x1f9fd :: rest -> Some ("sponge", rest)
  | 0x1f9fc :: rest -> Some ("soap", rest)
  | 0x1f9fb :: rest -> Some ("roll_of_paper", rest)
  | 0x1f9fa :: rest -> Some ("basket", rest)
  | 0x1f9f9 :: rest -> Some ("broom", rest)
  | 0x1f9f8 :: rest -> Some ("teddy_bear", rest)
  | 0x1f9f7 :: rest -> Some ("safety_pin", rest)
  | 0x1f9f6 :: rest -> Some ("yarn", rest)
  | 0x1f9f5 :: rest -> Some ("thread", rest)
  | 0x1f9f4 :: rest -> Some ("squeeze_bottle", rest)
  | 0x1f9f3 :: rest -> Some ("luggage", rest)
  | 0x1f9f2 :: rest -> Some ("magnet", rest)
  | 0x1f9f1 :: rest -> Some ("bricks", rest)
  | 0x1f9f0 :: rest -> Some ("toolbox", rest)
  | 0x1f9ef :: rest -> Some ("fire_extinguisher", rest)
  | 0x1f9ee :: rest -> Some ("abacus", rest)
  | 0x1f9ed :: rest -> Some ("compass", rest)
  | 0x1f9ec :: rest -> Some ("dna", rest)
  | 0x1f9eb :: rest -> Some ("petri_dish", rest)
  | 0x1f9ea :: rest -> Some ("test_tube", rest)
  | 0x1f9e9 :: rest -> Some ("jigsaw", rest)
  | 0x1f9e8 :: rest -> Some ("firecracker", rest)
  | 0x1f9e7 :: rest -> Some ("red_envelope", rest)
  | 0x1f9e6 :: rest -> Some ("socks", rest)
  | 0x1f9e5 :: rest -> Some ("coat", rest)
  | 0x1f9e4 :: rest -> Some ("gloves", rest)
  | 0x1f9e3 :: rest -> Some ("scarf", rest)
  | 0x1f9e2 :: rest -> Some ("billed_cap", rest)
  | 0x1f9e1 :: rest -> Some ("orange_heart", rest)
  | 0x1f9e0 :: rest -> Some ("brain", rest)
  | 0x1f9df :: 0x200d :: 0x2642 :: 0xfe0f :: rest -> Some ("man_zombie", rest)
  | 0x1f9df :: 0x200d :: 0x2640 :: 0xfe0f :: rest -> Some ("woman_zombie", rest)
  | 0x1f9df :: rest -> Some ("zombie", rest)
  | 0x1f9de :: 0x200d :: 0x2642 :: 0xfe0f :: rest -> Some ("man_genie", rest)
  | 0x1f9de :: 0x200d :: 0x2640 :: 0xfe0f :: rest -> Some ("woman_genie", rest)
  | 0x1f9de :: rest -> Some ("genie", rest)
  | 0x1f9dd :: 0x1f3ff :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_elf_tone5", rest)
  | 0x1f9dd :: 0x1f3ff :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_elf_tone5", rest)
  | 0x1f9dd :: 0x1f3ff :: rest -> Some ("elf_tone5", rest)
  | 0x1f9dd :: 0x1f3fe :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_elf_tone4", rest)
  | 0x1f9dd :: 0x1f3fe :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_elf_tone4", rest)
  | 0x1f9dd :: 0x1f3fe :: rest -> Some ("elf_tone4", rest)
  | 0x1f9dd :: 0x1f3fd :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_elf_tone3", rest)
  | 0x1f9dd :: 0x1f3fd :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_elf_tone3", rest)
  | 0x1f9dd :: 0x1f3fd :: rest -> Some ("elf_tone3", rest)
  | 0x1f9dd :: 0x1f3fc :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_elf_tone2", rest)
  | 0x1f9dd :: 0x1f3fc :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_elf_tone2", rest)
  | 0x1f9dd :: 0x1f3fc :: rest -> Some ("elf_tone2", rest)
  | 0x1f9dd :: 0x1f3fb :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_elf_tone1", rest)
  | 0x1f9dd :: 0x1f3fb :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_elf_tone1", rest)
  | 0x1f9dd :: 0x1f3fb :: rest -> Some ("elf_tone1", rest)
  | 0x1f9dd :: 0x200d :: 0x2642 :: 0xfe0f :: rest -> Some ("man_elf", rest)
  | 0x1f9dd :: 0x200d :: 0x2640 :: 0xfe0f :: rest -> Some ("woman_elf", rest)
  | 0x1f9dd :: rest -> Some ("elf", rest)
  | 0x1f9dc :: 0x1f3ff :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("merman_tone5", rest)
  | 0x1f9dc :: 0x1f3ff :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("mermaid_tone5", rest)
  | 0x1f9dc :: 0x1f3ff :: rest -> Some ("merperson_tone5", rest)
  | 0x1f9dc :: 0x1f3fe :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("merman_tone4", rest)
  | 0x1f9dc :: 0x1f3fe :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("mermaid_tone4", rest)
  | 0x1f9dc :: 0x1f3fe :: rest -> Some ("merperson_tone4", rest)
  | 0x1f9dc :: 0x1f3fd :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("merman_tone3", rest)
  | 0x1f9dc :: 0x1f3fd :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("mermaid_tone3", rest)
  | 0x1f9dc :: 0x1f3fd :: rest -> Some ("merperson_tone3", rest)
  | 0x1f9dc :: 0x1f3fc :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("merman_tone2", rest)
  | 0x1f9dc :: 0x1f3fc :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("mermaid_tone2", rest)
  | 0x1f9dc :: 0x1f3fc :: rest -> Some ("merperson_tone2", rest)
  | 0x1f9dc :: 0x1f3fb :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("merman_tone1", rest)
  | 0x1f9dc :: 0x1f3fb :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("mermaid_tone1", rest)
  | 0x1f9dc :: 0x1f3fb :: rest -> Some ("merperson_tone1", rest)
  | 0x1f9dc :: 0x200d :: 0x2642 :: 0xfe0f :: rest -> Some ("merman", rest)
  | 0x1f9dc :: 0x200d :: 0x2640 :: 0xfe0f :: rest -> Some ("mermaid", rest)
  | 0x1f9dc :: rest -> Some ("merperson", rest)
  | 0x1f9db :: 0x1f3ff :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_vampire_tone5", rest)
  | 0x1f9db :: 0x1f3ff :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_vampire_tone5", rest)
  | 0x1f9db :: 0x1f3ff :: rest -> Some ("vampire_tone5", rest)
  | 0x1f9db :: 0x1f3fe :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_vampire_tone4", rest)
  | 0x1f9db :: 0x1f3fe :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_vampire_tone4", rest)
  | 0x1f9db :: 0x1f3fe :: rest -> Some ("vampire_tone4", rest)
  | 0x1f9db :: 0x1f3fd :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_vampire_tone3", rest)
  | 0x1f9db :: 0x1f3fd :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_vampire_tone3", rest)
  | 0x1f9db :: 0x1f3fd :: rest -> Some ("vampire_tone3", rest)
  | 0x1f9db :: 0x1f3fc :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_vampire_tone2", rest)
  | 0x1f9db :: 0x1f3fc :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_vampire_tone2", rest)
  | 0x1f9db :: 0x1f3fc :: rest -> Some ("vampire_tone2", rest)
  | 0x1f9db :: 0x1f3fb :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_vampire_tone1", rest)
  | 0x1f9db :: 0x1f3fb :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_vampire_tone1", rest)
  | 0x1f9db :: 0x1f3fb :: rest -> Some ("vampire_tone1", rest)
  | 0x1f9db :: 0x200d :: 0x2642 :: 0xfe0f :: rest -> Some ("man_vampire", rest)
  | 0x1f9db :: 0x200d :: 0x2640 :: 0xfe0f :: rest -> Some ("woman_vampire", rest)
  | 0x1f9db :: rest -> Some ("vampire", rest)
  | 0x1f9da :: 0x1f3ff :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_fairy_tone5", rest)
  | 0x1f9da :: 0x1f3ff :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_fairy_tone5", rest)
  | 0x1f9da :: 0x1f3ff :: rest -> Some ("fairy_tone5", rest)
  | 0x1f9da :: 0x1f3fe :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_fairy_tone4", rest)
  | 0x1f9da :: 0x1f3fe :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_fairy_tone4", rest)
  | 0x1f9da :: 0x1f3fe :: rest -> Some ("fairy_tone4", rest)
  | 0x1f9da :: 0x1f3fd :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_fairy_tone3", rest)
  | 0x1f9da :: 0x1f3fd :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_fairy_tone3", rest)
  | 0x1f9da :: 0x1f3fd :: rest -> Some ("fairy_tone3", rest)
  | 0x1f9da :: 0x1f3fc :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_fairy_tone2", rest)
  | 0x1f9da :: 0x1f3fc :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_fairy_tone2", rest)
  | 0x1f9da :: 0x1f3fc :: rest -> Some ("fairy_tone2", rest)
  | 0x1f9da :: 0x1f3fb :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_fairy_tone1", rest)
  | 0x1f9da :: 0x1f3fb :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_fairy_tone1", rest)
  | 0x1f9da :: 0x1f3fb :: rest -> Some ("fairy_tone1", rest)
  | 0x1f9da :: 0x200d :: 0x2642 :: 0xfe0f :: rest -> Some ("man_fairy", rest)
  | 0x1f9da :: 0x200d :: 0x2640 :: 0xfe0f :: rest -> Some ("woman_fairy", rest)
  | 0x1f9da :: rest -> Some ("fairy", rest)
  | 0x1f9d9 :: 0x1f3ff :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_mage_tone5", rest)
  | 0x1f9d9 :: 0x1f3ff :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_mage_tone5", rest)
  | 0x1f9d9 :: 0x1f3ff :: rest -> Some ("mage_tone5", rest)
  | 0x1f9d9 :: 0x1f3fe :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_mage_tone4", rest)
  | 0x1f9d9 :: 0x1f3fe :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_mage_tone4", rest)
  | 0x1f9d9 :: 0x1f3fe :: rest -> Some ("mage_tone4", rest)
  | 0x1f9d9 :: 0x1f3fd :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_mage_tone3", rest)
  | 0x1f9d9 :: 0x1f3fd :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_mage_tone3", rest)
  | 0x1f9d9 :: 0x1f3fd :: rest -> Some ("mage_tone3", rest)
  | 0x1f9d9 :: 0x1f3fc :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_mage_tone2", rest)
  | 0x1f9d9 :: 0x1f3fc :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_mage_tone2", rest)
  | 0x1f9d9 :: 0x1f3fc :: rest -> Some ("mage_tone2", rest)
  | 0x1f9d9 :: 0x1f3fb :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_mage_tone1", rest)
  | 0x1f9d9 :: 0x1f3fb :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_mage_tone1", rest)
  | 0x1f9d9 :: 0x1f3fb :: rest -> Some ("mage_tone1", rest)
  | 0x1f9d9 :: 0x200d :: 0x2642 :: 0xfe0f :: rest -> Some ("man_mage", rest)
  | 0x1f9d9 :: 0x200d :: 0x2640 :: 0xfe0f :: rest -> Some ("woman_mage", rest)
  | 0x1f9d9 :: rest -> Some ("mage", rest)
  | 0x1f9d8 :: 0x1f3ff :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_in_lotus_position_tone5", rest)
  | 0x1f9d8 :: 0x1f3ff :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_in_lotus_position_tone5", rest)
  | 0x1f9d8 :: 0x1f3ff :: rest -> Some ("person_in_lotus_position_tone5", rest)
  | 0x1f9d8 :: 0x1f3fe :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_in_lotus_position_tone4", rest)
  | 0x1f9d8 :: 0x1f3fe :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_in_lotus_position_tone4", rest)
  | 0x1f9d8 :: 0x1f3fe :: rest -> Some ("person_in_lotus_position_tone4", rest)
  | 0x1f9d8 :: 0x1f3fd :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_in_lotus_position_tone3", rest)
  | 0x1f9d8 :: 0x1f3fd :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_in_lotus_position_tone3", rest)
  | 0x1f9d8 :: 0x1f3fd :: rest -> Some ("person_in_lotus_position_tone3", rest)
  | 0x1f9d8 :: 0x1f3fc :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_in_lotus_position_tone2", rest)
  | 0x1f9d8 :: 0x1f3fc :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_in_lotus_position_tone2", rest)
  | 0x1f9d8 :: 0x1f3fc :: rest -> Some ("person_in_lotus_position_tone2", rest)
  | 0x1f9d8 :: 0x1f3fb :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_in_lotus_position_tone1", rest)
  | 0x1f9d8 :: 0x1f3fb :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_in_lotus_position_tone1", rest)
  | 0x1f9d8 :: 0x1f3fb :: rest -> Some ("person_in_lotus_position_tone1", rest)
  | 0x1f9d8 :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_in_lotus_position", rest)
  | 0x1f9d8 :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_in_lotus_position", rest)
  | 0x1f9d8 :: rest -> Some ("person_in_lotus_position", rest)
  | 0x1f9d7 :: 0x1f3ff :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_climbing_tone5", rest)
  | 0x1f9d7 :: 0x1f3ff :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_climbing_tone5", rest)
  | 0x1f9d7 :: 0x1f3ff :: rest -> Some ("person_climbing_tone5", rest)
  | 0x1f9d7 :: 0x1f3fe :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_climbing_tone4", rest)
  | 0x1f9d7 :: 0x1f3fe :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_climbing_tone4", rest)
  | 0x1f9d7 :: 0x1f3fe :: rest -> Some ("person_climbing_tone4", rest)
  | 0x1f9d7 :: 0x1f3fd :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_climbing_tone3", rest)
  | 0x1f9d7 :: 0x1f3fd :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_climbing_tone3", rest)
  | 0x1f9d7 :: 0x1f3fd :: rest -> Some ("person_climbing_tone3", rest)
  | 0x1f9d7 :: 0x1f3fc :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_climbing_tone2", rest)
  | 0x1f9d7 :: 0x1f3fc :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_climbing_tone2", rest)
  | 0x1f9d7 :: 0x1f3fc :: rest -> Some ("person_climbing_tone2", rest)
  | 0x1f9d7 :: 0x1f3fb :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_climbing_tone1", rest)
  | 0x1f9d7 :: 0x1f3fb :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_climbing_tone1", rest)
  | 0x1f9d7 :: 0x1f3fb :: rest -> Some ("person_climbing_tone1", rest)
  | 0x1f9d7 :: 0x200d :: 0x2642 :: 0xfe0f :: rest -> Some ("man_climbing", rest)
  | 0x1f9d7 :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_climbing", rest)
  | 0x1f9d7 :: rest -> Some ("person_climbing", rest)
  | 0x1f9d6 :: 0x1f3ff :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_in_steamy_room_tone5", rest)
  | 0x1f9d6 :: 0x1f3ff :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_in_steamy_room_tone5", rest)
  | 0x1f9d6 :: 0x1f3ff :: rest -> Some ("person_in_steamy_room_tone5", rest)
  | 0x1f9d6 :: 0x1f3fe :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_in_steamy_room_tone4", rest)
  | 0x1f9d6 :: 0x1f3fe :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_in_steamy_room_tone4", rest)
  | 0x1f9d6 :: 0x1f3fe :: rest -> Some ("person_in_steamy_room_tone4", rest)
  | 0x1f9d6 :: 0x1f3fd :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_in_steamy_room_tone3", rest)
  | 0x1f9d6 :: 0x1f3fd :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_in_steamy_room_tone3", rest)
  | 0x1f9d6 :: 0x1f3fd :: rest -> Some ("person_in_steamy_room_tone3", rest)
  | 0x1f9d6 :: 0x1f3fc :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_in_steamy_room_tone2", rest)
  | 0x1f9d6 :: 0x1f3fc :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_in_steamy_room_tone2", rest)
  | 0x1f9d6 :: 0x1f3fc :: rest -> Some ("person_in_steamy_room_tone2", rest)
  | 0x1f9d6 :: 0x1f3fb :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_in_steamy_room_tone1", rest)
  | 0x1f9d6 :: 0x1f3fb :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_in_steamy_room_tone1", rest)
  | 0x1f9d6 :: 0x1f3fb :: rest -> Some ("person_in_steamy_room_tone1", rest)
  | 0x1f9d6 :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_in_steamy_room", rest)
  | 0x1f9d6 :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_in_steamy_room", rest)
  | 0x1f9d6 :: rest -> Some ("person_in_steamy_room", rest)
  | 0x1f9d5 :: 0x1f3ff :: rest -> Some ("woman_with_headscarf_tone5", rest)
  | 0x1f9d5 :: 0x1f3fe :: rest -> Some ("woman_with_headscarf_tone4", rest)
  | 0x1f9d5 :: 0x1f3fd :: rest -> Some ("woman_with_headscarf_tone3", rest)
  | 0x1f9d5 :: 0x1f3fc :: rest -> Some ("woman_with_headscarf_tone2", rest)
  | 0x1f9d5 :: 0x1f3fb :: rest -> Some ("woman_with_headscarf_tone1", rest)
  | 0x1f9d5 :: rest -> Some ("woman_with_headscarf", rest)
  | 0x1f9d4 :: 0x1f3ff :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_tone5_beard", rest)
  | 0x1f9d4 :: 0x1f3ff :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_tone5_beard", rest)
  | 0x1f9d4 :: 0x1f3ff :: rest -> Some ("bearded_person_tone5", rest)
  | 0x1f9d4 :: 0x1f3fe :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_tone4_beard", rest)
  | 0x1f9d4 :: 0x1f3fe :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_tone4_beard", rest)
  | 0x1f9d4 :: 0x1f3fe :: rest -> Some ("bearded_person_tone4", rest)
  | 0x1f9d4 :: 0x1f3fd :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_tone3_beard", rest)
  | 0x1f9d4 :: 0x1f3fd :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_tone3_beard", rest)
  | 0x1f9d4 :: 0x1f3fd :: rest -> Some ("bearded_person_tone3", rest)
  | 0x1f9d4 :: 0x1f3fc :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_tone2_beard", rest)
  | 0x1f9d4 :: 0x1f3fc :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_tone2_beard", rest)
  | 0x1f9d4 :: 0x1f3fc :: rest -> Some ("bearded_person_tone2", rest)
  | 0x1f9d4 :: 0x1f3fb :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_tone1_beard", rest)
  | 0x1f9d4 :: 0x1f3fb :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_tone1_beard", rest)
  | 0x1f9d4 :: 0x1f3fb :: rest -> Some ("bearded_person_tone1", rest)
  | 0x1f9d4 :: 0x200d :: 0x2642 :: 0xfe0f :: rest -> Some ("man_beard", rest)
  | 0x1f9d4 :: 0x200d :: 0x2640 :: 0xfe0f :: rest -> Some ("woman_beard", rest)
  | 0x1f9d4 :: rest -> Some ("bearded_person", rest)
  | 0x1f9d3 :: 0x1f3ff :: rest -> Some ("older_adult_tone5", rest)
  | 0x1f9d3 :: 0x1f3fe :: rest -> Some ("older_adult_tone4", rest)
  | 0x1f9d3 :: 0x1f3fd :: rest -> Some ("older_adult_tone3", rest)
  | 0x1f9d3 :: 0x1f3fc :: rest -> Some ("older_adult_tone2", rest)
  | 0x1f9d3 :: 0x1f3fb :: rest -> Some ("older_adult_tone1", rest)
  | 0x1f9d3 :: rest -> Some ("older_adult", rest)
  | 0x1f9d2 :: 0x1f3ff :: rest -> Some ("child_tone5", rest)
  | 0x1f9d2 :: 0x1f3fe :: rest -> Some ("child_tone4", rest)
  | 0x1f9d2 :: 0x1f3fd :: rest -> Some ("child_tone3", rest)
  | 0x1f9d2 :: 0x1f3fc :: rest -> Some ("child_tone2", rest)
  | 0x1f9d2 :: 0x1f3fb :: rest -> Some ("child_tone1", rest)
  | 0x1f9d2 :: rest -> Some ("child", rest)
  | 0x1f9d1 :: 0x1f3ff :: 0x200d :: 0x1f9bd :: rest ->
      Some ("person_in_manual_wheelchair_tone5", rest)
  | 0x1f9d1 :: 0x1f3ff :: 0x200d :: 0x1f9bc :: rest ->
      Some ("person_in_motorized_wheelchair_tone5", rest)
  | 0x1f9d1 :: 0x1f3ff :: 0x200d :: 0x1f9b3 :: rest ->
      Some ("person_tone5_white_hair", rest)
  | 0x1f9d1 :: 0x1f3ff :: 0x200d :: 0x1f9b2 :: rest ->
      Some ("person_tone5_bald", rest)
  | 0x1f9d1 :: 0x1f3ff :: 0x200d :: 0x1f9b1 :: rest ->
      Some ("person_tone5_curly_hair", rest)
  | 0x1f9d1 :: 0x1f3ff :: 0x200d :: 0x1f9b0 :: rest ->
      Some ("person_tone5_red_hair", rest)
  | 0x1f9d1 :: 0x1f3ff :: 0x200d :: 0x1f9af :: rest ->
      Some ("person_with_probing_cane_tone5", rest)
  | 0x1f9d1 :: 0x1f3ff :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f9d1 :: 0x1f3ff
    :: rest ->
      Some ("people_holding_hands_tone5", rest)
  | 0x1f9d1 :: 0x1f3ff :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f9d1 :: 0x1f3fe
    :: rest ->
      Some ("people_holding_hands_tone5_tone4", rest)
  | 0x1f9d1 :: 0x1f3ff :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f9d1 :: 0x1f3fd
    :: rest ->
      Some ("people_holding_hands_tone5_tone3", rest)
  | 0x1f9d1 :: 0x1f3ff :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f9d1 :: 0x1f3fc
    :: rest ->
      Some ("people_holding_hands_tone5_tone2", rest)
  | 0x1f9d1 :: 0x1f3ff :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f9d1 :: 0x1f3fb
    :: rest ->
      Some ("people_holding_hands_tone5_tone1", rest)
  | 0x1f9d1 :: 0x1f3ff :: 0x200d :: 0x1f692 :: rest ->
      Some ("firefighter_tone5", rest)
  | 0x1f9d1 :: 0x1f3ff :: 0x200d :: 0x1f680 :: rest ->
      Some ("astronaut_tone5", rest)
  | 0x1f9d1 :: 0x1f3ff :: 0x200d :: 0x1f52c :: rest ->
      Some ("scientist_tone5", rest)
  | 0x1f9d1 :: 0x1f3ff :: 0x200d :: 0x1f527 :: rest ->
      Some ("mechanic_tone5", rest)
  | 0x1f9d1 :: 0x1f3ff :: 0x200d :: 0x1f4bc :: rest ->
      Some ("office_worker_tone5", rest)
  | 0x1f9d1 :: 0x1f3ff :: 0x200d :: 0x1f4bb :: rest ->
      Some ("technologist_tone5", rest)
  | 0x1f9d1 :: 0x1f3ff :: 0x200d :: 0x1f3ed :: rest ->
      Some ("factory_worker_tone5", rest)
  | 0x1f9d1 :: 0x1f3ff :: 0x200d :: 0x1f3eb :: rest ->
      Some ("teacher_tone5", rest)
  | 0x1f9d1 :: 0x1f3ff :: 0x200d :: 0x1f3a8 :: rest ->
      Some ("artist_tone5", rest)
  | 0x1f9d1 :: 0x1f3ff :: 0x200d :: 0x1f3a4 :: rest ->
      Some ("singer_tone5", rest)
  | 0x1f9d1 :: 0x1f3ff :: 0x200d :: 0x1f393 :: rest ->
      Some ("student_tone5", rest)
  | 0x1f9d1 :: 0x1f3ff :: 0x200d :: 0x1f384 :: rest ->
      Some ("mx_claus_tone5", rest)
  | 0x1f9d1 :: 0x1f3ff :: 0x200d :: 0x1f37c :: rest ->
      Some ("person_feeding_baby_tone5", rest)
  | 0x1f9d1 :: 0x1f3ff :: 0x200d :: 0x1f373 :: rest -> Some ("cook_tone5", rest)
  | 0x1f9d1 :: 0x1f3ff :: 0x200d :: 0x1f33e :: rest ->
      Some ("farmer_tone5", rest)
  | 0x1f9d1 :: 0x1f3ff :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f9d1
    :: 0x1f3fe :: rest ->
      Some ("couple_with_heart_person_person_tone5_tone4", rest)
  | 0x1f9d1 :: 0x1f3ff :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f9d1
    :: 0x1f3fd :: rest ->
      Some ("couple_with_heart_person_person_tone5_tone3", rest)
  | 0x1f9d1 :: 0x1f3ff :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f9d1
    :: 0x1f3fc :: rest ->
      Some ("couple_with_heart_person_person_tone5_tone2", rest)
  | 0x1f9d1 :: 0x1f3ff :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f9d1
    :: 0x1f3fb :: rest ->
      Some ("couple_with_heart_person_person_tone5_tone1", rest)
  | 0x1f9d1 :: 0x1f3ff :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f9d1 :: 0x1f3fe :: rest ->
      Some ("kiss_person_person_tone5_tone4", rest)
  | 0x1f9d1 :: 0x1f3ff :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f9d1 :: 0x1f3fd :: rest ->
      Some ("kiss_person_person_tone5_tone3", rest)
  | 0x1f9d1 :: 0x1f3ff :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f9d1 :: 0x1f3fc :: rest ->
      Some ("kiss_person_person_tone5_tone2", rest)
  | 0x1f9d1 :: 0x1f3ff :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f9d1 :: 0x1f3fb :: rest ->
      Some ("kiss_person_person_tone5_tone1", rest)
  | 0x1f9d1 :: 0x1f3ff :: 0x200d :: 0x2708 :: 0xfe0f :: rest ->
      Some ("pilot_tone5", rest)
  | 0x1f9d1 :: 0x1f3ff :: 0x200d :: 0x2696 :: 0xfe0f :: rest ->
      Some ("judge_tone5", rest)
  | 0x1f9d1 :: 0x1f3ff :: 0x200d :: 0x2695 :: 0xfe0f :: rest ->
      Some ("health_worker_tone5", rest)
  | 0x1f9d1 :: 0x1f3ff :: rest -> Some ("adult_tone5", rest)
  | 0x1f9d1 :: 0x1f3fe :: 0x200d :: 0x1f9bd :: rest ->
      Some ("person_in_manual_wheelchair_tone4", rest)
  | 0x1f9d1 :: 0x1f3fe :: 0x200d :: 0x1f9bc :: rest ->
      Some ("person_in_motorized_wheelchair_tone4", rest)
  | 0x1f9d1 :: 0x1f3fe :: 0x200d :: 0x1f9b3 :: rest ->
      Some ("person_tone4_white_hair", rest)
  | 0x1f9d1 :: 0x1f3fe :: 0x200d :: 0x1f9b2 :: rest ->
      Some ("person_tone4_bald", rest)
  | 0x1f9d1 :: 0x1f3fe :: 0x200d :: 0x1f9b1 :: rest ->
      Some ("person_tone4_curly_hair", rest)
  | 0x1f9d1 :: 0x1f3fe :: 0x200d :: 0x1f9b0 :: rest ->
      Some ("person_tone4_red_hair", rest)
  | 0x1f9d1 :: 0x1f3fe :: 0x200d :: 0x1f9af :: rest ->
      Some ("person_with_probing_cane_tone4", rest)
  | 0x1f9d1 :: 0x1f3fe :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f9d1 :: 0x1f3ff
    :: rest ->
      Some ("people_holding_hands_tone4_tone5", rest)
  | 0x1f9d1 :: 0x1f3fe :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f9d1 :: 0x1f3fe
    :: rest ->
      Some ("people_holding_hands_tone4", rest)
  | 0x1f9d1 :: 0x1f3fe :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f9d1 :: 0x1f3fd
    :: rest ->
      Some ("people_holding_hands_tone4_tone3", rest)
  | 0x1f9d1 :: 0x1f3fe :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f9d1 :: 0x1f3fc
    :: rest ->
      Some ("people_holding_hands_tone4_tone2", rest)
  | 0x1f9d1 :: 0x1f3fe :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f9d1 :: 0x1f3fb
    :: rest ->
      Some ("people_holding_hands_tone4_tone1", rest)
  | 0x1f9d1 :: 0x1f3fe :: 0x200d :: 0x1f692 :: rest ->
      Some ("firefighter_tone4", rest)
  | 0x1f9d1 :: 0x1f3fe :: 0x200d :: 0x1f680 :: rest ->
      Some ("astronaut_tone4", rest)
  | 0x1f9d1 :: 0x1f3fe :: 0x200d :: 0x1f52c :: rest ->
      Some ("scientist_tone4", rest)
  | 0x1f9d1 :: 0x1f3fe :: 0x200d :: 0x1f527 :: rest ->
      Some ("mechanic_tone4", rest)
  | 0x1f9d1 :: 0x1f3fe :: 0x200d :: 0x1f4bc :: rest ->
      Some ("office_worker_tone4", rest)
  | 0x1f9d1 :: 0x1f3fe :: 0x200d :: 0x1f4bb :: rest ->
      Some ("technologist_tone4", rest)
  | 0x1f9d1 :: 0x1f3fe :: 0x200d :: 0x1f3ed :: rest ->
      Some ("factory_worker_tone4", rest)
  | 0x1f9d1 :: 0x1f3fe :: 0x200d :: 0x1f3eb :: rest ->
      Some ("teacher_tone4", rest)
  | 0x1f9d1 :: 0x1f3fe :: 0x200d :: 0x1f3a8 :: rest ->
      Some ("artist_tone4", rest)
  | 0x1f9d1 :: 0x1f3fe :: 0x200d :: 0x1f3a4 :: rest ->
      Some ("singer_tone4", rest)
  | 0x1f9d1 :: 0x1f3fe :: 0x200d :: 0x1f393 :: rest ->
      Some ("student_tone4", rest)
  | 0x1f9d1 :: 0x1f3fe :: 0x200d :: 0x1f384 :: rest ->
      Some ("mx_claus_tone4", rest)
  | 0x1f9d1 :: 0x1f3fe :: 0x200d :: 0x1f37c :: rest ->
      Some ("person_feeding_baby_tone4", rest)
  | 0x1f9d1 :: 0x1f3fe :: 0x200d :: 0x1f373 :: rest -> Some ("cook_tone4", rest)
  | 0x1f9d1 :: 0x1f3fe :: 0x200d :: 0x1f33e :: rest ->
      Some ("farmer_tone4", rest)
  | 0x1f9d1 :: 0x1f3fe :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f9d1
    :: 0x1f3ff :: rest ->
      Some ("couple_with_heart_person_person_tone4_tone5", rest)
  | 0x1f9d1 :: 0x1f3fe :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f9d1
    :: 0x1f3fd :: rest ->
      Some ("couple_with_heart_person_person_tone4_tone3", rest)
  | 0x1f9d1 :: 0x1f3fe :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f9d1
    :: 0x1f3fc :: rest ->
      Some ("couple_with_heart_person_person_tone4_tone2", rest)
  | 0x1f9d1 :: 0x1f3fe :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f9d1
    :: 0x1f3fb :: rest ->
      Some ("couple_with_heart_person_person_tone4_tone1", rest)
  | 0x1f9d1 :: 0x1f3fe :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f9d1 :: 0x1f3ff :: rest ->
      Some ("kiss_person_person_tone4_tone5", rest)
  | 0x1f9d1 :: 0x1f3fe :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f9d1 :: 0x1f3fd :: rest ->
      Some ("kiss_person_person_tone4_tone3", rest)
  | 0x1f9d1 :: 0x1f3fe :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f9d1 :: 0x1f3fc :: rest ->
      Some ("kiss_person_person_tone4_tone2", rest)
  | 0x1f9d1 :: 0x1f3fe :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f9d1 :: 0x1f3fb :: rest ->
      Some ("kiss_person_person_tone4_tone1", rest)
  | 0x1f9d1 :: 0x1f3fe :: 0x200d :: 0x2708 :: 0xfe0f :: rest ->
      Some ("pilot_tone4", rest)
  | 0x1f9d1 :: 0x1f3fe :: 0x200d :: 0x2696 :: 0xfe0f :: rest ->
      Some ("judge_tone4", rest)
  | 0x1f9d1 :: 0x1f3fe :: 0x200d :: 0x2695 :: 0xfe0f :: rest ->
      Some ("health_worker_tone4", rest)
  | 0x1f9d1 :: 0x1f3fe :: rest -> Some ("adult_tone4", rest)
  | 0x1f9d1 :: 0x1f3fd :: 0x200d :: 0x1f9bd :: rest ->
      Some ("person_in_manual_wheelchair_tone3", rest)
  | 0x1f9d1 :: 0x1f3fd :: 0x200d :: 0x1f9bc :: rest ->
      Some ("person_in_motorized_wheelchair_tone3", rest)
  | 0x1f9d1 :: 0x1f3fd :: 0x200d :: 0x1f9b3 :: rest ->
      Some ("person_tone3_white_hair", rest)
  | 0x1f9d1 :: 0x1f3fd :: 0x200d :: 0x1f9b2 :: rest ->
      Some ("person_tone3_bald", rest)
  | 0x1f9d1 :: 0x1f3fd :: 0x200d :: 0x1f9b1 :: rest ->
      Some ("person_tone3_curly_hair", rest)
  | 0x1f9d1 :: 0x1f3fd :: 0x200d :: 0x1f9b0 :: rest ->
      Some ("person_tone3_red_hair", rest)
  | 0x1f9d1 :: 0x1f3fd :: 0x200d :: 0x1f9af :: rest ->
      Some ("person_with_probing_cane_tone3", rest)
  | 0x1f9d1 :: 0x1f3fd :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f9d1 :: 0x1f3ff
    :: rest ->
      Some ("people_holding_hands_tone3_tone5", rest)
  | 0x1f9d1 :: 0x1f3fd :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f9d1 :: 0x1f3fe
    :: rest ->
      Some ("people_holding_hands_tone3_tone4", rest)
  | 0x1f9d1 :: 0x1f3fd :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f9d1 :: 0x1f3fd
    :: rest ->
      Some ("people_holding_hands_tone3", rest)
  | 0x1f9d1 :: 0x1f3fd :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f9d1 :: 0x1f3fc
    :: rest ->
      Some ("people_holding_hands_tone3_tone2", rest)
  | 0x1f9d1 :: 0x1f3fd :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f9d1 :: 0x1f3fb
    :: rest ->
      Some ("people_holding_hands_tone3_tone1", rest)
  | 0x1f9d1 :: 0x1f3fd :: 0x200d :: 0x1f692 :: rest ->
      Some ("firefighter_tone3", rest)
  | 0x1f9d1 :: 0x1f3fd :: 0x200d :: 0x1f680 :: rest ->
      Some ("astronaut_tone3", rest)
  | 0x1f9d1 :: 0x1f3fd :: 0x200d :: 0x1f52c :: rest ->
      Some ("scientist_tone3", rest)
  | 0x1f9d1 :: 0x1f3fd :: 0x200d :: 0x1f527 :: rest ->
      Some ("mechanic_tone3", rest)
  | 0x1f9d1 :: 0x1f3fd :: 0x200d :: 0x1f4bc :: rest ->
      Some ("office_worker_tone3", rest)
  | 0x1f9d1 :: 0x1f3fd :: 0x200d :: 0x1f4bb :: rest ->
      Some ("technologist_tone3", rest)
  | 0x1f9d1 :: 0x1f3fd :: 0x200d :: 0x1f3ed :: rest ->
      Some ("factory_worker_tone3", rest)
  | 0x1f9d1 :: 0x1f3fd :: 0x200d :: 0x1f3eb :: rest ->
      Some ("teacher_tone3", rest)
  | 0x1f9d1 :: 0x1f3fd :: 0x200d :: 0x1f3a8 :: rest ->
      Some ("artist_tone3", rest)
  | 0x1f9d1 :: 0x1f3fd :: 0x200d :: 0x1f3a4 :: rest ->
      Some ("singer_tone3", rest)
  | 0x1f9d1 :: 0x1f3fd :: 0x200d :: 0x1f393 :: rest ->
      Some ("student_tone3", rest)
  | 0x1f9d1 :: 0x1f3fd :: 0x200d :: 0x1f384 :: rest ->
      Some ("mx_claus_tone3", rest)
  | 0x1f9d1 :: 0x1f3fd :: 0x200d :: 0x1f37c :: rest ->
      Some ("person_feeding_baby_tone3", rest)
  | 0x1f9d1 :: 0x1f3fd :: 0x200d :: 0x1f373 :: rest -> Some ("cook_tone3", rest)
  | 0x1f9d1 :: 0x1f3fd :: 0x200d :: 0x1f33e :: rest ->
      Some ("farmer_tone3", rest)
  | 0x1f9d1 :: 0x1f3fd :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f9d1
    :: 0x1f3ff :: rest ->
      Some ("couple_with_heart_person_person_tone3_tone5", rest)
  | 0x1f9d1 :: 0x1f3fd :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f9d1
    :: 0x1f3fe :: rest ->
      Some ("couple_with_heart_person_person_tone3_tone4", rest)
  | 0x1f9d1 :: 0x1f3fd :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f9d1
    :: 0x1f3fc :: rest ->
      Some ("couple_with_heart_person_person_tone3_tone2", rest)
  | 0x1f9d1 :: 0x1f3fd :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f9d1
    :: 0x1f3fb :: rest ->
      Some ("couple_with_heart_person_person_tone3_tone1", rest)
  | 0x1f9d1 :: 0x1f3fd :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f9d1 :: 0x1f3ff :: rest ->
      Some ("kiss_person_person_tone3_tone5", rest)
  | 0x1f9d1 :: 0x1f3fd :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f9d1 :: 0x1f3fe :: rest ->
      Some ("kiss_person_person_tone3_tone4", rest)
  | 0x1f9d1 :: 0x1f3fd :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f9d1 :: 0x1f3fc :: rest ->
      Some ("kiss_person_person_tone3_tone2", rest)
  | 0x1f9d1 :: 0x1f3fd :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f9d1 :: 0x1f3fb :: rest ->
      Some ("kiss_person_person_tone3_tone1", rest)
  | 0x1f9d1 :: 0x1f3fd :: 0x200d :: 0x2708 :: 0xfe0f :: rest ->
      Some ("pilot_tone3", rest)
  | 0x1f9d1 :: 0x1f3fd :: 0x200d :: 0x2696 :: 0xfe0f :: rest ->
      Some ("judge_tone3", rest)
  | 0x1f9d1 :: 0x1f3fd :: 0x200d :: 0x2695 :: 0xfe0f :: rest ->
      Some ("health_worker_tone3", rest)
  | 0x1f9d1 :: 0x1f3fd :: rest -> Some ("adult_tone3", rest)
  | 0x1f9d1 :: 0x1f3fc :: 0x200d :: 0x1f9bd :: rest ->
      Some ("person_in_manual_wheelchair_tone2", rest)
  | 0x1f9d1 :: 0x1f3fc :: 0x200d :: 0x1f9bc :: rest ->
      Some ("person_in_motorized_wheelchair_tone2", rest)
  | 0x1f9d1 :: 0x1f3fc :: 0x200d :: 0x1f9b3 :: rest ->
      Some ("person_tone2_white_hair", rest)
  | 0x1f9d1 :: 0x1f3fc :: 0x200d :: 0x1f9b2 :: rest ->
      Some ("person_tone2_bald", rest)
  | 0x1f9d1 :: 0x1f3fc :: 0x200d :: 0x1f9b1 :: rest ->
      Some ("person_tone2_curly_hair", rest)
  | 0x1f9d1 :: 0x1f3fc :: 0x200d :: 0x1f9b0 :: rest ->
      Some ("person_tone2_red_hair", rest)
  | 0x1f9d1 :: 0x1f3fc :: 0x200d :: 0x1f9af :: rest ->
      Some ("person_with_probing_cane_tone2", rest)
  | 0x1f9d1 :: 0x1f3fc :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f9d1 :: 0x1f3ff
    :: rest ->
      Some ("people_holding_hands_tone2_tone5", rest)
  | 0x1f9d1 :: 0x1f3fc :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f9d1 :: 0x1f3fe
    :: rest ->
      Some ("people_holding_hands_tone2_tone4", rest)
  | 0x1f9d1 :: 0x1f3fc :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f9d1 :: 0x1f3fd
    :: rest ->
      Some ("people_holding_hands_tone2_tone3", rest)
  | 0x1f9d1 :: 0x1f3fc :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f9d1 :: 0x1f3fc
    :: rest ->
      Some ("people_holding_hands_tone2", rest)
  | 0x1f9d1 :: 0x1f3fc :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f9d1 :: 0x1f3fb
    :: rest ->
      Some ("people_holding_hands_tone2_tone1", rest)
  | 0x1f9d1 :: 0x1f3fc :: 0x200d :: 0x1f692 :: rest ->
      Some ("firefighter_tone2", rest)
  | 0x1f9d1 :: 0x1f3fc :: 0x200d :: 0x1f680 :: rest ->
      Some ("astronaut_tone2", rest)
  | 0x1f9d1 :: 0x1f3fc :: 0x200d :: 0x1f52c :: rest ->
      Some ("scientist_tone2", rest)
  | 0x1f9d1 :: 0x1f3fc :: 0x200d :: 0x1f527 :: rest ->
      Some ("mechanic_tone2", rest)
  | 0x1f9d1 :: 0x1f3fc :: 0x200d :: 0x1f4bc :: rest ->
      Some ("office_worker_tone2", rest)
  | 0x1f9d1 :: 0x1f3fc :: 0x200d :: 0x1f4bb :: rest ->
      Some ("technologist_tone2", rest)
  | 0x1f9d1 :: 0x1f3fc :: 0x200d :: 0x1f3ed :: rest ->
      Some ("factory_worker_tone2", rest)
  | 0x1f9d1 :: 0x1f3fc :: 0x200d :: 0x1f3eb :: rest ->
      Some ("teacher_tone2", rest)
  | 0x1f9d1 :: 0x1f3fc :: 0x200d :: 0x1f3a8 :: rest ->
      Some ("artist_tone2", rest)
  | 0x1f9d1 :: 0x1f3fc :: 0x200d :: 0x1f3a4 :: rest ->
      Some ("singer_tone2", rest)
  | 0x1f9d1 :: 0x1f3fc :: 0x200d :: 0x1f393 :: rest ->
      Some ("student_tone2", rest)
  | 0x1f9d1 :: 0x1f3fc :: 0x200d :: 0x1f384 :: rest ->
      Some ("mx_claus_tone2", rest)
  | 0x1f9d1 :: 0x1f3fc :: 0x200d :: 0x1f37c :: rest ->
      Some ("person_feeding_baby_tone2", rest)
  | 0x1f9d1 :: 0x1f3fc :: 0x200d :: 0x1f373 :: rest -> Some ("cook_tone2", rest)
  | 0x1f9d1 :: 0x1f3fc :: 0x200d :: 0x1f33e :: rest ->
      Some ("farmer_tone2", rest)
  | 0x1f9d1 :: 0x1f3fc :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f9d1
    :: 0x1f3ff :: rest ->
      Some ("couple_with_heart_person_person_tone2_tone5", rest)
  | 0x1f9d1 :: 0x1f3fc :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f9d1
    :: 0x1f3fe :: rest ->
      Some ("couple_with_heart_person_person_tone2_tone4", rest)
  | 0x1f9d1 :: 0x1f3fc :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f9d1
    :: 0x1f3fd :: rest ->
      Some ("couple_with_heart_person_person_tone2_tone3", rest)
  | 0x1f9d1 :: 0x1f3fc :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f9d1
    :: 0x1f3fb :: rest ->
      Some ("couple_with_heart_person_person_tone2_tone1", rest)
  | 0x1f9d1 :: 0x1f3fc :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f9d1 :: 0x1f3ff :: rest ->
      Some ("kiss_person_person_tone2_tone5", rest)
  | 0x1f9d1 :: 0x1f3fc :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f9d1 :: 0x1f3fe :: rest ->
      Some ("kiss_person_person_tone2_tone4", rest)
  | 0x1f9d1 :: 0x1f3fc :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f9d1 :: 0x1f3fd :: rest ->
      Some ("kiss_person_person_tone2_tone3", rest)
  | 0x1f9d1 :: 0x1f3fc :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f9d1 :: 0x1f3fb :: rest ->
      Some ("kiss_person_person_tone2_tone1", rest)
  | 0x1f9d1 :: 0x1f3fc :: 0x200d :: 0x2708 :: 0xfe0f :: rest ->
      Some ("pilot_tone2", rest)
  | 0x1f9d1 :: 0x1f3fc :: 0x200d :: 0x2696 :: 0xfe0f :: rest ->
      Some ("judge_tone2", rest)
  | 0x1f9d1 :: 0x1f3fc :: 0x200d :: 0x2695 :: 0xfe0f :: rest ->
      Some ("health_worker_tone2", rest)
  | 0x1f9d1 :: 0x1f3fc :: rest -> Some ("adult_tone2", rest)
  | 0x1f9d1 :: 0x1f3fb :: 0x200d :: 0x1f9bd :: rest ->
      Some ("person_in_manual_wheelchair_tone1", rest)
  | 0x1f9d1 :: 0x1f3fb :: 0x200d :: 0x1f9bc :: rest ->
      Some ("person_in_motorized_wheelchair_tone1", rest)
  | 0x1f9d1 :: 0x1f3fb :: 0x200d :: 0x1f9b3 :: rest ->
      Some ("person_tone1_white_hair", rest)
  | 0x1f9d1 :: 0x1f3fb :: 0x200d :: 0x1f9b2 :: rest ->
      Some ("person_tone1_bald", rest)
  | 0x1f9d1 :: 0x1f3fb :: 0x200d :: 0x1f9b1 :: rest ->
      Some ("person_tone1_curly_hair", rest)
  | 0x1f9d1 :: 0x1f3fb :: 0x200d :: 0x1f9b0 :: rest ->
      Some ("person_tone1_red_hair", rest)
  | 0x1f9d1 :: 0x1f3fb :: 0x200d :: 0x1f9af :: rest ->
      Some ("person_with_probing_cane_tone1", rest)
  | 0x1f9d1 :: 0x1f3fb :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f9d1 :: 0x1f3ff
    :: rest ->
      Some ("people_holding_hands_tone1_tone5", rest)
  | 0x1f9d1 :: 0x1f3fb :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f9d1 :: 0x1f3fe
    :: rest ->
      Some ("people_holding_hands_tone1_tone4", rest)
  | 0x1f9d1 :: 0x1f3fb :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f9d1 :: 0x1f3fd
    :: rest ->
      Some ("people_holding_hands_tone1_tone3", rest)
  | 0x1f9d1 :: 0x1f3fb :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f9d1 :: 0x1f3fc
    :: rest ->
      Some ("people_holding_hands_tone1_tone2", rest)
  | 0x1f9d1 :: 0x1f3fb :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f9d1 :: 0x1f3fb
    :: rest ->
      Some ("people_holding_hands_tone1", rest)
  | 0x1f9d1 :: 0x1f3fb :: 0x200d :: 0x1f692 :: rest ->
      Some ("firefighter_tone1", rest)
  | 0x1f9d1 :: 0x1f3fb :: 0x200d :: 0x1f680 :: rest ->
      Some ("astronaut_tone1", rest)
  | 0x1f9d1 :: 0x1f3fb :: 0x200d :: 0x1f52c :: rest ->
      Some ("scientist_tone1", rest)
  | 0x1f9d1 :: 0x1f3fb :: 0x200d :: 0x1f527 :: rest ->
      Some ("mechanic_tone1", rest)
  | 0x1f9d1 :: 0x1f3fb :: 0x200d :: 0x1f4bc :: rest ->
      Some ("office_worker_tone1", rest)
  | 0x1f9d1 :: 0x1f3fb :: 0x200d :: 0x1f4bb :: rest ->
      Some ("technologist_tone1", rest)
  | 0x1f9d1 :: 0x1f3fb :: 0x200d :: 0x1f3ed :: rest ->
      Some ("factory_worker_tone1", rest)
  | 0x1f9d1 :: 0x1f3fb :: 0x200d :: 0x1f3eb :: rest ->
      Some ("teacher_tone1", rest)
  | 0x1f9d1 :: 0x1f3fb :: 0x200d :: 0x1f3a8 :: rest ->
      Some ("artist_tone1", rest)
  | 0x1f9d1 :: 0x1f3fb :: 0x200d :: 0x1f3a4 :: rest ->
      Some ("singer_tone1", rest)
  | 0x1f9d1 :: 0x1f3fb :: 0x200d :: 0x1f393 :: rest ->
      Some ("student_tone1", rest)
  | 0x1f9d1 :: 0x1f3fb :: 0x200d :: 0x1f384 :: rest ->
      Some ("mx_claus_tone1", rest)
  | 0x1f9d1 :: 0x1f3fb :: 0x200d :: 0x1f37c :: rest ->
      Some ("person_feeding_baby_tone1", rest)
  | 0x1f9d1 :: 0x1f3fb :: 0x200d :: 0x1f373 :: rest -> Some ("cook_tone1", rest)
  | 0x1f9d1 :: 0x1f3fb :: 0x200d :: 0x1f33e :: rest ->
      Some ("farmer_tone1", rest)
  | 0x1f9d1 :: 0x1f3fb :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f9d1
    :: 0x1f3ff :: rest ->
      Some ("couple_with_heart_person_person_tone1_tone5", rest)
  | 0x1f9d1 :: 0x1f3fb :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f9d1
    :: 0x1f3fe :: rest ->
      Some ("couple_with_heart_person_person_tone1_tone4", rest)
  | 0x1f9d1 :: 0x1f3fb :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f9d1
    :: 0x1f3fd :: rest ->
      Some ("couple_with_heart_person_person_tone1_tone3", rest)
  | 0x1f9d1 :: 0x1f3fb :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f9d1
    :: 0x1f3fc :: rest ->
      Some ("couple_with_heart_person_person_tone1_tone2", rest)
  | 0x1f9d1 :: 0x1f3fb :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f9d1 :: 0x1f3ff :: rest ->
      Some ("kiss_person_person_tone1_tone5", rest)
  | 0x1f9d1 :: 0x1f3fb :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f9d1 :: 0x1f3fe :: rest ->
      Some ("kiss_person_person_tone1_tone4", rest)
  | 0x1f9d1 :: 0x1f3fb :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f9d1 :: 0x1f3fd :: rest ->
      Some ("kiss_person_person_tone1_tone3", rest)
  | 0x1f9d1 :: 0x1f3fb :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f9d1 :: 0x1f3fc :: rest ->
      Some ("kiss_person_person_tone1_tone2", rest)
  | 0x1f9d1 :: 0x1f3fb :: 0x200d :: 0x2708 :: 0xfe0f :: rest ->
      Some ("pilot_tone1", rest)
  | 0x1f9d1 :: 0x1f3fb :: 0x200d :: 0x2696 :: 0xfe0f :: rest ->
      Some ("judge_tone1", rest)
  | 0x1f9d1 :: 0x1f3fb :: 0x200d :: 0x2695 :: 0xfe0f :: rest ->
      Some ("health_worker_tone1", rest)
  | 0x1f9d1 :: 0x1f3fb :: rest -> Some ("adult_tone1", rest)
  | 0x1f9d1 :: 0x200d :: 0x1f9bd :: rest ->
      Some ("person_in_manual_wheelchair", rest)
  | 0x1f9d1 :: 0x200d :: 0x1f9bc :: rest ->
      Some ("person_in_motorized_wheelchair", rest)
  | 0x1f9d1 :: 0x200d :: 0x1f9b3 :: rest -> Some ("person_white_hair", rest)
  | 0x1f9d1 :: 0x200d :: 0x1f9b2 :: rest -> Some ("person_bald", rest)
  | 0x1f9d1 :: 0x200d :: 0x1f9b1 :: rest -> Some ("person_curly_hair", rest)
  | 0x1f9d1 :: 0x200d :: 0x1f9b0 :: rest -> Some ("person_red_hair", rest)
  | 0x1f9d1 :: 0x200d :: 0x1f9af :: rest ->
      Some ("person_with_probing_cane", rest)
  | 0x1f9d1 :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f9d1 :: rest ->
      Some ("people_holding_hands", rest)
  | 0x1f9d1 :: 0x200d :: 0x1f692 :: rest -> Some ("firefighter", rest)
  | 0x1f9d1 :: 0x200d :: 0x1f680 :: rest -> Some ("astronaut", rest)
  | 0x1f9d1 :: 0x200d :: 0x1f52c :: rest -> Some ("scientist", rest)
  | 0x1f9d1 :: 0x200d :: 0x1f527 :: rest -> Some ("mechanic", rest)
  | 0x1f9d1 :: 0x200d :: 0x1f4bc :: rest -> Some ("office_worker", rest)
  | 0x1f9d1 :: 0x200d :: 0x1f4bb :: rest -> Some ("technologist", rest)
  | 0x1f9d1 :: 0x200d :: 0x1f3ed :: rest -> Some ("factory_worker", rest)
  | 0x1f9d1 :: 0x200d :: 0x1f3eb :: rest -> Some ("teacher", rest)
  | 0x1f9d1 :: 0x200d :: 0x1f3a8 :: rest -> Some ("artist", rest)
  | 0x1f9d1 :: 0x200d :: 0x1f3a4 :: rest -> Some ("singer", rest)
  | 0x1f9d1 :: 0x200d :: 0x1f393 :: rest -> Some ("student", rest)
  | 0x1f9d1 :: 0x200d :: 0x1f384 :: rest -> Some ("mx_claus", rest)
  | 0x1f9d1 :: 0x200d :: 0x1f37c :: rest -> Some ("person_feeding_baby", rest)
  | 0x1f9d1 :: 0x200d :: 0x1f373 :: rest -> Some ("cook", rest)
  | 0x1f9d1 :: 0x200d :: 0x1f33e :: rest -> Some ("farmer", rest)
  | 0x1f9d1 :: 0x200d :: 0x2708 :: 0xfe0f :: rest -> Some ("pilot", rest)
  | 0x1f9d1 :: 0x200d :: 0x2696 :: 0xfe0f :: rest -> Some ("judge", rest)
  | 0x1f9d1 :: 0x200d :: 0x2695 :: 0xfe0f :: rest -> Some ("health_worker", rest)
  | 0x1f9d1 :: rest -> Some ("adult", rest)
  | 0x1f9d0 :: rest -> Some ("face_with_monocle", rest)
  | 0x1f9cf :: 0x1f3ff :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("deaf_man_tone5", rest)
  | 0x1f9cf :: 0x1f3ff :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("deaf_woman_tone5", rest)
  | 0x1f9cf :: 0x1f3ff :: rest -> Some ("deaf_person_tone5", rest)
  | 0x1f9cf :: 0x1f3fe :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("deaf_man_tone4", rest)
  | 0x1f9cf :: 0x1f3fe :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("deaf_woman_tone4", rest)
  | 0x1f9cf :: 0x1f3fe :: rest -> Some ("deaf_person_tone4", rest)
  | 0x1f9cf :: 0x1f3fd :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("deaf_man_tone3", rest)
  | 0x1f9cf :: 0x1f3fd :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("deaf_woman_tone3", rest)
  | 0x1f9cf :: 0x1f3fd :: rest -> Some ("deaf_person_tone3", rest)
  | 0x1f9cf :: 0x1f3fc :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("deaf_man_tone2", rest)
  | 0x1f9cf :: 0x1f3fc :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("deaf_woman_tone2", rest)
  | 0x1f9cf :: 0x1f3fc :: rest -> Some ("deaf_person_tone2", rest)
  | 0x1f9cf :: 0x1f3fb :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("deaf_man_tone1", rest)
  | 0x1f9cf :: 0x1f3fb :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("deaf_woman_tone1", rest)
  | 0x1f9cf :: 0x1f3fb :: rest -> Some ("deaf_person_tone1", rest)
  | 0x1f9cf :: 0x200d :: 0x2642 :: 0xfe0f :: rest -> Some ("deaf_man", rest)
  | 0x1f9cf :: 0x200d :: 0x2640 :: 0xfe0f :: rest -> Some ("deaf_woman", rest)
  | 0x1f9cf :: rest -> Some ("deaf_person", rest)
  | 0x1f9ce :: 0x1f3ff :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_kneeling_tone5", rest)
  | 0x1f9ce :: 0x1f3ff :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_kneeling_tone5", rest)
  | 0x1f9ce :: 0x1f3ff :: rest -> Some ("person_kneeling_tone5", rest)
  | 0x1f9ce :: 0x1f3fe :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_kneeling_tone4", rest)
  | 0x1f9ce :: 0x1f3fe :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_kneeling_tone4", rest)
  | 0x1f9ce :: 0x1f3fe :: rest -> Some ("person_kneeling_tone4", rest)
  | 0x1f9ce :: 0x1f3fd :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_kneeling_tone3", rest)
  | 0x1f9ce :: 0x1f3fd :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_kneeling_tone3", rest)
  | 0x1f9ce :: 0x1f3fd :: rest -> Some ("person_kneeling_tone3", rest)
  | 0x1f9ce :: 0x1f3fc :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_kneeling_tone2", rest)
  | 0x1f9ce :: 0x1f3fc :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_kneeling_tone2", rest)
  | 0x1f9ce :: 0x1f3fc :: rest -> Some ("person_kneeling_tone2", rest)
  | 0x1f9ce :: 0x1f3fb :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_kneeling_tone1", rest)
  | 0x1f9ce :: 0x1f3fb :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_kneeling_tone1", rest)
  | 0x1f9ce :: 0x1f3fb :: rest -> Some ("person_kneeling_tone1", rest)
  | 0x1f9ce :: 0x200d :: 0x2642 :: 0xfe0f :: rest -> Some ("man_kneeling", rest)
  | 0x1f9ce :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_kneeling", rest)
  | 0x1f9ce :: rest -> Some ("person_kneeling", rest)
  | 0x1f9cd :: 0x1f3ff :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_standing_tone5", rest)
  | 0x1f9cd :: 0x1f3ff :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_standing_tone5", rest)
  | 0x1f9cd :: 0x1f3ff :: rest -> Some ("person_standing_tone5", rest)
  | 0x1f9cd :: 0x1f3fe :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_standing_tone4", rest)
  | 0x1f9cd :: 0x1f3fe :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_standing_tone4", rest)
  | 0x1f9cd :: 0x1f3fe :: rest -> Some ("person_standing_tone4", rest)
  | 0x1f9cd :: 0x1f3fd :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_standing_tone3", rest)
  | 0x1f9cd :: 0x1f3fd :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_standing_tone3", rest)
  | 0x1f9cd :: 0x1f3fd :: rest -> Some ("person_standing_tone3", rest)
  | 0x1f9cd :: 0x1f3fc :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_standing_tone2", rest)
  | 0x1f9cd :: 0x1f3fc :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_standing_tone2", rest)
  | 0x1f9cd :: 0x1f3fc :: rest -> Some ("person_standing_tone2", rest)
  | 0x1f9cd :: 0x1f3fb :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_standing_tone1", rest)
  | 0x1f9cd :: 0x1f3fb :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_standing_tone1", rest)
  | 0x1f9cd :: 0x1f3fb :: rest -> Some ("person_standing_tone1", rest)
  | 0x1f9cd :: 0x200d :: 0x2642 :: 0xfe0f :: rest -> Some ("man_standing", rest)
  | 0x1f9cd :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_standing", rest)
  | 0x1f9cd :: rest -> Some ("person_standing", rest)
  | 0x1f9cc :: rest -> Some ("troll", rest)
  | 0x1f9cb :: rest -> Some ("bubble_tea", rest)
  | 0x1f9ca :: rest -> Some ("ice_cube", rest)
  | 0x1f9c9 :: rest -> Some ("mate", rest)
  | 0x1f9c8 :: rest -> Some ("butter", rest)
  | 0x1f9c7 :: rest -> Some ("waffle", rest)
  | 0x1f9c6 :: rest -> Some ("falafel", rest)
  | 0x1f9c5 :: rest -> Some ("onion", rest)
  | 0x1f9c4 :: rest -> Some ("garlic", rest)
  | 0x1f9c3 :: rest -> Some ("beverage_box", rest)
  | 0x1f9c2 :: rest -> Some ("salt", rest)
  | 0x1f9c1 :: rest -> Some ("cupcake", rest)
  | 0x1f9c0 :: rest -> Some ("cheese", rest)
  | 0x1f9bf :: rest -> Some ("mechanical_leg", rest)
  | 0x1f9be :: rest -> Some ("mechanical_arm", rest)
  | 0x1f9bd :: rest -> Some ("manual_wheelchair", rest)
  | 0x1f9bc :: rest -> Some ("motorized_wheelchair", rest)
  | 0x1f9bb :: 0x1f3ff :: rest -> Some ("ear_with_hearing_aid_tone5", rest)
  | 0x1f9bb :: 0x1f3fe :: rest -> Some ("ear_with_hearing_aid_tone4", rest)
  | 0x1f9bb :: 0x1f3fd :: rest -> Some ("ear_with_hearing_aid_tone3", rest)
  | 0x1f9bb :: 0x1f3fc :: rest -> Some ("ear_with_hearing_aid_tone2", rest)
  | 0x1f9bb :: 0x1f3fb :: rest -> Some ("ear_with_hearing_aid_tone1", rest)
  | 0x1f9bb :: rest -> Some ("ear_with_hearing_aid", rest)
  | 0x1f9ba :: rest -> Some ("safety_vest", rest)
  | 0x1f9b9 :: 0x1f3ff :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_supervillain_tone5", rest)
  | 0x1f9b9 :: 0x1f3ff :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_supervillain_tone5", rest)
  | 0x1f9b9 :: 0x1f3ff :: rest -> Some ("supervillain_tone5", rest)
  | 0x1f9b9 :: 0x1f3fe :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_supervillain_tone4", rest)
  | 0x1f9b9 :: 0x1f3fe :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_supervillain_tone4", rest)
  | 0x1f9b9 :: 0x1f3fe :: rest -> Some ("supervillain_tone4", rest)
  | 0x1f9b9 :: 0x1f3fd :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_supervillain_tone3", rest)
  | 0x1f9b9 :: 0x1f3fd :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_supervillain_tone3", rest)
  | 0x1f9b9 :: 0x1f3fd :: rest -> Some ("supervillain_tone3", rest)
  | 0x1f9b9 :: 0x1f3fc :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_supervillain_tone2", rest)
  | 0x1f9b9 :: 0x1f3fc :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_supervillain_tone2", rest)
  | 0x1f9b9 :: 0x1f3fc :: rest -> Some ("supervillain_tone2", rest)
  | 0x1f9b9 :: 0x1f3fb :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_supervillain_tone1", rest)
  | 0x1f9b9 :: 0x1f3fb :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_supervillain_tone1", rest)
  | 0x1f9b9 :: 0x1f3fb :: rest -> Some ("supervillain_tone1", rest)
  | 0x1f9b9 :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_supervillain", rest)
  | 0x1f9b9 :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_supervillain", rest)
  | 0x1f9b9 :: rest -> Some ("supervillain", rest)
  | 0x1f9b8 :: 0x1f3ff :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_superhero_tone5", rest)
  | 0x1f9b8 :: 0x1f3ff :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_superhero_tone5", rest)
  | 0x1f9b8 :: 0x1f3ff :: rest -> Some ("superhero_tone5", rest)
  | 0x1f9b8 :: 0x1f3fe :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_superhero_tone4", rest)
  | 0x1f9b8 :: 0x1f3fe :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_superhero_tone4", rest)
  | 0x1f9b8 :: 0x1f3fe :: rest -> Some ("superhero_tone4", rest)
  | 0x1f9b8 :: 0x1f3fd :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_superhero_tone3", rest)
  | 0x1f9b8 :: 0x1f3fd :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_superhero_tone3", rest)
  | 0x1f9b8 :: 0x1f3fd :: rest -> Some ("superhero_tone3", rest)
  | 0x1f9b8 :: 0x1f3fc :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_superhero_tone2", rest)
  | 0x1f9b8 :: 0x1f3fc :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_superhero_tone2", rest)
  | 0x1f9b8 :: 0x1f3fc :: rest -> Some ("superhero_tone2", rest)
  | 0x1f9b8 :: 0x1f3fb :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_superhero_tone1", rest)
  | 0x1f9b8 :: 0x1f3fb :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_superhero_tone1", rest)
  | 0x1f9b8 :: 0x1f3fb :: rest -> Some ("superhero_tone1", rest)
  | 0x1f9b8 :: 0x200d :: 0x2642 :: 0xfe0f :: rest -> Some ("man_superhero", rest)
  | 0x1f9b8 :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_superhero", rest)
  | 0x1f9b8 :: rest -> Some ("superhero", rest)
  | 0x1f9b7 :: rest -> Some ("tooth", rest)
  | 0x1f9b6 :: 0x1f3ff :: rest -> Some ("foot_tone5", rest)
  | 0x1f9b6 :: 0x1f3fe :: rest -> Some ("foot_tone4", rest)
  | 0x1f9b6 :: 0x1f3fd :: rest -> Some ("foot_tone3", rest)
  | 0x1f9b6 :: 0x1f3fc :: rest -> Some ("foot_tone2", rest)
  | 0x1f9b6 :: 0x1f3fb :: rest -> Some ("foot_tone1", rest)
  | 0x1f9b6 :: rest -> Some ("foot", rest)
  | 0x1f9b5 :: 0x1f3ff :: rest -> Some ("leg_tone5", rest)
  | 0x1f9b5 :: 0x1f3fe :: rest -> Some ("leg_tone4", rest)
  | 0x1f9b5 :: 0x1f3fd :: rest -> Some ("leg_tone3", rest)
  | 0x1f9b5 :: 0x1f3fc :: rest -> Some ("leg_tone2", rest)
  | 0x1f9b5 :: 0x1f3fb :: rest -> Some ("leg_tone1", rest)
  | 0x1f9b5 :: rest -> Some ("leg", rest)
  | 0x1f9b4 :: rest -> Some ("bone", rest)
  | 0x1f9b3 :: rest -> Some ("white_haired", rest)
  | 0x1f9b2 :: rest -> Some ("bald", rest)
  | 0x1f9b1 :: rest -> Some ("curly_haired", rest)
  | 0x1f9b0 :: rest -> Some ("red_haired", rest)
  | 0x1f9af :: rest -> Some ("probing_cane", rest)
  | 0x1f9ae :: rest -> Some ("guide_dog", rest)
  | 0x1f9ad :: rest -> Some ("seal", rest)
  | 0x1f9ac :: rest -> Some ("bison", rest)
  | 0x1f9ab :: rest -> Some ("beaver", rest)
  | 0x1f9aa :: rest -> Some ("oyster", rest)
  | 0x1f9a9 :: rest -> Some ("flamingo", rest)
  | 0x1f9a8 :: rest -> Some ("skunk", rest)
  | 0x1f9a7 :: rest -> Some ("orangutan", rest)
  | 0x1f9a6 :: rest -> Some ("otter", rest)
  | 0x1f9a5 :: rest -> Some ("sloth", rest)
  | 0x1f9a4 :: rest -> Some ("dodo", rest)
  | 0x1f9a3 :: rest -> Some ("mammoth", rest)
  | 0x1f9a2 :: rest -> Some ("swan", rest)
  | 0x1f9a1 :: rest -> Some ("badger", rest)
  | 0x1f9a0 :: rest -> Some ("microbe", rest)
  | 0x1f99f :: rest -> Some ("mosquito", rest)
  | 0x1f99e :: rest -> Some ("lobster", rest)
  | 0x1f99d :: rest -> Some ("raccoon", rest)
  | 0x1f99c :: rest -> Some ("parrot", rest)
  | 0x1f99b :: rest -> Some ("hippopotamus", rest)
  | 0x1f99a :: rest -> Some ("peacock", rest)
  | 0x1f999 :: rest -> Some ("llama", rest)
  | 0x1f998 :: rest -> Some ("kangaroo", rest)
  | 0x1f997 :: rest -> Some ("cricket", rest)
  | 0x1f996 :: rest -> Some ("t_rex", rest)
  | 0x1f995 :: rest -> Some ("sauropod", rest)
  | 0x1f994 :: rest -> Some ("hedgehog", rest)
  | 0x1f993 :: rest -> Some ("zebra", rest)
  | 0x1f992 :: rest -> Some ("giraffe", rest)
  | 0x1f991 :: rest -> Some ("squid", rest)
  | 0x1f990 :: rest -> Some ("shrimp", rest)
  | 0x1f98f :: rest -> Some ("rhino", rest)
  | 0x1f98e :: rest -> Some ("lizard", rest)
  | 0x1f98d :: rest -> Some ("gorilla", rest)
  | 0x1f98c :: rest -> Some ("deer", rest)
  | 0x1f98b :: rest -> Some ("butterfly", rest)
  | 0x1f98a :: rest -> Some ("fox", rest)
  | 0x1f989 :: rest -> Some ("owl", rest)
  | 0x1f988 :: rest -> Some ("shark", rest)
  | 0x1f987 :: rest -> Some ("bat", rest)
  | 0x1f986 :: rest -> Some ("duck", rest)
  | 0x1f985 :: rest -> Some ("eagle", rest)
  | 0x1f984 :: rest -> Some ("unicorn", rest)
  | 0x1f983 :: rest -> Some ("turkey", rest)
  | 0x1f982 :: rest -> Some ("scorpion", rest)
  | 0x1f981 :: rest -> Some ("lion_face", rest)
  | 0x1f980 :: rest -> Some ("crab", rest)
  | 0x1f97f :: rest -> Some ("womans_flat_shoe", rest)
  | 0x1f97e :: rest -> Some ("hiking_boot", rest)
  | 0x1f97d :: rest -> Some ("goggles", rest)
  | 0x1f97c :: rest -> Some ("lab_coat", rest)
  | 0x1f97b :: rest -> Some ("sari", rest)
  | 0x1f97a :: rest -> Some ("pleading_face", rest)
  | 0x1f979 :: rest -> Some ("face_holding_back_tears", rest)
  | 0x1f978 :: rest -> Some ("disguised_face", rest)
  | 0x1f977 :: 0x1f3ff :: rest -> Some ("ninja_tone5", rest)
  | 0x1f977 :: 0x1f3fe :: rest -> Some ("ninja_tone4", rest)
  | 0x1f977 :: 0x1f3fd :: rest -> Some ("ninja_tone3", rest)
  | 0x1f977 :: 0x1f3fc :: rest -> Some ("ninja_tone2", rest)
  | 0x1f977 :: 0x1f3fb :: rest -> Some ("ninja_tone1", rest)
  | 0x1f977 :: rest -> Some ("ninja", rest)
  | 0x1f976 :: rest -> Some ("cold_face", rest)
  | 0x1f975 :: rest -> Some ("hot_face", rest)
  | 0x1f974 :: rest -> Some ("woozy_face", rest)
  | 0x1f973 :: rest -> Some ("partying_face", rest)
  | 0x1f972 :: rest -> Some ("smiling_face_with_tear", rest)
  | 0x1f971 :: rest -> Some ("yawning_face", rest)
  | 0x1f970 :: rest -> Some ("smiling_face_with_3_hearts", rest)
  | 0x1f96f :: rest -> Some ("bagel", rest)
  | 0x1f96e :: rest -> Some ("moon_cake", rest)
  | 0x1f96d :: rest -> Some ("mango", rest)
  | 0x1f96c :: rest -> Some ("leafy_green", rest)
  | 0x1f96b :: rest -> Some ("canned_food", rest)
  | 0x1f96a :: rest -> Some ("sandwich", rest)
  | 0x1f969 :: rest -> Some ("cut_of_meat", rest)
  | 0x1f968 :: rest -> Some ("pretzel", rest)
  | 0x1f967 :: rest -> Some ("pie", rest)
  | 0x1f966 :: rest -> Some ("broccoli", rest)
  | 0x1f965 :: rest -> Some ("coconut", rest)
  | 0x1f964 :: rest -> Some ("cup_with_straw", rest)
  | 0x1f963 :: rest -> Some ("bowl_with_spoon", rest)
  | 0x1f962 :: rest -> Some ("chopsticks", rest)
  | 0x1f961 :: rest -> Some ("takeout_box", rest)
  | 0x1f960 :: rest -> Some ("fortune_cookie", rest)
  | 0x1f95f :: rest -> Some ("dumpling", rest)
  | 0x1f95e :: rest -> Some ("pancakes", rest)
  | 0x1f95d :: rest -> Some ("kiwi", rest)
  | 0x1f95c :: rest -> Some ("peanuts", rest)
  | 0x1f95b :: rest -> Some ("milk", rest)
  | 0x1f95a :: rest -> Some ("egg", rest)
  | 0x1f959 :: rest -> Some ("stuffed_flatbread", rest)
  | 0x1f958 :: rest -> Some ("shallow_pan_of_food", rest)
  | 0x1f957 :: rest -> Some ("salad", rest)
  | 0x1f956 :: rest -> Some ("french_bread", rest)
  | 0x1f955 :: rest -> Some ("carrot", rest)
  | 0x1f954 :: rest -> Some ("potato", rest)
  | 0x1f953 :: rest -> Some ("bacon", rest)
  | 0x1f952 :: rest -> Some ("cucumber", rest)
  | 0x1f951 :: rest -> Some ("avocado", rest)
  | 0x1f950 :: rest -> Some ("croissant", rest)
  | 0x1f94f :: rest -> Some ("flying_disc", rest)
  | 0x1f94e :: rest -> Some ("softball", rest)
  | 0x1f94d :: rest -> Some ("lacrosse", rest)
  | 0x1f94c :: rest -> Some ("curling_stone", rest)
  | 0x1f94b :: rest -> Some ("martial_arts_uniform", rest)
  | 0x1f94a :: rest -> Some ("boxing_glove", rest)
  | 0x1f949 :: rest -> Some ("third_place", rest)
  | 0x1f948 :: rest -> Some ("second_place", rest)
  | 0x1f947 :: rest -> Some ("first_place", rest)
  | 0x1f945 :: rest -> Some ("goal", rest)
  | 0x1f944 :: rest -> Some ("spoon", rest)
  | 0x1f943 :: rest -> Some ("tumbler_glass", rest)
  | 0x1f942 :: rest -> Some ("champagne_glass", rest)
  | 0x1f941 :: rest -> Some ("drum", rest)
  | 0x1f940 :: rest -> Some ("wilted_rose", rest)
  | 0x1f93f :: rest -> Some ("diving_mask", rest)
  | 0x1f93e :: 0x1f3ff :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_playing_handball_tone5", rest)
  | 0x1f93e :: 0x1f3ff :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_playing_handball_tone5", rest)
  | 0x1f93e :: 0x1f3ff :: rest -> Some ("person_playing_handball_tone5", rest)
  | 0x1f93e :: 0x1f3fe :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_playing_handball_tone4", rest)
  | 0x1f93e :: 0x1f3fe :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_playing_handball_tone4", rest)
  | 0x1f93e :: 0x1f3fe :: rest -> Some ("person_playing_handball_tone4", rest)
  | 0x1f93e :: 0x1f3fd :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_playing_handball_tone3", rest)
  | 0x1f93e :: 0x1f3fd :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_playing_handball_tone3", rest)
  | 0x1f93e :: 0x1f3fd :: rest -> Some ("person_playing_handball_tone3", rest)
  | 0x1f93e :: 0x1f3fc :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_playing_handball_tone2", rest)
  | 0x1f93e :: 0x1f3fc :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_playing_handball_tone2", rest)
  | 0x1f93e :: 0x1f3fc :: rest -> Some ("person_playing_handball_tone2", rest)
  | 0x1f93e :: 0x1f3fb :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_playing_handball_tone1", rest)
  | 0x1f93e :: 0x1f3fb :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_playing_handball_tone1", rest)
  | 0x1f93e :: 0x1f3fb :: rest -> Some ("person_playing_handball_tone1", rest)
  | 0x1f93e :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_playing_handball", rest)
  | 0x1f93e :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_playing_handball", rest)
  | 0x1f93e :: rest -> Some ("person_playing_handball", rest)
  | 0x1f93d :: 0x1f3ff :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_playing_water_polo_tone5", rest)
  | 0x1f93d :: 0x1f3ff :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_playing_water_polo_tone5", rest)
  | 0x1f93d :: 0x1f3ff :: rest -> Some ("person_playing_water_polo_tone5", rest)
  | 0x1f93d :: 0x1f3fe :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_playing_water_polo_tone4", rest)
  | 0x1f93d :: 0x1f3fe :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_playing_water_polo_tone4", rest)
  | 0x1f93d :: 0x1f3fe :: rest -> Some ("person_playing_water_polo_tone4", rest)
  | 0x1f93d :: 0x1f3fd :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_playing_water_polo_tone3", rest)
  | 0x1f93d :: 0x1f3fd :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_playing_water_polo_tone3", rest)
  | 0x1f93d :: 0x1f3fd :: rest -> Some ("person_playing_water_polo_tone3", rest)
  | 0x1f93d :: 0x1f3fc :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_playing_water_polo_tone2", rest)
  | 0x1f93d :: 0x1f3fc :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_playing_water_polo_tone2", rest)
  | 0x1f93d :: 0x1f3fc :: rest -> Some ("person_playing_water_polo_tone2", rest)
  | 0x1f93d :: 0x1f3fb :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_playing_water_polo_tone1", rest)
  | 0x1f93d :: 0x1f3fb :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_playing_water_polo_tone1", rest)
  | 0x1f93d :: 0x1f3fb :: rest -> Some ("person_playing_water_polo_tone1", rest)
  | 0x1f93d :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_playing_water_polo", rest)
  | 0x1f93d :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_playing_water_polo", rest)
  | 0x1f93d :: rest -> Some ("person_playing_water_polo", rest)
  | 0x1f93c :: 0x200d :: 0x2642 :: 0xfe0f :: rest -> Some ("men_wrestling", rest)
  | 0x1f93c :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("women_wrestling", rest)
  | 0x1f93c :: rest -> Some ("people_wrestling", rest)
  | 0x1f93a :: rest -> Some ("person_fencing", rest)
  | 0x1f939 :: 0x1f3ff :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_juggling_tone5", rest)
  | 0x1f939 :: 0x1f3ff :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_juggling_tone5", rest)
  | 0x1f939 :: 0x1f3ff :: rest -> Some ("person_juggling_tone5", rest)
  | 0x1f939 :: 0x1f3fe :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_juggling_tone4", rest)
  | 0x1f939 :: 0x1f3fe :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_juggling_tone4", rest)
  | 0x1f939 :: 0x1f3fe :: rest -> Some ("person_juggling_tone4", rest)
  | 0x1f939 :: 0x1f3fd :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_juggling_tone3", rest)
  | 0x1f939 :: 0x1f3fd :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_juggling_tone3", rest)
  | 0x1f939 :: 0x1f3fd :: rest -> Some ("person_juggling_tone3", rest)
  | 0x1f939 :: 0x1f3fc :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_juggling_tone2", rest)
  | 0x1f939 :: 0x1f3fc :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_juggling_tone2", rest)
  | 0x1f939 :: 0x1f3fc :: rest -> Some ("person_juggling_tone2", rest)
  | 0x1f939 :: 0x1f3fb :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_juggling_tone1", rest)
  | 0x1f939 :: 0x1f3fb :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_juggling_tone1", rest)
  | 0x1f939 :: 0x1f3fb :: rest -> Some ("person_juggling_tone1", rest)
  | 0x1f939 :: 0x200d :: 0x2642 :: 0xfe0f :: rest -> Some ("man_juggling", rest)
  | 0x1f939 :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_juggling", rest)
  | 0x1f939 :: rest -> Some ("person_juggling", rest)
  | 0x1f938 :: 0x1f3ff :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_cartwheeling_tone5", rest)
  | 0x1f938 :: 0x1f3ff :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_cartwheeling_tone5", rest)
  | 0x1f938 :: 0x1f3ff :: rest -> Some ("person_doing_cartwheel_tone5", rest)
  | 0x1f938 :: 0x1f3fe :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_cartwheeling_tone4", rest)
  | 0x1f938 :: 0x1f3fe :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_cartwheeling_tone4", rest)
  | 0x1f938 :: 0x1f3fe :: rest -> Some ("person_doing_cartwheel_tone4", rest)
  | 0x1f938 :: 0x1f3fd :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_cartwheeling_tone3", rest)
  | 0x1f938 :: 0x1f3fd :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_cartwheeling_tone3", rest)
  | 0x1f938 :: 0x1f3fd :: rest -> Some ("person_doing_cartwheel_tone3", rest)
  | 0x1f938 :: 0x1f3fc :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_cartwheeling_tone2", rest)
  | 0x1f938 :: 0x1f3fc :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_cartwheeling_tone2", rest)
  | 0x1f938 :: 0x1f3fc :: rest -> Some ("person_doing_cartwheel_tone2", rest)
  | 0x1f938 :: 0x1f3fb :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_cartwheeling_tone1", rest)
  | 0x1f938 :: 0x1f3fb :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_cartwheeling_tone1", rest)
  | 0x1f938 :: 0x1f3fb :: rest -> Some ("person_doing_cartwheel_tone1", rest)
  | 0x1f938 :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_cartwheeling", rest)
  | 0x1f938 :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_cartwheeling", rest)
  | 0x1f938 :: rest -> Some ("person_doing_cartwheel", rest)
  | 0x1f937 :: 0x1f3ff :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_shrugging_tone5", rest)
  | 0x1f937 :: 0x1f3ff :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_shrugging_tone5", rest)
  | 0x1f937 :: 0x1f3ff :: rest -> Some ("person_shrugging_tone5", rest)
  | 0x1f937 :: 0x1f3fe :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_shrugging_tone4", rest)
  | 0x1f937 :: 0x1f3fe :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_shrugging_tone4", rest)
  | 0x1f937 :: 0x1f3fe :: rest -> Some ("person_shrugging_tone4", rest)
  | 0x1f937 :: 0x1f3fd :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_shrugging_tone3", rest)
  | 0x1f937 :: 0x1f3fd :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_shrugging_tone3", rest)
  | 0x1f937 :: 0x1f3fd :: rest -> Some ("person_shrugging_tone3", rest)
  | 0x1f937 :: 0x1f3fc :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_shrugging_tone2", rest)
  | 0x1f937 :: 0x1f3fc :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_shrugging_tone2", rest)
  | 0x1f937 :: 0x1f3fc :: rest -> Some ("person_shrugging_tone2", rest)
  | 0x1f937 :: 0x1f3fb :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_shrugging_tone1", rest)
  | 0x1f937 :: 0x1f3fb :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_shrugging_tone1", rest)
  | 0x1f937 :: 0x1f3fb :: rest -> Some ("person_shrugging_tone1", rest)
  | 0x1f937 :: 0x200d :: 0x2642 :: 0xfe0f :: rest -> Some ("man_shrugging", rest)
  | 0x1f937 :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_shrugging", rest)
  | 0x1f937 :: rest -> Some ("person_shrugging", rest)
  | 0x1f936 :: 0x1f3ff :: rest -> Some ("mrs_claus_tone5", rest)
  | 0x1f936 :: 0x1f3fe :: rest -> Some ("mrs_claus_tone4", rest)
  | 0x1f936 :: 0x1f3fd :: rest -> Some ("mrs_claus_tone3", rest)
  | 0x1f936 :: 0x1f3fc :: rest -> Some ("mrs_claus_tone2", rest)
  | 0x1f936 :: 0x1f3fb :: rest -> Some ("mrs_claus_tone1", rest)
  | 0x1f936 :: rest -> Some ("mrs_claus", rest)
  | 0x1f935 :: 0x1f3ff :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_in_tuxedo_tone5", rest)
  | 0x1f935 :: 0x1f3ff :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_in_tuxedo_tone5", rest)
  | 0x1f935 :: 0x1f3ff :: rest -> Some ("person_in_tuxedo_tone5", rest)
  | 0x1f935 :: 0x1f3fe :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_in_tuxedo_tone4", rest)
  | 0x1f935 :: 0x1f3fe :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_in_tuxedo_tone4", rest)
  | 0x1f935 :: 0x1f3fe :: rest -> Some ("person_in_tuxedo_tone4", rest)
  | 0x1f935 :: 0x1f3fd :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_in_tuxedo_tone3", rest)
  | 0x1f935 :: 0x1f3fd :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_in_tuxedo_tone3", rest)
  | 0x1f935 :: 0x1f3fd :: rest -> Some ("person_in_tuxedo_tone3", rest)
  | 0x1f935 :: 0x1f3fc :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_in_tuxedo_tone2", rest)
  | 0x1f935 :: 0x1f3fc :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_in_tuxedo_tone2", rest)
  | 0x1f935 :: 0x1f3fc :: rest -> Some ("person_in_tuxedo_tone2", rest)
  | 0x1f935 :: 0x1f3fb :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_in_tuxedo_tone1", rest)
  | 0x1f935 :: 0x1f3fb :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_in_tuxedo_tone1", rest)
  | 0x1f935 :: 0x1f3fb :: rest -> Some ("person_in_tuxedo_tone1", rest)
  | 0x1f935 :: 0x200d :: 0x2642 :: 0xfe0f :: rest -> Some ("man_in_tuxedo", rest)
  | 0x1f935 :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_in_tuxedo", rest)
  | 0x1f935 :: rest -> Some ("person_in_tuxedo", rest)
  | 0x1f934 :: 0x1f3ff :: rest -> Some ("prince_tone5", rest)
  | 0x1f934 :: 0x1f3fe :: rest -> Some ("prince_tone4", rest)
  | 0x1f934 :: 0x1f3fd :: rest -> Some ("prince_tone3", rest)
  | 0x1f934 :: 0x1f3fc :: rest -> Some ("prince_tone2", rest)
  | 0x1f934 :: 0x1f3fb :: rest -> Some ("prince_tone1", rest)
  | 0x1f934 :: rest -> Some ("prince", rest)
  | 0x1f933 :: 0x1f3ff :: rest -> Some ("selfie_tone5", rest)
  | 0x1f933 :: 0x1f3fe :: rest -> Some ("selfie_tone4", rest)
  | 0x1f933 :: 0x1f3fd :: rest -> Some ("selfie_tone3", rest)
  | 0x1f933 :: 0x1f3fc :: rest -> Some ("selfie_tone2", rest)
  | 0x1f933 :: 0x1f3fb :: rest -> Some ("selfie_tone1", rest)
  | 0x1f933 :: rest -> Some ("selfie", rest)
  | 0x1f932 :: 0x1f3ff :: rest -> Some ("palms_up_together_tone5", rest)
  | 0x1f932 :: 0x1f3fe :: rest -> Some ("palms_up_together_tone4", rest)
  | 0x1f932 :: 0x1f3fd :: rest -> Some ("palms_up_together_tone3", rest)
  | 0x1f932 :: 0x1f3fc :: rest -> Some ("palms_up_together_tone2", rest)
  | 0x1f932 :: 0x1f3fb :: rest -> Some ("palms_up_together_tone1", rest)
  | 0x1f932 :: rest -> Some ("palms_up_together", rest)
  | 0x1f931 :: 0x1f3ff :: rest -> Some ("breast_feeding_tone5", rest)
  | 0x1f931 :: 0x1f3fe :: rest -> Some ("breast_feeding_tone4", rest)
  | 0x1f931 :: 0x1f3fd :: rest -> Some ("breast_feeding_tone3", rest)
  | 0x1f931 :: 0x1f3fc :: rest -> Some ("breast_feeding_tone2", rest)
  | 0x1f931 :: 0x1f3fb :: rest -> Some ("breast_feeding_tone1", rest)
  | 0x1f931 :: rest -> Some ("breast_feeding", rest)
  | 0x1f930 :: 0x1f3ff :: rest -> Some ("pregnant_woman_tone5", rest)
  | 0x1f930 :: 0x1f3fe :: rest -> Some ("pregnant_woman_tone4", rest)
  | 0x1f930 :: 0x1f3fd :: rest -> Some ("pregnant_woman_tone3", rest)
  | 0x1f930 :: 0x1f3fc :: rest -> Some ("pregnant_woman_tone2", rest)
  | 0x1f930 :: 0x1f3fb :: rest -> Some ("pregnant_woman_tone1", rest)
  | 0x1f930 :: rest -> Some ("pregnant_woman", rest)
  | 0x1f92f :: rest -> Some ("exploding_head", rest)
  | 0x1f92e :: rest -> Some ("face_vomiting", rest)
  | 0x1f92d :: rest -> Some ("face_with_hand_over_mouth", rest)
  | 0x1f92c :: rest -> Some ("face_with_symbols_over_mouth", rest)
  | 0x1f92b :: rest -> Some ("shushing_face", rest)
  | 0x1f92a :: rest -> Some ("zany_face", rest)
  | 0x1f929 :: rest -> Some ("star_struck", rest)
  | 0x1f928 :: rest -> Some ("face_with_raised_eyebrow", rest)
  | 0x1f927 :: rest -> Some ("sneezing_face", rest)
  | 0x1f926 :: 0x1f3ff :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_facepalming_tone5", rest)
  | 0x1f926 :: 0x1f3ff :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_facepalming_tone5", rest)
  | 0x1f926 :: 0x1f3ff :: rest -> Some ("person_facepalming_tone5", rest)
  | 0x1f926 :: 0x1f3fe :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_facepalming_tone4", rest)
  | 0x1f926 :: 0x1f3fe :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_facepalming_tone4", rest)
  | 0x1f926 :: 0x1f3fe :: rest -> Some ("person_facepalming_tone4", rest)
  | 0x1f926 :: 0x1f3fd :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_facepalming_tone3", rest)
  | 0x1f926 :: 0x1f3fd :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_facepalming_tone3", rest)
  | 0x1f926 :: 0x1f3fd :: rest -> Some ("person_facepalming_tone3", rest)
  | 0x1f926 :: 0x1f3fc :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_facepalming_tone2", rest)
  | 0x1f926 :: 0x1f3fc :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_facepalming_tone2", rest)
  | 0x1f926 :: 0x1f3fc :: rest -> Some ("person_facepalming_tone2", rest)
  | 0x1f926 :: 0x1f3fb :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_facepalming_tone1", rest)
  | 0x1f926 :: 0x1f3fb :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_facepalming_tone1", rest)
  | 0x1f926 :: 0x1f3fb :: rest -> Some ("person_facepalming_tone1", rest)
  | 0x1f926 :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_facepalming", rest)
  | 0x1f926 :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_facepalming", rest)
  | 0x1f926 :: rest -> Some ("person_facepalming", rest)
  | 0x1f925 :: rest -> Some ("lying_face", rest)
  | 0x1f924 :: rest -> Some ("drooling_face", rest)
  | 0x1f923 :: rest -> Some ("rofl", rest)
  | 0x1f922 :: rest -> Some ("nauseated_face", rest)
  | 0x1f921 :: rest -> Some ("clown", rest)
  | 0x1f920 :: rest -> Some ("cowboy", rest)
  | 0x1f91f :: 0x1f3ff :: rest -> Some ("love_you_gesture_tone5", rest)
  | 0x1f91f :: 0x1f3fe :: rest -> Some ("love_you_gesture_tone4", rest)
  | 0x1f91f :: 0x1f3fd :: rest -> Some ("love_you_gesture_tone3", rest)
  | 0x1f91f :: 0x1f3fc :: rest -> Some ("love_you_gesture_tone2", rest)
  | 0x1f91f :: 0x1f3fb :: rest -> Some ("love_you_gesture_tone1", rest)
  | 0x1f91f :: rest -> Some ("love_you_gesture", rest)
  | 0x1f91e :: 0x1f3ff :: rest -> Some ("fingers_crossed_tone5", rest)
  | 0x1f91e :: 0x1f3fe :: rest -> Some ("fingers_crossed_tone4", rest)
  | 0x1f91e :: 0x1f3fd :: rest -> Some ("fingers_crossed_tone3", rest)
  | 0x1f91e :: 0x1f3fc :: rest -> Some ("fingers_crossed_tone2", rest)
  | 0x1f91e :: 0x1f3fb :: rest -> Some ("fingers_crossed_tone1", rest)
  | 0x1f91e :: rest -> Some ("fingers_crossed", rest)
  | 0x1f91d :: 0x1f3ff :: rest -> Some ("handshake_tone5", rest)
  | 0x1f91d :: 0x1f3fe :: rest -> Some ("handshake_tone4", rest)
  | 0x1f91d :: 0x1f3fd :: rest -> Some ("handshake_tone3", rest)
  | 0x1f91d :: 0x1f3fc :: rest -> Some ("handshake_tone2", rest)
  | 0x1f91d :: 0x1f3fb :: rest -> Some ("handshake_tone1", rest)
  | 0x1f91d :: rest -> Some ("handshake", rest)
  | 0x1f91c :: 0x1f3ff :: rest -> Some ("right_facing_fist_tone5", rest)
  | 0x1f91c :: 0x1f3fe :: rest -> Some ("right_facing_fist_tone4", rest)
  | 0x1f91c :: 0x1f3fd :: rest -> Some ("right_facing_fist_tone3", rest)
  | 0x1f91c :: 0x1f3fc :: rest -> Some ("right_facing_fist_tone2", rest)
  | 0x1f91c :: 0x1f3fb :: rest -> Some ("right_facing_fist_tone1", rest)
  | 0x1f91c :: rest -> Some ("right_facing_fist", rest)
  | 0x1f91b :: 0x1f3ff :: rest -> Some ("left_facing_fist_tone5", rest)
  | 0x1f91b :: 0x1f3fe :: rest -> Some ("left_facing_fist_tone4", rest)
  | 0x1f91b :: 0x1f3fd :: rest -> Some ("left_facing_fist_tone3", rest)
  | 0x1f91b :: 0x1f3fc :: rest -> Some ("left_facing_fist_tone2", rest)
  | 0x1f91b :: 0x1f3fb :: rest -> Some ("left_facing_fist_tone1", rest)
  | 0x1f91b :: rest -> Some ("left_facing_fist", rest)
  | 0x1f91a :: 0x1f3ff :: rest -> Some ("raised_back_of_hand_tone5", rest)
  | 0x1f91a :: 0x1f3fe :: rest -> Some ("raised_back_of_hand_tone4", rest)
  | 0x1f91a :: 0x1f3fd :: rest -> Some ("raised_back_of_hand_tone3", rest)
  | 0x1f91a :: 0x1f3fc :: rest -> Some ("raised_back_of_hand_tone2", rest)
  | 0x1f91a :: 0x1f3fb :: rest -> Some ("raised_back_of_hand_tone1", rest)
  | 0x1f91a :: rest -> Some ("raised_back_of_hand", rest)
  | 0x1f919 :: 0x1f3ff :: rest -> Some ("call_me_tone5", rest)
  | 0x1f919 :: 0x1f3fe :: rest -> Some ("call_me_tone4", rest)
  | 0x1f919 :: 0x1f3fd :: rest -> Some ("call_me_tone3", rest)
  | 0x1f919 :: 0x1f3fc :: rest -> Some ("call_me_tone2", rest)
  | 0x1f919 :: 0x1f3fb :: rest -> Some ("call_me_tone1", rest)
  | 0x1f919 :: rest -> Some ("call_me", rest)
  | 0x1f918 :: 0x1f3ff :: rest -> Some ("metal_tone5", rest)
  | 0x1f918 :: 0x1f3fe :: rest -> Some ("metal_tone4", rest)
  | 0x1f918 :: 0x1f3fd :: rest -> Some ("metal_tone3", rest)
  | 0x1f918 :: 0x1f3fc :: rest -> Some ("metal_tone2", rest)
  | 0x1f918 :: 0x1f3fb :: rest -> Some ("metal_tone1", rest)
  | 0x1f918 :: rest -> Some ("metal", rest)
  | 0x1f917 :: rest -> Some ("hugging", rest)
  | 0x1f916 :: rest -> Some ("robot", rest)
  | 0x1f915 :: rest -> Some ("head_bandage", rest)
  | 0x1f914 :: rest -> Some ("thinking", rest)
  | 0x1f913 :: rest -> Some ("nerd", rest)
  | 0x1f912 :: rest -> Some ("thermometer_face", rest)
  | 0x1f911 :: rest -> Some ("money_mouth", rest)
  | 0x1f910 :: rest -> Some ("zipper_mouth", rest)
  | 0x1f90f :: 0x1f3ff :: rest -> Some ("pinching_hand_tone5", rest)
  | 0x1f90f :: 0x1f3fe :: rest -> Some ("pinching_hand_tone4", rest)
  | 0x1f90f :: 0x1f3fd :: rest -> Some ("pinching_hand_tone3", rest)
  | 0x1f90f :: 0x1f3fc :: rest -> Some ("pinching_hand_tone2", rest)
  | 0x1f90f :: 0x1f3fb :: rest -> Some ("pinching_hand_tone1", rest)
  | 0x1f90f :: rest -> Some ("pinching_hand", rest)
  | 0x1f90e :: rest -> Some ("brown_heart", rest)
  | 0x1f90d :: rest -> Some ("white_heart", rest)
  | 0x1f90c :: 0x1f3ff :: rest -> Some ("pinched_fingers_tone5", rest)
  | 0x1f90c :: 0x1f3fe :: rest -> Some ("pinched_fingers_tone4", rest)
  | 0x1f90c :: 0x1f3fd :: rest -> Some ("pinched_fingers_tone3", rest)
  | 0x1f90c :: 0x1f3fc :: rest -> Some ("pinched_fingers_tone2", rest)
  | 0x1f90c :: 0x1f3fb :: rest -> Some ("pinched_fingers_tone1", rest)
  | 0x1f90c :: rest -> Some ("pinched_fingers", rest)
  | 0x1f7f0 :: rest -> Some ("heavy_equals_sign", rest)
  | 0x1f7eb :: rest -> Some ("brown_square", rest)
  | 0x1f7ea :: rest -> Some ("purple_square", rest)
  | 0x1f7e9 :: rest -> Some ("green_square", rest)
  | 0x1f7e8 :: rest -> Some ("yellow_square", rest)
  | 0x1f7e7 :: rest -> Some ("orange_square", rest)
  | 0x1f7e6 :: rest -> Some ("blue_square", rest)
  | 0x1f7e5 :: rest -> Some ("red_square", rest)
  | 0x1f7e4 :: rest -> Some ("brown_circle", rest)
  | 0x1f7e3 :: rest -> Some ("purple_circle", rest)
  | 0x1f7e2 :: rest -> Some ("green_circle", rest)
  | 0x1f7e1 :: rest -> Some ("yellow_circle", rest)
  | 0x1f7e0 :: rest -> Some ("orange_circle", rest)
  | 0x1f6fc :: rest -> Some ("roller_skate", rest)
  | 0x1f6fb :: rest -> Some ("pickup_truck", rest)
  | 0x1f6fa :: rest -> Some ("auto_rickshaw", rest)
  | 0x1f6f9 :: rest -> Some ("skateboard", rest)
  | 0x1f6f8 :: rest -> Some ("flying_saucer", rest)
  | 0x1f6f7 :: rest -> Some ("sled", rest)
  | 0x1f6f6 :: rest -> Some ("canoe", rest)
  | 0x1f6f5 :: rest -> Some ("motor_scooter", rest)
  | 0x1f6f4 :: rest -> Some ("scooter", rest)
  | 0x1f6f3 :: rest -> Some ("cruise_ship", rest)
  | 0x1f6f0 :: rest -> Some ("satellite_orbital", rest)
  | 0x1f6ec :: rest -> Some ("airplane_arriving", rest)
  | 0x1f6eb :: rest -> Some ("airplane_departure", rest)
  | 0x1f6e9 :: rest -> Some ("airplane_small", rest)
  | 0x1f6e5 :: rest -> Some ("motorboat", rest)
  | 0x1f6e4 :: rest -> Some ("railway_track", rest)
  | 0x1f6e3 :: rest -> Some ("motorway", rest)
  | 0x1f6e2 :: rest -> Some ("oil", rest)
  | 0x1f6e1 :: rest -> Some ("shield", rest)
  | 0x1f6e0 :: rest -> Some ("tools", rest)
  | 0x1f6df :: rest -> Some ("ring_buoy", rest)
  | 0x1f6de :: rest -> Some ("wheel", rest)
  | 0x1f6dd :: rest -> Some ("playground_slide", rest)
  | 0x1f6d7 :: rest -> Some ("elevator", rest)
  | 0x1f6d6 :: rest -> Some ("hut", rest)
  | 0x1f6d5 :: rest -> Some ("hindu_temple", rest)
  | 0x1f6d2 :: rest -> Some ("shopping_cart", rest)
  | 0x1f6d1 :: rest -> Some ("octagonal_sign", rest)
  | 0x1f6d0 :: rest -> Some ("place_of_worship", rest)
  | 0x1f6cf :: rest -> Some ("bed", rest)
  | 0x1f6ce :: rest -> Some ("bellhop", rest)
  | 0x1f6cd :: rest -> Some ("shopping_bags", rest)
  | 0x1f6cc :: 0x1f3ff :: rest -> Some ("person_in_bed_tone5", rest)
  | 0x1f6cc :: 0x1f3fe :: rest -> Some ("person_in_bed_tone4", rest)
  | 0x1f6cc :: 0x1f3fd :: rest -> Some ("person_in_bed_tone3", rest)
  | 0x1f6cc :: 0x1f3fc :: rest -> Some ("person_in_bed_tone2", rest)
  | 0x1f6cc :: 0x1f3fb :: rest -> Some ("person_in_bed_tone1", rest)
  | 0x1f6cc :: rest -> Some ("sleeping_accommodation", rest)
  | 0x1f6cb :: rest -> Some ("couch", rest)
  | 0x1f6c5 :: rest -> Some ("left_luggage", rest)
  | 0x1f6c4 :: rest -> Some ("baggage_claim", rest)
  | 0x1f6c3 :: rest -> Some ("customs", rest)
  | 0x1f6c2 :: rest -> Some ("passport_control", rest)
  | 0x1f6c1 :: rest -> Some ("bathtub", rest)
  | 0x1f6c0 :: 0x1f3ff :: rest -> Some ("bath_tone5", rest)
  | 0x1f6c0 :: 0x1f3fe :: rest -> Some ("bath_tone4", rest)
  | 0x1f6c0 :: 0x1f3fd :: rest -> Some ("bath_tone3", rest)
  | 0x1f6c0 :: 0x1f3fc :: rest -> Some ("bath_tone2", rest)
  | 0x1f6c0 :: 0x1f3fb :: rest -> Some ("bath_tone1", rest)
  | 0x1f6c0 :: rest -> Some ("bath", rest)
  | 0x1f6bf :: rest -> Some ("shower", rest)
  | 0x1f6be :: rest -> Some ("wc", rest)
  | 0x1f6bd :: rest -> Some ("toilet", rest)
  | 0x1f6bc :: rest -> Some ("baby_symbol", rest)
  | 0x1f6bb :: rest -> Some ("restroom", rest)
  | 0x1f6ba :: rest -> Some ("womens", rest)
  | 0x1f6b9 :: rest -> Some ("mens", rest)
  | 0x1f6b8 :: rest -> Some ("children_crossing", rest)
  | 0x1f6b7 :: rest -> Some ("no_pedestrians", rest)
  | 0x1f6b6 :: 0x1f3ff :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_walking_tone5", rest)
  | 0x1f6b6 :: 0x1f3ff :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_walking_tone5", rest)
  | 0x1f6b6 :: 0x1f3ff :: rest -> Some ("person_walking_tone5", rest)
  | 0x1f6b6 :: 0x1f3fe :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_walking_tone4", rest)
  | 0x1f6b6 :: 0x1f3fe :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_walking_tone4", rest)
  | 0x1f6b6 :: 0x1f3fe :: rest -> Some ("person_walking_tone4", rest)
  | 0x1f6b6 :: 0x1f3fd :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_walking_tone3", rest)
  | 0x1f6b6 :: 0x1f3fd :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_walking_tone3", rest)
  | 0x1f6b6 :: 0x1f3fd :: rest -> Some ("person_walking_tone3", rest)
  | 0x1f6b6 :: 0x1f3fc :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_walking_tone2", rest)
  | 0x1f6b6 :: 0x1f3fc :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_walking_tone2", rest)
  | 0x1f6b6 :: 0x1f3fc :: rest -> Some ("person_walking_tone2", rest)
  | 0x1f6b6 :: 0x1f3fb :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_walking_tone1", rest)
  | 0x1f6b6 :: 0x1f3fb :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_walking_tone1", rest)
  | 0x1f6b6 :: 0x1f3fb :: rest -> Some ("person_walking_tone1", rest)
  | 0x1f6b6 :: 0x200d :: 0x2642 :: 0xfe0f :: rest -> Some ("man_walking", rest)
  | 0x1f6b6 :: 0x200d :: 0x2640 :: 0xfe0f :: rest -> Some ("woman_walking", rest)
  | 0x1f6b6 :: rest -> Some ("person_walking", rest)
  | 0x1f6b5 :: 0x1f3ff :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_mountain_biking_tone5", rest)
  | 0x1f6b5 :: 0x1f3ff :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_mountain_biking_tone5", rest)
  | 0x1f6b5 :: 0x1f3ff :: rest -> Some ("person_mountain_biking_tone5", rest)
  | 0x1f6b5 :: 0x1f3fe :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_mountain_biking_tone4", rest)
  | 0x1f6b5 :: 0x1f3fe :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_mountain_biking_tone4", rest)
  | 0x1f6b5 :: 0x1f3fe :: rest -> Some ("person_mountain_biking_tone4", rest)
  | 0x1f6b5 :: 0x1f3fd :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_mountain_biking_tone3", rest)
  | 0x1f6b5 :: 0x1f3fd :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_mountain_biking_tone3", rest)
  | 0x1f6b5 :: 0x1f3fd :: rest -> Some ("person_mountain_biking_tone3", rest)
  | 0x1f6b5 :: 0x1f3fc :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_mountain_biking_tone2", rest)
  | 0x1f6b5 :: 0x1f3fc :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_mountain_biking_tone2", rest)
  | 0x1f6b5 :: 0x1f3fc :: rest -> Some ("person_mountain_biking_tone2", rest)
  | 0x1f6b5 :: 0x1f3fb :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_mountain_biking_tone1", rest)
  | 0x1f6b5 :: 0x1f3fb :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_mountain_biking_tone1", rest)
  | 0x1f6b5 :: 0x1f3fb :: rest -> Some ("person_mountain_biking_tone1", rest)
  | 0x1f6b5 :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_mountain_biking", rest)
  | 0x1f6b5 :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_mountain_biking", rest)
  | 0x1f6b5 :: rest -> Some ("person_mountain_biking", rest)
  | 0x1f6b4 :: 0x1f3ff :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_biking_tone5", rest)
  | 0x1f6b4 :: 0x1f3ff :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_biking_tone5", rest)
  | 0x1f6b4 :: 0x1f3ff :: rest -> Some ("person_biking_tone5", rest)
  | 0x1f6b4 :: 0x1f3fe :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_biking_tone4", rest)
  | 0x1f6b4 :: 0x1f3fe :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_biking_tone4", rest)
  | 0x1f6b4 :: 0x1f3fe :: rest -> Some ("person_biking_tone4", rest)
  | 0x1f6b4 :: 0x1f3fd :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_biking_tone3", rest)
  | 0x1f6b4 :: 0x1f3fd :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_biking_tone3", rest)
  | 0x1f6b4 :: 0x1f3fd :: rest -> Some ("person_biking_tone3", rest)
  | 0x1f6b4 :: 0x1f3fc :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_biking_tone2", rest)
  | 0x1f6b4 :: 0x1f3fc :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_biking_tone2", rest)
  | 0x1f6b4 :: 0x1f3fc :: rest -> Some ("person_biking_tone2", rest)
  | 0x1f6b4 :: 0x1f3fb :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_biking_tone1", rest)
  | 0x1f6b4 :: 0x1f3fb :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_biking_tone1", rest)
  | 0x1f6b4 :: 0x1f3fb :: rest -> Some ("person_biking_tone1", rest)
  | 0x1f6b4 :: 0x200d :: 0x2642 :: 0xfe0f :: rest -> Some ("man_biking", rest)
  | 0x1f6b4 :: 0x200d :: 0x2640 :: 0xfe0f :: rest -> Some ("woman_biking", rest)
  | 0x1f6b4 :: rest -> Some ("person_biking", rest)
  | 0x1f6b3 :: rest -> Some ("no_bicycles", rest)
  | 0x1f6b2 :: rest -> Some ("bike", rest)
  | 0x1f6b1 :: rest -> Some ("non-potable_water", rest)
  | 0x1f6b0 :: rest -> Some ("potable_water", rest)
  | 0x1f6af :: rest -> Some ("do_not_litter", rest)
  | 0x1f6ae :: rest -> Some ("put_litter_in_its_place", rest)
  | 0x1f6ad :: rest -> Some ("no_smoking", rest)
  | 0x1f6ac :: rest -> Some ("smoking", rest)
  | 0x1f6ab :: rest -> Some ("no_entry_sign", rest)
  | 0x1f6aa :: rest -> Some ("door", rest)
  | 0x1f6a9 :: rest -> Some ("triangular_flag_on_post", rest)
  | 0x1f6a8 :: rest -> Some ("rotating_light", rest)
  | 0x1f6a7 :: rest -> Some ("construction", rest)
  | 0x1f6a6 :: rest -> Some ("vertical_traffic_light", rest)
  | 0x1f6a5 :: rest -> Some ("traffic_light", rest)
  | 0x1f6a4 :: rest -> Some ("speedboat", rest)
  | 0x1f6a3 :: 0x1f3ff :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_rowing_boat_tone5", rest)
  | 0x1f6a3 :: 0x1f3ff :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_rowing_boat_tone5", rest)
  | 0x1f6a3 :: 0x1f3ff :: rest -> Some ("person_rowing_boat_tone5", rest)
  | 0x1f6a3 :: 0x1f3fe :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_rowing_boat_tone4", rest)
  | 0x1f6a3 :: 0x1f3fe :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_rowing_boat_tone4", rest)
  | 0x1f6a3 :: 0x1f3fe :: rest -> Some ("person_rowing_boat_tone4", rest)
  | 0x1f6a3 :: 0x1f3fd :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_rowing_boat_tone3", rest)
  | 0x1f6a3 :: 0x1f3fd :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_rowing_boat_tone3", rest)
  | 0x1f6a3 :: 0x1f3fd :: rest -> Some ("person_rowing_boat_tone3", rest)
  | 0x1f6a3 :: 0x1f3fc :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_rowing_boat_tone2", rest)
  | 0x1f6a3 :: 0x1f3fc :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_rowing_boat_tone2", rest)
  | 0x1f6a3 :: 0x1f3fc :: rest -> Some ("person_rowing_boat_tone2", rest)
  | 0x1f6a3 :: 0x1f3fb :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_rowing_boat_tone1", rest)
  | 0x1f6a3 :: 0x1f3fb :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_rowing_boat_tone1", rest)
  | 0x1f6a3 :: 0x1f3fb :: rest -> Some ("person_rowing_boat_tone1", rest)
  | 0x1f6a3 :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_rowing_boat", rest)
  | 0x1f6a3 :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_rowing_boat", rest)
  | 0x1f6a3 :: rest -> Some ("person_rowing_boat", rest)
  | 0x1f6a2 :: rest -> Some ("ship", rest)
  | 0x1f6a1 :: rest -> Some ("aerial_tramway", rest)
  | 0x1f6a0 :: rest -> Some ("mountain_cableway", rest)
  | 0x1f69f :: rest -> Some ("suspension_railway", rest)
  | 0x1f69e :: rest -> Some ("mountain_railway", rest)
  | 0x1f69d :: rest -> Some ("monorail", rest)
  | 0x1f69c :: rest -> Some ("tractor", rest)
  | 0x1f69b :: rest -> Some ("articulated_lorry", rest)
  | 0x1f69a :: rest -> Some ("truck", rest)
  | 0x1f699 :: rest -> Some ("blue_car", rest)
  | 0x1f698 :: rest -> Some ("oncoming_automobile", rest)
  | 0x1f697 :: rest -> Some ("red_car", rest)
  | 0x1f696 :: rest -> Some ("oncoming_taxi", rest)
  | 0x1f695 :: rest -> Some ("taxi", rest)
  | 0x1f694 :: rest -> Some ("oncoming_police_car", rest)
  | 0x1f693 :: rest -> Some ("police_car", rest)
  | 0x1f692 :: rest -> Some ("fire_engine", rest)
  | 0x1f691 :: rest -> Some ("ambulance", rest)
  | 0x1f690 :: rest -> Some ("minibus", rest)
  | 0x1f68f :: rest -> Some ("busstop", rest)
  | 0x1f68e :: rest -> Some ("trolleybus", rest)
  | 0x1f68d :: rest -> Some ("oncoming_bus", rest)
  | 0x1f68c :: rest -> Some ("bus", rest)
  | 0x1f68b :: rest -> Some ("train", rest)
  | 0x1f68a :: rest -> Some ("tram", rest)
  | 0x1f689 :: rest -> Some ("station", rest)
  | 0x1f688 :: rest -> Some ("light_rail", rest)
  | 0x1f687 :: rest -> Some ("metro", rest)
  | 0x1f686 :: rest -> Some ("train2", rest)
  | 0x1f685 :: rest -> Some ("bullettrain_front", rest)
  | 0x1f684 :: rest -> Some ("bullettrain_side", rest)
  | 0x1f683 :: rest -> Some ("railway_car", rest)
  | 0x1f682 :: rest -> Some ("steam_locomotive", rest)
  | 0x1f681 :: rest -> Some ("helicopter", rest)
  | 0x1f680 :: rest -> Some ("rocket", rest)
  | 0x1f64f :: 0x1f3ff :: rest -> Some ("pray_tone5", rest)
  | 0x1f64f :: 0x1f3fe :: rest -> Some ("pray_tone4", rest)
  | 0x1f64f :: 0x1f3fd :: rest -> Some ("pray_tone3", rest)
  | 0x1f64f :: 0x1f3fc :: rest -> Some ("pray_tone2", rest)
  | 0x1f64f :: 0x1f3fb :: rest -> Some ("pray_tone1", rest)
  | 0x1f64f :: rest -> Some ("pray", rest)
  | 0x1f64e :: 0x1f3ff :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_pouting_tone5", rest)
  | 0x1f64e :: 0x1f3ff :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_pouting_tone5", rest)
  | 0x1f64e :: 0x1f3ff :: rest -> Some ("person_pouting_tone5", rest)
  | 0x1f64e :: 0x1f3fe :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_pouting_tone4", rest)
  | 0x1f64e :: 0x1f3fe :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_pouting_tone4", rest)
  | 0x1f64e :: 0x1f3fe :: rest -> Some ("person_pouting_tone4", rest)
  | 0x1f64e :: 0x1f3fd :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_pouting_tone3", rest)
  | 0x1f64e :: 0x1f3fd :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_pouting_tone3", rest)
  | 0x1f64e :: 0x1f3fd :: rest -> Some ("person_pouting_tone3", rest)
  | 0x1f64e :: 0x1f3fc :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_pouting_tone2", rest)
  | 0x1f64e :: 0x1f3fc :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_pouting_tone2", rest)
  | 0x1f64e :: 0x1f3fc :: rest -> Some ("person_pouting_tone2", rest)
  | 0x1f64e :: 0x1f3fb :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_pouting_tone1", rest)
  | 0x1f64e :: 0x1f3fb :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_pouting_tone1", rest)
  | 0x1f64e :: 0x1f3fb :: rest -> Some ("person_pouting_tone1", rest)
  | 0x1f64e :: 0x200d :: 0x2642 :: 0xfe0f :: rest -> Some ("man_pouting", rest)
  | 0x1f64e :: 0x200d :: 0x2640 :: 0xfe0f :: rest -> Some ("woman_pouting", rest)
  | 0x1f64e :: rest -> Some ("person_pouting", rest)
  | 0x1f64d :: 0x1f3ff :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_frowning_tone5", rest)
  | 0x1f64d :: 0x1f3ff :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_frowning_tone5", rest)
  | 0x1f64d :: 0x1f3ff :: rest -> Some ("person_frowning_tone5", rest)
  | 0x1f64d :: 0x1f3fe :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_frowning_tone4", rest)
  | 0x1f64d :: 0x1f3fe :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_frowning_tone4", rest)
  | 0x1f64d :: 0x1f3fe :: rest -> Some ("person_frowning_tone4", rest)
  | 0x1f64d :: 0x1f3fd :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_frowning_tone3", rest)
  | 0x1f64d :: 0x1f3fd :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_frowning_tone3", rest)
  | 0x1f64d :: 0x1f3fd :: rest -> Some ("person_frowning_tone3", rest)
  | 0x1f64d :: 0x1f3fc :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_frowning_tone2", rest)
  | 0x1f64d :: 0x1f3fc :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_frowning_tone2", rest)
  | 0x1f64d :: 0x1f3fc :: rest -> Some ("person_frowning_tone2", rest)
  | 0x1f64d :: 0x1f3fb :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_frowning_tone1", rest)
  | 0x1f64d :: 0x1f3fb :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_frowning_tone1", rest)
  | 0x1f64d :: 0x1f3fb :: rest -> Some ("person_frowning_tone1", rest)
  | 0x1f64d :: 0x200d :: 0x2642 :: 0xfe0f :: rest -> Some ("man_frowning", rest)
  | 0x1f64d :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_frowning", rest)
  | 0x1f64d :: rest -> Some ("person_frowning", rest)
  | 0x1f64c :: 0x1f3ff :: rest -> Some ("raised_hands_tone5", rest)
  | 0x1f64c :: 0x1f3fe :: rest -> Some ("raised_hands_tone4", rest)
  | 0x1f64c :: 0x1f3fd :: rest -> Some ("raised_hands_tone3", rest)
  | 0x1f64c :: 0x1f3fc :: rest -> Some ("raised_hands_tone2", rest)
  | 0x1f64c :: 0x1f3fb :: rest -> Some ("raised_hands_tone1", rest)
  | 0x1f64c :: rest -> Some ("raised_hands", rest)
  | 0x1f64b :: 0x1f3ff :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_raising_hand_tone5", rest)
  | 0x1f64b :: 0x1f3ff :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_raising_hand_tone5", rest)
  | 0x1f64b :: 0x1f3ff :: rest -> Some ("person_raising_hand_tone5", rest)
  | 0x1f64b :: 0x1f3fe :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_raising_hand_tone4", rest)
  | 0x1f64b :: 0x1f3fe :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_raising_hand_tone4", rest)
  | 0x1f64b :: 0x1f3fe :: rest -> Some ("person_raising_hand_tone4", rest)
  | 0x1f64b :: 0x1f3fd :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_raising_hand_tone3", rest)
  | 0x1f64b :: 0x1f3fd :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_raising_hand_tone3", rest)
  | 0x1f64b :: 0x1f3fd :: rest -> Some ("person_raising_hand_tone3", rest)
  | 0x1f64b :: 0x1f3fc :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_raising_hand_tone2", rest)
  | 0x1f64b :: 0x1f3fc :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_raising_hand_tone2", rest)
  | 0x1f64b :: 0x1f3fc :: rest -> Some ("person_raising_hand_tone2", rest)
  | 0x1f64b :: 0x1f3fb :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_raising_hand_tone1", rest)
  | 0x1f64b :: 0x1f3fb :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_raising_hand_tone1", rest)
  | 0x1f64b :: 0x1f3fb :: rest -> Some ("person_raising_hand_tone1", rest)
  | 0x1f64b :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_raising_hand", rest)
  | 0x1f64b :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_raising_hand", rest)
  | 0x1f64b :: rest -> Some ("person_raising_hand", rest)
  | 0x1f64a :: rest -> Some ("speak_no_evil", rest)
  | 0x1f649 :: rest -> Some ("hear_no_evil", rest)
  | 0x1f648 :: rest -> Some ("see_no_evil", rest)
  | 0x1f647 :: 0x1f3ff :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_bowing_tone5", rest)
  | 0x1f647 :: 0x1f3ff :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_bowing_tone5", rest)
  | 0x1f647 :: 0x1f3ff :: rest -> Some ("person_bowing_tone5", rest)
  | 0x1f647 :: 0x1f3fe :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_bowing_tone4", rest)
  | 0x1f647 :: 0x1f3fe :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_bowing_tone4", rest)
  | 0x1f647 :: 0x1f3fe :: rest -> Some ("person_bowing_tone4", rest)
  | 0x1f647 :: 0x1f3fd :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_bowing_tone3", rest)
  | 0x1f647 :: 0x1f3fd :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_bowing_tone3", rest)
  | 0x1f647 :: 0x1f3fd :: rest -> Some ("person_bowing_tone3", rest)
  | 0x1f647 :: 0x1f3fc :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_bowing_tone2", rest)
  | 0x1f647 :: 0x1f3fc :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_bowing_tone2", rest)
  | 0x1f647 :: 0x1f3fc :: rest -> Some ("person_bowing_tone2", rest)
  | 0x1f647 :: 0x1f3fb :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_bowing_tone1", rest)
  | 0x1f647 :: 0x1f3fb :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_bowing_tone1", rest)
  | 0x1f647 :: 0x1f3fb :: rest -> Some ("person_bowing_tone1", rest)
  | 0x1f647 :: 0x200d :: 0x2642 :: 0xfe0f :: rest -> Some ("man_bowing", rest)
  | 0x1f647 :: 0x200d :: 0x2640 :: 0xfe0f :: rest -> Some ("woman_bowing", rest)
  | 0x1f647 :: rest -> Some ("person_bowing", rest)
  | 0x1f646 :: 0x1f3ff :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_gesturing_ok_tone5", rest)
  | 0x1f646 :: 0x1f3ff :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_gesturing_ok_tone5", rest)
  | 0x1f646 :: 0x1f3ff :: rest -> Some ("person_gesturing_ok_tone5", rest)
  | 0x1f646 :: 0x1f3fe :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_gesturing_ok_tone4", rest)
  | 0x1f646 :: 0x1f3fe :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_gesturing_ok_tone4", rest)
  | 0x1f646 :: 0x1f3fe :: rest -> Some ("person_gesturing_ok_tone4", rest)
  | 0x1f646 :: 0x1f3fd :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_gesturing_ok_tone3", rest)
  | 0x1f646 :: 0x1f3fd :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_gesturing_ok_tone3", rest)
  | 0x1f646 :: 0x1f3fd :: rest -> Some ("person_gesturing_ok_tone3", rest)
  | 0x1f646 :: 0x1f3fc :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_gesturing_ok_tone2", rest)
  | 0x1f646 :: 0x1f3fc :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_gesturing_ok_tone2", rest)
  | 0x1f646 :: 0x1f3fc :: rest -> Some ("person_gesturing_ok_tone2", rest)
  | 0x1f646 :: 0x1f3fb :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_gesturing_ok_tone1", rest)
  | 0x1f646 :: 0x1f3fb :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_gesturing_ok_tone1", rest)
  | 0x1f646 :: 0x1f3fb :: rest -> Some ("person_gesturing_ok_tone1", rest)
  | 0x1f646 :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_gesturing_ok", rest)
  | 0x1f646 :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_gesturing_ok", rest)
  | 0x1f646 :: rest -> Some ("person_gesturing_ok", rest)
  | 0x1f645 :: 0x1f3ff :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_gesturing_no_tone5", rest)
  | 0x1f645 :: 0x1f3ff :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_gesturing_no_tone5", rest)
  | 0x1f645 :: 0x1f3ff :: rest -> Some ("person_gesturing_no_tone5", rest)
  | 0x1f645 :: 0x1f3fe :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_gesturing_no_tone4", rest)
  | 0x1f645 :: 0x1f3fe :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_gesturing_no_tone4", rest)
  | 0x1f645 :: 0x1f3fe :: rest -> Some ("person_gesturing_no_tone4", rest)
  | 0x1f645 :: 0x1f3fd :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_gesturing_no_tone3", rest)
  | 0x1f645 :: 0x1f3fd :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_gesturing_no_tone3", rest)
  | 0x1f645 :: 0x1f3fd :: rest -> Some ("person_gesturing_no_tone3", rest)
  | 0x1f645 :: 0x1f3fc :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_gesturing_no_tone2", rest)
  | 0x1f645 :: 0x1f3fc :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_gesturing_no_tone2", rest)
  | 0x1f645 :: 0x1f3fc :: rest -> Some ("person_gesturing_no_tone2", rest)
  | 0x1f645 :: 0x1f3fb :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_gesturing_no_tone1", rest)
  | 0x1f645 :: 0x1f3fb :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_gesturing_no_tone1", rest)
  | 0x1f645 :: 0x1f3fb :: rest -> Some ("person_gesturing_no_tone1", rest)
  | 0x1f645 :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_gesturing_no", rest)
  | 0x1f645 :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_gesturing_no", rest)
  | 0x1f645 :: rest -> Some ("person_gesturing_no", rest)
  | 0x1f644 :: rest -> Some ("rolling_eyes", rest)
  | 0x1f643 :: rest -> Some ("upside_down", rest)
  | 0x1f642 :: rest -> Some ("slight_smile", rest)
  | 0x1f641 :: rest -> Some ("slight_frown", rest)
  | 0x1f640 :: rest -> Some ("scream_cat", rest)
  | 0x1f63f :: rest -> Some ("crying_cat_face", rest)
  | 0x1f63e :: rest -> Some ("pouting_cat", rest)
  | 0x1f63d :: rest -> Some ("kissing_cat", rest)
  | 0x1f63c :: rest -> Some ("smirk_cat", rest)
  | 0x1f63b :: rest -> Some ("heart_eyes_cat", rest)
  | 0x1f63a :: rest -> Some ("smiley_cat", rest)
  | 0x1f639 :: rest -> Some ("joy_cat", rest)
  | 0x1f638 :: rest -> Some ("smile_cat", rest)
  | 0x1f637 :: rest -> Some ("mask", rest)
  | 0x1f636 :: 0x200d :: 0x1f32b :: 0xfe0f :: rest ->
      Some ("face_in_clouds", rest)
  | 0x1f636 :: rest -> Some ("no_mouth", rest)
  | 0x1f635 :: 0x200d :: 0x1f4ab :: rest -> Some ("face_with_spiral_eyes", rest)
  | 0x1f635 :: rest -> Some ("dizzy_face", rest)
  | 0x1f634 :: rest -> Some ("sleeping", rest)
  | 0x1f633 :: rest -> Some ("flushed", rest)
  | 0x1f632 :: rest -> Some ("astonished", rest)
  | 0x1f631 :: rest -> Some ("scream", rest)
  | 0x1f630 :: rest -> Some ("cold_sweat", rest)
  | 0x1f62f :: rest -> Some ("hushed", rest)
  | 0x1f62e :: 0x200d :: 0x1f4a8 :: rest -> Some ("face_exhaling", rest)
  | 0x1f62e :: rest -> Some ("open_mouth", rest)
  | 0x1f62d :: rest -> Some ("sob", rest)
  | 0x1f62c :: rest -> Some ("grimacing", rest)
  | 0x1f62b :: rest -> Some ("tired_face", rest)
  | 0x1f62a :: rest -> Some ("sleepy", rest)
  | 0x1f629 :: rest -> Some ("weary", rest)
  | 0x1f628 :: rest -> Some ("fearful", rest)
  | 0x1f627 :: rest -> Some ("anguished", rest)
  | 0x1f626 :: rest -> Some ("frowning", rest)
  | 0x1f625 :: rest -> Some ("disappointed_relieved", rest)
  | 0x1f624 :: rest -> Some ("triumph", rest)
  | 0x1f623 :: rest -> Some ("persevere", rest)
  | 0x1f622 :: rest -> Some ("cry", rest)
  | 0x1f621 :: rest -> Some ("rage", rest)
  | 0x1f620 :: rest -> Some ("angry", rest)
  | 0x1f61f :: rest -> Some ("worried", rest)
  | 0x1f61e :: rest -> Some ("disappointed", rest)
  | 0x1f61d :: rest -> Some ("stuck_out_tongue_closed_eyes", rest)
  | 0x1f61c :: rest -> Some ("stuck_out_tongue_winking_eye", rest)
  | 0x1f61b :: rest -> Some ("stuck_out_tongue", rest)
  | 0x1f61a :: rest -> Some ("kissing_closed_eyes", rest)
  | 0x1f619 :: rest -> Some ("kissing_smiling_eyes", rest)
  | 0x1f618 :: rest -> Some ("kissing_heart", rest)
  | 0x1f617 :: rest -> Some ("kissing", rest)
  | 0x1f616 :: rest -> Some ("confounded", rest)
  | 0x1f615 :: rest -> Some ("confused", rest)
  | 0x1f614 :: rest -> Some ("pensive", rest)
  | 0x1f613 :: rest -> Some ("sweat", rest)
  | 0x1f612 :: rest -> Some ("unamused", rest)
  | 0x1f611 :: rest -> Some ("expressionless", rest)
  | 0x1f610 :: rest -> Some ("neutral_face", rest)
  | 0x1f60f :: rest -> Some ("smirk", rest)
  | 0x1f60e :: rest -> Some ("sunglasses", rest)
  | 0x1f60d :: rest -> Some ("heart_eyes", rest)
  | 0x1f60c :: rest -> Some ("relieved", rest)
  | 0x1f60b :: rest -> Some ("yum", rest)
  | 0x1f60a :: rest -> Some ("blush", rest)
  | 0x1f609 :: rest -> Some ("wink", rest)
  | 0x1f608 :: rest -> Some ("smiling_imp", rest)
  | 0x1f607 :: rest -> Some ("innocent", rest)
  | 0x1f606 :: rest -> Some ("laughing", rest)
  | 0x1f605 :: rest -> Some ("sweat_smile", rest)
  | 0x1f604 :: rest -> Some ("smile", rest)
  | 0x1f603 :: rest -> Some ("smiley", rest)
  | 0x1f602 :: rest -> Some ("joy", rest)
  | 0x1f601 :: rest -> Some ("grin", rest)
  | 0x1f600 :: rest -> Some ("grinning", rest)
  | 0x1f5ff :: rest -> Some ("moyai", rest)
  | 0x1f5fe :: rest -> Some ("japan", rest)
  | 0x1f5fd :: rest -> Some ("statue_of_liberty", rest)
  | 0x1f5fc :: rest -> Some ("tokyo_tower", rest)
  | 0x1f5fb :: rest -> Some ("mount_fuji", rest)
  | 0x1f5fa :: rest -> Some ("map", rest)
  | 0x1f5f3 :: rest -> Some ("ballot_box", rest)
  | 0x1f5ef :: rest -> Some ("anger_right", rest)
  | 0x1f5e8 :: rest -> Some ("speech_left", rest)
  | 0x1f5e3 :: rest -> Some ("speaking_head", rest)
  | 0x1f5e1 :: rest -> Some ("dagger", rest)
  | 0x1f5de :: rest -> Some ("newspaper2", rest)
  | 0x1f5dd :: rest -> Some ("key2", rest)
  | 0x1f5dc :: rest -> Some ("compression", rest)
  | 0x1f5d3 :: rest -> Some ("calendar_spiral", rest)
  | 0x1f5d2 :: rest -> Some ("notepad_spiral", rest)
  | 0x1f5d1 :: rest -> Some ("wastebasket", rest)
  | 0x1f5c4 :: rest -> Some ("file_cabinet", rest)
  | 0x1f5c3 :: rest -> Some ("card_box", rest)
  | 0x1f5c2 :: rest -> Some ("dividers", rest)
  | 0x1f5bc :: rest -> Some ("frame_photo", rest)
  | 0x1f5b2 :: rest -> Some ("trackball", rest)
  | 0x1f5b1 :: rest -> Some ("mouse_three_button", rest)
  | 0x1f5a8 :: rest -> Some ("printer", rest)
  | 0x1f5a5 :: rest -> Some ("desktop", rest)
  | 0x1f5a4 :: rest -> Some ("black_heart", rest)
  | 0x1f596 :: 0x1f3ff :: rest -> Some ("vulcan_tone5", rest)
  | 0x1f596 :: 0x1f3fe :: rest -> Some ("vulcan_tone4", rest)
  | 0x1f596 :: 0x1f3fd :: rest -> Some ("vulcan_tone3", rest)
  | 0x1f596 :: 0x1f3fc :: rest -> Some ("vulcan_tone2", rest)
  | 0x1f596 :: 0x1f3fb :: rest -> Some ("vulcan_tone1", rest)
  | 0x1f596 :: rest -> Some ("vulcan", rest)
  | 0x1f595 :: 0x1f3ff :: rest -> Some ("middle_finger_tone5", rest)
  | 0x1f595 :: 0x1f3fe :: rest -> Some ("middle_finger_tone4", rest)
  | 0x1f595 :: 0x1f3fd :: rest -> Some ("middle_finger_tone3", rest)
  | 0x1f595 :: 0x1f3fc :: rest -> Some ("middle_finger_tone2", rest)
  | 0x1f595 :: 0x1f3fb :: rest -> Some ("middle_finger_tone1", rest)
  | 0x1f595 :: rest -> Some ("middle_finger", rest)
  | 0x1f590 :: 0x1f3ff :: rest -> Some ("hand_splayed_tone5", rest)
  | 0x1f590 :: 0x1f3fe :: rest -> Some ("hand_splayed_tone4", rest)
  | 0x1f590 :: 0x1f3fd :: rest -> Some ("hand_splayed_tone3", rest)
  | 0x1f590 :: 0x1f3fc :: rest -> Some ("hand_splayed_tone2", rest)
  | 0x1f590 :: 0x1f3fb :: rest -> Some ("hand_splayed_tone1", rest)
  | 0x1f590 :: rest -> Some ("hand_splayed", rest)
  | 0x1f58d :: rest -> Some ("crayon", rest)
  | 0x1f58c :: rest -> Some ("paintbrush", rest)
  | 0x1f58b :: rest -> Some ("pen_fountain", rest)
  | 0x1f58a :: rest -> Some ("pen_ballpoint", rest)
  | 0x1f587 :: rest -> Some ("paperclips", rest)
  | 0x1f57a :: 0x1f3ff :: rest -> Some ("man_dancing_tone5", rest)
  | 0x1f57a :: 0x1f3fe :: rest -> Some ("man_dancing_tone4", rest)
  | 0x1f57a :: 0x1f3fd :: rest -> Some ("man_dancing_tone3", rest)
  | 0x1f57a :: 0x1f3fc :: rest -> Some ("man_dancing_tone2", rest)
  | 0x1f57a :: 0x1f3fb :: rest -> Some ("man_dancing_tone1", rest)
  | 0x1f57a :: rest -> Some ("man_dancing", rest)
  | 0x1f579 :: rest -> Some ("joystick", rest)
  | 0x1f578 :: rest -> Some ("spider_web", rest)
  | 0x1f577 :: rest -> Some ("spider", rest)
  | 0x1f576 :: rest -> Some ("dark_sunglasses", rest)
  | 0x1f575 :: 0x1f3ff :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_detective_tone5", rest)
  | 0x1f575 :: 0x1f3ff :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_detective_tone5", rest)
  | 0x1f575 :: 0x1f3ff :: rest -> Some ("detective_tone5", rest)
  | 0x1f575 :: 0x1f3fe :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_detective_tone4", rest)
  | 0x1f575 :: 0x1f3fe :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_detective_tone4", rest)
  | 0x1f575 :: 0x1f3fe :: rest -> Some ("detective_tone4", rest)
  | 0x1f575 :: 0x1f3fd :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_detective_tone3", rest)
  | 0x1f575 :: 0x1f3fd :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_detective_tone3", rest)
  | 0x1f575 :: 0x1f3fd :: rest -> Some ("detective_tone3", rest)
  | 0x1f575 :: 0x1f3fc :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_detective_tone2", rest)
  | 0x1f575 :: 0x1f3fc :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_detective_tone2", rest)
  | 0x1f575 :: 0x1f3fc :: rest -> Some ("detective_tone2", rest)
  | 0x1f575 :: 0x1f3fb :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_detective_tone1", rest)
  | 0x1f575 :: 0x1f3fb :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_detective_tone1", rest)
  | 0x1f575 :: 0x1f3fb :: rest -> Some ("detective_tone1", rest)
  | 0x1f575 :: 0xfe0f :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_detective", rest)
  | 0x1f575 :: 0xfe0f :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_detective", rest)
  | 0x1f575 :: rest -> Some ("detective", rest)
  | 0x1f574 :: 0x1f3ff :: rest -> Some ("levitate_tone5", rest)
  | 0x1f574 :: 0x1f3fe :: rest -> Some ("levitate_tone4", rest)
  | 0x1f574 :: 0x1f3fd :: rest -> Some ("levitate_tone3", rest)
  | 0x1f574 :: 0x1f3fc :: rest -> Some ("levitate_tone2", rest)
  | 0x1f574 :: 0x1f3fb :: rest -> Some ("levitate_tone1", rest)
  | 0x1f574 :: rest -> Some ("levitate", rest)
  | 0x1f573 :: rest -> Some ("hole", rest)
  | 0x1f570 :: rest -> Some ("clock", rest)
  | 0x1f56f :: rest -> Some ("candle", rest)
  | 0x1f567 :: rest -> Some ("clock1230", rest)
  | 0x1f566 :: rest -> Some ("clock1130", rest)
  | 0x1f565 :: rest -> Some ("clock1030", rest)
  | 0x1f564 :: rest -> Some ("clock930", rest)
  | 0x1f563 :: rest -> Some ("clock830", rest)
  | 0x1f562 :: rest -> Some ("clock730", rest)
  | 0x1f561 :: rest -> Some ("clock630", rest)
  | 0x1f560 :: rest -> Some ("clock530", rest)
  | 0x1f55f :: rest -> Some ("clock430", rest)
  | 0x1f55e :: rest -> Some ("clock330", rest)
  | 0x1f55d :: rest -> Some ("clock230", rest)
  | 0x1f55c :: rest -> Some ("clock130", rest)
  | 0x1f55b :: rest -> Some ("clock12", rest)
  | 0x1f55a :: rest -> Some ("clock11", rest)
  | 0x1f559 :: rest -> Some ("clock10", rest)
  | 0x1f558 :: rest -> Some ("clock9", rest)
  | 0x1f557 :: rest -> Some ("clock8", rest)
  | 0x1f556 :: rest -> Some ("clock7", rest)
  | 0x1f555 :: rest -> Some ("clock6", rest)
  | 0x1f554 :: rest -> Some ("clock5", rest)
  | 0x1f553 :: rest -> Some ("clock4", rest)
  | 0x1f552 :: rest -> Some ("clock3", rest)
  | 0x1f551 :: rest -> Some ("clock2", rest)
  | 0x1f550 :: rest -> Some ("clock1", rest)
  | 0x1f54e :: rest -> Some ("menorah", rest)
  | 0x1f54d :: rest -> Some ("synagogue", rest)
  | 0x1f54c :: rest -> Some ("mosque", rest)
  | 0x1f54b :: rest -> Some ("kaaba", rest)
  | 0x1f54a :: rest -> Some ("dove", rest)
  | 0x1f549 :: rest -> Some ("om_symbol", rest)
  | 0x1f53d :: rest -> Some ("arrow_down_small", rest)
  | 0x1f53c :: rest -> Some ("arrow_up_small", rest)
  | 0x1f53b :: rest -> Some ("small_red_triangle_down", rest)
  | 0x1f53a :: rest -> Some ("small_red_triangle", rest)
  | 0x1f539 :: rest -> Some ("small_blue_diamond", rest)
  | 0x1f538 :: rest -> Some ("small_orange_diamond", rest)
  | 0x1f537 :: rest -> Some ("large_blue_diamond", rest)
  | 0x1f536 :: rest -> Some ("large_orange_diamond", rest)
  | 0x1f535 :: rest -> Some ("blue_circle", rest)
  | 0x1f534 :: rest -> Some ("red_circle", rest)
  | 0x1f533 :: rest -> Some ("white_square_button", rest)
  | 0x1f532 :: rest -> Some ("black_square_button", rest)
  | 0x1f531 :: rest -> Some ("trident", rest)
  | 0x1f530 :: rest -> Some ("beginner", rest)
  | 0x1f52f :: rest -> Some ("six_pointed_star", rest)
  | 0x1f52e :: rest -> Some ("crystal_ball", rest)
  | 0x1f52d :: rest -> Some ("telescope", rest)
  | 0x1f52c :: rest -> Some ("microscope", rest)
  | 0x1f52b :: rest -> Some ("gun", rest)
  | 0x1f52a :: rest -> Some ("knife", rest)
  | 0x1f529 :: rest -> Some ("nut_and_bolt", rest)
  | 0x1f528 :: rest -> Some ("hammer", rest)
  | 0x1f527 :: rest -> Some ("wrench", rest)
  | 0x1f526 :: rest -> Some ("flashlight", rest)
  | 0x1f525 :: rest -> Some ("fire", rest)
  | 0x1f524 :: rest -> Some ("abc", rest)
  | 0x1f523 :: rest -> Some ("symbols", rest)
  | 0x1f522 :: rest -> Some ("1234", rest)
  | 0x1f521 :: rest -> Some ("abcd", rest)
  | 0x1f520 :: rest -> Some ("capital_abcd", rest)
  | 0x1f51f :: rest -> Some ("keycap_ten", rest)
  | 0x1f51e :: rest -> Some ("underage", rest)
  | 0x1f51d :: rest -> Some ("top", rest)
  | 0x1f51c :: rest -> Some ("soon", rest)
  | 0x1f51b :: rest -> Some ("on", rest)
  | 0x1f51a :: rest -> Some ("end", rest)
  | 0x1f519 :: rest -> Some ("back", rest)
  | 0x1f518 :: rest -> Some ("radio_button", rest)
  | 0x1f517 :: rest -> Some ("link", rest)
  | 0x1f516 :: rest -> Some ("bookmark", rest)
  | 0x1f515 :: rest -> Some ("no_bell", rest)
  | 0x1f514 :: rest -> Some ("bell", rest)
  | 0x1f513 :: rest -> Some ("unlock", rest)
  | 0x1f512 :: rest -> Some ("lock", rest)
  | 0x1f511 :: rest -> Some ("key", rest)
  | 0x1f510 :: rest -> Some ("closed_lock_with_key", rest)
  | 0x1f50f :: rest -> Some ("lock_with_ink_pen", rest)
  | 0x1f50e :: rest -> Some ("mag_right", rest)
  | 0x1f50d :: rest -> Some ("mag", rest)
  | 0x1f50c :: rest -> Some ("electric_plug", rest)
  | 0x1f50b :: rest -> Some ("battery", rest)
  | 0x1f50a :: rest -> Some ("loud_sound", rest)
  | 0x1f509 :: rest -> Some ("sound", rest)
  | 0x1f508 :: rest -> Some ("speaker", rest)
  | 0x1f507 :: rest -> Some ("mute", rest)
  | 0x1f506 :: rest -> Some ("high_brightness", rest)
  | 0x1f505 :: rest -> Some ("low_brightness", rest)
  | 0x1f504 :: rest -> Some ("arrows_counterclockwise", rest)
  | 0x1f503 :: rest -> Some ("arrows_clockwise", rest)
  | 0x1f502 :: rest -> Some ("repeat_one", rest)
  | 0x1f501 :: rest -> Some ("repeat", rest)
  | 0x1f500 :: rest -> Some ("twisted_rightwards_arrows", rest)
  | 0x1f4ff :: rest -> Some ("prayer_beads", rest)
  | 0x1f4fd :: rest -> Some ("projector", rest)
  | 0x1f4fc :: rest -> Some ("vhs", rest)
  | 0x1f4fb :: rest -> Some ("radio", rest)
  | 0x1f4fa :: rest -> Some ("tv", rest)
  | 0x1f4f9 :: rest -> Some ("video_camera", rest)
  | 0x1f4f8 :: rest -> Some ("camera_with_flash", rest)
  | 0x1f4f7 :: rest -> Some ("camera", rest)
  | 0x1f4f6 :: rest -> Some ("signal_strength", rest)
  | 0x1f4f5 :: rest -> Some ("no_mobile_phones", rest)
  | 0x1f4f4 :: rest -> Some ("mobile_phone_off", rest)
  | 0x1f4f3 :: rest -> Some ("vibration_mode", rest)
  | 0x1f4f2 :: rest -> Some ("calling", rest)
  | 0x1f4f1 :: rest -> Some ("mobile_phone", rest)
  | 0x1f4f0 :: rest -> Some ("newspaper", rest)
  | 0x1f4ef :: rest -> Some ("postal_horn", rest)
  | 0x1f4ee :: rest -> Some ("postbox", rest)
  | 0x1f4ed :: rest -> Some ("mailbox_with_no_mail", rest)
  | 0x1f4ec :: rest -> Some ("mailbox_with_mail", rest)
  | 0x1f4eb :: rest -> Some ("mailbox", rest)
  | 0x1f4ea :: rest -> Some ("mailbox_closed", rest)
  | 0x1f4e9 :: rest -> Some ("envelope_with_arrow", rest)
  | 0x1f4e8 :: rest -> Some ("incoming_envelope", rest)
  | 0x1f4e7 :: rest -> Some ("e-mail", rest)
  | 0x1f4e6 :: rest -> Some ("package", rest)
  | 0x1f4e5 :: rest -> Some ("inbox_tray", rest)
  | 0x1f4e4 :: rest -> Some ("outbox_tray", rest)
  | 0x1f4e3 :: rest -> Some ("mega", rest)
  | 0x1f4e2 :: rest -> Some ("loudspeaker", rest)
  | 0x1f4e1 :: rest -> Some ("satellite", rest)
  | 0x1f4e0 :: rest -> Some ("fax", rest)
  | 0x1f4df :: rest -> Some ("pager", rest)
  | 0x1f4de :: rest -> Some ("telephone_receiver", rest)
  | 0x1f4dd :: rest -> Some ("pencil", rest)
  | 0x1f4dc :: rest -> Some ("scroll", rest)
  | 0x1f4db :: rest -> Some ("name_badge", rest)
  | 0x1f4da :: rest -> Some ("books", rest)
  | 0x1f4d9 :: rest -> Some ("orange_book", rest)
  | 0x1f4d8 :: rest -> Some ("blue_book", rest)
  | 0x1f4d7 :: rest -> Some ("green_book", rest)
  | 0x1f4d6 :: rest -> Some ("book", rest)
  | 0x1f4d5 :: rest -> Some ("closed_book", rest)
  | 0x1f4d4 :: rest -> Some ("notebook_with_decorative_cover", rest)
  | 0x1f4d3 :: rest -> Some ("notebook", rest)
  | 0x1f4d2 :: rest -> Some ("ledger", rest)
  | 0x1f4d1 :: rest -> Some ("bookmark_tabs", rest)
  | 0x1f4d0 :: rest -> Some ("triangular_ruler", rest)
  | 0x1f4cf :: rest -> Some ("straight_ruler", rest)
  | 0x1f4ce :: rest -> Some ("paperclip", rest)
  | 0x1f4cd :: rest -> Some ("round_pushpin", rest)
  | 0x1f4cc :: rest -> Some ("pushpin", rest)
  | 0x1f4cb :: rest -> Some ("clipboard", rest)
  | 0x1f4ca :: rest -> Some ("bar_chart", rest)
  | 0x1f4c9 :: rest -> Some ("chart_with_downwards_trend", rest)
  | 0x1f4c8 :: rest -> Some ("chart_with_upwards_trend", rest)
  | 0x1f4c7 :: rest -> Some ("card_index", rest)
  | 0x1f4c6 :: rest -> Some ("calendar", rest)
  | 0x1f4c5 :: rest -> Some ("date", rest)
  | 0x1f4c4 :: rest -> Some ("page_facing_up", rest)
  | 0x1f4c3 :: rest -> Some ("page_with_curl", rest)
  | 0x1f4c2 :: rest -> Some ("open_file_folder", rest)
  | 0x1f4c1 :: rest -> Some ("file_folder", rest)
  | 0x1f4c0 :: rest -> Some ("dvd", rest)
  | 0x1f4bf :: rest -> Some ("cd", rest)
  | 0x1f4be :: rest -> Some ("floppy_disk", rest)
  | 0x1f4bd :: rest -> Some ("minidisc", rest)
  | 0x1f4bc :: rest -> Some ("briefcase", rest)
  | 0x1f4bb :: rest -> Some ("computer", rest)
  | 0x1f4ba :: rest -> Some ("seat", rest)
  | 0x1f4b9 :: rest -> Some ("chart", rest)
  | 0x1f4b8 :: rest -> Some ("money_with_wings", rest)
  | 0x1f4b7 :: rest -> Some ("pound", rest)
  | 0x1f4b6 :: rest -> Some ("euro", rest)
  | 0x1f4b5 :: rest -> Some ("dollar", rest)
  | 0x1f4b4 :: rest -> Some ("yen", rest)
  | 0x1f4b3 :: rest -> Some ("credit_card", rest)
  | 0x1f4b2 :: rest -> Some ("heavy_dollar_sign", rest)
  | 0x1f4b1 :: rest -> Some ("currency_exchange", rest)
  | 0x1f4b0 :: rest -> Some ("moneybag", rest)
  | 0x1f4af :: rest -> Some ("100", rest)
  | 0x1f4ae :: rest -> Some ("white_flower", rest)
  | 0x1f4ad :: rest -> Some ("thought_balloon", rest)
  | 0x1f4ac :: rest -> Some ("speech_balloon", rest)
  | 0x1f4ab :: rest -> Some ("dizzy", rest)
  | 0x1f4aa :: 0x1f3ff :: rest -> Some ("muscle_tone5", rest)
  | 0x1f4aa :: 0x1f3fe :: rest -> Some ("muscle_tone4", rest)
  | 0x1f4aa :: 0x1f3fd :: rest -> Some ("muscle_tone3", rest)
  | 0x1f4aa :: 0x1f3fc :: rest -> Some ("muscle_tone2", rest)
  | 0x1f4aa :: 0x1f3fb :: rest -> Some ("muscle_tone1", rest)
  | 0x1f4aa :: rest -> Some ("muscle", rest)
  | 0x1f4a9 :: rest -> Some ("poop", rest)
  | 0x1f4a8 :: rest -> Some ("dash", rest)
  | 0x1f4a7 :: rest -> Some ("droplet", rest)
  | 0x1f4a6 :: rest -> Some ("sweat_drops", rest)
  | 0x1f4a5 :: rest -> Some ("boom", rest)
  | 0x1f4a4 :: rest -> Some ("zzz", rest)
  | 0x1f4a3 :: rest -> Some ("bomb", rest)
  | 0x1f4a2 :: rest -> Some ("anger", rest)
  | 0x1f4a1 :: rest -> Some ("bulb", rest)
  | 0x1f4a0 :: rest -> Some ("diamond_shape_with_a_dot_inside", rest)
  | 0x1f49f :: rest -> Some ("heart_decoration", rest)
  | 0x1f49e :: rest -> Some ("revolving_hearts", rest)
  | 0x1f49d :: rest -> Some ("gift_heart", rest)
  | 0x1f49c :: rest -> Some ("purple_heart", rest)
  | 0x1f49b :: rest -> Some ("yellow_heart", rest)
  | 0x1f49a :: rest -> Some ("green_heart", rest)
  | 0x1f499 :: rest -> Some ("blue_heart", rest)
  | 0x1f498 :: rest -> Some ("cupid", rest)
  | 0x1f497 :: rest -> Some ("heartpulse", rest)
  | 0x1f496 :: rest -> Some ("sparkling_heart", rest)
  | 0x1f495 :: rest -> Some ("two_hearts", rest)
  | 0x1f494 :: rest -> Some ("broken_heart", rest)
  | 0x1f493 :: rest -> Some ("heartbeat", rest)
  | 0x1f492 :: rest -> Some ("wedding", rest)
  | 0x1f491 :: 0x1f3ff :: rest -> Some ("couple_with_heart_tone5", rest)
  | 0x1f491 :: 0x1f3fe :: rest -> Some ("couple_with_heart_tone4", rest)
  | 0x1f491 :: 0x1f3fd :: rest -> Some ("couple_with_heart_tone3", rest)
  | 0x1f491 :: 0x1f3fc :: rest -> Some ("couple_with_heart_tone2", rest)
  | 0x1f491 :: 0x1f3fb :: rest -> Some ("couple_with_heart_tone1", rest)
  | 0x1f491 :: rest -> Some ("couple_with_heart", rest)
  | 0x1f490 :: rest -> Some ("bouquet", rest)
  | 0x1f48f :: 0x1f3ff :: rest -> Some ("kiss_tone5", rest)
  | 0x1f48f :: 0x1f3fe :: rest -> Some ("kiss_tone4", rest)
  | 0x1f48f :: 0x1f3fd :: rest -> Some ("kiss_tone3", rest)
  | 0x1f48f :: 0x1f3fc :: rest -> Some ("kiss_tone2", rest)
  | 0x1f48f :: 0x1f3fb :: rest -> Some ("kiss_tone1", rest)
  | 0x1f48f :: rest -> Some ("couplekiss", rest)
  | 0x1f48e :: rest -> Some ("gem", rest)
  | 0x1f48d :: rest -> Some ("ring", rest)
  | 0x1f48c :: rest -> Some ("love_letter", rest)
  | 0x1f48b :: rest -> Some ("kiss", rest)
  | 0x1f48a :: rest -> Some ("pill", rest)
  | 0x1f489 :: rest -> Some ("syringe", rest)
  | 0x1f488 :: rest -> Some ("barber", rest)
  | 0x1f487 :: 0x1f3ff :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_getting_haircut_tone5", rest)
  | 0x1f487 :: 0x1f3ff :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_getting_haircut_tone5", rest)
  | 0x1f487 :: 0x1f3ff :: rest -> Some ("person_getting_haircut_tone5", rest)
  | 0x1f487 :: 0x1f3fe :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_getting_haircut_tone4", rest)
  | 0x1f487 :: 0x1f3fe :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_getting_haircut_tone4", rest)
  | 0x1f487 :: 0x1f3fe :: rest -> Some ("person_getting_haircut_tone4", rest)
  | 0x1f487 :: 0x1f3fd :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_getting_haircut_tone3", rest)
  | 0x1f487 :: 0x1f3fd :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_getting_haircut_tone3", rest)
  | 0x1f487 :: 0x1f3fd :: rest -> Some ("person_getting_haircut_tone3", rest)
  | 0x1f487 :: 0x1f3fc :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_getting_haircut_tone2", rest)
  | 0x1f487 :: 0x1f3fc :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_getting_haircut_tone2", rest)
  | 0x1f487 :: 0x1f3fc :: rest -> Some ("person_getting_haircut_tone2", rest)
  | 0x1f487 :: 0x1f3fb :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_getting_haircut_tone1", rest)
  | 0x1f487 :: 0x1f3fb :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_getting_haircut_tone1", rest)
  | 0x1f487 :: 0x1f3fb :: rest -> Some ("person_getting_haircut_tone1", rest)
  | 0x1f487 :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_getting_haircut", rest)
  | 0x1f487 :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_getting_haircut", rest)
  | 0x1f487 :: rest -> Some ("person_getting_haircut", rest)
  | 0x1f486 :: 0x1f3ff :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_getting_face_massage_tone5", rest)
  | 0x1f486 :: 0x1f3ff :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_getting_face_massage_tone5", rest)
  | 0x1f486 :: 0x1f3ff :: rest -> Some ("person_getting_massage_tone5", rest)
  | 0x1f486 :: 0x1f3fe :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_getting_face_massage_tone4", rest)
  | 0x1f486 :: 0x1f3fe :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_getting_face_massage_tone4", rest)
  | 0x1f486 :: 0x1f3fe :: rest -> Some ("person_getting_massage_tone4", rest)
  | 0x1f486 :: 0x1f3fd :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_getting_face_massage_tone3", rest)
  | 0x1f486 :: 0x1f3fd :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_getting_face_massage_tone3", rest)
  | 0x1f486 :: 0x1f3fd :: rest -> Some ("person_getting_massage_tone3", rest)
  | 0x1f486 :: 0x1f3fc :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_getting_face_massage_tone2", rest)
  | 0x1f486 :: 0x1f3fc :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_getting_face_massage_tone2", rest)
  | 0x1f486 :: 0x1f3fc :: rest -> Some ("person_getting_massage_tone2", rest)
  | 0x1f486 :: 0x1f3fb :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_getting_face_massage_tone1", rest)
  | 0x1f486 :: 0x1f3fb :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_getting_face_massage_tone1", rest)
  | 0x1f486 :: 0x1f3fb :: rest -> Some ("person_getting_massage_tone1", rest)
  | 0x1f486 :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_getting_face_massage", rest)
  | 0x1f486 :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_getting_face_massage", rest)
  | 0x1f486 :: rest -> Some ("person_getting_massage", rest)
  | 0x1f485 :: 0x1f3ff :: rest -> Some ("nail_care_tone5", rest)
  | 0x1f485 :: 0x1f3fe :: rest -> Some ("nail_care_tone4", rest)
  | 0x1f485 :: 0x1f3fd :: rest -> Some ("nail_care_tone3", rest)
  | 0x1f485 :: 0x1f3fc :: rest -> Some ("nail_care_tone2", rest)
  | 0x1f485 :: 0x1f3fb :: rest -> Some ("nail_care_tone1", rest)
  | 0x1f485 :: rest -> Some ("nail_care", rest)
  | 0x1f484 :: rest -> Some ("lipstick", rest)
  | 0x1f483 :: 0x1f3ff :: rest -> Some ("dancer_tone5", rest)
  | 0x1f483 :: 0x1f3fe :: rest -> Some ("dancer_tone4", rest)
  | 0x1f483 :: 0x1f3fd :: rest -> Some ("dancer_tone3", rest)
  | 0x1f483 :: 0x1f3fc :: rest -> Some ("dancer_tone2", rest)
  | 0x1f483 :: 0x1f3fb :: rest -> Some ("dancer_tone1", rest)
  | 0x1f483 :: rest -> Some ("dancer", rest)
  | 0x1f482 :: 0x1f3ff :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_guard_tone5", rest)
  | 0x1f482 :: 0x1f3ff :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_guard_tone5", rest)
  | 0x1f482 :: 0x1f3ff :: rest -> Some ("guard_tone5", rest)
  | 0x1f482 :: 0x1f3fe :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_guard_tone4", rest)
  | 0x1f482 :: 0x1f3fe :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_guard_tone4", rest)
  | 0x1f482 :: 0x1f3fe :: rest -> Some ("guard_tone4", rest)
  | 0x1f482 :: 0x1f3fd :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_guard_tone3", rest)
  | 0x1f482 :: 0x1f3fd :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_guard_tone3", rest)
  | 0x1f482 :: 0x1f3fd :: rest -> Some ("guard_tone3", rest)
  | 0x1f482 :: 0x1f3fc :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_guard_tone2", rest)
  | 0x1f482 :: 0x1f3fc :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_guard_tone2", rest)
  | 0x1f482 :: 0x1f3fc :: rest -> Some ("guard_tone2", rest)
  | 0x1f482 :: 0x1f3fb :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_guard_tone1", rest)
  | 0x1f482 :: 0x1f3fb :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_guard_tone1", rest)
  | 0x1f482 :: 0x1f3fb :: rest -> Some ("guard_tone1", rest)
  | 0x1f482 :: 0x200d :: 0x2642 :: 0xfe0f :: rest -> Some ("man_guard", rest)
  | 0x1f482 :: 0x200d :: 0x2640 :: 0xfe0f :: rest -> Some ("woman_guard", rest)
  | 0x1f482 :: rest -> Some ("guard", rest)
  | 0x1f481 :: 0x1f3ff :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_tipping_hand_tone5", rest)
  | 0x1f481 :: 0x1f3ff :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_tipping_hand_tone5", rest)
  | 0x1f481 :: 0x1f3ff :: rest -> Some ("person_tipping_hand_tone5", rest)
  | 0x1f481 :: 0x1f3fe :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_tipping_hand_tone4", rest)
  | 0x1f481 :: 0x1f3fe :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_tipping_hand_tone4", rest)
  | 0x1f481 :: 0x1f3fe :: rest -> Some ("person_tipping_hand_tone4", rest)
  | 0x1f481 :: 0x1f3fd :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_tipping_hand_tone3", rest)
  | 0x1f481 :: 0x1f3fd :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_tipping_hand_tone3", rest)
  | 0x1f481 :: 0x1f3fd :: rest -> Some ("person_tipping_hand_tone3", rest)
  | 0x1f481 :: 0x1f3fc :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_tipping_hand_tone2", rest)
  | 0x1f481 :: 0x1f3fc :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_tipping_hand_tone2", rest)
  | 0x1f481 :: 0x1f3fc :: rest -> Some ("person_tipping_hand_tone2", rest)
  | 0x1f481 :: 0x1f3fb :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_tipping_hand_tone1", rest)
  | 0x1f481 :: 0x1f3fb :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_tipping_hand_tone1", rest)
  | 0x1f481 :: 0x1f3fb :: rest -> Some ("person_tipping_hand_tone1", rest)
  | 0x1f481 :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_tipping_hand", rest)
  | 0x1f481 :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_tipping_hand", rest)
  | 0x1f481 :: rest -> Some ("person_tipping_hand", rest)
  | 0x1f480 :: rest -> Some ("skull", rest)
  | 0x1f47f :: rest -> Some ("imp", rest)
  | 0x1f47e :: rest -> Some ("space_invader", rest)
  | 0x1f47d :: rest -> Some ("alien", rest)
  | 0x1f47c :: 0x1f3ff :: rest -> Some ("angel_tone5", rest)
  | 0x1f47c :: 0x1f3fe :: rest -> Some ("angel_tone4", rest)
  | 0x1f47c :: 0x1f3fd :: rest -> Some ("angel_tone3", rest)
  | 0x1f47c :: 0x1f3fc :: rest -> Some ("angel_tone2", rest)
  | 0x1f47c :: 0x1f3fb :: rest -> Some ("angel_tone1", rest)
  | 0x1f47c :: rest -> Some ("angel", rest)
  | 0x1f47b :: rest -> Some ("ghost", rest)
  | 0x1f47a :: rest -> Some ("japanese_goblin", rest)
  | 0x1f479 :: rest -> Some ("japanese_ogre", rest)
  | 0x1f478 :: 0x1f3ff :: rest -> Some ("princess_tone5", rest)
  | 0x1f478 :: 0x1f3fe :: rest -> Some ("princess_tone4", rest)
  | 0x1f478 :: 0x1f3fd :: rest -> Some ("princess_tone3", rest)
  | 0x1f478 :: 0x1f3fc :: rest -> Some ("princess_tone2", rest)
  | 0x1f478 :: 0x1f3fb :: rest -> Some ("princess_tone1", rest)
  | 0x1f478 :: rest -> Some ("princess", rest)
  | 0x1f477 :: 0x1f3ff :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_construction_worker_tone5", rest)
  | 0x1f477 :: 0x1f3ff :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_construction_worker_tone5", rest)
  | 0x1f477 :: 0x1f3ff :: rest -> Some ("construction_worker_tone5", rest)
  | 0x1f477 :: 0x1f3fe :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_construction_worker_tone4", rest)
  | 0x1f477 :: 0x1f3fe :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_construction_worker_tone4", rest)
  | 0x1f477 :: 0x1f3fe :: rest -> Some ("construction_worker_tone4", rest)
  | 0x1f477 :: 0x1f3fd :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_construction_worker_tone3", rest)
  | 0x1f477 :: 0x1f3fd :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_construction_worker_tone3", rest)
  | 0x1f477 :: 0x1f3fd :: rest -> Some ("construction_worker_tone3", rest)
  | 0x1f477 :: 0x1f3fc :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_construction_worker_tone2", rest)
  | 0x1f477 :: 0x1f3fc :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_construction_worker_tone2", rest)
  | 0x1f477 :: 0x1f3fc :: rest -> Some ("construction_worker_tone2", rest)
  | 0x1f477 :: 0x1f3fb :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_construction_worker_tone1", rest)
  | 0x1f477 :: 0x1f3fb :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_construction_worker_tone1", rest)
  | 0x1f477 :: 0x1f3fb :: rest -> Some ("construction_worker_tone1", rest)
  | 0x1f477 :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_construction_worker", rest)
  | 0x1f477 :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_construction_worker", rest)
  | 0x1f477 :: rest -> Some ("construction_worker", rest)
  | 0x1f476 :: 0x1f3ff :: rest -> Some ("baby_tone5", rest)
  | 0x1f476 :: 0x1f3fe :: rest -> Some ("baby_tone4", rest)
  | 0x1f476 :: 0x1f3fd :: rest -> Some ("baby_tone3", rest)
  | 0x1f476 :: 0x1f3fc :: rest -> Some ("baby_tone2", rest)
  | 0x1f476 :: 0x1f3fb :: rest -> Some ("baby_tone1", rest)
  | 0x1f476 :: rest -> Some ("baby", rest)
  | 0x1f475 :: 0x1f3ff :: rest -> Some ("older_woman_tone5", rest)
  | 0x1f475 :: 0x1f3fe :: rest -> Some ("older_woman_tone4", rest)
  | 0x1f475 :: 0x1f3fd :: rest -> Some ("older_woman_tone3", rest)
  | 0x1f475 :: 0x1f3fc :: rest -> Some ("older_woman_tone2", rest)
  | 0x1f475 :: 0x1f3fb :: rest -> Some ("older_woman_tone1", rest)
  | 0x1f475 :: rest -> Some ("older_woman", rest)
  | 0x1f474 :: 0x1f3ff :: rest -> Some ("older_man_tone5", rest)
  | 0x1f474 :: 0x1f3fe :: rest -> Some ("older_man_tone4", rest)
  | 0x1f474 :: 0x1f3fd :: rest -> Some ("older_man_tone3", rest)
  | 0x1f474 :: 0x1f3fc :: rest -> Some ("older_man_tone2", rest)
  | 0x1f474 :: 0x1f3fb :: rest -> Some ("older_man_tone1", rest)
  | 0x1f474 :: rest -> Some ("older_man", rest)
  | 0x1f473 :: 0x1f3ff :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_wearing_turban_tone5", rest)
  | 0x1f473 :: 0x1f3ff :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_wearing_turban_tone5", rest)
  | 0x1f473 :: 0x1f3ff :: rest -> Some ("person_wearing_turban_tone5", rest)
  | 0x1f473 :: 0x1f3fe :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_wearing_turban_tone4", rest)
  | 0x1f473 :: 0x1f3fe :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_wearing_turban_tone4", rest)
  | 0x1f473 :: 0x1f3fe :: rest -> Some ("person_wearing_turban_tone4", rest)
  | 0x1f473 :: 0x1f3fd :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_wearing_turban_tone3", rest)
  | 0x1f473 :: 0x1f3fd :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_wearing_turban_tone3", rest)
  | 0x1f473 :: 0x1f3fd :: rest -> Some ("person_wearing_turban_tone3", rest)
  | 0x1f473 :: 0x1f3fc :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_wearing_turban_tone2", rest)
  | 0x1f473 :: 0x1f3fc :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_wearing_turban_tone2", rest)
  | 0x1f473 :: 0x1f3fc :: rest -> Some ("person_wearing_turban_tone2", rest)
  | 0x1f473 :: 0x1f3fb :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_wearing_turban_tone1", rest)
  | 0x1f473 :: 0x1f3fb :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_wearing_turban_tone1", rest)
  | 0x1f473 :: 0x1f3fb :: rest -> Some ("person_wearing_turban_tone1", rest)
  | 0x1f473 :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_wearing_turban", rest)
  | 0x1f473 :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_wearing_turban", rest)
  | 0x1f473 :: rest -> Some ("person_wearing_turban", rest)
  | 0x1f472 :: 0x1f3ff :: rest -> Some ("man_with_chinese_cap_tone5", rest)
  | 0x1f472 :: 0x1f3fe :: rest -> Some ("man_with_chinese_cap_tone4", rest)
  | 0x1f472 :: 0x1f3fd :: rest -> Some ("man_with_chinese_cap_tone3", rest)
  | 0x1f472 :: 0x1f3fc :: rest -> Some ("man_with_chinese_cap_tone2", rest)
  | 0x1f472 :: 0x1f3fb :: rest -> Some ("man_with_chinese_cap_tone1", rest)
  | 0x1f472 :: rest -> Some ("man_with_chinese_cap", rest)
  | 0x1f471 :: 0x1f3ff :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("blond-haired_man_tone5", rest)
  | 0x1f471 :: 0x1f3ff :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("blond-haired_woman_tone5", rest)
  | 0x1f471 :: 0x1f3ff :: rest -> Some ("blond_haired_person_tone5", rest)
  | 0x1f471 :: 0x1f3fe :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("blond-haired_man_tone4", rest)
  | 0x1f471 :: 0x1f3fe :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("blond-haired_woman_tone4", rest)
  | 0x1f471 :: 0x1f3fe :: rest -> Some ("blond_haired_person_tone4", rest)
  | 0x1f471 :: 0x1f3fd :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("blond-haired_man_tone3", rest)
  | 0x1f471 :: 0x1f3fd :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("blond-haired_woman_tone3", rest)
  | 0x1f471 :: 0x1f3fd :: rest -> Some ("blond_haired_person_tone3", rest)
  | 0x1f471 :: 0x1f3fc :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("blond-haired_man_tone2", rest)
  | 0x1f471 :: 0x1f3fc :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("blond-haired_woman_tone2", rest)
  | 0x1f471 :: 0x1f3fc :: rest -> Some ("blond_haired_person_tone2", rest)
  | 0x1f471 :: 0x1f3fb :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("blond-haired_man_tone1", rest)
  | 0x1f471 :: 0x1f3fb :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("blond-haired_woman_tone1", rest)
  | 0x1f471 :: 0x1f3fb :: rest -> Some ("blond_haired_person_tone1", rest)
  | 0x1f471 :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("blond-haired_man", rest)
  | 0x1f471 :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("blond-haired_woman", rest)
  | 0x1f471 :: rest -> Some ("blond_haired_person", rest)
  | 0x1f470 :: 0x1f3ff :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_with_veil_tone5", rest)
  | 0x1f470 :: 0x1f3ff :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_with_veil_tone5", rest)
  | 0x1f470 :: 0x1f3ff :: rest -> Some ("person_with_veil_tone5", rest)
  | 0x1f470 :: 0x1f3fe :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_with_veil_tone4", rest)
  | 0x1f470 :: 0x1f3fe :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_with_veil_tone4", rest)
  | 0x1f470 :: 0x1f3fe :: rest -> Some ("person_with_veil_tone4", rest)
  | 0x1f470 :: 0x1f3fd :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_with_veil_tone3", rest)
  | 0x1f470 :: 0x1f3fd :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_with_veil_tone3", rest)
  | 0x1f470 :: 0x1f3fd :: rest -> Some ("person_with_veil_tone3", rest)
  | 0x1f470 :: 0x1f3fc :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_with_veil_tone2", rest)
  | 0x1f470 :: 0x1f3fc :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_with_veil_tone2", rest)
  | 0x1f470 :: 0x1f3fc :: rest -> Some ("person_with_veil_tone2", rest)
  | 0x1f470 :: 0x1f3fb :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_with_veil_tone1", rest)
  | 0x1f470 :: 0x1f3fb :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_with_veil_tone1", rest)
  | 0x1f470 :: 0x1f3fb :: rest -> Some ("person_with_veil_tone1", rest)
  | 0x1f470 :: 0x200d :: 0x2642 :: 0xfe0f :: rest -> Some ("man_with_veil", rest)
  | 0x1f470 :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_with_veil", rest)
  | 0x1f470 :: rest -> Some ("person_with_veil", rest)
  | 0x1f46f :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("men_with_bunny_ears_partying", rest)
  | 0x1f46f :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("women_with_bunny_ears_partying", rest)
  | 0x1f46f :: rest -> Some ("people_with_bunny_ears_partying", rest)
  | 0x1f46e :: 0x1f3ff :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_police_officer_tone5", rest)
  | 0x1f46e :: 0x1f3ff :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_police_officer_tone5", rest)
  | 0x1f46e :: 0x1f3ff :: rest -> Some ("police_officer_tone5", rest)
  | 0x1f46e :: 0x1f3fe :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_police_officer_tone4", rest)
  | 0x1f46e :: 0x1f3fe :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_police_officer_tone4", rest)
  | 0x1f46e :: 0x1f3fe :: rest -> Some ("police_officer_tone4", rest)
  | 0x1f46e :: 0x1f3fd :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_police_officer_tone3", rest)
  | 0x1f46e :: 0x1f3fd :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_police_officer_tone3", rest)
  | 0x1f46e :: 0x1f3fd :: rest -> Some ("police_officer_tone3", rest)
  | 0x1f46e :: 0x1f3fc :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_police_officer_tone2", rest)
  | 0x1f46e :: 0x1f3fc :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_police_officer_tone2", rest)
  | 0x1f46e :: 0x1f3fc :: rest -> Some ("police_officer_tone2", rest)
  | 0x1f46e :: 0x1f3fb :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_police_officer_tone1", rest)
  | 0x1f46e :: 0x1f3fb :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_police_officer_tone1", rest)
  | 0x1f46e :: 0x1f3fb :: rest -> Some ("police_officer_tone1", rest)
  | 0x1f46e :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_police_officer", rest)
  | 0x1f46e :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_police_officer", rest)
  | 0x1f46e :: rest -> Some ("police_officer", rest)
  | 0x1f46d :: 0x1f3ff :: rest -> Some ("women_holding_hands_tone5", rest)
  | 0x1f46d :: 0x1f3fe :: rest -> Some ("women_holding_hands_tone4", rest)
  | 0x1f46d :: 0x1f3fd :: rest -> Some ("women_holding_hands_tone3", rest)
  | 0x1f46d :: 0x1f3fc :: rest -> Some ("women_holding_hands_tone2", rest)
  | 0x1f46d :: 0x1f3fb :: rest -> Some ("women_holding_hands_tone1", rest)
  | 0x1f46d :: rest -> Some ("two_women_holding_hands", rest)
  | 0x1f46c :: 0x1f3ff :: rest -> Some ("men_holding_hands_tone5", rest)
  | 0x1f46c :: 0x1f3fe :: rest -> Some ("men_holding_hands_tone4", rest)
  | 0x1f46c :: 0x1f3fd :: rest -> Some ("men_holding_hands_tone3", rest)
  | 0x1f46c :: 0x1f3fc :: rest -> Some ("men_holding_hands_tone2", rest)
  | 0x1f46c :: 0x1f3fb :: rest -> Some ("men_holding_hands_tone1", rest)
  | 0x1f46c :: rest -> Some ("two_men_holding_hands", rest)
  | 0x1f46b :: 0x1f3ff :: rest ->
      Some ("woman_and_man_holding_hands_tone5", rest)
  | 0x1f46b :: 0x1f3fe :: rest ->
      Some ("woman_and_man_holding_hands_tone4", rest)
  | 0x1f46b :: 0x1f3fd :: rest ->
      Some ("woman_and_man_holding_hands_tone3", rest)
  | 0x1f46b :: 0x1f3fc :: rest ->
      Some ("woman_and_man_holding_hands_tone2", rest)
  | 0x1f46b :: 0x1f3fb :: rest ->
      Some ("woman_and_man_holding_hands_tone1", rest)
  | 0x1f46b :: rest -> Some ("couple", rest)
  | 0x1f46a :: rest -> Some ("family", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x1f9bd :: rest ->
      Some ("woman_in_manual_wheelchair_tone5", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x1f9bc :: rest ->
      Some ("woman_in_motorized_wheelchair_tone5", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x1f9b3 :: rest ->
      Some ("woman_white_haired_tone5", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x1f9b2 :: rest ->
      Some ("woman_bald_tone5", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x1f9b1 :: rest ->
      Some ("woman_curly_haired_tone5", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x1f9b0 :: rest ->
      Some ("woman_red_haired_tone5", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x1f9af :: rest ->
      Some ("woman_with_probing_cane_tone5", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f469 :: 0x1f3fe
    :: rest ->
      Some ("women_holding_hands_tone5_tone4", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f469 :: 0x1f3fd
    :: rest ->
      Some ("women_holding_hands_tone5_tone3", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f469 :: 0x1f3fc
    :: rest ->
      Some ("women_holding_hands_tone5_tone2", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f469 :: 0x1f3fb
    :: rest ->
      Some ("women_holding_hands_tone5_tone1", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f468 :: 0x1f3fe
    :: rest ->
      Some ("woman_and_man_holding_hands_tone5_tone4", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f468 :: 0x1f3fd
    :: rest ->
      Some ("woman_and_man_holding_hands_tone5_tone3", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f468 :: 0x1f3fc
    :: rest ->
      Some ("woman_and_man_holding_hands_tone5_tone2", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f468 :: 0x1f3fb
    :: rest ->
      Some ("woman_and_man_holding_hands_tone5_tone1", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x1f692 :: rest ->
      Some ("woman_firefighter_tone5", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x1f680 :: rest ->
      Some ("woman_astronaut_tone5", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x1f52c :: rest ->
      Some ("woman_scientist_tone5", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x1f527 :: rest ->
      Some ("woman_mechanic_tone5", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x1f4bc :: rest ->
      Some ("woman_office_worker_tone5", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x1f4bb :: rest ->
      Some ("woman_technologist_tone5", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x1f3ed :: rest ->
      Some ("woman_factory_worker_tone5", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x1f3eb :: rest ->
      Some ("woman_teacher_tone5", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x1f3a8 :: rest ->
      Some ("woman_artist_tone5", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x1f3a4 :: rest ->
      Some ("woman_singer_tone5", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x1f393 :: rest ->
      Some ("woman_student_tone5", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x1f37c :: rest ->
      Some ("woman_feeding_baby_tone5", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x1f373 :: rest ->
      Some ("woman_cook_tone5", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x1f33e :: rest ->
      Some ("woman_farmer_tone5", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f469 :: 0x1f3ff :: rest ->
      Some ("kiss_woman_woman_tone5", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f469 :: 0x1f3fe :: rest ->
      Some ("kiss_woman_woman_tone5_tone4", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f469 :: 0x1f3fd :: rest ->
      Some ("kiss_woman_woman_tone5_tone3", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f469 :: 0x1f3fc :: rest ->
      Some ("kiss_woman_woman_tone5_tone2", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f469 :: 0x1f3fb :: rest ->
      Some ("kiss_woman_woman_tone5_tone1", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3ff :: rest ->
      Some ("kiss_woman_man_tone5", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3fe :: rest ->
      Some ("kiss_woman_man_tone5_tone4", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3fd :: rest ->
      Some ("kiss_woman_man_tone5_tone3", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3fc :: rest ->
      Some ("kiss_woman_man_tone5_tone2", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3fb :: rest ->
      Some ("kiss_woman_man_tone5_tone1", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f469
    :: 0x1f3ff :: rest ->
      Some ("couple_with_heart_woman_woman_tone5", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f469
    :: 0x1f3fe :: rest ->
      Some ("couple_with_heart_woman_woman_tone5_tone4", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f469
    :: 0x1f3fd :: rest ->
      Some ("couple_with_heart_woman_woman_tone5_tone3", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f469
    :: 0x1f3fc :: rest ->
      Some ("couple_with_heart_woman_woman_tone5_tone2", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f469
    :: 0x1f3fb :: rest ->
      Some ("couple_with_heart_woman_woman_tone5_tone1", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3ff :: rest ->
      Some ("couple_with_heart_woman_man_tone5", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3fe :: rest ->
      Some ("couple_with_heart_woman_man_tone5_tone4", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3fd :: rest ->
      Some ("couple_with_heart_woman_man_tone5_tone3", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3fc :: rest ->
      Some ("couple_with_heart_woman_man_tone5_tone2", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3fb :: rest ->
      Some ("couple_with_heart_woman_man_tone5_tone1", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x2708 :: 0xfe0f :: rest ->
      Some ("woman_pilot_tone5", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x2696 :: 0xfe0f :: rest ->
      Some ("woman_judge_tone5", rest)
  | 0x1f469 :: 0x1f3ff :: 0x200d :: 0x2695 :: 0xfe0f :: rest ->
      Some ("woman_health_worker_tone5", rest)
  | 0x1f469 :: 0x1f3ff :: rest -> Some ("woman_tone5", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x1f9bd :: rest ->
      Some ("woman_in_manual_wheelchair_tone4", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x1f9bc :: rest ->
      Some ("woman_in_motorized_wheelchair_tone4", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x1f9b3 :: rest ->
      Some ("woman_white_haired_tone4", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x1f9b2 :: rest ->
      Some ("woman_bald_tone4", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x1f9b1 :: rest ->
      Some ("woman_curly_haired_tone4", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x1f9b0 :: rest ->
      Some ("woman_red_haired_tone4", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x1f9af :: rest ->
      Some ("woman_with_probing_cane_tone4", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f469 :: 0x1f3ff
    :: rest ->
      Some ("women_holding_hands_tone4_tone5", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f469 :: 0x1f3fd
    :: rest ->
      Some ("women_holding_hands_tone4_tone3", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f469 :: 0x1f3fc
    :: rest ->
      Some ("women_holding_hands_tone4_tone2", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f469 :: 0x1f3fb
    :: rest ->
      Some ("women_holding_hands_tone4_tone1", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f468 :: 0x1f3ff
    :: rest ->
      Some ("woman_and_man_holding_hands_tone4_tone5", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f468 :: 0x1f3fd
    :: rest ->
      Some ("woman_and_man_holding_hands_tone4_tone3", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f468 :: 0x1f3fc
    :: rest ->
      Some ("woman_and_man_holding_hands_tone4_tone2", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f468 :: 0x1f3fb
    :: rest ->
      Some ("woman_and_man_holding_hands_tone4_tone1", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x1f692 :: rest ->
      Some ("woman_firefighter_tone4", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x1f680 :: rest ->
      Some ("woman_astronaut_tone4", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x1f52c :: rest ->
      Some ("woman_scientist_tone4", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x1f527 :: rest ->
      Some ("woman_mechanic_tone4", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x1f4bc :: rest ->
      Some ("woman_office_worker_tone4", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x1f4bb :: rest ->
      Some ("woman_technologist_tone4", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x1f3ed :: rest ->
      Some ("woman_factory_worker_tone4", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x1f3eb :: rest ->
      Some ("woman_teacher_tone4", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x1f3a8 :: rest ->
      Some ("woman_artist_tone4", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x1f3a4 :: rest ->
      Some ("woman_singer_tone4", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x1f393 :: rest ->
      Some ("woman_student_tone4", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x1f37c :: rest ->
      Some ("woman_feeding_baby_tone4", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x1f373 :: rest ->
      Some ("woman_cook_tone4", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x1f33e :: rest ->
      Some ("woman_farmer_tone4", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f469 :: 0x1f3ff :: rest ->
      Some ("kiss_woman_woman_tone4_tone5", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f469 :: 0x1f3fe :: rest ->
      Some ("kiss_woman_woman_tone4", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f469 :: 0x1f3fd :: rest ->
      Some ("kiss_woman_woman_tone4_tone3", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f469 :: 0x1f3fc :: rest ->
      Some ("kiss_woman_woman_tone4_tone2", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f469 :: 0x1f3fb :: rest ->
      Some ("kiss_woman_woman_tone4_tone1", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3ff :: rest ->
      Some ("kiss_woman_man_tone4_tone5", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3fe :: rest ->
      Some ("kiss_woman_man_tone4", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3fd :: rest ->
      Some ("kiss_woman_man_tone4_tone3", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3fc :: rest ->
      Some ("kiss_woman_man_tone4_tone2", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3fb :: rest ->
      Some ("kiss_woman_man_tone4_tone1", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f469
    :: 0x1f3ff :: rest ->
      Some ("couple_with_heart_woman_woman_tone4_tone5", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f469
    :: 0x1f3fe :: rest ->
      Some ("couple_with_heart_woman_woman_tone4", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f469
    :: 0x1f3fd :: rest ->
      Some ("couple_with_heart_woman_woman_tone4_tone3", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f469
    :: 0x1f3fc :: rest ->
      Some ("couple_with_heart_woman_woman_tone4_tone2", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f469
    :: 0x1f3fb :: rest ->
      Some ("couple_with_heart_woman_woman_tone4_tone1", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3ff :: rest ->
      Some ("couple_with_heart_woman_man_tone4_tone5", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3fe :: rest ->
      Some ("couple_with_heart_woman_man_tone4", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3fd :: rest ->
      Some ("couple_with_heart_woman_man_tone4_tone3", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3fc :: rest ->
      Some ("couple_with_heart_woman_man_tone4_tone2", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3fb :: rest ->
      Some ("couple_with_heart_woman_man_tone4_tone1", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x2708 :: 0xfe0f :: rest ->
      Some ("woman_pilot_tone4", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x2696 :: 0xfe0f :: rest ->
      Some ("woman_judge_tone4", rest)
  | 0x1f469 :: 0x1f3fe :: 0x200d :: 0x2695 :: 0xfe0f :: rest ->
      Some ("woman_health_worker_tone4", rest)
  | 0x1f469 :: 0x1f3fe :: rest -> Some ("woman_tone4", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x1f9bd :: rest ->
      Some ("woman_in_manual_wheelchair_tone3", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x1f9bc :: rest ->
      Some ("woman_in_motorized_wheelchair_tone3", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x1f9b3 :: rest ->
      Some ("woman_white_haired_tone3", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x1f9b2 :: rest ->
      Some ("woman_bald_tone3", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x1f9b1 :: rest ->
      Some ("woman_curly_haired_tone3", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x1f9b0 :: rest ->
      Some ("woman_red_haired_tone3", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x1f9af :: rest ->
      Some ("woman_with_probing_cane_tone3", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f469 :: 0x1f3ff
    :: rest ->
      Some ("women_holding_hands_tone3_tone5", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f469 :: 0x1f3fe
    :: rest ->
      Some ("women_holding_hands_tone3_tone4", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f469 :: 0x1f3fc
    :: rest ->
      Some ("women_holding_hands_tone3_tone2", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f469 :: 0x1f3fb
    :: rest ->
      Some ("women_holding_hands_tone3_tone1", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f468 :: 0x1f3ff
    :: rest ->
      Some ("woman_and_man_holding_hands_tone3_tone5", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f468 :: 0x1f3fe
    :: rest ->
      Some ("woman_and_man_holding_hands_tone3_tone4", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f468 :: 0x1f3fc
    :: rest ->
      Some ("woman_and_man_holding_hands_tone3_tone2", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f468 :: 0x1f3fb
    :: rest ->
      Some ("woman_and_man_holding_hands_tone3_tone1", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x1f692 :: rest ->
      Some ("woman_firefighter_tone3", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x1f680 :: rest ->
      Some ("woman_astronaut_tone3", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x1f52c :: rest ->
      Some ("woman_scientist_tone3", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x1f527 :: rest ->
      Some ("woman_mechanic_tone3", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x1f4bc :: rest ->
      Some ("woman_office_worker_tone3", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x1f4bb :: rest ->
      Some ("woman_technologist_tone3", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x1f3ed :: rest ->
      Some ("woman_factory_worker_tone3", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x1f3eb :: rest ->
      Some ("woman_teacher_tone3", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x1f3a8 :: rest ->
      Some ("woman_artist_tone3", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x1f3a4 :: rest ->
      Some ("woman_singer_tone3", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x1f393 :: rest ->
      Some ("woman_student_tone3", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x1f37c :: rest ->
      Some ("woman_feeding_baby_tone3", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x1f373 :: rest ->
      Some ("woman_cook_tone3", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x1f33e :: rest ->
      Some ("woman_farmer_tone3", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f469 :: 0x1f3ff :: rest ->
      Some ("kiss_woman_woman_tone3_tone5", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f469 :: 0x1f3fe :: rest ->
      Some ("kiss_woman_woman_tone3_tone4", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f469 :: 0x1f3fd :: rest ->
      Some ("kiss_woman_woman_tone3", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f469 :: 0x1f3fc :: rest ->
      Some ("kiss_woman_woman_tone3_tone2", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f469 :: 0x1f3fb :: rest ->
      Some ("kiss_woman_woman_tone3_tone1", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3ff :: rest ->
      Some ("kiss_woman_man_tone3_tone5", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3fe :: rest ->
      Some ("kiss_woman_man_tone3_tone4", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3fd :: rest ->
      Some ("kiss_woman_man_tone3", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3fc :: rest ->
      Some ("kiss_woman_man_tone3_tone2", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3fb :: rest ->
      Some ("kiss_woman_man_tone3_tone1", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f469
    :: 0x1f3ff :: rest ->
      Some ("couple_with_heart_woman_woman_tone3_tone5", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f469
    :: 0x1f3fe :: rest ->
      Some ("couple_with_heart_woman_woman_tone3_tone4", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f469
    :: 0x1f3fd :: rest ->
      Some ("couple_with_heart_woman_woman_tone3", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f469
    :: 0x1f3fc :: rest ->
      Some ("couple_with_heart_woman_woman_tone3_tone2", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f469
    :: 0x1f3fb :: rest ->
      Some ("couple_with_heart_woman_woman_tone3_tone1", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3ff :: rest ->
      Some ("couple_with_heart_woman_man_tone3_tone5", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3fe :: rest ->
      Some ("couple_with_heart_woman_man_tone3_tone4", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3fd :: rest ->
      Some ("couple_with_heart_woman_man_tone3", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3fc :: rest ->
      Some ("couple_with_heart_woman_man_tone3_tone2", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3fb :: rest ->
      Some ("couple_with_heart_woman_man_tone3_tone1", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x2708 :: 0xfe0f :: rest ->
      Some ("woman_pilot_tone3", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x2696 :: 0xfe0f :: rest ->
      Some ("woman_judge_tone3", rest)
  | 0x1f469 :: 0x1f3fd :: 0x200d :: 0x2695 :: 0xfe0f :: rest ->
      Some ("woman_health_worker_tone3", rest)
  | 0x1f469 :: 0x1f3fd :: rest -> Some ("woman_tone3", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x1f9bd :: rest ->
      Some ("woman_in_manual_wheelchair_tone2", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x1f9bc :: rest ->
      Some ("woman_in_motorized_wheelchair_tone2", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x1f9b3 :: rest ->
      Some ("woman_white_haired_tone2", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x1f9b2 :: rest ->
      Some ("woman_bald_tone2", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x1f9b1 :: rest ->
      Some ("woman_curly_haired_tone2", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x1f9b0 :: rest ->
      Some ("woman_red_haired_tone2", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x1f9af :: rest ->
      Some ("woman_with_probing_cane_tone2", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f469 :: 0x1f3ff
    :: rest ->
      Some ("women_holding_hands_tone2_tone5", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f469 :: 0x1f3fe
    :: rest ->
      Some ("women_holding_hands_tone2_tone4", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f469 :: 0x1f3fd
    :: rest ->
      Some ("women_holding_hands_tone2_tone3", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f469 :: 0x1f3fb
    :: rest ->
      Some ("women_holding_hands_tone2_tone1", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f468 :: 0x1f3ff
    :: rest ->
      Some ("woman_and_man_holding_hands_tone2_tone5", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f468 :: 0x1f3fe
    :: rest ->
      Some ("woman_and_man_holding_hands_tone2_tone4", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f468 :: 0x1f3fd
    :: rest ->
      Some ("woman_and_man_holding_hands_tone2_tone3", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f468 :: 0x1f3fb
    :: rest ->
      Some ("woman_and_man_holding_hands_tone2_tone1", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x1f692 :: rest ->
      Some ("woman_firefighter_tone2", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x1f680 :: rest ->
      Some ("woman_astronaut_tone2", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x1f52c :: rest ->
      Some ("woman_scientist_tone2", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x1f527 :: rest ->
      Some ("woman_mechanic_tone2", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x1f4bc :: rest ->
      Some ("woman_office_worker_tone2", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x1f4bb :: rest ->
      Some ("woman_technologist_tone2", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x1f3ed :: rest ->
      Some ("woman_factory_worker_tone2", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x1f3eb :: rest ->
      Some ("woman_teacher_tone2", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x1f3a8 :: rest ->
      Some ("woman_artist_tone2", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x1f3a4 :: rest ->
      Some ("woman_singer_tone2", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x1f393 :: rest ->
      Some ("woman_student_tone2", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x1f37c :: rest ->
      Some ("woman_feeding_baby_tone2", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x1f373 :: rest ->
      Some ("woman_cook_tone2", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x1f33e :: rest ->
      Some ("woman_farmer_tone2", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f469 :: 0x1f3ff :: rest ->
      Some ("kiss_woman_woman_tone2_tone5", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f469 :: 0x1f3fe :: rest ->
      Some ("kiss_woman_woman_tone2_tone4", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f469 :: 0x1f3fd :: rest ->
      Some ("kiss_woman_woman_tone2_tone3", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f469 :: 0x1f3fc :: rest ->
      Some ("kiss_woman_woman_tone2", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f469 :: 0x1f3fb :: rest ->
      Some ("kiss_woman_woman_tone2_tone1", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3ff :: rest ->
      Some ("kiss_woman_man_tone2_tone5", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3fe :: rest ->
      Some ("kiss_woman_man_tone2_tone4", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3fd :: rest ->
      Some ("kiss_woman_man_tone2_tone3", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3fc :: rest ->
      Some ("kiss_woman_man_tone2", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3fb :: rest ->
      Some ("kiss_woman_man_tone2_tone1", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f469
    :: 0x1f3ff :: rest ->
      Some ("couple_with_heart_woman_woman_tone2_tone5", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f469
    :: 0x1f3fe :: rest ->
      Some ("couple_with_heart_woman_woman_tone2_tone4", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f469
    :: 0x1f3fd :: rest ->
      Some ("couple_with_heart_woman_woman_tone2_tone3", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f469
    :: 0x1f3fc :: rest ->
      Some ("couple_with_heart_woman_woman_tone2", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f469
    :: 0x1f3fb :: rest ->
      Some ("couple_with_heart_woman_woman_tone2_tone1", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3ff :: rest ->
      Some ("couple_with_heart_woman_man_tone2_tone5", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3fe :: rest ->
      Some ("couple_with_heart_woman_man_tone2_tone4", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3fd :: rest ->
      Some ("couple_with_heart_woman_man_tone2_tone3", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3fc :: rest ->
      Some ("couple_with_heart_woman_man_tone2", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3fb :: rest ->
      Some ("couple_with_heart_woman_man_tone2_tone1", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x2708 :: 0xfe0f :: rest ->
      Some ("woman_pilot_tone2", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x2696 :: 0xfe0f :: rest ->
      Some ("woman_judge_tone2", rest)
  | 0x1f469 :: 0x1f3fc :: 0x200d :: 0x2695 :: 0xfe0f :: rest ->
      Some ("woman_health_worker_tone2", rest)
  | 0x1f469 :: 0x1f3fc :: rest -> Some ("woman_tone2", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x1f9bd :: rest ->
      Some ("woman_in_manual_wheelchair_tone1", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x1f9bc :: rest ->
      Some ("woman_in_motorized_wheelchair_tone1", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x1f9b3 :: rest ->
      Some ("woman_white_haired_tone1", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x1f9b2 :: rest ->
      Some ("woman_bald_tone1", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x1f9b1 :: rest ->
      Some ("woman_curly_haired_tone1", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x1f9b0 :: rest ->
      Some ("woman_red_haired_tone1", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x1f9af :: rest ->
      Some ("woman_with_probing_cane_tone1", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f469 :: 0x1f3ff
    :: rest ->
      Some ("women_holding_hands_tone1_tone5", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f469 :: 0x1f3fe
    :: rest ->
      Some ("women_holding_hands_tone1_tone4", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f469 :: 0x1f3fd
    :: rest ->
      Some ("women_holding_hands_tone1_tone3", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f469 :: 0x1f3fc
    :: rest ->
      Some ("women_holding_hands_tone1_tone2", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f468 :: 0x1f3ff
    :: rest ->
      Some ("woman_and_man_holding_hands_tone1_tone5", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f468 :: 0x1f3fe
    :: rest ->
      Some ("woman_and_man_holding_hands_tone1_tone4", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f468 :: 0x1f3fd
    :: rest ->
      Some ("woman_and_man_holding_hands_tone1_tone3", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f468 :: 0x1f3fc
    :: rest ->
      Some ("woman_and_man_holding_hands_tone1_tone2", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x1f692 :: rest ->
      Some ("woman_firefighter_tone1", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x1f680 :: rest ->
      Some ("woman_astronaut_tone1", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x1f52c :: rest ->
      Some ("woman_scientist_tone1", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x1f527 :: rest ->
      Some ("woman_mechanic_tone1", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x1f4bc :: rest ->
      Some ("woman_office_worker_tone1", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x1f4bb :: rest ->
      Some ("woman_technologist_tone1", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x1f3ed :: rest ->
      Some ("woman_factory_worker_tone1", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x1f3eb :: rest ->
      Some ("woman_teacher_tone1", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x1f3a8 :: rest ->
      Some ("woman_artist_tone1", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x1f3a4 :: rest ->
      Some ("woman_singer_tone1", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x1f393 :: rest ->
      Some ("woman_student_tone1", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x1f37c :: rest ->
      Some ("woman_feeding_baby_tone1", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x1f373 :: rest ->
      Some ("woman_cook_tone1", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x1f33e :: rest ->
      Some ("woman_farmer_tone1", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f469 :: 0x1f3ff :: rest ->
      Some ("kiss_woman_woman_tone1_tone5", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f469 :: 0x1f3fe :: rest ->
      Some ("kiss_woman_woman_tone1_tone4", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f469 :: 0x1f3fd :: rest ->
      Some ("kiss_woman_woman_tone1_tone3", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f469 :: 0x1f3fc :: rest ->
      Some ("kiss_woman_woman_tone1_tone2", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f469 :: 0x1f3fb :: rest ->
      Some ("kiss_woman_woman_tone1", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3ff :: rest ->
      Some ("kiss_woman_man_tone1_tone5", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3fe :: rest ->
      Some ("kiss_woman_man_tone1_tone4", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3fd :: rest ->
      Some ("kiss_woman_man_tone1_tone3", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3fc :: rest ->
      Some ("kiss_woman_man_tone1_tone2", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3fb :: rest ->
      Some ("kiss_woman_man_tone1", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f469
    :: 0x1f3ff :: rest ->
      Some ("couple_with_heart_woman_woman_tone1_tone5", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f469
    :: 0x1f3fe :: rest ->
      Some ("couple_with_heart_woman_woman_tone1_tone4", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f469
    :: 0x1f3fd :: rest ->
      Some ("couple_with_heart_woman_woman_tone1_tone3", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f469
    :: 0x1f3fc :: rest ->
      Some ("couple_with_heart_woman_woman_tone1_tone2", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f469
    :: 0x1f3fb :: rest ->
      Some ("couple_with_heart_woman_woman_tone1", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3ff :: rest ->
      Some ("couple_with_heart_woman_man_tone1_tone5", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3fe :: rest ->
      Some ("couple_with_heart_woman_man_tone1_tone4", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3fd :: rest ->
      Some ("couple_with_heart_woman_man_tone1_tone3", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3fc :: rest ->
      Some ("couple_with_heart_woman_man_tone1_tone2", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3fb :: rest ->
      Some ("couple_with_heart_woman_man_tone1", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x2708 :: 0xfe0f :: rest ->
      Some ("woman_pilot_tone1", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x2696 :: 0xfe0f :: rest ->
      Some ("woman_judge_tone1", rest)
  | 0x1f469 :: 0x1f3fb :: 0x200d :: 0x2695 :: 0xfe0f :: rest ->
      Some ("woman_health_worker_tone1", rest)
  | 0x1f469 :: 0x1f3fb :: rest -> Some ("woman_tone1", rest)
  | 0x1f469 :: 0x200d :: 0x1f9bd :: rest ->
      Some ("woman_in_manual_wheelchair", rest)
  | 0x1f469 :: 0x200d :: 0x1f9bc :: rest ->
      Some ("woman_in_motorized_wheelchair", rest)
  | 0x1f469 :: 0x200d :: 0x1f9b3 :: rest -> Some ("woman_white_haired", rest)
  | 0x1f469 :: 0x200d :: 0x1f9b2 :: rest -> Some ("woman_bald", rest)
  | 0x1f469 :: 0x200d :: 0x1f9b1 :: rest -> Some ("woman_curly_haired", rest)
  | 0x1f469 :: 0x200d :: 0x1f9b0 :: rest -> Some ("woman_red_haired", rest)
  | 0x1f469 :: 0x200d :: 0x1f9af :: rest ->
      Some ("woman_with_probing_cane", rest)
  | 0x1f469 :: 0x200d :: 0x1f692 :: rest -> Some ("woman_firefighter", rest)
  | 0x1f469 :: 0x200d :: 0x1f680 :: rest -> Some ("woman_astronaut", rest)
  | 0x1f469 :: 0x200d :: 0x1f52c :: rest -> Some ("woman_scientist", rest)
  | 0x1f469 :: 0x200d :: 0x1f527 :: rest -> Some ("woman_mechanic", rest)
  | 0x1f469 :: 0x200d :: 0x1f4bc :: rest -> Some ("woman_office_worker", rest)
  | 0x1f469 :: 0x200d :: 0x1f4bb :: rest -> Some ("woman_technologist", rest)
  | 0x1f469 :: 0x200d :: 0x1f469 :: 0x200d :: 0x1f467 :: 0x200d :: 0x1f467
    :: rest ->
      Some ("family_wwgg", rest)
  | 0x1f469 :: 0x200d :: 0x1f469 :: 0x200d :: 0x1f467 :: 0x200d :: 0x1f466
    :: rest ->
      Some ("family_wwgb", rest)
  | 0x1f469 :: 0x200d :: 0x1f469 :: 0x200d :: 0x1f467 :: rest ->
      Some ("family_wwg", rest)
  | 0x1f469 :: 0x200d :: 0x1f469 :: 0x200d :: 0x1f466 :: 0x200d :: 0x1f466
    :: rest ->
      Some ("family_wwbb", rest)
  | 0x1f469 :: 0x200d :: 0x1f469 :: 0x200d :: 0x1f466 :: rest ->
      Some ("family_wwb", rest)
  | 0x1f469 :: 0x200d :: 0x1f467 :: 0x200d :: 0x1f467 :: rest ->
      Some ("family_woman_girl_girl", rest)
  | 0x1f469 :: 0x200d :: 0x1f467 :: 0x200d :: 0x1f466 :: rest ->
      Some ("family_woman_girl_boy", rest)
  | 0x1f469 :: 0x200d :: 0x1f467 :: rest -> Some ("family_woman_girl", rest)
  | 0x1f469 :: 0x200d :: 0x1f466 :: 0x200d :: 0x1f466 :: rest ->
      Some ("family_woman_boy_boy", rest)
  | 0x1f469 :: 0x200d :: 0x1f466 :: rest -> Some ("family_woman_boy", rest)
  | 0x1f469 :: 0x200d :: 0x1f3ed :: rest -> Some ("woman_factory_worker", rest)
  | 0x1f469 :: 0x200d :: 0x1f3eb :: rest -> Some ("woman_teacher", rest)
  | 0x1f469 :: 0x200d :: 0x1f3a8 :: rest -> Some ("woman_artist", rest)
  | 0x1f469 :: 0x200d :: 0x1f3a4 :: rest -> Some ("woman_singer", rest)
  | 0x1f469 :: 0x200d :: 0x1f393 :: rest -> Some ("woman_student", rest)
  | 0x1f469 :: 0x200d :: 0x1f37c :: rest -> Some ("woman_feeding_baby", rest)
  | 0x1f469 :: 0x200d :: 0x1f373 :: rest -> Some ("woman_cook", rest)
  | 0x1f469 :: 0x200d :: 0x1f33e :: rest -> Some ("woman_farmer", rest)
  | 0x1f469 :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b :: 0x200d
    :: 0x1f469 :: rest ->
      Some ("kiss_ww", rest)
  | 0x1f469 :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b :: 0x200d
    :: 0x1f468 :: rest ->
      Some ("kiss_woman_man", rest)
  | 0x1f469 :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f469 :: rest ->
      Some ("couple_ww", rest)
  | 0x1f469 :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468 :: rest ->
      Some ("couple_with_heart_woman_man", rest)
  | 0x1f469 :: 0x200d :: 0x2708 :: 0xfe0f :: rest -> Some ("woman_pilot", rest)
  | 0x1f469 :: 0x200d :: 0x2696 :: 0xfe0f :: rest -> Some ("woman_judge", rest)
  | 0x1f469 :: 0x200d :: 0x2695 :: 0xfe0f :: rest ->
      Some ("woman_health_worker", rest)
  | 0x1f469 :: rest -> Some ("woman", rest)
  | 0x1f468 :: 0x1f3ff :: 0x200d :: 0x1f9bd :: rest ->
      Some ("man_in_manual_wheelchair_tone5", rest)
  | 0x1f468 :: 0x1f3ff :: 0x200d :: 0x1f9bc :: rest ->
      Some ("man_in_motorized_wheelchair_tone5", rest)
  | 0x1f468 :: 0x1f3ff :: 0x200d :: 0x1f9b3 :: rest ->
      Some ("man_white_haired_tone5", rest)
  | 0x1f468 :: 0x1f3ff :: 0x200d :: 0x1f9b2 :: rest ->
      Some ("man_bald_tone5", rest)
  | 0x1f468 :: 0x1f3ff :: 0x200d :: 0x1f9b1 :: rest ->
      Some ("man_curly_haired_tone5", rest)
  | 0x1f468 :: 0x1f3ff :: 0x200d :: 0x1f9b0 :: rest ->
      Some ("man_red_haired_tone5", rest)
  | 0x1f468 :: 0x1f3ff :: 0x200d :: 0x1f9af :: rest ->
      Some ("man_with_probing_cane_tone5", rest)
  | 0x1f468 :: 0x1f3ff :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f468 :: 0x1f3fe
    :: rest ->
      Some ("men_holding_hands_tone5_tone4", rest)
  | 0x1f468 :: 0x1f3ff :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f468 :: 0x1f3fd
    :: rest ->
      Some ("men_holding_hands_tone5_tone3", rest)
  | 0x1f468 :: 0x1f3ff :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f468 :: 0x1f3fc
    :: rest ->
      Some ("men_holding_hands_tone5_tone2", rest)
  | 0x1f468 :: 0x1f3ff :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f468 :: 0x1f3fb
    :: rest ->
      Some ("men_holding_hands_tone5_tone1", rest)
  | 0x1f468 :: 0x1f3ff :: 0x200d :: 0x1f692 :: rest ->
      Some ("man_firefighter_tone5", rest)
  | 0x1f468 :: 0x1f3ff :: 0x200d :: 0x1f680 :: rest ->
      Some ("man_astronaut_tone5", rest)
  | 0x1f468 :: 0x1f3ff :: 0x200d :: 0x1f52c :: rest ->
      Some ("man_scientist_tone5", rest)
  | 0x1f468 :: 0x1f3ff :: 0x200d :: 0x1f527 :: rest ->
      Some ("man_mechanic_tone5", rest)
  | 0x1f468 :: 0x1f3ff :: 0x200d :: 0x1f4bc :: rest ->
      Some ("man_office_worker_tone5", rest)
  | 0x1f468 :: 0x1f3ff :: 0x200d :: 0x1f4bb :: rest ->
      Some ("man_technologist_tone5", rest)
  | 0x1f468 :: 0x1f3ff :: 0x200d :: 0x1f3ed :: rest ->
      Some ("man_factory_worker_tone5", rest)
  | 0x1f468 :: 0x1f3ff :: 0x200d :: 0x1f3eb :: rest ->
      Some ("man_teacher_tone5", rest)
  | 0x1f468 :: 0x1f3ff :: 0x200d :: 0x1f3a8 :: rest ->
      Some ("man_artist_tone5", rest)
  | 0x1f468 :: 0x1f3ff :: 0x200d :: 0x1f3a4 :: rest ->
      Some ("man_singer_tone5", rest)
  | 0x1f468 :: 0x1f3ff :: 0x200d :: 0x1f393 :: rest ->
      Some ("man_student_tone5", rest)
  | 0x1f468 :: 0x1f3ff :: 0x200d :: 0x1f37c :: rest ->
      Some ("man_feeding_baby_tone5", rest)
  | 0x1f468 :: 0x1f3ff :: 0x200d :: 0x1f373 :: rest ->
      Some ("man_cook_tone5", rest)
  | 0x1f468 :: 0x1f3ff :: 0x200d :: 0x1f33e :: rest ->
      Some ("man_farmer_tone5", rest)
  | 0x1f468 :: 0x1f3ff :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3ff :: rest ->
      Some ("kiss_man_man_tone5", rest)
  | 0x1f468 :: 0x1f3ff :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3fe :: rest ->
      Some ("kiss_man_man_tone5_tone4", rest)
  | 0x1f468 :: 0x1f3ff :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3fd :: rest ->
      Some ("kiss_man_man_tone5_tone3", rest)
  | 0x1f468 :: 0x1f3ff :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3fc :: rest ->
      Some ("kiss_man_man_tone5_tone2", rest)
  | 0x1f468 :: 0x1f3ff :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3fb :: rest ->
      Some ("kiss_man_man_tone5_tone1", rest)
  | 0x1f468 :: 0x1f3ff :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3ff :: rest ->
      Some ("couple_with_heart_man_man_tone5", rest)
  | 0x1f468 :: 0x1f3ff :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3fe :: rest ->
      Some ("couple_with_heart_man_man_tone5_tone4", rest)
  | 0x1f468 :: 0x1f3ff :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3fd :: rest ->
      Some ("couple_with_heart_man_man_tone5_tone3", rest)
  | 0x1f468 :: 0x1f3ff :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3fc :: rest ->
      Some ("couple_with_heart_man_man_tone5_tone2", rest)
  | 0x1f468 :: 0x1f3ff :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3fb :: rest ->
      Some ("couple_with_heart_man_man_tone5_tone1", rest)
  | 0x1f468 :: 0x1f3ff :: 0x200d :: 0x2708 :: 0xfe0f :: rest ->
      Some ("man_pilot_tone5", rest)
  | 0x1f468 :: 0x1f3ff :: 0x200d :: 0x2696 :: 0xfe0f :: rest ->
      Some ("man_judge_tone5", rest)
  | 0x1f468 :: 0x1f3ff :: 0x200d :: 0x2695 :: 0xfe0f :: rest ->
      Some ("man_health_worker_tone5", rest)
  | 0x1f468 :: 0x1f3ff :: rest -> Some ("man_tone5", rest)
  | 0x1f468 :: 0x1f3fe :: 0x200d :: 0x1f9bd :: rest ->
      Some ("man_in_manual_wheelchair_tone4", rest)
  | 0x1f468 :: 0x1f3fe :: 0x200d :: 0x1f9bc :: rest ->
      Some ("man_in_motorized_wheelchair_tone4", rest)
  | 0x1f468 :: 0x1f3fe :: 0x200d :: 0x1f9b3 :: rest ->
      Some ("man_white_haired_tone4", rest)
  | 0x1f468 :: 0x1f3fe :: 0x200d :: 0x1f9b2 :: rest ->
      Some ("man_bald_tone4", rest)
  | 0x1f468 :: 0x1f3fe :: 0x200d :: 0x1f9b1 :: rest ->
      Some ("man_curly_haired_tone4", rest)
  | 0x1f468 :: 0x1f3fe :: 0x200d :: 0x1f9b0 :: rest ->
      Some ("man_red_haired_tone4", rest)
  | 0x1f468 :: 0x1f3fe :: 0x200d :: 0x1f9af :: rest ->
      Some ("man_with_probing_cane_tone4", rest)
  | 0x1f468 :: 0x1f3fe :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f468 :: 0x1f3ff
    :: rest ->
      Some ("men_holding_hands_tone4_tone5", rest)
  | 0x1f468 :: 0x1f3fe :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f468 :: 0x1f3fd
    :: rest ->
      Some ("men_holding_hands_tone4_tone3", rest)
  | 0x1f468 :: 0x1f3fe :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f468 :: 0x1f3fc
    :: rest ->
      Some ("men_holding_hands_tone4_tone2", rest)
  | 0x1f468 :: 0x1f3fe :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f468 :: 0x1f3fb
    :: rest ->
      Some ("men_holding_hands_tone4_tone1", rest)
  | 0x1f468 :: 0x1f3fe :: 0x200d :: 0x1f692 :: rest ->
      Some ("man_firefighter_tone4", rest)
  | 0x1f468 :: 0x1f3fe :: 0x200d :: 0x1f680 :: rest ->
      Some ("man_astronaut_tone4", rest)
  | 0x1f468 :: 0x1f3fe :: 0x200d :: 0x1f52c :: rest ->
      Some ("man_scientist_tone4", rest)
  | 0x1f468 :: 0x1f3fe :: 0x200d :: 0x1f527 :: rest ->
      Some ("man_mechanic_tone4", rest)
  | 0x1f468 :: 0x1f3fe :: 0x200d :: 0x1f4bc :: rest ->
      Some ("man_office_worker_tone4", rest)
  | 0x1f468 :: 0x1f3fe :: 0x200d :: 0x1f4bb :: rest ->
      Some ("man_technologist_tone4", rest)
  | 0x1f468 :: 0x1f3fe :: 0x200d :: 0x1f3ed :: rest ->
      Some ("man_factory_worker_tone4", rest)
  | 0x1f468 :: 0x1f3fe :: 0x200d :: 0x1f3eb :: rest ->
      Some ("man_teacher_tone4", rest)
  | 0x1f468 :: 0x1f3fe :: 0x200d :: 0x1f3a8 :: rest ->
      Some ("man_artist_tone4", rest)
  | 0x1f468 :: 0x1f3fe :: 0x200d :: 0x1f3a4 :: rest ->
      Some ("man_singer_tone4", rest)
  | 0x1f468 :: 0x1f3fe :: 0x200d :: 0x1f393 :: rest ->
      Some ("man_student_tone4", rest)
  | 0x1f468 :: 0x1f3fe :: 0x200d :: 0x1f37c :: rest ->
      Some ("man_feeding_baby_tone4", rest)
  | 0x1f468 :: 0x1f3fe :: 0x200d :: 0x1f373 :: rest ->
      Some ("man_cook_tone4", rest)
  | 0x1f468 :: 0x1f3fe :: 0x200d :: 0x1f33e :: rest ->
      Some ("man_farmer_tone4", rest)
  | 0x1f468 :: 0x1f3fe :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3ff :: rest ->
      Some ("kiss_man_man_tone4_tone5", rest)
  | 0x1f468 :: 0x1f3fe :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3fe :: rest ->
      Some ("kiss_man_man_tone4", rest)
  | 0x1f468 :: 0x1f3fe :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3fd :: rest ->
      Some ("kiss_man_man_tone4_tone3", rest)
  | 0x1f468 :: 0x1f3fe :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3fc :: rest ->
      Some ("kiss_man_man_tone4_tone2", rest)
  | 0x1f468 :: 0x1f3fe :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3fb :: rest ->
      Some ("kiss_man_man_tone4_tone1", rest)
  | 0x1f468 :: 0x1f3fe :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3ff :: rest ->
      Some ("couple_with_heart_man_man_tone4_tone5", rest)
  | 0x1f468 :: 0x1f3fe :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3fe :: rest ->
      Some ("couple_with_heart_man_man_tone4", rest)
  | 0x1f468 :: 0x1f3fe :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3fd :: rest ->
      Some ("couple_with_heart_man_man_tone4_tone3", rest)
  | 0x1f468 :: 0x1f3fe :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3fc :: rest ->
      Some ("couple_with_heart_man_man_tone4_tone2", rest)
  | 0x1f468 :: 0x1f3fe :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3fb :: rest ->
      Some ("couple_with_heart_man_man_tone4_tone1", rest)
  | 0x1f468 :: 0x1f3fe :: 0x200d :: 0x2708 :: 0xfe0f :: rest ->
      Some ("man_pilot_tone4", rest)
  | 0x1f468 :: 0x1f3fe :: 0x200d :: 0x2696 :: 0xfe0f :: rest ->
      Some ("man_judge_tone4", rest)
  | 0x1f468 :: 0x1f3fe :: 0x200d :: 0x2695 :: 0xfe0f :: rest ->
      Some ("man_health_worker_tone4", rest)
  | 0x1f468 :: 0x1f3fe :: rest -> Some ("man_tone4", rest)
  | 0x1f468 :: 0x1f3fd :: 0x200d :: 0x1f9bd :: rest ->
      Some ("man_in_manual_wheelchair_tone3", rest)
  | 0x1f468 :: 0x1f3fd :: 0x200d :: 0x1f9bc :: rest ->
      Some ("man_in_motorized_wheelchair_tone3", rest)
  | 0x1f468 :: 0x1f3fd :: 0x200d :: 0x1f9b3 :: rest ->
      Some ("man_white_haired_tone3", rest)
  | 0x1f468 :: 0x1f3fd :: 0x200d :: 0x1f9b2 :: rest ->
      Some ("man_bald_tone3", rest)
  | 0x1f468 :: 0x1f3fd :: 0x200d :: 0x1f9b1 :: rest ->
      Some ("man_curly_haired_tone3", rest)
  | 0x1f468 :: 0x1f3fd :: 0x200d :: 0x1f9b0 :: rest ->
      Some ("man_red_haired_tone3", rest)
  | 0x1f468 :: 0x1f3fd :: 0x200d :: 0x1f9af :: rest ->
      Some ("man_with_probing_cane_tone3", rest)
  | 0x1f468 :: 0x1f3fd :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f468 :: 0x1f3ff
    :: rest ->
      Some ("men_holding_hands_tone3_tone5", rest)
  | 0x1f468 :: 0x1f3fd :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f468 :: 0x1f3fe
    :: rest ->
      Some ("men_holding_hands_tone3_tone4", rest)
  | 0x1f468 :: 0x1f3fd :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f468 :: 0x1f3fc
    :: rest ->
      Some ("men_holding_hands_tone3_tone2", rest)
  | 0x1f468 :: 0x1f3fd :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f468 :: 0x1f3fb
    :: rest ->
      Some ("men_holding_hands_tone3_tone1", rest)
  | 0x1f468 :: 0x1f3fd :: 0x200d :: 0x1f692 :: rest ->
      Some ("man_firefighter_tone3", rest)
  | 0x1f468 :: 0x1f3fd :: 0x200d :: 0x1f680 :: rest ->
      Some ("man_astronaut_tone3", rest)
  | 0x1f468 :: 0x1f3fd :: 0x200d :: 0x1f52c :: rest ->
      Some ("man_scientist_tone3", rest)
  | 0x1f468 :: 0x1f3fd :: 0x200d :: 0x1f527 :: rest ->
      Some ("man_mechanic_tone3", rest)
  | 0x1f468 :: 0x1f3fd :: 0x200d :: 0x1f4bc :: rest ->
      Some ("man_office_worker_tone3", rest)
  | 0x1f468 :: 0x1f3fd :: 0x200d :: 0x1f4bb :: rest ->
      Some ("man_technologist_tone3", rest)
  | 0x1f468 :: 0x1f3fd :: 0x200d :: 0x1f3ed :: rest ->
      Some ("man_factory_worker_tone3", rest)
  | 0x1f468 :: 0x1f3fd :: 0x200d :: 0x1f3eb :: rest ->
      Some ("man_teacher_tone3", rest)
  | 0x1f468 :: 0x1f3fd :: 0x200d :: 0x1f3a8 :: rest ->
      Some ("man_artist_tone3", rest)
  | 0x1f468 :: 0x1f3fd :: 0x200d :: 0x1f3a4 :: rest ->
      Some ("man_singer_tone3", rest)
  | 0x1f468 :: 0x1f3fd :: 0x200d :: 0x1f393 :: rest ->
      Some ("man_student_tone3", rest)
  | 0x1f468 :: 0x1f3fd :: 0x200d :: 0x1f37c :: rest ->
      Some ("man_feeding_baby_tone3", rest)
  | 0x1f468 :: 0x1f3fd :: 0x200d :: 0x1f373 :: rest ->
      Some ("man_cook_tone3", rest)
  | 0x1f468 :: 0x1f3fd :: 0x200d :: 0x1f33e :: rest ->
      Some ("man_farmer_tone3", rest)
  | 0x1f468 :: 0x1f3fd :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3ff :: rest ->
      Some ("kiss_man_man_tone3_tone5", rest)
  | 0x1f468 :: 0x1f3fd :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3fe :: rest ->
      Some ("kiss_man_man_tone3_tone4", rest)
  | 0x1f468 :: 0x1f3fd :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3fd :: rest ->
      Some ("kiss_man_man_tone3", rest)
  | 0x1f468 :: 0x1f3fd :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3fc :: rest ->
      Some ("kiss_man_man_tone3_tone2", rest)
  | 0x1f468 :: 0x1f3fd :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3fb :: rest ->
      Some ("kiss_man_man_tone3_tone1", rest)
  | 0x1f468 :: 0x1f3fd :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3ff :: rest ->
      Some ("couple_with_heart_man_man_tone3_tone5", rest)
  | 0x1f468 :: 0x1f3fd :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3fe :: rest ->
      Some ("couple_with_heart_man_man_tone3_tone4", rest)
  | 0x1f468 :: 0x1f3fd :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3fd :: rest ->
      Some ("couple_with_heart_man_man_tone3", rest)
  | 0x1f468 :: 0x1f3fd :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3fc :: rest ->
      Some ("couple_with_heart_man_man_tone3_tone2", rest)
  | 0x1f468 :: 0x1f3fd :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3fb :: rest ->
      Some ("couple_with_heart_man_man_tone3_tone1", rest)
  | 0x1f468 :: 0x1f3fd :: 0x200d :: 0x2708 :: 0xfe0f :: rest ->
      Some ("man_pilot_tone3", rest)
  | 0x1f468 :: 0x1f3fd :: 0x200d :: 0x2696 :: 0xfe0f :: rest ->
      Some ("man_judge_tone3", rest)
  | 0x1f468 :: 0x1f3fd :: 0x200d :: 0x2695 :: 0xfe0f :: rest ->
      Some ("man_health_worker_tone3", rest)
  | 0x1f468 :: 0x1f3fd :: rest -> Some ("man_tone3", rest)
  | 0x1f468 :: 0x1f3fc :: 0x200d :: 0x1f9bd :: rest ->
      Some ("man_in_manual_wheelchair_tone2", rest)
  | 0x1f468 :: 0x1f3fc :: 0x200d :: 0x1f9bc :: rest ->
      Some ("man_in_motorized_wheelchair_tone2", rest)
  | 0x1f468 :: 0x1f3fc :: 0x200d :: 0x1f9b3 :: rest ->
      Some ("man_white_haired_tone2", rest)
  | 0x1f468 :: 0x1f3fc :: 0x200d :: 0x1f9b2 :: rest ->
      Some ("man_bald_tone2", rest)
  | 0x1f468 :: 0x1f3fc :: 0x200d :: 0x1f9b1 :: rest ->
      Some ("man_curly_haired_tone2", rest)
  | 0x1f468 :: 0x1f3fc :: 0x200d :: 0x1f9b0 :: rest ->
      Some ("man_red_haired_tone2", rest)
  | 0x1f468 :: 0x1f3fc :: 0x200d :: 0x1f9af :: rest ->
      Some ("man_with_probing_cane_tone2", rest)
  | 0x1f468 :: 0x1f3fc :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f468 :: 0x1f3ff
    :: rest ->
      Some ("men_holding_hands_tone2_tone5", rest)
  | 0x1f468 :: 0x1f3fc :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f468 :: 0x1f3fe
    :: rest ->
      Some ("men_holding_hands_tone2_tone4", rest)
  | 0x1f468 :: 0x1f3fc :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f468 :: 0x1f3fd
    :: rest ->
      Some ("men_holding_hands_tone2_tone3", rest)
  | 0x1f468 :: 0x1f3fc :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f468 :: 0x1f3fb
    :: rest ->
      Some ("men_holding_hands_tone2_tone1", rest)
  | 0x1f468 :: 0x1f3fc :: 0x200d :: 0x1f692 :: rest ->
      Some ("man_firefighter_tone2", rest)
  | 0x1f468 :: 0x1f3fc :: 0x200d :: 0x1f680 :: rest ->
      Some ("man_astronaut_tone2", rest)
  | 0x1f468 :: 0x1f3fc :: 0x200d :: 0x1f52c :: rest ->
      Some ("man_scientist_tone2", rest)
  | 0x1f468 :: 0x1f3fc :: 0x200d :: 0x1f527 :: rest ->
      Some ("man_mechanic_tone2", rest)
  | 0x1f468 :: 0x1f3fc :: 0x200d :: 0x1f4bc :: rest ->
      Some ("man_office_worker_tone2", rest)
  | 0x1f468 :: 0x1f3fc :: 0x200d :: 0x1f4bb :: rest ->
      Some ("man_technologist_tone2", rest)
  | 0x1f468 :: 0x1f3fc :: 0x200d :: 0x1f3ed :: rest ->
      Some ("man_factory_worker_tone2", rest)
  | 0x1f468 :: 0x1f3fc :: 0x200d :: 0x1f3eb :: rest ->
      Some ("man_teacher_tone2", rest)
  | 0x1f468 :: 0x1f3fc :: 0x200d :: 0x1f3a8 :: rest ->
      Some ("man_artist_tone2", rest)
  | 0x1f468 :: 0x1f3fc :: 0x200d :: 0x1f3a4 :: rest ->
      Some ("man_singer_tone2", rest)
  | 0x1f468 :: 0x1f3fc :: 0x200d :: 0x1f393 :: rest ->
      Some ("man_student_tone2", rest)
  | 0x1f468 :: 0x1f3fc :: 0x200d :: 0x1f37c :: rest ->
      Some ("man_feeding_baby_tone2", rest)
  | 0x1f468 :: 0x1f3fc :: 0x200d :: 0x1f373 :: rest ->
      Some ("man_cook_tone2", rest)
  | 0x1f468 :: 0x1f3fc :: 0x200d :: 0x1f33e :: rest ->
      Some ("man_farmer_tone2", rest)
  | 0x1f468 :: 0x1f3fc :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3ff :: rest ->
      Some ("kiss_man_man_tone2_tone5", rest)
  | 0x1f468 :: 0x1f3fc :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3fe :: rest ->
      Some ("kiss_man_man_tone2_tone4", rest)
  | 0x1f468 :: 0x1f3fc :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3fd :: rest ->
      Some ("kiss_man_man_tone2_tone3", rest)
  | 0x1f468 :: 0x1f3fc :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3fc :: rest ->
      Some ("kiss_man_man_tone2", rest)
  | 0x1f468 :: 0x1f3fc :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3fb :: rest ->
      Some ("kiss_man_man_tone2_tone1", rest)
  | 0x1f468 :: 0x1f3fc :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3ff :: rest ->
      Some ("couple_with_heart_man_man_tone2_tone5", rest)
  | 0x1f468 :: 0x1f3fc :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3fe :: rest ->
      Some ("couple_with_heart_man_man_tone2_tone4", rest)
  | 0x1f468 :: 0x1f3fc :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3fd :: rest ->
      Some ("couple_with_heart_man_man_tone2_tone3", rest)
  | 0x1f468 :: 0x1f3fc :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3fc :: rest ->
      Some ("couple_with_heart_man_man_tone2", rest)
  | 0x1f468 :: 0x1f3fc :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3fb :: rest ->
      Some ("couple_with_heart_man_man_tone2_tone1", rest)
  | 0x1f468 :: 0x1f3fc :: 0x200d :: 0x2708 :: 0xfe0f :: rest ->
      Some ("man_pilot_tone2", rest)
  | 0x1f468 :: 0x1f3fc :: 0x200d :: 0x2696 :: 0xfe0f :: rest ->
      Some ("man_judge_tone2", rest)
  | 0x1f468 :: 0x1f3fc :: 0x200d :: 0x2695 :: 0xfe0f :: rest ->
      Some ("man_health_worker_tone2", rest)
  | 0x1f468 :: 0x1f3fc :: rest -> Some ("man_tone2", rest)
  | 0x1f468 :: 0x1f3fb :: 0x200d :: 0x1f9bd :: rest ->
      Some ("man_in_manual_wheelchair_tone1", rest)
  | 0x1f468 :: 0x1f3fb :: 0x200d :: 0x1f9bc :: rest ->
      Some ("man_in_motorized_wheelchair_tone1", rest)
  | 0x1f468 :: 0x1f3fb :: 0x200d :: 0x1f9b3 :: rest ->
      Some ("man_white_haired_tone1", rest)
  | 0x1f468 :: 0x1f3fb :: 0x200d :: 0x1f9b2 :: rest ->
      Some ("man_bald_tone1", rest)
  | 0x1f468 :: 0x1f3fb :: 0x200d :: 0x1f9b1 :: rest ->
      Some ("man_curly_haired_tone1", rest)
  | 0x1f468 :: 0x1f3fb :: 0x200d :: 0x1f9b0 :: rest ->
      Some ("man_red_haired_tone1", rest)
  | 0x1f468 :: 0x1f3fb :: 0x200d :: 0x1f9af :: rest ->
      Some ("man_with_probing_cane_tone1", rest)
  | 0x1f468 :: 0x1f3fb :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f468 :: 0x1f3ff
    :: rest ->
      Some ("men_holding_hands_tone1_tone5", rest)
  | 0x1f468 :: 0x1f3fb :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f468 :: 0x1f3fe
    :: rest ->
      Some ("men_holding_hands_tone1_tone4", rest)
  | 0x1f468 :: 0x1f3fb :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f468 :: 0x1f3fd
    :: rest ->
      Some ("men_holding_hands_tone1_tone3", rest)
  | 0x1f468 :: 0x1f3fb :: 0x200d :: 0x1f91d :: 0x200d :: 0x1f468 :: 0x1f3fc
    :: rest ->
      Some ("men_holding_hands_tone1_tone2", rest)
  | 0x1f468 :: 0x1f3fb :: 0x200d :: 0x1f692 :: rest ->
      Some ("man_firefighter_tone1", rest)
  | 0x1f468 :: 0x1f3fb :: 0x200d :: 0x1f680 :: rest ->
      Some ("man_astronaut_tone1", rest)
  | 0x1f468 :: 0x1f3fb :: 0x200d :: 0x1f52c :: rest ->
      Some ("man_scientist_tone1", rest)
  | 0x1f468 :: 0x1f3fb :: 0x200d :: 0x1f527 :: rest ->
      Some ("man_mechanic_tone1", rest)
  | 0x1f468 :: 0x1f3fb :: 0x200d :: 0x1f4bc :: rest ->
      Some ("man_office_worker_tone1", rest)
  | 0x1f468 :: 0x1f3fb :: 0x200d :: 0x1f4bb :: rest ->
      Some ("man_technologist_tone1", rest)
  | 0x1f468 :: 0x1f3fb :: 0x200d :: 0x1f3ed :: rest ->
      Some ("man_factory_worker_tone1", rest)
  | 0x1f468 :: 0x1f3fb :: 0x200d :: 0x1f3eb :: rest ->
      Some ("man_teacher_tone1", rest)
  | 0x1f468 :: 0x1f3fb :: 0x200d :: 0x1f3a8 :: rest ->
      Some ("man_artist_tone1", rest)
  | 0x1f468 :: 0x1f3fb :: 0x200d :: 0x1f3a4 :: rest ->
      Some ("man_singer_tone1", rest)
  | 0x1f468 :: 0x1f3fb :: 0x200d :: 0x1f393 :: rest ->
      Some ("man_student_tone1", rest)
  | 0x1f468 :: 0x1f3fb :: 0x200d :: 0x1f37c :: rest ->
      Some ("man_feeding_baby_tone1", rest)
  | 0x1f468 :: 0x1f3fb :: 0x200d :: 0x1f373 :: rest ->
      Some ("man_cook_tone1", rest)
  | 0x1f468 :: 0x1f3fb :: 0x200d :: 0x1f33e :: rest ->
      Some ("man_farmer_tone1", rest)
  | 0x1f468 :: 0x1f3fb :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3ff :: rest ->
      Some ("kiss_man_man_tone1_tone5", rest)
  | 0x1f468 :: 0x1f3fb :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3fe :: rest ->
      Some ("kiss_man_man_tone1_tone4", rest)
  | 0x1f468 :: 0x1f3fb :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3fd :: rest ->
      Some ("kiss_man_man_tone1_tone3", rest)
  | 0x1f468 :: 0x1f3fb :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3fc :: rest ->
      Some ("kiss_man_man_tone1_tone2", rest)
  | 0x1f468 :: 0x1f3fb :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b
    :: 0x200d :: 0x1f468 :: 0x1f3fb :: rest ->
      Some ("kiss_man_man_tone1", rest)
  | 0x1f468 :: 0x1f3fb :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3ff :: rest ->
      Some ("couple_with_heart_man_man_tone1_tone5", rest)
  | 0x1f468 :: 0x1f3fb :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3fe :: rest ->
      Some ("couple_with_heart_man_man_tone1_tone4", rest)
  | 0x1f468 :: 0x1f3fb :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3fd :: rest ->
      Some ("couple_with_heart_man_man_tone1_tone3", rest)
  | 0x1f468 :: 0x1f3fb :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3fc :: rest ->
      Some ("couple_with_heart_man_man_tone1_tone2", rest)
  | 0x1f468 :: 0x1f3fb :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468
    :: 0x1f3fb :: rest ->
      Some ("couple_with_heart_man_man_tone1", rest)
  | 0x1f468 :: 0x1f3fb :: 0x200d :: 0x2708 :: 0xfe0f :: rest ->
      Some ("man_pilot_tone1", rest)
  | 0x1f468 :: 0x1f3fb :: 0x200d :: 0x2696 :: 0xfe0f :: rest ->
      Some ("man_judge_tone1", rest)
  | 0x1f468 :: 0x1f3fb :: 0x200d :: 0x2695 :: 0xfe0f :: rest ->
      Some ("man_health_worker_tone1", rest)
  | 0x1f468 :: 0x1f3fb :: rest -> Some ("man_tone1", rest)
  | 0x1f468 :: 0x200d :: 0x1f9bd :: rest ->
      Some ("man_in_manual_wheelchair", rest)
  | 0x1f468 :: 0x200d :: 0x1f9bc :: rest ->
      Some ("man_in_motorized_wheelchair", rest)
  | 0x1f468 :: 0x200d :: 0x1f9b3 :: rest -> Some ("man_white_haired", rest)
  | 0x1f468 :: 0x200d :: 0x1f9b2 :: rest -> Some ("man_bald", rest)
  | 0x1f468 :: 0x200d :: 0x1f9b1 :: rest -> Some ("man_curly_haired", rest)
  | 0x1f468 :: 0x200d :: 0x1f9b0 :: rest -> Some ("man_red_haired", rest)
  | 0x1f468 :: 0x200d :: 0x1f9af :: rest -> Some ("man_with_probing_cane", rest)
  | 0x1f468 :: 0x200d :: 0x1f692 :: rest -> Some ("man_firefighter", rest)
  | 0x1f468 :: 0x200d :: 0x1f680 :: rest -> Some ("man_astronaut", rest)
  | 0x1f468 :: 0x200d :: 0x1f52c :: rest -> Some ("man_scientist", rest)
  | 0x1f468 :: 0x200d :: 0x1f527 :: rest -> Some ("man_mechanic", rest)
  | 0x1f468 :: 0x200d :: 0x1f4bc :: rest -> Some ("man_office_worker", rest)
  | 0x1f468 :: 0x200d :: 0x1f4bb :: rest -> Some ("man_technologist", rest)
  | 0x1f468 :: 0x200d :: 0x1f469 :: 0x200d :: 0x1f467 :: 0x200d :: 0x1f467
    :: rest ->
      Some ("family_mwgg", rest)
  | 0x1f468 :: 0x200d :: 0x1f469 :: 0x200d :: 0x1f467 :: 0x200d :: 0x1f466
    :: rest ->
      Some ("family_mwgb", rest)
  | 0x1f468 :: 0x200d :: 0x1f469 :: 0x200d :: 0x1f467 :: rest ->
      Some ("family_mwg", rest)
  | 0x1f468 :: 0x200d :: 0x1f469 :: 0x200d :: 0x1f466 :: 0x200d :: 0x1f466
    :: rest ->
      Some ("family_mwbb", rest)
  | 0x1f468 :: 0x200d :: 0x1f469 :: 0x200d :: 0x1f466 :: rest ->
      Some ("family_man_woman_boy", rest)
  | 0x1f468 :: 0x200d :: 0x1f468 :: 0x200d :: 0x1f467 :: 0x200d :: 0x1f467
    :: rest ->
      Some ("family_mmgg", rest)
  | 0x1f468 :: 0x200d :: 0x1f468 :: 0x200d :: 0x1f467 :: 0x200d :: 0x1f466
    :: rest ->
      Some ("family_mmgb", rest)
  | 0x1f468 :: 0x200d :: 0x1f468 :: 0x200d :: 0x1f467 :: rest ->
      Some ("family_mmg", rest)
  | 0x1f468 :: 0x200d :: 0x1f468 :: 0x200d :: 0x1f466 :: 0x200d :: 0x1f466
    :: rest ->
      Some ("family_mmbb", rest)
  | 0x1f468 :: 0x200d :: 0x1f468 :: 0x200d :: 0x1f466 :: rest ->
      Some ("family_mmb", rest)
  | 0x1f468 :: 0x200d :: 0x1f467 :: 0x200d :: 0x1f467 :: rest ->
      Some ("family_man_girl_girl", rest)
  | 0x1f468 :: 0x200d :: 0x1f467 :: 0x200d :: 0x1f466 :: rest ->
      Some ("family_man_girl_boy", rest)
  | 0x1f468 :: 0x200d :: 0x1f467 :: rest -> Some ("family_man_girl", rest)
  | 0x1f468 :: 0x200d :: 0x1f466 :: 0x200d :: 0x1f466 :: rest ->
      Some ("family_man_boy_boy", rest)
  | 0x1f468 :: 0x200d :: 0x1f466 :: rest -> Some ("family_man_boy", rest)
  | 0x1f468 :: 0x200d :: 0x1f3ed :: rest -> Some ("man_factory_worker", rest)
  | 0x1f468 :: 0x200d :: 0x1f3eb :: rest -> Some ("man_teacher", rest)
  | 0x1f468 :: 0x200d :: 0x1f3a8 :: rest -> Some ("man_artist", rest)
  | 0x1f468 :: 0x200d :: 0x1f3a4 :: rest -> Some ("man_singer", rest)
  | 0x1f468 :: 0x200d :: 0x1f393 :: rest -> Some ("man_student", rest)
  | 0x1f468 :: 0x200d :: 0x1f37c :: rest -> Some ("man_feeding_baby", rest)
  | 0x1f468 :: 0x200d :: 0x1f373 :: rest -> Some ("man_cook", rest)
  | 0x1f468 :: 0x200d :: 0x1f33e :: rest -> Some ("man_farmer", rest)
  | 0x1f468 :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f48b :: 0x200d
    :: 0x1f468 :: rest ->
      Some ("kiss_mm", rest)
  | 0x1f468 :: 0x200d :: 0x2764 :: 0xfe0f :: 0x200d :: 0x1f468 :: rest ->
      Some ("couple_mm", rest)
  | 0x1f468 :: 0x200d :: 0x2708 :: 0xfe0f :: rest -> Some ("man_pilot", rest)
  | 0x1f468 :: 0x200d :: 0x2696 :: 0xfe0f :: rest -> Some ("man_judge", rest)
  | 0x1f468 :: 0x200d :: 0x2695 :: 0xfe0f :: rest ->
      Some ("man_health_worker", rest)
  | 0x1f468 :: rest -> Some ("man", rest)
  | 0x1f467 :: 0x1f3ff :: rest -> Some ("girl_tone5", rest)
  | 0x1f467 :: 0x1f3fe :: rest -> Some ("girl_tone4", rest)
  | 0x1f467 :: 0x1f3fd :: rest -> Some ("girl_tone3", rest)
  | 0x1f467 :: 0x1f3fc :: rest -> Some ("girl_tone2", rest)
  | 0x1f467 :: 0x1f3fb :: rest -> Some ("girl_tone1", rest)
  | 0x1f467 :: rest -> Some ("girl", rest)
  | 0x1f466 :: 0x1f3ff :: rest -> Some ("boy_tone5", rest)
  | 0x1f466 :: 0x1f3fe :: rest -> Some ("boy_tone4", rest)
  | 0x1f466 :: 0x1f3fd :: rest -> Some ("boy_tone3", rest)
  | 0x1f466 :: 0x1f3fc :: rest -> Some ("boy_tone2", rest)
  | 0x1f466 :: 0x1f3fb :: rest -> Some ("boy_tone1", rest)
  | 0x1f466 :: rest -> Some ("boy", rest)
  | 0x1f465 :: rest -> Some ("busts_in_silhouette", rest)
  | 0x1f464 :: rest -> Some ("bust_in_silhouette", rest)
  | 0x1f463 :: rest -> Some ("footprints", rest)
  | 0x1f462 :: rest -> Some ("boot", rest)
  | 0x1f461 :: rest -> Some ("sandal", rest)
  | 0x1f460 :: rest -> Some ("high_heel", rest)
  | 0x1f45f :: rest -> Some ("athletic_shoe", rest)
  | 0x1f45e :: rest -> Some ("mans_shoe", rest)
  | 0x1f45d :: rest -> Some ("pouch", rest)
  | 0x1f45c :: rest -> Some ("handbag", rest)
  | 0x1f45b :: rest -> Some ("purse", rest)
  | 0x1f45a :: rest -> Some ("womans_clothes", rest)
  | 0x1f459 :: rest -> Some ("bikini", rest)
  | 0x1f458 :: rest -> Some ("kimono", rest)
  | 0x1f457 :: rest -> Some ("dress", rest)
  | 0x1f456 :: rest -> Some ("jeans", rest)
  | 0x1f455 :: rest -> Some ("shirt", rest)
  | 0x1f454 :: rest -> Some ("necktie", rest)
  | 0x1f453 :: rest -> Some ("eyeglasses", rest)
  | 0x1f452 :: rest -> Some ("womans_hat", rest)
  | 0x1f451 :: rest -> Some ("crown", rest)
  | 0x1f450 :: 0x1f3ff :: rest -> Some ("open_hands_tone5", rest)
  | 0x1f450 :: 0x1f3fe :: rest -> Some ("open_hands_tone4", rest)
  | 0x1f450 :: 0x1f3fd :: rest -> Some ("open_hands_tone3", rest)
  | 0x1f450 :: 0x1f3fc :: rest -> Some ("open_hands_tone2", rest)
  | 0x1f450 :: 0x1f3fb :: rest -> Some ("open_hands_tone1", rest)
  | 0x1f450 :: rest -> Some ("open_hands", rest)
  | 0x1f44f :: 0x1f3ff :: rest -> Some ("clap_tone5", rest)
  | 0x1f44f :: 0x1f3fe :: rest -> Some ("clap_tone4", rest)
  | 0x1f44f :: 0x1f3fd :: rest -> Some ("clap_tone3", rest)
  | 0x1f44f :: 0x1f3fc :: rest -> Some ("clap_tone2", rest)
  | 0x1f44f :: 0x1f3fb :: rest -> Some ("clap_tone1", rest)
  | 0x1f44f :: rest -> Some ("clap", rest)
  | 0x1f44e :: 0x1f3ff :: rest -> Some ("thumbsdown_tone5", rest)
  | 0x1f44e :: 0x1f3fe :: rest -> Some ("thumbsdown_tone4", rest)
  | 0x1f44e :: 0x1f3fd :: rest -> Some ("thumbsdown_tone3", rest)
  | 0x1f44e :: 0x1f3fc :: rest -> Some ("thumbsdown_tone2", rest)
  | 0x1f44e :: 0x1f3fb :: rest -> Some ("thumbsdown_tone1", rest)
  | 0x1f44e :: rest -> Some ("thumbsdown", rest)
  | 0x1f44d :: 0x1f3ff :: rest -> Some ("thumbsup_tone5", rest)
  | 0x1f44d :: 0x1f3fe :: rest -> Some ("thumbsup_tone4", rest)
  | 0x1f44d :: 0x1f3fd :: rest -> Some ("thumbsup_tone3", rest)
  | 0x1f44d :: 0x1f3fc :: rest -> Some ("thumbsup_tone2", rest)
  | 0x1f44d :: 0x1f3fb :: rest -> Some ("thumbsup_tone1", rest)
  | 0x1f44d :: rest -> Some ("thumbsup", rest)
  | 0x1f44c :: 0x1f3ff :: rest -> Some ("ok_hand_tone5", rest)
  | 0x1f44c :: 0x1f3fe :: rest -> Some ("ok_hand_tone4", rest)
  | 0x1f44c :: 0x1f3fd :: rest -> Some ("ok_hand_tone3", rest)
  | 0x1f44c :: 0x1f3fc :: rest -> Some ("ok_hand_tone2", rest)
  | 0x1f44c :: 0x1f3fb :: rest -> Some ("ok_hand_tone1", rest)
  | 0x1f44c :: rest -> Some ("ok_hand", rest)
  | 0x1f44b :: 0x1f3ff :: rest -> Some ("wave_tone5", rest)
  | 0x1f44b :: 0x1f3fe :: rest -> Some ("wave_tone4", rest)
  | 0x1f44b :: 0x1f3fd :: rest -> Some ("wave_tone3", rest)
  | 0x1f44b :: 0x1f3fc :: rest -> Some ("wave_tone2", rest)
  | 0x1f44b :: 0x1f3fb :: rest -> Some ("wave_tone1", rest)
  | 0x1f44b :: rest -> Some ("wave", rest)
  | 0x1f44a :: 0x1f3ff :: rest -> Some ("punch_tone5", rest)
  | 0x1f44a :: 0x1f3fe :: rest -> Some ("punch_tone4", rest)
  | 0x1f44a :: 0x1f3fd :: rest -> Some ("punch_tone3", rest)
  | 0x1f44a :: 0x1f3fc :: rest -> Some ("punch_tone2", rest)
  | 0x1f44a :: 0x1f3fb :: rest -> Some ("punch_tone1", rest)
  | 0x1f44a :: rest -> Some ("punch", rest)
  | 0x1f449 :: 0x1f3ff :: rest -> Some ("point_right_tone5", rest)
  | 0x1f449 :: 0x1f3fe :: rest -> Some ("point_right_tone4", rest)
  | 0x1f449 :: 0x1f3fd :: rest -> Some ("point_right_tone3", rest)
  | 0x1f449 :: 0x1f3fc :: rest -> Some ("point_right_tone2", rest)
  | 0x1f449 :: 0x1f3fb :: rest -> Some ("point_right_tone1", rest)
  | 0x1f449 :: rest -> Some ("point_right", rest)
  | 0x1f448 :: 0x1f3ff :: rest -> Some ("point_left_tone5", rest)
  | 0x1f448 :: 0x1f3fe :: rest -> Some ("point_left_tone4", rest)
  | 0x1f448 :: 0x1f3fd :: rest -> Some ("point_left_tone3", rest)
  | 0x1f448 :: 0x1f3fc :: rest -> Some ("point_left_tone2", rest)
  | 0x1f448 :: 0x1f3fb :: rest -> Some ("point_left_tone1", rest)
  | 0x1f448 :: rest -> Some ("point_left", rest)
  | 0x1f447 :: 0x1f3ff :: rest -> Some ("point_down_tone5", rest)
  | 0x1f447 :: 0x1f3fe :: rest -> Some ("point_down_tone4", rest)
  | 0x1f447 :: 0x1f3fd :: rest -> Some ("point_down_tone3", rest)
  | 0x1f447 :: 0x1f3fc :: rest -> Some ("point_down_tone2", rest)
  | 0x1f447 :: 0x1f3fb :: rest -> Some ("point_down_tone1", rest)
  | 0x1f447 :: rest -> Some ("point_down", rest)
  | 0x1f446 :: 0x1f3ff :: rest -> Some ("point_up_2_tone5", rest)
  | 0x1f446 :: 0x1f3fe :: rest -> Some ("point_up_2_tone4", rest)
  | 0x1f446 :: 0x1f3fd :: rest -> Some ("point_up_2_tone3", rest)
  | 0x1f446 :: 0x1f3fc :: rest -> Some ("point_up_2_tone2", rest)
  | 0x1f446 :: 0x1f3fb :: rest -> Some ("point_up_2_tone1", rest)
  | 0x1f446 :: rest -> Some ("point_up_2", rest)
  | 0x1f445 :: rest -> Some ("tongue", rest)
  | 0x1f444 :: rest -> Some ("lips", rest)
  | 0x1f443 :: 0x1f3ff :: rest -> Some ("nose_tone5", rest)
  | 0x1f443 :: 0x1f3fe :: rest -> Some ("nose_tone4", rest)
  | 0x1f443 :: 0x1f3fd :: rest -> Some ("nose_tone3", rest)
  | 0x1f443 :: 0x1f3fc :: rest -> Some ("nose_tone2", rest)
  | 0x1f443 :: 0x1f3fb :: rest -> Some ("nose_tone1", rest)
  | 0x1f443 :: rest -> Some ("nose", rest)
  | 0x1f442 :: 0x1f3ff :: rest -> Some ("ear_tone5", rest)
  | 0x1f442 :: 0x1f3fe :: rest -> Some ("ear_tone4", rest)
  | 0x1f442 :: 0x1f3fd :: rest -> Some ("ear_tone3", rest)
  | 0x1f442 :: 0x1f3fc :: rest -> Some ("ear_tone2", rest)
  | 0x1f442 :: 0x1f3fb :: rest -> Some ("ear_tone1", rest)
  | 0x1f442 :: rest -> Some ("ear", rest)
  | 0x1f441 :: 0xfe0f :: 0x200d :: 0x1f5e8 :: 0xfe0f :: rest ->
      Some ("eye_in_speech_bubble", rest)
  | 0x1f441 :: rest -> Some ("eye", rest)
  | 0x1f440 :: rest -> Some ("eyes", rest)
  | 0x1f43f :: rest -> Some ("chipmunk", rest)
  | 0x1f43e :: rest -> Some ("feet", rest)
  | 0x1f43d :: rest -> Some ("pig_nose", rest)
  | 0x1f43c :: rest -> Some ("panda_face", rest)
  | 0x1f43b :: 0x200d :: 0x2744 :: 0xfe0f :: rest -> Some ("polar_bear", rest)
  | 0x1f43b :: rest -> Some ("bear", rest)
  | 0x1f43a :: rest -> Some ("wolf", rest)
  | 0x1f439 :: rest -> Some ("hamster", rest)
  | 0x1f438 :: rest -> Some ("frog", rest)
  | 0x1f437 :: rest -> Some ("pig", rest)
  | 0x1f436 :: rest -> Some ("dog", rest)
  | 0x1f435 :: rest -> Some ("monkey_face", rest)
  | 0x1f434 :: rest -> Some ("horse", rest)
  | 0x1f433 :: rest -> Some ("whale", rest)
  | 0x1f432 :: rest -> Some ("dragon_face", rest)
  | 0x1f431 :: rest -> Some ("cat", rest)
  | 0x1f430 :: rest -> Some ("rabbit", rest)
  | 0x1f42f :: rest -> Some ("tiger", rest)
  | 0x1f42e :: rest -> Some ("cow", rest)
  | 0x1f42d :: rest -> Some ("mouse", rest)
  | 0x1f42c :: rest -> Some ("dolphin", rest)
  | 0x1f42b :: rest -> Some ("camel", rest)
  | 0x1f42a :: rest -> Some ("dromedary_camel", rest)
  | 0x1f429 :: rest -> Some ("poodle", rest)
  | 0x1f428 :: rest -> Some ("koala", rest)
  | 0x1f427 :: rest -> Some ("penguin", rest)
  | 0x1f426 :: rest -> Some ("bird", rest)
  | 0x1f425 :: rest -> Some ("hatched_chick", rest)
  | 0x1f424 :: rest -> Some ("baby_chick", rest)
  | 0x1f423 :: rest -> Some ("hatching_chick", rest)
  | 0x1f422 :: rest -> Some ("turtle", rest)
  | 0x1f421 :: rest -> Some ("blowfish", rest)
  | 0x1f420 :: rest -> Some ("tropical_fish", rest)
  | 0x1f41f :: rest -> Some ("fish", rest)
  | 0x1f41e :: rest -> Some ("lady_beetle", rest)
  | 0x1f41d :: rest -> Some ("bee", rest)
  | 0x1f41c :: rest -> Some ("ant", rest)
  | 0x1f41b :: rest -> Some ("bug", rest)
  | 0x1f41a :: rest -> Some ("shell", rest)
  | 0x1f419 :: rest -> Some ("octopus", rest)
  | 0x1f418 :: rest -> Some ("elephant", rest)
  | 0x1f417 :: rest -> Some ("boar", rest)
  | 0x1f416 :: rest -> Some ("pig2", rest)
  | 0x1f415 :: 0x200d :: 0x1f9ba :: rest -> Some ("service_dog", rest)
  | 0x1f415 :: rest -> Some ("dog2", rest)
  | 0x1f414 :: rest -> Some ("chicken", rest)
  | 0x1f413 :: rest -> Some ("rooster", rest)
  | 0x1f412 :: rest -> Some ("monkey", rest)
  | 0x1f411 :: rest -> Some ("sheep", rest)
  | 0x1f410 :: rest -> Some ("goat", rest)
  | 0x1f40f :: rest -> Some ("ram", rest)
  | 0x1f40e :: rest -> Some ("racehorse", rest)
  | 0x1f40d :: rest -> Some ("snake", rest)
  | 0x1f40c :: rest -> Some ("snail", rest)
  | 0x1f40b :: rest -> Some ("whale2", rest)
  | 0x1f40a :: rest -> Some ("crocodile", rest)
  | 0x1f409 :: rest -> Some ("dragon", rest)
  | 0x1f408 :: 0x200d :: 0x2b1b :: rest -> Some ("black_cat", rest)
  | 0x1f408 :: rest -> Some ("cat2", rest)
  | 0x1f407 :: rest -> Some ("rabbit2", rest)
  | 0x1f406 :: rest -> Some ("leopard", rest)
  | 0x1f405 :: rest -> Some ("tiger2", rest)
  | 0x1f404 :: rest -> Some ("cow2", rest)
  | 0x1f403 :: rest -> Some ("water_buffalo", rest)
  | 0x1f402 :: rest -> Some ("ox", rest)
  | 0x1f401 :: rest -> Some ("mouse2", rest)
  | 0x1f400 :: rest -> Some ("rat", rest)
  | 0x1f3ff :: rest -> Some ("tone5", rest)
  | 0x1f3fe :: rest -> Some ("tone4", rest)
  | 0x1f3fd :: rest -> Some ("tone3", rest)
  | 0x1f3fc :: rest -> Some ("tone2", rest)
  | 0x1f3fb :: rest -> Some ("tone1", rest)
  | 0x1f3fa :: rest -> Some ("amphora", rest)
  | 0x1f3f9 :: rest -> Some ("bow_and_arrow", rest)
  | 0x1f3f8 :: rest -> Some ("badminton", rest)
  | 0x1f3f7 :: rest -> Some ("label", rest)
  | 0x1f3f5 :: rest -> Some ("rosette", rest)
  | 0x1f3f4 :: 0xe0067 :: 0xe0062 :: 0xe0077 :: 0xe006c :: 0xe0073 :: 0xe007f
    :: rest ->
      Some ("wales", rest)
  | 0x1f3f4 :: 0xe0067 :: 0xe0062 :: 0xe0073 :: 0xe0063 :: 0xe0074 :: 0xe007f
    :: rest ->
      Some ("scotland", rest)
  | 0x1f3f4 :: 0xe0067 :: 0xe0062 :: 0xe0065 :: 0xe006e :: 0xe0067 :: 0xe007f
    :: rest ->
      Some ("england", rest)
  | 0x1f3f4 :: 0x200d :: 0x2620 :: 0xfe0f :: rest -> Some ("pirate_flag", rest)
  | 0x1f3f4 :: rest -> Some ("flag_black", rest)
  | 0x1f3f3 :: 0xfe0f :: 0x200d :: 0x1f308 :: rest -> Some ("rainbow_flag", rest)
  | 0x1f3f3 :: 0xfe0f :: 0x200d :: 0x26a7 :: 0xfe0f :: rest ->
      Some ("transgender_flag", rest)
  | 0x1f3f3 :: rest -> Some ("flag_white", rest)
  | 0x1f3f0 :: rest -> Some ("european_castle", rest)
  | 0x1f3ef :: rest -> Some ("japanese_castle", rest)
  | 0x1f3ee :: rest -> Some ("izakaya_lantern", rest)
  | 0x1f3ed :: rest -> Some ("factory", rest)
  | 0x1f3ec :: rest -> Some ("department_store", rest)
  | 0x1f3eb :: rest -> Some ("school", rest)
  | 0x1f3ea :: rest -> Some ("convenience_store", rest)
  | 0x1f3e9 :: rest -> Some ("love_hotel", rest)
  | 0x1f3e8 :: rest -> Some ("hotel", rest)
  | 0x1f3e7 :: rest -> Some ("atm", rest)
  | 0x1f3e6 :: rest -> Some ("bank", rest)
  | 0x1f3e5 :: rest -> Some ("hospital", rest)
  | 0x1f3e4 :: rest -> Some ("european_post_office", rest)
  | 0x1f3e3 :: rest -> Some ("post_office", rest)
  | 0x1f3e2 :: rest -> Some ("office", rest)
  | 0x1f3e1 :: rest -> Some ("house_with_garden", rest)
  | 0x1f3e0 :: rest -> Some ("house", rest)
  | 0x1f3df :: rest -> Some ("stadium", rest)
  | 0x1f3de :: rest -> Some ("park", rest)
  | 0x1f3dd :: rest -> Some ("island", rest)
  | 0x1f3dc :: rest -> Some ("desert", rest)
  | 0x1f3db :: rest -> Some ("classical_building", rest)
  | 0x1f3da :: rest -> Some ("house_abandoned", rest)
  | 0x1f3d9 :: rest -> Some ("cityscape", rest)
  | 0x1f3d8 :: rest -> Some ("homes", rest)
  | 0x1f3d7 :: rest -> Some ("construction_site", rest)
  | 0x1f3d6 :: rest -> Some ("beach", rest)
  | 0x1f3d5 :: rest -> Some ("camping", rest)
  | 0x1f3d4 :: rest -> Some ("mountain_snow", rest)
  | 0x1f3d3 :: rest -> Some ("ping_pong", rest)
  | 0x1f3d2 :: rest -> Some ("hockey", rest)
  | 0x1f3d1 :: rest -> Some ("field_hockey", rest)
  | 0x1f3d0 :: rest -> Some ("volleyball", rest)
  | 0x1f3cf :: rest -> Some ("cricket_game", rest)
  | 0x1f3ce :: rest -> Some ("race_car", rest)
  | 0x1f3cd :: rest -> Some ("motorcycle", rest)
  | 0x1f3cc :: 0x1f3ff :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_golfing_tone5", rest)
  | 0x1f3cc :: 0x1f3ff :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_golfing_tone5", rest)
  | 0x1f3cc :: 0x1f3ff :: rest -> Some ("person_golfing_tone5", rest)
  | 0x1f3cc :: 0x1f3fe :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_golfing_tone4", rest)
  | 0x1f3cc :: 0x1f3fe :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_golfing_tone4", rest)
  | 0x1f3cc :: 0x1f3fe :: rest -> Some ("person_golfing_tone4", rest)
  | 0x1f3cc :: 0x1f3fd :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_golfing_tone3", rest)
  | 0x1f3cc :: 0x1f3fd :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_golfing_tone3", rest)
  | 0x1f3cc :: 0x1f3fd :: rest -> Some ("person_golfing_tone3", rest)
  | 0x1f3cc :: 0x1f3fc :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_golfing_tone2", rest)
  | 0x1f3cc :: 0x1f3fc :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_golfing_tone2", rest)
  | 0x1f3cc :: 0x1f3fc :: rest -> Some ("person_golfing_tone2", rest)
  | 0x1f3cc :: 0x1f3fb :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_golfing_tone1", rest)
  | 0x1f3cc :: 0x1f3fb :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_golfing_tone1", rest)
  | 0x1f3cc :: 0x1f3fb :: rest -> Some ("person_golfing_tone1", rest)
  | 0x1f3cc :: 0xfe0f :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_golfing", rest)
  | 0x1f3cc :: 0xfe0f :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_golfing", rest)
  | 0x1f3cc :: rest -> Some ("person_golfing", rest)
  | 0x1f3cb :: 0x1f3ff :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_lifting_weights_tone5", rest)
  | 0x1f3cb :: 0x1f3ff :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_lifting_weights_tone5", rest)
  | 0x1f3cb :: 0x1f3ff :: rest -> Some ("person_lifting_weights_tone5", rest)
  | 0x1f3cb :: 0x1f3fe :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_lifting_weights_tone4", rest)
  | 0x1f3cb :: 0x1f3fe :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_lifting_weights_tone4", rest)
  | 0x1f3cb :: 0x1f3fe :: rest -> Some ("person_lifting_weights_tone4", rest)
  | 0x1f3cb :: 0x1f3fd :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_lifting_weights_tone3", rest)
  | 0x1f3cb :: 0x1f3fd :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_lifting_weights_tone3", rest)
  | 0x1f3cb :: 0x1f3fd :: rest -> Some ("person_lifting_weights_tone3", rest)
  | 0x1f3cb :: 0x1f3fc :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_lifting_weights_tone2", rest)
  | 0x1f3cb :: 0x1f3fc :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_lifting_weights_tone2", rest)
  | 0x1f3cb :: 0x1f3fc :: rest -> Some ("person_lifting_weights_tone2", rest)
  | 0x1f3cb :: 0x1f3fb :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_lifting_weights_tone1", rest)
  | 0x1f3cb :: 0x1f3fb :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_lifting_weights_tone1", rest)
  | 0x1f3cb :: 0x1f3fb :: rest -> Some ("person_lifting_weights_tone1", rest)
  | 0x1f3cb :: 0xfe0f :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_lifting_weights", rest)
  | 0x1f3cb :: 0xfe0f :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_lifting_weights", rest)
  | 0x1f3cb :: rest -> Some ("person_lifting_weights", rest)
  | 0x1f3ca :: 0x1f3ff :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_swimming_tone5", rest)
  | 0x1f3ca :: 0x1f3ff :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_swimming_tone5", rest)
  | 0x1f3ca :: 0x1f3ff :: rest -> Some ("person_swimming_tone5", rest)
  | 0x1f3ca :: 0x1f3fe :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_swimming_tone4", rest)
  | 0x1f3ca :: 0x1f3fe :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_swimming_tone4", rest)
  | 0x1f3ca :: 0x1f3fe :: rest -> Some ("person_swimming_tone4", rest)
  | 0x1f3ca :: 0x1f3fd :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_swimming_tone3", rest)
  | 0x1f3ca :: 0x1f3fd :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_swimming_tone3", rest)
  | 0x1f3ca :: 0x1f3fd :: rest -> Some ("person_swimming_tone3", rest)
  | 0x1f3ca :: 0x1f3fc :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_swimming_tone2", rest)
  | 0x1f3ca :: 0x1f3fc :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_swimming_tone2", rest)
  | 0x1f3ca :: 0x1f3fc :: rest -> Some ("person_swimming_tone2", rest)
  | 0x1f3ca :: 0x1f3fb :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_swimming_tone1", rest)
  | 0x1f3ca :: 0x1f3fb :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_swimming_tone1", rest)
  | 0x1f3ca :: 0x1f3fb :: rest -> Some ("person_swimming_tone1", rest)
  | 0x1f3ca :: 0x200d :: 0x2642 :: 0xfe0f :: rest -> Some ("man_swimming", rest)
  | 0x1f3ca :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_swimming", rest)
  | 0x1f3ca :: rest -> Some ("person_swimming", rest)
  | 0x1f3c9 :: rest -> Some ("rugby_football", rest)
  | 0x1f3c8 :: rest -> Some ("football", rest)
  | 0x1f3c7 :: 0x1f3ff :: rest -> Some ("horse_racing_tone5", rest)
  | 0x1f3c7 :: 0x1f3fe :: rest -> Some ("horse_racing_tone4", rest)
  | 0x1f3c7 :: 0x1f3fd :: rest -> Some ("horse_racing_tone3", rest)
  | 0x1f3c7 :: 0x1f3fc :: rest -> Some ("horse_racing_tone2", rest)
  | 0x1f3c7 :: 0x1f3fb :: rest -> Some ("horse_racing_tone1", rest)
  | 0x1f3c7 :: rest -> Some ("horse_racing", rest)
  | 0x1f3c6 :: rest -> Some ("trophy", rest)
  | 0x1f3c5 :: rest -> Some ("medal", rest)
  | 0x1f3c4 :: 0x1f3ff :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_surfing_tone5", rest)
  | 0x1f3c4 :: 0x1f3ff :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_surfing_tone5", rest)
  | 0x1f3c4 :: 0x1f3ff :: rest -> Some ("person_surfing_tone5", rest)
  | 0x1f3c4 :: 0x1f3fe :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_surfing_tone4", rest)
  | 0x1f3c4 :: 0x1f3fe :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_surfing_tone4", rest)
  | 0x1f3c4 :: 0x1f3fe :: rest -> Some ("person_surfing_tone4", rest)
  | 0x1f3c4 :: 0x1f3fd :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_surfing_tone3", rest)
  | 0x1f3c4 :: 0x1f3fd :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_surfing_tone3", rest)
  | 0x1f3c4 :: 0x1f3fd :: rest -> Some ("person_surfing_tone3", rest)
  | 0x1f3c4 :: 0x1f3fc :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_surfing_tone2", rest)
  | 0x1f3c4 :: 0x1f3fc :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_surfing_tone2", rest)
  | 0x1f3c4 :: 0x1f3fc :: rest -> Some ("person_surfing_tone2", rest)
  | 0x1f3c4 :: 0x1f3fb :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_surfing_tone1", rest)
  | 0x1f3c4 :: 0x1f3fb :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_surfing_tone1", rest)
  | 0x1f3c4 :: 0x1f3fb :: rest -> Some ("person_surfing_tone1", rest)
  | 0x1f3c4 :: 0x200d :: 0x2642 :: 0xfe0f :: rest -> Some ("man_surfing", rest)
  | 0x1f3c4 :: 0x200d :: 0x2640 :: 0xfe0f :: rest -> Some ("woman_surfing", rest)
  | 0x1f3c4 :: rest -> Some ("person_surfing", rest)
  | 0x1f3c3 :: 0x1f3ff :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_running_tone5", rest)
  | 0x1f3c3 :: 0x1f3ff :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_running_tone5", rest)
  | 0x1f3c3 :: 0x1f3ff :: rest -> Some ("person_running_tone5", rest)
  | 0x1f3c3 :: 0x1f3fe :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_running_tone4", rest)
  | 0x1f3c3 :: 0x1f3fe :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_running_tone4", rest)
  | 0x1f3c3 :: 0x1f3fe :: rest -> Some ("person_running_tone4", rest)
  | 0x1f3c3 :: 0x1f3fd :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_running_tone3", rest)
  | 0x1f3c3 :: 0x1f3fd :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_running_tone3", rest)
  | 0x1f3c3 :: 0x1f3fd :: rest -> Some ("person_running_tone3", rest)
  | 0x1f3c3 :: 0x1f3fc :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_running_tone2", rest)
  | 0x1f3c3 :: 0x1f3fc :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_running_tone2", rest)
  | 0x1f3c3 :: 0x1f3fc :: rest -> Some ("person_running_tone2", rest)
  | 0x1f3c3 :: 0x1f3fb :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_running_tone1", rest)
  | 0x1f3c3 :: 0x1f3fb :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_running_tone1", rest)
  | 0x1f3c3 :: 0x1f3fb :: rest -> Some ("person_running_tone1", rest)
  | 0x1f3c3 :: 0x200d :: 0x2642 :: 0xfe0f :: rest -> Some ("man_running", rest)
  | 0x1f3c3 :: 0x200d :: 0x2640 :: 0xfe0f :: rest -> Some ("woman_running", rest)
  | 0x1f3c3 :: rest -> Some ("person_running", rest)
  | 0x1f3c2 :: 0x1f3ff :: rest -> Some ("snowboarder_tone5", rest)
  | 0x1f3c2 :: 0x1f3fe :: rest -> Some ("snowboarder_tone4", rest)
  | 0x1f3c2 :: 0x1f3fd :: rest -> Some ("snowboarder_tone3", rest)
  | 0x1f3c2 :: 0x1f3fc :: rest -> Some ("snowboarder_tone2", rest)
  | 0x1f3c2 :: 0x1f3fb :: rest -> Some ("snowboarder_tone1", rest)
  | 0x1f3c2 :: rest -> Some ("snowboarder", rest)
  | 0x1f3c1 :: rest -> Some ("checkered_flag", rest)
  | 0x1f3c0 :: rest -> Some ("basketball", rest)
  | 0x1f3bf :: rest -> Some ("ski", rest)
  | 0x1f3be :: rest -> Some ("tennis", rest)
  | 0x1f3bd :: rest -> Some ("running_shirt_with_sash", rest)
  | 0x1f3bc :: rest -> Some ("musical_score", rest)
  | 0x1f3bb :: rest -> Some ("violin", rest)
  | 0x1f3ba :: rest -> Some ("trumpet", rest)
  | 0x1f3b9 :: rest -> Some ("musical_keyboard", rest)
  | 0x1f3b8 :: rest -> Some ("guitar", rest)
  | 0x1f3b7 :: rest -> Some ("saxophone", rest)
  | 0x1f3b6 :: rest -> Some ("notes", rest)
  | 0x1f3b5 :: rest -> Some ("musical_note", rest)
  | 0x1f3b4 :: rest -> Some ("flower_playing_cards", rest)
  | 0x1f3b3 :: rest -> Some ("bowling", rest)
  | 0x1f3b2 :: rest -> Some ("game_die", rest)
  | 0x1f3b1 :: rest -> Some ("8ball", rest)
  | 0x1f3b0 :: rest -> Some ("slot_machine", rest)
  | 0x1f3af :: rest -> Some ("dart", rest)
  | 0x1f3ae :: rest -> Some ("video_game", rest)
  | 0x1f3ad :: rest -> Some ("performing_arts", rest)
  | 0x1f3ac :: rest -> Some ("clapper", rest)
  | 0x1f3ab :: rest -> Some ("ticket", rest)
  | 0x1f3aa :: rest -> Some ("circus_tent", rest)
  | 0x1f3a9 :: rest -> Some ("tophat", rest)
  | 0x1f3a8 :: rest -> Some ("art", rest)
  | 0x1f3a7 :: rest -> Some ("headphones", rest)
  | 0x1f3a6 :: rest -> Some ("cinema", rest)
  | 0x1f3a5 :: rest -> Some ("movie_camera", rest)
  | 0x1f3a4 :: rest -> Some ("microphone", rest)
  | 0x1f3a3 :: rest -> Some ("fishing_pole_and_fish", rest)
  | 0x1f3a2 :: rest -> Some ("roller_coaster", rest)
  | 0x1f3a1 :: rest -> Some ("ferris_wheel", rest)
  | 0x1f3a0 :: rest -> Some ("carousel_horse", rest)
  | 0x1f39f :: rest -> Some ("tickets", rest)
  | 0x1f39e :: rest -> Some ("film_frames", rest)
  | 0x1f39b :: rest -> Some ("control_knobs", rest)
  | 0x1f39a :: rest -> Some ("level_slider", rest)
  | 0x1f399 :: rest -> Some ("microphone2", rest)
  | 0x1f397 :: rest -> Some ("reminder_ribbon", rest)
  | 0x1f396 :: rest -> Some ("military_medal", rest)
  | 0x1f393 :: rest -> Some ("mortar_board", rest)
  | 0x1f392 :: rest -> Some ("school_satchel", rest)
  | 0x1f391 :: rest -> Some ("rice_scene", rest)
  | 0x1f390 :: rest -> Some ("wind_chime", rest)
  | 0x1f38f :: rest -> Some ("flags", rest)
  | 0x1f38e :: rest -> Some ("dolls", rest)
  | 0x1f38d :: rest -> Some ("bamboo", rest)
  | 0x1f38c :: rest -> Some ("crossed_flags", rest)
  | 0x1f38b :: rest -> Some ("tanabata_tree", rest)
  | 0x1f38a :: rest -> Some ("confetti_ball", rest)
  | 0x1f389 :: rest -> Some ("tada", rest)
  | 0x1f388 :: rest -> Some ("balloon", rest)
  | 0x1f387 :: rest -> Some ("sparkler", rest)
  | 0x1f386 :: rest -> Some ("fireworks", rest)
  | 0x1f385 :: 0x1f3ff :: rest -> Some ("santa_tone5", rest)
  | 0x1f385 :: 0x1f3fe :: rest -> Some ("santa_tone4", rest)
  | 0x1f385 :: 0x1f3fd :: rest -> Some ("santa_tone3", rest)
  | 0x1f385 :: 0x1f3fc :: rest -> Some ("santa_tone2", rest)
  | 0x1f385 :: 0x1f3fb :: rest -> Some ("santa_tone1", rest)
  | 0x1f385 :: rest -> Some ("santa", rest)
  | 0x1f384 :: rest -> Some ("christmas_tree", rest)
  | 0x1f383 :: rest -> Some ("jack_o_lantern", rest)
  | 0x1f382 :: rest -> Some ("birthday", rest)
  | 0x1f381 :: rest -> Some ("gift", rest)
  | 0x1f380 :: rest -> Some ("ribbon", rest)
  | 0x1f37f :: rest -> Some ("popcorn", rest)
  | 0x1f37e :: rest -> Some ("champagne", rest)
  | 0x1f37d :: rest -> Some ("fork_knife_plate", rest)
  | 0x1f37c :: rest -> Some ("baby_bottle", rest)
  | 0x1f37b :: rest -> Some ("beers", rest)
  | 0x1f37a :: rest -> Some ("beer", rest)
  | 0x1f379 :: rest -> Some ("tropical_drink", rest)
  | 0x1f378 :: rest -> Some ("cocktail", rest)
  | 0x1f377 :: rest -> Some ("wine_glass", rest)
  | 0x1f376 :: rest -> Some ("sake", rest)
  | 0x1f375 :: rest -> Some ("tea", rest)
  | 0x1f374 :: rest -> Some ("fork_and_knife", rest)
  | 0x1f373 :: rest -> Some ("cooking", rest)
  | 0x1f372 :: rest -> Some ("stew", rest)
  | 0x1f371 :: rest -> Some ("bento", rest)
  | 0x1f370 :: rest -> Some ("cake", rest)
  | 0x1f36f :: rest -> Some ("honey_pot", rest)
  | 0x1f36e :: rest -> Some ("custard", rest)
  | 0x1f36d :: rest -> Some ("lollipop", rest)
  | 0x1f36c :: rest -> Some ("candy", rest)
  | 0x1f36b :: rest -> Some ("chocolate_bar", rest)
  | 0x1f36a :: rest -> Some ("cookie", rest)
  | 0x1f369 :: rest -> Some ("doughnut", rest)
  | 0x1f368 :: rest -> Some ("ice_cream", rest)
  | 0x1f367 :: rest -> Some ("shaved_ice", rest)
  | 0x1f366 :: rest -> Some ("icecream", rest)
  | 0x1f365 :: rest -> Some ("fish_cake", rest)
  | 0x1f364 :: rest -> Some ("fried_shrimp", rest)
  | 0x1f363 :: rest -> Some ("sushi", rest)
  | 0x1f362 :: rest -> Some ("oden", rest)
  | 0x1f361 :: rest -> Some ("dango", rest)
  | 0x1f360 :: rest -> Some ("sweet_potato", rest)
  | 0x1f35f :: rest -> Some ("fries", rest)
  | 0x1f35e :: rest -> Some ("bread", rest)
  | 0x1f35d :: rest -> Some ("spaghetti", rest)
  | 0x1f35c :: rest -> Some ("ramen", rest)
  | 0x1f35b :: rest -> Some ("curry", rest)
  | 0x1f35a :: rest -> Some ("rice", rest)
  | 0x1f359 :: rest -> Some ("rice_ball", rest)
  | 0x1f358 :: rest -> Some ("rice_cracker", rest)
  | 0x1f357 :: rest -> Some ("poultry_leg", rest)
  | 0x1f356 :: rest -> Some ("meat_on_bone", rest)
  | 0x1f355 :: rest -> Some ("pizza", rest)
  | 0x1f354 :: rest -> Some ("hamburger", rest)
  | 0x1f353 :: rest -> Some ("strawberry", rest)
  | 0x1f352 :: rest -> Some ("cherries", rest)
  | 0x1f351 :: rest -> Some ("peach", rest)
  | 0x1f350 :: rest -> Some ("pear", rest)
  | 0x1f34f :: rest -> Some ("green_apple", rest)
  | 0x1f34e :: rest -> Some ("apple", rest)
  | 0x1f34d :: rest -> Some ("pineapple", rest)
  | 0x1f34c :: rest -> Some ("banana", rest)
  | 0x1f34b :: rest -> Some ("lemon", rest)
  | 0x1f34a :: rest -> Some ("tangerine", rest)
  | 0x1f349 :: rest -> Some ("watermelon", rest)
  | 0x1f348 :: rest -> Some ("melon", rest)
  | 0x1f347 :: rest -> Some ("grapes", rest)
  | 0x1f346 :: rest -> Some ("eggplant", rest)
  | 0x1f345 :: rest -> Some ("tomato", rest)
  | 0x1f344 :: rest -> Some ("mushroom", rest)
  | 0x1f343 :: rest -> Some ("leaves", rest)
  | 0x1f342 :: rest -> Some ("fallen_leaf", rest)
  | 0x1f341 :: rest -> Some ("maple_leaf", rest)
  | 0x1f340 :: rest -> Some ("four_leaf_clover", rest)
  | 0x1f33f :: rest -> Some ("herb", rest)
  | 0x1f33e :: rest -> Some ("ear_of_rice", rest)
  | 0x1f33d :: rest -> Some ("corn", rest)
  | 0x1f33c :: rest -> Some ("blossom", rest)
  | 0x1f33b :: rest -> Some ("sunflower", rest)
  | 0x1f33a :: rest -> Some ("hibiscus", rest)
  | 0x1f339 :: rest -> Some ("rose", rest)
  | 0x1f338 :: rest -> Some ("cherry_blossom", rest)
  | 0x1f337 :: rest -> Some ("tulip", rest)
  | 0x1f336 :: rest -> Some ("hot_pepper", rest)
  | 0x1f335 :: rest -> Some ("cactus", rest)
  | 0x1f334 :: rest -> Some ("palm_tree", rest)
  | 0x1f333 :: rest -> Some ("deciduous_tree", rest)
  | 0x1f332 :: rest -> Some ("evergreen_tree", rest)
  | 0x1f331 :: rest -> Some ("seedling", rest)
  | 0x1f330 :: rest -> Some ("chestnut", rest)
  | 0x1f32f :: rest -> Some ("burrito", rest)
  | 0x1f32e :: rest -> Some ("taco", rest)
  | 0x1f32d :: rest -> Some ("hotdog", rest)
  | 0x1f32c :: rest -> Some ("wind_blowing_face", rest)
  | 0x1f32b :: rest -> Some ("fog", rest)
  | 0x1f32a :: rest -> Some ("cloud_tornado", rest)
  | 0x1f329 :: rest -> Some ("cloud_lightning", rest)
  | 0x1f328 :: rest -> Some ("cloud_snow", rest)
  | 0x1f327 :: rest -> Some ("cloud_rain", rest)
  | 0x1f326 :: rest -> Some ("white_sun_rain_cloud", rest)
  | 0x1f325 :: rest -> Some ("white_sun_cloud", rest)
  | 0x1f324 :: rest -> Some ("white_sun_small_cloud", rest)
  | 0x1f321 :: rest -> Some ("thermometer", rest)
  | 0x1f320 :: rest -> Some ("stars", rest)
  | 0x1f31f :: rest -> Some ("star2", rest)
  | 0x1f31e :: rest -> Some ("sun_with_face", rest)
  | 0x1f31d :: rest -> Some ("full_moon_with_face", rest)
  | 0x1f31c :: rest -> Some ("last_quarter_moon_with_face", rest)
  | 0x1f31b :: rest -> Some ("first_quarter_moon_with_face", rest)
  | 0x1f31a :: rest -> Some ("new_moon_with_face", rest)
  | 0x1f319 :: rest -> Some ("crescent_moon", rest)
  | 0x1f318 :: rest -> Some ("waning_crescent_moon", rest)
  | 0x1f317 :: rest -> Some ("last_quarter_moon", rest)
  | 0x1f316 :: rest -> Some ("waning_gibbous_moon", rest)
  | 0x1f315 :: rest -> Some ("full_moon", rest)
  | 0x1f314 :: rest -> Some ("waxing_gibbous_moon", rest)
  | 0x1f313 :: rest -> Some ("first_quarter_moon", rest)
  | 0x1f312 :: rest -> Some ("waxing_crescent_moon", rest)
  | 0x1f311 :: rest -> Some ("new_moon", rest)
  | 0x1f310 :: rest -> Some ("globe_with_meridians", rest)
  | 0x1f30f :: rest -> Some ("earth_asia", rest)
  | 0x1f30e :: rest -> Some ("earth_americas", rest)
  | 0x1f30d :: rest -> Some ("earth_africa", rest)
  | 0x1f30c :: rest -> Some ("milky_way", rest)
  | 0x1f30b :: rest -> Some ("volcano", rest)
  | 0x1f30a :: rest -> Some ("ocean", rest)
  | 0x1f309 :: rest -> Some ("bridge_at_night", rest)
  | 0x1f308 :: rest -> Some ("rainbow", rest)
  | 0x1f307 :: rest -> Some ("city_sunset", rest)
  | 0x1f306 :: rest -> Some ("city_dusk", rest)
  | 0x1f305 :: rest -> Some ("sunrise", rest)
  | 0x1f304 :: rest -> Some ("sunrise_over_mountains", rest)
  | 0x1f303 :: rest -> Some ("night_with_stars", rest)
  | 0x1f302 :: rest -> Some ("closed_umbrella", rest)
  | 0x1f301 :: rest -> Some ("foggy", rest)
  | 0x1f300 :: rest -> Some ("cyclone", rest)
  | 0x1f251 :: rest -> Some ("accept", rest)
  | 0x1f250 :: rest -> Some ("ideograph_advantage", rest)
  | 0x1f23a :: rest -> Some ("u55b6", rest)
  | 0x1f239 :: rest -> Some ("u5272", rest)
  | 0x1f238 :: rest -> Some ("u7533", rest)
  | 0x1f237 :: rest -> Some ("u6708", rest)
  | 0x1f236 :: rest -> Some ("u6709", rest)
  | 0x1f235 :: rest -> Some ("u6e80", rest)
  | 0x1f234 :: rest -> Some ("u5408", rest)
  | 0x1f233 :: rest -> Some ("u7a7a", rest)
  | 0x1f232 :: rest -> Some ("u7981", rest)
  | 0x1f22f :: rest -> Some ("u6307", rest)
  | 0x1f21a :: rest -> Some ("u7121", rest)
  | 0x1f202 :: rest -> Some ("sa", rest)
  | 0x1f201 :: rest -> Some ("koko", rest)
  | 0x1f1ff :: 0x1f1fc :: rest -> Some ("flag_zw", rest)
  | 0x1f1ff :: 0x1f1f2 :: rest -> Some ("flag_zm", rest)
  | 0x1f1ff :: 0x1f1e6 :: rest -> Some ("flag_za", rest)
  | 0x1f1ff :: rest -> Some ("regional_indicator_z", rest)
  | 0x1f1fe :: 0x1f1f9 :: rest -> Some ("flag_yt", rest)
  | 0x1f1fe :: 0x1f1ea :: rest -> Some ("flag_ye", rest)
  | 0x1f1fe :: rest -> Some ("regional_indicator_y", rest)
  | 0x1f1fd :: 0x1f1f0 :: rest -> Some ("flag_xk", rest)
  | 0x1f1fd :: rest -> Some ("regional_indicator_x", rest)
  | 0x1f1fc :: 0x1f1f8 :: rest -> Some ("flag_ws", rest)
  | 0x1f1fc :: 0x1f1eb :: rest -> Some ("flag_wf", rest)
  | 0x1f1fc :: rest -> Some ("regional_indicator_w", rest)
  | 0x1f1fb :: 0x1f1fa :: rest -> Some ("flag_vu", rest)
  | 0x1f1fb :: 0x1f1f3 :: rest -> Some ("flag_vn", rest)
  | 0x1f1fb :: 0x1f1ee :: rest -> Some ("flag_vi", rest)
  | 0x1f1fb :: 0x1f1ec :: rest -> Some ("flag_vg", rest)
  | 0x1f1fb :: 0x1f1ea :: rest -> Some ("flag_ve", rest)
  | 0x1f1fb :: 0x1f1e8 :: rest -> Some ("flag_vc", rest)
  | 0x1f1fb :: 0x1f1e6 :: rest -> Some ("flag_va", rest)
  | 0x1f1fb :: rest -> Some ("regional_indicator_v", rest)
  | 0x1f1fa :: 0x1f1ff :: rest -> Some ("flag_uz", rest)
  | 0x1f1fa :: 0x1f1fe :: rest -> Some ("flag_uy", rest)
  | 0x1f1fa :: 0x1f1f8 :: rest -> Some ("flag_us", rest)
  | 0x1f1fa :: 0x1f1f3 :: rest -> Some ("united_nations", rest)
  | 0x1f1fa :: 0x1f1f2 :: rest -> Some ("flag_um", rest)
  | 0x1f1fa :: 0x1f1ec :: rest -> Some ("flag_ug", rest)
  | 0x1f1fa :: 0x1f1e6 :: rest -> Some ("flag_ua", rest)
  | 0x1f1fa :: rest -> Some ("regional_indicator_u", rest)
  | 0x1f1f9 :: 0x1f1ff :: rest -> Some ("flag_tz", rest)
  | 0x1f1f9 :: 0x1f1fc :: rest -> Some ("flag_tw", rest)
  | 0x1f1f9 :: 0x1f1fb :: rest -> Some ("flag_tv", rest)
  | 0x1f1f9 :: 0x1f1f9 :: rest -> Some ("flag_tt", rest)
  | 0x1f1f9 :: 0x1f1f7 :: rest -> Some ("flag_tr", rest)
  | 0x1f1f9 :: 0x1f1f4 :: rest -> Some ("flag_to", rest)
  | 0x1f1f9 :: 0x1f1f3 :: rest -> Some ("flag_tn", rest)
  | 0x1f1f9 :: 0x1f1f2 :: rest -> Some ("flag_tm", rest)
  | 0x1f1f9 :: 0x1f1f1 :: rest -> Some ("flag_tl", rest)
  | 0x1f1f9 :: 0x1f1f0 :: rest -> Some ("flag_tk", rest)
  | 0x1f1f9 :: 0x1f1ef :: rest -> Some ("flag_tj", rest)
  | 0x1f1f9 :: 0x1f1ed :: rest -> Some ("flag_th", rest)
  | 0x1f1f9 :: 0x1f1ec :: rest -> Some ("flag_tg", rest)
  | 0x1f1f9 :: 0x1f1eb :: rest -> Some ("flag_tf", rest)
  | 0x1f1f9 :: 0x1f1e9 :: rest -> Some ("flag_td", rest)
  | 0x1f1f9 :: 0x1f1e8 :: rest -> Some ("flag_tc", rest)
  | 0x1f1f9 :: 0x1f1e6 :: rest -> Some ("flag_ta", rest)
  | 0x1f1f9 :: rest -> Some ("regional_indicator_t", rest)
  | 0x1f1f8 :: 0x1f1ff :: rest -> Some ("flag_sz", rest)
  | 0x1f1f8 :: 0x1f1fe :: rest -> Some ("flag_sy", rest)
  | 0x1f1f8 :: 0x1f1fd :: rest -> Some ("flag_sx", rest)
  | 0x1f1f8 :: 0x1f1fb :: rest -> Some ("flag_sv", rest)
  | 0x1f1f8 :: 0x1f1f9 :: rest -> Some ("flag_st", rest)
  | 0x1f1f8 :: 0x1f1f8 :: rest -> Some ("flag_ss", rest)
  | 0x1f1f8 :: 0x1f1f7 :: rest -> Some ("flag_sr", rest)
  | 0x1f1f8 :: 0x1f1f4 :: rest -> Some ("flag_so", rest)
  | 0x1f1f8 :: 0x1f1f3 :: rest -> Some ("flag_sn", rest)
  | 0x1f1f8 :: 0x1f1f2 :: rest -> Some ("flag_sm", rest)
  | 0x1f1f8 :: 0x1f1f1 :: rest -> Some ("flag_sl", rest)
  | 0x1f1f8 :: 0x1f1f0 :: rest -> Some ("flag_sk", rest)
  | 0x1f1f8 :: 0x1f1ef :: rest -> Some ("flag_sj", rest)
  | 0x1f1f8 :: 0x1f1ee :: rest -> Some ("flag_si", rest)
  | 0x1f1f8 :: 0x1f1ed :: rest -> Some ("flag_sh", rest)
  | 0x1f1f8 :: 0x1f1ec :: rest -> Some ("flag_sg", rest)
  | 0x1f1f8 :: 0x1f1ea :: rest -> Some ("flag_se", rest)
  | 0x1f1f8 :: 0x1f1e9 :: rest -> Some ("flag_sd", rest)
  | 0x1f1f8 :: 0x1f1e8 :: rest -> Some ("flag_sc", rest)
  | 0x1f1f8 :: 0x1f1e7 :: rest -> Some ("flag_sb", rest)
  | 0x1f1f8 :: 0x1f1e6 :: rest -> Some ("flag_sa", rest)
  | 0x1f1f8 :: rest -> Some ("regional_indicator_s", rest)
  | 0x1f1f7 :: 0x1f1fc :: rest -> Some ("flag_rw", rest)
  | 0x1f1f7 :: 0x1f1fa :: rest -> Some ("flag_ru", rest)
  | 0x1f1f7 :: 0x1f1f8 :: rest -> Some ("flag_rs", rest)
  | 0x1f1f7 :: 0x1f1f4 :: rest -> Some ("flag_ro", rest)
  | 0x1f1f7 :: 0x1f1ea :: rest -> Some ("flag_re", rest)
  | 0x1f1f7 :: rest -> Some ("regional_indicator_r", rest)
  | 0x1f1f6 :: 0x1f1e6 :: rest -> Some ("flag_qa", rest)
  | 0x1f1f6 :: rest -> Some ("regional_indicator_q", rest)
  | 0x1f1f5 :: 0x1f1fe :: rest -> Some ("flag_py", rest)
  | 0x1f1f5 :: 0x1f1fc :: rest -> Some ("flag_pw", rest)
  | 0x1f1f5 :: 0x1f1f9 :: rest -> Some ("flag_pt", rest)
  | 0x1f1f5 :: 0x1f1f8 :: rest -> Some ("flag_ps", rest)
  | 0x1f1f5 :: 0x1f1f7 :: rest -> Some ("flag_pr", rest)
  | 0x1f1f5 :: 0x1f1f3 :: rest -> Some ("flag_pn", rest)
  | 0x1f1f5 :: 0x1f1f2 :: rest -> Some ("flag_pm", rest)
  | 0x1f1f5 :: 0x1f1f1 :: rest -> Some ("flag_pl", rest)
  | 0x1f1f5 :: 0x1f1f0 :: rest -> Some ("flag_pk", rest)
  | 0x1f1f5 :: 0x1f1ed :: rest -> Some ("flag_ph", rest)
  | 0x1f1f5 :: 0x1f1ec :: rest -> Some ("flag_pg", rest)
  | 0x1f1f5 :: 0x1f1eb :: rest -> Some ("flag_pf", rest)
  | 0x1f1f5 :: 0x1f1ea :: rest -> Some ("flag_pe", rest)
  | 0x1f1f5 :: 0x1f1e6 :: rest -> Some ("flag_pa", rest)
  | 0x1f1f5 :: rest -> Some ("regional_indicator_p", rest)
  | 0x1f1f4 :: 0x1f1f2 :: rest -> Some ("flag_om", rest)
  | 0x1f1f4 :: rest -> Some ("regional_indicator_o", rest)
  | 0x1f1f3 :: 0x1f1ff :: rest -> Some ("flag_nz", rest)
  | 0x1f1f3 :: 0x1f1fa :: rest -> Some ("flag_nu", rest)
  | 0x1f1f3 :: 0x1f1f7 :: rest -> Some ("flag_nr", rest)
  | 0x1f1f3 :: 0x1f1f5 :: rest -> Some ("flag_np", rest)
  | 0x1f1f3 :: 0x1f1f4 :: rest -> Some ("flag_no", rest)
  | 0x1f1f3 :: 0x1f1f1 :: rest -> Some ("flag_nl", rest)
  | 0x1f1f3 :: 0x1f1ee :: rest -> Some ("flag_ni", rest)
  | 0x1f1f3 :: 0x1f1ec :: rest -> Some ("flag_ng", rest)
  | 0x1f1f3 :: 0x1f1eb :: rest -> Some ("flag_nf", rest)
  | 0x1f1f3 :: 0x1f1ea :: rest -> Some ("flag_ne", rest)
  | 0x1f1f3 :: 0x1f1e8 :: rest -> Some ("flag_nc", rest)
  | 0x1f1f3 :: 0x1f1e6 :: rest -> Some ("flag_na", rest)
  | 0x1f1f3 :: rest -> Some ("regional_indicator_n", rest)
  | 0x1f1f2 :: 0x1f1ff :: rest -> Some ("flag_mz", rest)
  | 0x1f1f2 :: 0x1f1fe :: rest -> Some ("flag_my", rest)
  | 0x1f1f2 :: 0x1f1fd :: rest -> Some ("flag_mx", rest)
  | 0x1f1f2 :: 0x1f1fc :: rest -> Some ("flag_mw", rest)
  | 0x1f1f2 :: 0x1f1fb :: rest -> Some ("flag_mv", rest)
  | 0x1f1f2 :: 0x1f1fa :: rest -> Some ("flag_mu", rest)
  | 0x1f1f2 :: 0x1f1f9 :: rest -> Some ("flag_mt", rest)
  | 0x1f1f2 :: 0x1f1f8 :: rest -> Some ("flag_ms", rest)
  | 0x1f1f2 :: 0x1f1f7 :: rest -> Some ("flag_mr", rest)
  | 0x1f1f2 :: 0x1f1f6 :: rest -> Some ("flag_mq", rest)
  | 0x1f1f2 :: 0x1f1f5 :: rest -> Some ("flag_mp", rest)
  | 0x1f1f2 :: 0x1f1f4 :: rest -> Some ("flag_mo", rest)
  | 0x1f1f2 :: 0x1f1f3 :: rest -> Some ("flag_mn", rest)
  | 0x1f1f2 :: 0x1f1f2 :: rest -> Some ("flag_mm", rest)
  | 0x1f1f2 :: 0x1f1f1 :: rest -> Some ("flag_ml", rest)
  | 0x1f1f2 :: 0x1f1f0 :: rest -> Some ("flag_mk", rest)
  | 0x1f1f2 :: 0x1f1ed :: rest -> Some ("flag_mh", rest)
  | 0x1f1f2 :: 0x1f1ec :: rest -> Some ("flag_mg", rest)
  | 0x1f1f2 :: 0x1f1eb :: rest -> Some ("flag_mf", rest)
  | 0x1f1f2 :: 0x1f1ea :: rest -> Some ("flag_me", rest)
  | 0x1f1f2 :: 0x1f1e9 :: rest -> Some ("flag_md", rest)
  | 0x1f1f2 :: 0x1f1e8 :: rest -> Some ("flag_mc", rest)
  | 0x1f1f2 :: 0x1f1e6 :: rest -> Some ("flag_ma", rest)
  | 0x1f1f2 :: rest -> Some ("regional_indicator_m", rest)
  | 0x1f1f1 :: 0x1f1fe :: rest -> Some ("flag_ly", rest)
  | 0x1f1f1 :: 0x1f1fb :: rest -> Some ("flag_lv", rest)
  | 0x1f1f1 :: 0x1f1fa :: rest -> Some ("flag_lu", rest)
  | 0x1f1f1 :: 0x1f1f9 :: rest -> Some ("flag_lt", rest)
  | 0x1f1f1 :: 0x1f1f8 :: rest -> Some ("flag_ls", rest)
  | 0x1f1f1 :: 0x1f1f7 :: rest -> Some ("flag_lr", rest)
  | 0x1f1f1 :: 0x1f1f0 :: rest -> Some ("flag_lk", rest)
  | 0x1f1f1 :: 0x1f1ee :: rest -> Some ("flag_li", rest)
  | 0x1f1f1 :: 0x1f1e8 :: rest -> Some ("flag_lc", rest)
  | 0x1f1f1 :: 0x1f1e7 :: rest -> Some ("flag_lb", rest)
  | 0x1f1f1 :: 0x1f1e6 :: rest -> Some ("flag_la", rest)
  | 0x1f1f1 :: rest -> Some ("regional_indicator_l", rest)
  | 0x1f1f0 :: 0x1f1ff :: rest -> Some ("flag_kz", rest)
  | 0x1f1f0 :: 0x1f1fe :: rest -> Some ("flag_ky", rest)
  | 0x1f1f0 :: 0x1f1fc :: rest -> Some ("flag_kw", rest)
  | 0x1f1f0 :: 0x1f1f7 :: rest -> Some ("flag_kr", rest)
  | 0x1f1f0 :: 0x1f1f5 :: rest -> Some ("flag_kp", rest)
  | 0x1f1f0 :: 0x1f1f3 :: rest -> Some ("flag_kn", rest)
  | 0x1f1f0 :: 0x1f1f2 :: rest -> Some ("flag_km", rest)
  | 0x1f1f0 :: 0x1f1ee :: rest -> Some ("flag_ki", rest)
  | 0x1f1f0 :: 0x1f1ed :: rest -> Some ("flag_kh", rest)
  | 0x1f1f0 :: 0x1f1ec :: rest -> Some ("flag_kg", rest)
  | 0x1f1f0 :: 0x1f1ea :: rest -> Some ("flag_ke", rest)
  | 0x1f1f0 :: rest -> Some ("regional_indicator_k", rest)
  | 0x1f1ef :: 0x1f1f5 :: rest -> Some ("flag_jp", rest)
  | 0x1f1ef :: 0x1f1f4 :: rest -> Some ("flag_jo", rest)
  | 0x1f1ef :: 0x1f1f2 :: rest -> Some ("flag_jm", rest)
  | 0x1f1ef :: 0x1f1ea :: rest -> Some ("flag_je", rest)
  | 0x1f1ef :: rest -> Some ("regional_indicator_j", rest)
  | 0x1f1ee :: 0x1f1f9 :: rest -> Some ("flag_it", rest)
  | 0x1f1ee :: 0x1f1f8 :: rest -> Some ("flag_is", rest)
  | 0x1f1ee :: 0x1f1f7 :: rest -> Some ("flag_ir", rest)
  | 0x1f1ee :: 0x1f1f6 :: rest -> Some ("flag_iq", rest)
  | 0x1f1ee :: 0x1f1f4 :: rest -> Some ("flag_io", rest)
  | 0x1f1ee :: 0x1f1f3 :: rest -> Some ("flag_in", rest)
  | 0x1f1ee :: 0x1f1f2 :: rest -> Some ("flag_im", rest)
  | 0x1f1ee :: 0x1f1f1 :: rest -> Some ("flag_il", rest)
  | 0x1f1ee :: 0x1f1ea :: rest -> Some ("flag_ie", rest)
  | 0x1f1ee :: 0x1f1e9 :: rest -> Some ("flag_id", rest)
  | 0x1f1ee :: 0x1f1e8 :: rest -> Some ("flag_ic", rest)
  | 0x1f1ee :: rest -> Some ("regional_indicator_i", rest)
  | 0x1f1ed :: 0x1f1fa :: rest -> Some ("flag_hu", rest)
  | 0x1f1ed :: 0x1f1f9 :: rest -> Some ("flag_ht", rest)
  | 0x1f1ed :: 0x1f1f7 :: rest -> Some ("flag_hr", rest)
  | 0x1f1ed :: 0x1f1f3 :: rest -> Some ("flag_hn", rest)
  | 0x1f1ed :: 0x1f1f2 :: rest -> Some ("flag_hm", rest)
  | 0x1f1ed :: 0x1f1f0 :: rest -> Some ("flag_hk", rest)
  | 0x1f1ed :: rest -> Some ("regional_indicator_h", rest)
  | 0x1f1ec :: 0x1f1fe :: rest -> Some ("flag_gy", rest)
  | 0x1f1ec :: 0x1f1fc :: rest -> Some ("flag_gw", rest)
  | 0x1f1ec :: 0x1f1fa :: rest -> Some ("flag_gu", rest)
  | 0x1f1ec :: 0x1f1f9 :: rest -> Some ("flag_gt", rest)
  | 0x1f1ec :: 0x1f1f8 :: rest -> Some ("flag_gs", rest)
  | 0x1f1ec :: 0x1f1f7 :: rest -> Some ("flag_gr", rest)
  | 0x1f1ec :: 0x1f1f6 :: rest -> Some ("flag_gq", rest)
  | 0x1f1ec :: 0x1f1f5 :: rest -> Some ("flag_gp", rest)
  | 0x1f1ec :: 0x1f1f3 :: rest -> Some ("flag_gn", rest)
  | 0x1f1ec :: 0x1f1f2 :: rest -> Some ("flag_gm", rest)
  | 0x1f1ec :: 0x1f1f1 :: rest -> Some ("flag_gl", rest)
  | 0x1f1ec :: 0x1f1ee :: rest -> Some ("flag_gi", rest)
  | 0x1f1ec :: 0x1f1ed :: rest -> Some ("flag_gh", rest)
  | 0x1f1ec :: 0x1f1ec :: rest -> Some ("flag_gg", rest)
  | 0x1f1ec :: 0x1f1eb :: rest -> Some ("flag_gf", rest)
  | 0x1f1ec :: 0x1f1ea :: rest -> Some ("flag_ge", rest)
  | 0x1f1ec :: 0x1f1e9 :: rest -> Some ("flag_gd", rest)
  | 0x1f1ec :: 0x1f1e7 :: rest -> Some ("flag_gb", rest)
  | 0x1f1ec :: 0x1f1e6 :: rest -> Some ("flag_ga", rest)
  | 0x1f1ec :: rest -> Some ("regional_indicator_g", rest)
  | 0x1f1eb :: 0x1f1f7 :: rest -> Some ("flag_fr", rest)
  | 0x1f1eb :: 0x1f1f4 :: rest -> Some ("flag_fo", rest)
  | 0x1f1eb :: 0x1f1f2 :: rest -> Some ("flag_fm", rest)
  | 0x1f1eb :: 0x1f1f0 :: rest -> Some ("flag_fk", rest)
  | 0x1f1eb :: 0x1f1ef :: rest -> Some ("flag_fj", rest)
  | 0x1f1eb :: 0x1f1ee :: rest -> Some ("flag_fi", rest)
  | 0x1f1eb :: rest -> Some ("regional_indicator_f", rest)
  | 0x1f1ea :: 0x1f1fa :: rest -> Some ("flag_eu", rest)
  | 0x1f1ea :: 0x1f1f9 :: rest -> Some ("flag_et", rest)
  | 0x1f1ea :: 0x1f1f8 :: rest -> Some ("flag_es", rest)
  | 0x1f1ea :: 0x1f1f7 :: rest -> Some ("flag_er", rest)
  | 0x1f1ea :: 0x1f1ed :: rest -> Some ("flag_eh", rest)
  | 0x1f1ea :: 0x1f1ec :: rest -> Some ("flag_eg", rest)
  | 0x1f1ea :: 0x1f1ea :: rest -> Some ("flag_ee", rest)
  | 0x1f1ea :: 0x1f1e8 :: rest -> Some ("flag_ec", rest)
  | 0x1f1ea :: 0x1f1e6 :: rest -> Some ("flag_ea", rest)
  | 0x1f1ea :: rest -> Some ("regional_indicator_e", rest)
  | 0x1f1e9 :: 0x1f1ff :: rest -> Some ("flag_dz", rest)
  | 0x1f1e9 :: 0x1f1f4 :: rest -> Some ("flag_do", rest)
  | 0x1f1e9 :: 0x1f1f2 :: rest -> Some ("flag_dm", rest)
  | 0x1f1e9 :: 0x1f1f0 :: rest -> Some ("flag_dk", rest)
  | 0x1f1e9 :: 0x1f1ef :: rest -> Some ("flag_dj", rest)
  | 0x1f1e9 :: 0x1f1ec :: rest -> Some ("flag_dg", rest)
  | 0x1f1e9 :: 0x1f1ea :: rest -> Some ("flag_de", rest)
  | 0x1f1e9 :: rest -> Some ("regional_indicator_d", rest)
  | 0x1f1e8 :: 0x1f1ff :: rest -> Some ("flag_cz", rest)
  | 0x1f1e8 :: 0x1f1fe :: rest -> Some ("flag_cy", rest)
  | 0x1f1e8 :: 0x1f1fd :: rest -> Some ("flag_cx", rest)
  | 0x1f1e8 :: 0x1f1fc :: rest -> Some ("flag_cw", rest)
  | 0x1f1e8 :: 0x1f1fb :: rest -> Some ("flag_cv", rest)
  | 0x1f1e8 :: 0x1f1fa :: rest -> Some ("flag_cu", rest)
  | 0x1f1e8 :: 0x1f1f7 :: rest -> Some ("flag_cr", rest)
  | 0x1f1e8 :: 0x1f1f5 :: rest -> Some ("flag_cp", rest)
  | 0x1f1e8 :: 0x1f1f4 :: rest -> Some ("flag_co", rest)
  | 0x1f1e8 :: 0x1f1f3 :: rest -> Some ("flag_cn", rest)
  | 0x1f1e8 :: 0x1f1f2 :: rest -> Some ("flag_cm", rest)
  | 0x1f1e8 :: 0x1f1f1 :: rest -> Some ("flag_cl", rest)
  | 0x1f1e8 :: 0x1f1f0 :: rest -> Some ("flag_ck", rest)
  | 0x1f1e8 :: 0x1f1ee :: rest -> Some ("flag_ci", rest)
  | 0x1f1e8 :: 0x1f1ed :: rest -> Some ("flag_ch", rest)
  | 0x1f1e8 :: 0x1f1ec :: rest -> Some ("flag_cg", rest)
  | 0x1f1e8 :: 0x1f1eb :: rest -> Some ("flag_cf", rest)
  | 0x1f1e8 :: 0x1f1e9 :: rest -> Some ("flag_cd", rest)
  | 0x1f1e8 :: 0x1f1e8 :: rest -> Some ("flag_cc", rest)
  | 0x1f1e8 :: 0x1f1e6 :: rest -> Some ("flag_ca", rest)
  | 0x1f1e8 :: rest -> Some ("regional_indicator_c", rest)
  | 0x1f1e7 :: 0x1f1ff :: rest -> Some ("flag_bz", rest)
  | 0x1f1e7 :: 0x1f1fe :: rest -> Some ("flag_by", rest)
  | 0x1f1e7 :: 0x1f1fc :: rest -> Some ("flag_bw", rest)
  | 0x1f1e7 :: 0x1f1fb :: rest -> Some ("flag_bv", rest)
  | 0x1f1e7 :: 0x1f1f9 :: rest -> Some ("flag_bt", rest)
  | 0x1f1e7 :: 0x1f1f8 :: rest -> Some ("flag_bs", rest)
  | 0x1f1e7 :: 0x1f1f7 :: rest -> Some ("flag_br", rest)
  | 0x1f1e7 :: 0x1f1f6 :: rest -> Some ("flag_bq", rest)
  | 0x1f1e7 :: 0x1f1f4 :: rest -> Some ("flag_bo", rest)
  | 0x1f1e7 :: 0x1f1f3 :: rest -> Some ("flag_bn", rest)
  | 0x1f1e7 :: 0x1f1f2 :: rest -> Some ("flag_bm", rest)
  | 0x1f1e7 :: 0x1f1f1 :: rest -> Some ("flag_bl", rest)
  | 0x1f1e7 :: 0x1f1ef :: rest -> Some ("flag_bj", rest)
  | 0x1f1e7 :: 0x1f1ee :: rest -> Some ("flag_bi", rest)
  | 0x1f1e7 :: 0x1f1ed :: rest -> Some ("flag_bh", rest)
  | 0x1f1e7 :: 0x1f1ec :: rest -> Some ("flag_bg", rest)
  | 0x1f1e7 :: 0x1f1eb :: rest -> Some ("flag_bf", rest)
  | 0x1f1e7 :: 0x1f1ea :: rest -> Some ("flag_be", rest)
  | 0x1f1e7 :: 0x1f1e9 :: rest -> Some ("flag_bd", rest)
  | 0x1f1e7 :: 0x1f1e7 :: rest -> Some ("flag_bb", rest)
  | 0x1f1e7 :: 0x1f1e6 :: rest -> Some ("flag_ba", rest)
  | 0x1f1e7 :: rest -> Some ("regional_indicator_b", rest)
  | 0x1f1e6 :: 0x1f1ff :: rest -> Some ("flag_az", rest)
  | 0x1f1e6 :: 0x1f1fd :: rest -> Some ("flag_ax", rest)
  | 0x1f1e6 :: 0x1f1fc :: rest -> Some ("flag_aw", rest)
  | 0x1f1e6 :: 0x1f1fa :: rest -> Some ("flag_au", rest)
  | 0x1f1e6 :: 0x1f1f9 :: rest -> Some ("flag_at", rest)
  | 0x1f1e6 :: 0x1f1f8 :: rest -> Some ("flag_as", rest)
  | 0x1f1e6 :: 0x1f1f7 :: rest -> Some ("flag_ar", rest)
  | 0x1f1e6 :: 0x1f1f6 :: rest -> Some ("flag_aq", rest)
  | 0x1f1e6 :: 0x1f1f4 :: rest -> Some ("flag_ao", rest)
  | 0x1f1e6 :: 0x1f1f2 :: rest -> Some ("flag_am", rest)
  | 0x1f1e6 :: 0x1f1f1 :: rest -> Some ("flag_al", rest)
  | 0x1f1e6 :: 0x1f1ee :: rest -> Some ("flag_ai", rest)
  | 0x1f1e6 :: 0x1f1ec :: rest -> Some ("flag_ag", rest)
  | 0x1f1e6 :: 0x1f1eb :: rest -> Some ("flag_af", rest)
  | 0x1f1e6 :: 0x1f1ea :: rest -> Some ("flag_ae", rest)
  | 0x1f1e6 :: 0x1f1e9 :: rest -> Some ("flag_ad", rest)
  | 0x1f1e6 :: 0x1f1e8 :: rest -> Some ("flag_ac", rest)
  | 0x1f1e6 :: rest -> Some ("regional_indicator_a", rest)
  | 0x1f19a :: rest -> Some ("vs", rest)
  | 0x1f199 :: rest -> Some ("up", rest)
  | 0x1f198 :: rest -> Some ("sos", rest)
  | 0x1f197 :: rest -> Some ("ok", rest)
  | 0x1f196 :: rest -> Some ("ng", rest)
  | 0x1f195 :: rest -> Some ("new", rest)
  | 0x1f194 :: rest -> Some ("id", rest)
  | 0x1f193 :: rest -> Some ("free", rest)
  | 0x1f192 :: rest -> Some ("cool", rest)
  | 0x1f191 :: rest -> Some ("cl", rest)
  | 0x1f18e :: rest -> Some ("ab", rest)
  | 0x1f17f :: rest -> Some ("parking", rest)
  | 0x1f17e :: rest -> Some ("o2", rest)
  | 0x1f171 :: rest -> Some ("b", rest)
  | 0x1f170 :: rest -> Some ("a", rest)
  | 0x1f0cf :: rest -> Some ("black_joker", rest)
  | 0x1f004 :: rest -> Some ("mahjong", rest)
  | 0x3299 :: rest -> Some ("secret", rest)
  | 0x3297 :: rest -> Some ("congratulations", rest)
  | 0x303d :: rest -> Some ("part_alternation_mark", rest)
  | 0x3030 :: rest -> Some ("wavy_dash", rest)
  | 0x2b55 :: rest -> Some ("o", rest)
  | 0x2b50 :: rest -> Some ("star", rest)
  | 0x2b1c :: rest -> Some ("white_large_square", rest)
  | 0x2b1b :: rest -> Some ("black_large_square", rest)
  | 0x2b07 :: rest -> Some ("arrow_down", rest)
  | 0x2b06 :: rest -> Some ("arrow_up", rest)
  | 0x2b05 :: rest -> Some ("arrow_left", rest)
  | 0x2935 :: rest -> Some ("arrow_heading_down", rest)
  | 0x2934 :: rest -> Some ("arrow_heading_up", rest)
  | 0x27bf :: rest -> Some ("loop", rest)
  | 0x27b0 :: rest -> Some ("curly_loop", rest)
  | 0x27a1 :: rest -> Some ("arrow_right", rest)
  | 0x2797 :: rest -> Some ("heavy_division_sign", rest)
  | 0x2796 :: rest -> Some ("heavy_minus_sign", rest)
  | 0x2795 :: rest -> Some ("heavy_plus_sign", rest)
  | 0x2764 :: 0xfe0f :: 0x200d :: 0x1fa79 :: rest -> Some ("mending_heart", rest)
  | 0x2764 :: 0xfe0f :: 0x200d :: 0x1f525 :: rest -> Some ("heart_on_fire", rest)
  | 0x2764 :: rest -> Some ("heart", rest)
  | 0x2763 :: rest -> Some ("heart_exclamation", rest)
  | 0x2757 :: rest -> Some ("exclamation", rest)
  | 0x2755 :: rest -> Some ("grey_exclamation", rest)
  | 0x2754 :: rest -> Some ("grey_question", rest)
  | 0x2753 :: rest -> Some ("question", rest)
  | 0x274e :: rest -> Some ("negative_squared_cross_mark", rest)
  | 0x274c :: rest -> Some ("x", rest)
  | 0x2747 :: rest -> Some ("sparkle", rest)
  | 0x2744 :: rest -> Some ("snowflake", rest)
  | 0x2734 :: rest -> Some ("eight_pointed_black_star", rest)
  | 0x2733 :: rest -> Some ("eight_spoked_asterisk", rest)
  | 0x2728 :: rest -> Some ("sparkles", rest)
  | 0x2721 :: rest -> Some ("star_of_david", rest)
  | 0x271d :: rest -> Some ("cross", rest)
  | 0x2716 :: rest -> Some ("heavy_multiplication_x", rest)
  | 0x2714 :: rest -> Some ("heavy_check_mark", rest)
  | 0x2712 :: rest -> Some ("black_nib", rest)
  | 0x270f :: rest -> Some ("pencil2", rest)
  | 0x270d :: 0x1f3ff :: rest -> Some ("writing_hand_tone5", rest)
  | 0x270d :: 0x1f3fe :: rest -> Some ("writing_hand_tone4", rest)
  | 0x270d :: 0x1f3fd :: rest -> Some ("writing_hand_tone3", rest)
  | 0x270d :: 0x1f3fc :: rest -> Some ("writing_hand_tone2", rest)
  | 0x270d :: 0x1f3fb :: rest -> Some ("writing_hand_tone1", rest)
  | 0x270d :: rest -> Some ("writing_hand", rest)
  | 0x270c :: 0x1f3ff :: rest -> Some ("v_tone5", rest)
  | 0x270c :: 0x1f3fe :: rest -> Some ("v_tone4", rest)
  | 0x270c :: 0x1f3fd :: rest -> Some ("v_tone3", rest)
  | 0x270c :: 0x1f3fc :: rest -> Some ("v_tone2", rest)
  | 0x270c :: 0x1f3fb :: rest -> Some ("v_tone1", rest)
  | 0x270c :: rest -> Some ("v", rest)
  | 0x270b :: 0x1f3ff :: rest -> Some ("raised_hand_tone5", rest)
  | 0x270b :: 0x1f3fe :: rest -> Some ("raised_hand_tone4", rest)
  | 0x270b :: 0x1f3fd :: rest -> Some ("raised_hand_tone3", rest)
  | 0x270b :: 0x1f3fc :: rest -> Some ("raised_hand_tone2", rest)
  | 0x270b :: 0x1f3fb :: rest -> Some ("raised_hand_tone1", rest)
  | 0x270b :: rest -> Some ("raised_hand", rest)
  | 0x270a :: 0x1f3ff :: rest -> Some ("fist_tone5", rest)
  | 0x270a :: 0x1f3fe :: rest -> Some ("fist_tone4", rest)
  | 0x270a :: 0x1f3fd :: rest -> Some ("fist_tone3", rest)
  | 0x270a :: 0x1f3fc :: rest -> Some ("fist_tone2", rest)
  | 0x270a :: 0x1f3fb :: rest -> Some ("fist_tone1", rest)
  | 0x270a :: rest -> Some ("fist", rest)
  | 0x2709 :: rest -> Some ("envelope", rest)
  | 0x2708 :: rest -> Some ("airplane", rest)
  | 0x2705 :: rest -> Some ("white_check_mark", rest)
  | 0x2702 :: rest -> Some ("scissors", rest)
  | 0x26fd :: rest -> Some ("fuelpump", rest)
  | 0x26fa :: rest -> Some ("tent", rest)
  | 0x26f9 :: 0x1f3ff :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_bouncing_ball_tone5", rest)
  | 0x26f9 :: 0x1f3ff :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_bouncing_ball_tone5", rest)
  | 0x26f9 :: 0x1f3ff :: rest -> Some ("person_bouncing_ball_tone5", rest)
  | 0x26f9 :: 0x1f3fe :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_bouncing_ball_tone4", rest)
  | 0x26f9 :: 0x1f3fe :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_bouncing_ball_tone4", rest)
  | 0x26f9 :: 0x1f3fe :: rest -> Some ("person_bouncing_ball_tone4", rest)
  | 0x26f9 :: 0x1f3fd :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_bouncing_ball_tone3", rest)
  | 0x26f9 :: 0x1f3fd :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_bouncing_ball_tone3", rest)
  | 0x26f9 :: 0x1f3fd :: rest -> Some ("person_bouncing_ball_tone3", rest)
  | 0x26f9 :: 0x1f3fc :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_bouncing_ball_tone2", rest)
  | 0x26f9 :: 0x1f3fc :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_bouncing_ball_tone2", rest)
  | 0x26f9 :: 0x1f3fc :: rest -> Some ("person_bouncing_ball_tone2", rest)
  | 0x26f9 :: 0x1f3fb :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_bouncing_ball_tone1", rest)
  | 0x26f9 :: 0x1f3fb :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_bouncing_ball_tone1", rest)
  | 0x26f9 :: 0x1f3fb :: rest -> Some ("person_bouncing_ball_tone1", rest)
  | 0x26f9 :: 0xfe0f :: 0x200d :: 0x2642 :: 0xfe0f :: rest ->
      Some ("man_bouncing_ball", rest)
  | 0x26f9 :: 0xfe0f :: 0x200d :: 0x2640 :: 0xfe0f :: rest ->
      Some ("woman_bouncing_ball", rest)
  | 0x26f9 :: rest -> Some ("person_bouncing_ball", rest)
  | 0x26f8 :: rest -> Some ("ice_skate", rest)
  | 0x26f7 :: rest -> Some ("skier", rest)
  | 0x26f5 :: rest -> Some ("sailboat", rest)
  | 0x26f4 :: rest -> Some ("ferry", rest)
  | 0x26f3 :: rest -> Some ("golf", rest)
  | 0x26f2 :: rest -> Some ("fountain", rest)
  | 0x26f1 :: rest -> Some ("beach_umbrella", rest)
  | 0x26f0 :: rest -> Some ("mountain", rest)
  | 0x26ea :: rest -> Some ("church", rest)
  | 0x26e9 :: rest -> Some ("shinto_shrine", rest)
  | 0x26d4 :: rest -> Some ("no_entry", rest)
  | 0x26d3 :: rest -> Some ("chains", rest)
  | 0x26d1 :: rest -> Some ("helmet_with_cross", rest)
  | 0x26cf :: rest -> Some ("pick", rest)
  | 0x26ce :: rest -> Some ("ophiuchus", rest)
  | 0x26c8 :: rest -> Some ("thunder_cloud_rain", rest)
  | 0x26c5 :: rest -> Some ("partly_sunny", rest)
  | 0x26c4 :: rest -> Some ("snowman", rest)
  | 0x26be :: rest -> Some ("baseball", rest)
  | 0x26bd :: rest -> Some ("soccer", rest)
  | 0x26b1 :: rest -> Some ("urn", rest)
  | 0x26b0 :: rest -> Some ("coffin", rest)
  | 0x26ab :: rest -> Some ("black_circle", rest)
  | 0x26aa :: rest -> Some ("white_circle", rest)
  | 0x26a7 :: rest -> Some ("transgender_symbol", rest)
  | 0x26a1 :: rest -> Some ("zap", rest)
  | 0x26a0 :: rest -> Some ("warning", rest)
  | 0x269c :: rest -> Some ("fleur-de-lis", rest)
  | 0x269b :: rest -> Some ("atom", rest)
  | 0x2699 :: rest -> Some ("gear", rest)
  | 0x2697 :: rest -> Some ("alembic", rest)
  | 0x2696 :: rest -> Some ("scales", rest)
  | 0x2695 :: rest -> Some ("medical_symbol", rest)
  | 0x2694 :: rest -> Some ("crossed_swords", rest)
  | 0x2693 :: rest -> Some ("anchor", rest)
  | 0x2692 :: rest -> Some ("hammer_pick", rest)
  | 0x267f :: rest -> Some ("wheelchair", rest)
  | 0x267e :: rest -> Some ("infinity", rest)
  | 0x267b :: rest -> Some ("recycle", rest)
  | 0x2668 :: rest -> Some ("hotsprings", rest)
  | 0x2666 :: rest -> Some ("diamonds", rest)
  | 0x2665 :: rest -> Some ("hearts", rest)
  | 0x2663 :: rest -> Some ("clubs", rest)
  | 0x2660 :: rest -> Some ("spades", rest)
  | 0x265f :: rest -> Some ("chess_pawn", rest)
  | 0x2653 :: rest -> Some ("pisces", rest)
  | 0x2652 :: rest -> Some ("aquarius", rest)
  | 0x2651 :: rest -> Some ("capricorn", rest)
  | 0x2650 :: rest -> Some ("sagittarius", rest)
  | 0x264f :: rest -> Some ("scorpius", rest)
  | 0x264e :: rest -> Some ("libra", rest)
  | 0x264d :: rest -> Some ("virgo", rest)
  | 0x264c :: rest -> Some ("leo", rest)
  | 0x264b :: rest -> Some ("cancer", rest)
  | 0x264a :: rest -> Some ("gemini", rest)
  | 0x2649 :: rest -> Some ("taurus", rest)
  | 0x2648 :: rest -> Some ("aries", rest)
  | 0x2642 :: rest -> Some ("male_sign", rest)
  | 0x2640 :: rest -> Some ("female_sign", rest)
  | 0x263a :: rest -> Some ("relaxed", rest)
  | 0x2639 :: rest -> Some ("frowning2", rest)
  | 0x2638 :: rest -> Some ("wheel_of_dharma", rest)
  | 0x262f :: rest -> Some ("yin_yang", rest)
  | 0x262e :: rest -> Some ("peace", rest)
  | 0x262a :: rest -> Some ("star_and_crescent", rest)
  | 0x2626 :: rest -> Some ("orthodox_cross", rest)
  | 0x2623 :: rest -> Some ("biohazard", rest)
  | 0x2622 :: rest -> Some ("radioactive", rest)
  | 0x2620 :: rest -> Some ("skull_crossbones", rest)
  | 0x261d :: 0x1f3ff :: rest -> Some ("point_up_tone5", rest)
  | 0x261d :: 0x1f3fe :: rest -> Some ("point_up_tone4", rest)
  | 0x261d :: 0x1f3fd :: rest -> Some ("point_up_tone3", rest)
  | 0x261d :: 0x1f3fc :: rest -> Some ("point_up_tone2", rest)
  | 0x261d :: 0x1f3fb :: rest -> Some ("point_up_tone1", rest)
  | 0x261d :: rest -> Some ("point_up", rest)
  | 0x2618 :: rest -> Some ("shamrock", rest)
  | 0x2615 :: rest -> Some ("coffee", rest)
  | 0x2614 :: rest -> Some ("umbrella", rest)
  | 0x2611 :: rest -> Some ("ballot_box_with_check", rest)
  | 0x260e :: rest -> Some ("telephone", rest)
  | 0x2604 :: rest -> Some ("comet", rest)
  | 0x2603 :: rest -> Some ("snowman2", rest)
  | 0x2602 :: rest -> Some ("umbrella2", rest)
  | 0x2601 :: rest -> Some ("cloud", rest)
  | 0x2600 :: rest -> Some ("sunny", rest)
  | 0x25fe :: rest -> Some ("black_medium_small_square", rest)
  | 0x25fd :: rest -> Some ("white_medium_small_square", rest)
  | 0x25fc :: rest -> Some ("black_medium_square", rest)
  | 0x25fb :: rest -> Some ("white_medium_square", rest)
  | 0x25c0 :: rest -> Some ("arrow_backward", rest)
  | 0x25b6 :: rest -> Some ("arrow_forward", rest)
  | 0x25ab :: rest -> Some ("white_small_square", rest)
  | 0x25aa :: rest -> Some ("black_small_square", rest)
  | 0x24c2 :: rest -> Some ("m", rest)
  | 0x23fa :: rest -> Some ("record_button", rest)
  | 0x23f9 :: rest -> Some ("stop_button", rest)
  | 0x23f8 :: rest -> Some ("pause_button", rest)
  | 0x23f3 :: rest -> Some ("hourglass_flowing_sand", rest)
  | 0x23f2 :: rest -> Some ("timer", rest)
  | 0x23f1 :: rest -> Some ("stopwatch", rest)
  | 0x23f0 :: rest -> Some ("alarm_clock", rest)
  | 0x23ef :: rest -> Some ("play_pause", rest)
  | 0x23ee :: rest -> Some ("track_previous", rest)
  | 0x23ed :: rest -> Some ("track_next", rest)
  | 0x23ec :: rest -> Some ("arrow_double_down", rest)
  | 0x23eb :: rest -> Some ("arrow_double_up", rest)
  | 0x23ea :: rest -> Some ("rewind", rest)
  | 0x23e9 :: rest -> Some ("fast_forward", rest)
  | 0x23cf :: rest -> Some ("eject", rest)
  | 0x2328 :: rest -> Some ("keyboard", rest)
  | 0x231b :: rest -> Some ("hourglass", rest)
  | 0x231a :: rest -> Some ("watch", rest)
  | 0x21aa :: rest -> Some ("arrow_right_hook", rest)
  | 0x21a9 :: rest -> Some ("leftwards_arrow_with_hook", rest)
  | 0x2199 :: rest -> Some ("arrow_lower_left", rest)
  | 0x2198 :: rest -> Some ("arrow_lower_right", rest)
  | 0x2197 :: rest -> Some ("arrow_upper_right", rest)
  | 0x2196 :: rest -> Some ("arrow_upper_left", rest)
  | 0x2195 :: rest -> Some ("arrow_up_down", rest)
  | 0x2194 :: rest -> Some ("left_right_arrow", rest)
  | 0x2139 :: rest -> Some ("information_source", rest)
  | 0x2122 :: rest -> Some ("tm", rest)
  | 0x2049 :: rest -> Some ("interrobang", rest)
  | 0x203c :: rest -> Some ("bangbang", rest)
  | 0xae :: rest -> Some ("registered", rest)
  | 0xa9 :: rest -> Some ("copyright", rest)
  | 0x39 :: 0xfe0f :: 0x20e3 :: rest -> Some ("nine", rest)
  | 0x38 :: 0xfe0f :: 0x20e3 :: rest -> Some ("eight", rest)
  | 0x37 :: 0xfe0f :: 0x20e3 :: rest -> Some ("seven", rest)
  | 0x36 :: 0xfe0f :: 0x20e3 :: rest -> Some ("six", rest)
  | 0x35 :: 0xfe0f :: 0x20e3 :: rest -> Some ("five", rest)
  | 0x34 :: 0xfe0f :: 0x20e3 :: rest -> Some ("four", rest)
  | 0x33 :: 0xfe0f :: 0x20e3 :: rest -> Some ("three", rest)
  | 0x32 :: 0xfe0f :: 0x20e3 :: rest -> Some ("two", rest)
  | 0x31 :: 0xfe0f :: 0x20e3 :: rest -> Some ("one", rest)
  | 0x30 :: 0xfe0f :: 0x20e3 :: rest -> Some ("zero", rest)
  | 0x2a :: 0xfe0f :: 0x20e3 :: rest -> Some ("asterisk", rest)
  | 0x23 :: 0xfe0f :: 0x20e3 :: rest -> Some ("hash", rest)
  | _ -> None
