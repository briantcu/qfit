--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.0
-- Dumped by pg_dump version 9.5.1

-- Started on 2016-10-04 20:37:03 PDT

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET search_path = public, pg_catalog;

--
-- TOC entry 2587 (class 0 OID 93911)
-- Dependencies: 181
-- Data for Name: day_exercises; Type: TABLE DATA; Schema: public; Owner: brianregan
--

INSERT INTO day_exercises VALUES (1, 1, 1, NULL, NULL);
INSERT INTO day_exercises VALUES (2, 1, 3, NULL, NULL);
INSERT INTO day_exercises VALUES (3, 1, 4, NULL, NULL);
INSERT INTO day_exercises VALUES (4, 1, 7, NULL, NULL);
INSERT INTO day_exercises VALUES (5, 1, 10, NULL, NULL);
INSERT INTO day_exercises VALUES (6, 1, 9, NULL, NULL);
INSERT INTO day_exercises VALUES (7, 1, 12, NULL, NULL);
INSERT INTO day_exercises VALUES (8, 1, 14, NULL, NULL);
INSERT INTO day_exercises VALUES (9, 2, 1, NULL, NULL);
INSERT INTO day_exercises VALUES (10, 2, 2, NULL, NULL);
INSERT INTO day_exercises VALUES (11, 2, 5, NULL, NULL);
INSERT INTO day_exercises VALUES (12, 2, 6, NULL, NULL);
INSERT INTO day_exercises VALUES (13, 2, 11, NULL, NULL);
INSERT INTO day_exercises VALUES (14, 2, 8, NULL, NULL);
INSERT INTO day_exercises VALUES (15, 2, 13, NULL, NULL);
INSERT INTO day_exercises VALUES (16, 2, 14, NULL, NULL);
INSERT INTO day_exercises VALUES (17, 3, 1, NULL, NULL);
INSERT INTO day_exercises VALUES (18, 3, 3, NULL, NULL);
INSERT INTO day_exercises VALUES (19, 3, 6, NULL, NULL);
INSERT INTO day_exercises VALUES (20, 3, 9, NULL, NULL);
INSERT INTO day_exercises VALUES (21, 3, 14, NULL, NULL);
INSERT INTO day_exercises VALUES (22, 4, 1, NULL, NULL);
INSERT INTO day_exercises VALUES (23, 4, 4, NULL, NULL);
INSERT INTO day_exercises VALUES (24, 4, 11, NULL, NULL);
INSERT INTO day_exercises VALUES (25, 4, 12, NULL, NULL);
INSERT INTO day_exercises VALUES (26, 4, 14, NULL, NULL);
INSERT INTO day_exercises VALUES (27, 5, 1, NULL, NULL);
INSERT INTO day_exercises VALUES (28, 5, 2, NULL, NULL);
INSERT INTO day_exercises VALUES (29, 5, 7, NULL, NULL);
INSERT INTO day_exercises VALUES (30, 5, 8, NULL, NULL);
INSERT INTO day_exercises VALUES (31, 5, 14, NULL, NULL);
INSERT INTO day_exercises VALUES (32, 6, 1, NULL, NULL);
INSERT INTO day_exercises VALUES (33, 6, 5, NULL, NULL);
INSERT INTO day_exercises VALUES (34, 6, 10, NULL, NULL);
INSERT INTO day_exercises VALUES (35, 6, 13, NULL, NULL);
INSERT INTO day_exercises VALUES (36, 6, 14, NULL, NULL);
INSERT INTO day_exercises VALUES (37, 7, 1, NULL, NULL);
INSERT INTO day_exercises VALUES (38, 7, 3, NULL, NULL);
INSERT INTO day_exercises VALUES (39, 7, 4, NULL, NULL);
INSERT INTO day_exercises VALUES (40, 7, 2, NULL, NULL);
INSERT INTO day_exercises VALUES (41, 7, 5, NULL, NULL);
INSERT INTO day_exercises VALUES (42, 7, 14, NULL, NULL);
INSERT INTO day_exercises VALUES (43, 8, 7, NULL, NULL);
INSERT INTO day_exercises VALUES (44, 8, 10, NULL, NULL);
INSERT INTO day_exercises VALUES (45, 8, 9, NULL, NULL);
INSERT INTO day_exercises VALUES (46, 8, 12, NULL, NULL);
INSERT INTO day_exercises VALUES (47, 8, 6, NULL, NULL);
INSERT INTO day_exercises VALUES (48, 8, 11, NULL, NULL);
INSERT INTO day_exercises VALUES (49, 8, 8, NULL, NULL);
INSERT INTO day_exercises VALUES (50, 8, 13, NULL, NULL);
INSERT INTO day_exercises VALUES (51, 8, 14, NULL, NULL);
INSERT INTO day_exercises VALUES (52, 9, 1, NULL, NULL);
INSERT INTO day_exercises VALUES (53, 9, 5, NULL, NULL);
INSERT INTO day_exercises VALUES (54, 9, 2, NULL, NULL);
INSERT INTO day_exercises VALUES (55, 9, 4, NULL, NULL);
INSERT INTO day_exercises VALUES (56, 9, 3, NULL, NULL);
INSERT INTO day_exercises VALUES (57, 9, 14, NULL, NULL);
INSERT INTO day_exercises VALUES (58, 10, 8, NULL, NULL);
INSERT INTO day_exercises VALUES (59, 10, 13, NULL, NULL);
INSERT INTO day_exercises VALUES (60, 10, 6, NULL, NULL);
INSERT INTO day_exercises VALUES (61, 10, 11, NULL, NULL);
INSERT INTO day_exercises VALUES (62, 10, 9, NULL, NULL);
INSERT INTO day_exercises VALUES (63, 10, 12, NULL, NULL);
INSERT INTO day_exercises VALUES (64, 10, 7, NULL, NULL);
INSERT INTO day_exercises VALUES (65, 10, 10, NULL, NULL);
INSERT INTO day_exercises VALUES (66, 10, 14, NULL, NULL);


--
-- TOC entry 2626 (class 0 OID 0)
-- Dependencies: 180
-- Name: day_exercises_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brianregan
--

SELECT pg_catalog.setval('day_exercises_id_seq', 66, true);


--
-- TOC entry 2589 (class 0 OID 93919)
-- Dependencies: 183
-- Data for Name: exercise_types; Type: TABLE DATA; Schema: public; Owner: brianregan
--

INSERT INTO exercise_types VALUES (1, 'Power', NULL, NULL);
INSERT INTO exercise_types VALUES (2, 'Knee Single', NULL, NULL);
INSERT INTO exercise_types VALUES (3, 'Knee Dual', NULL, NULL);
INSERT INTO exercise_types VALUES (4, 'Hip Single', NULL, NULL);
INSERT INTO exercise_types VALUES (5, 'Hip Dual', NULL, NULL);
INSERT INTO exercise_types VALUES (6, 'Horizontal Push Single', NULL, NULL);
INSERT INTO exercise_types VALUES (7, 'Horizontal Push Dual', NULL, NULL);
INSERT INTO exercise_types VALUES (8, 'Vert Push Single', NULL, NULL);
INSERT INTO exercise_types VALUES (9, 'Vert Push Dual', NULL, NULL);
INSERT INTO exercise_types VALUES (10, 'Horizontal Pull Single', NULL, NULL);
INSERT INTO exercise_types VALUES (11, 'Horizontal Pull Dual', NULL, NULL);
INSERT INTO exercise_types VALUES (12, 'Vert Pull Single', NULL, NULL);
INSERT INTO exercise_types VALUES (13, 'Vert Pull Dual', NULL, NULL);
INSERT INTO exercise_types VALUES (14, 'Core, Rotational', NULL, NULL);
INSERT INTO exercise_types VALUES (15, 'Core, Bridging', NULL, NULL);
INSERT INTO exercise_types VALUES (16, 'Core', NULL, NULL);


--
-- TOC entry 2627 (class 0 OID 0)
-- Dependencies: 182
-- Name: exercise_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brianregan
--

SELECT pg_catalog.setval('exercise_types_id_seq', 16, true);


--
-- TOC entry 2591 (class 0 OID 93927)
-- Dependencies: 185
-- Data for Name: exercises; Type: TABLE DATA; Schema: public; Owner: brianregan
--

INSERT INTO exercises VALUES (30, 4, '176557666', NULL, NULL, 3, 2, false, 'Single Leg Swiss Ball Pull In', false, NULL, '2016-10-04 19:40:06.112462', 1, false, 'http://i.vimeocdn.com/video/583834661_200x150.jpg');
INSERT INTO exercises VALUES (33, 6, '176557647', 2, 0.400000000000000022, 2, 1, false, 'One Arm Dumbbell Decline Press', false, NULL, '2016-10-04 19:40:06.539226', 1, false, 'http://i.vimeocdn.com/video/583835031_200x150.jpg');
INSERT INTO exercises VALUES (38, 6, '176552770', 2, 0.450000000000000011, 2, 1, false, 'Dumbbell Bench Press', false, NULL, '2016-10-04 19:40:07.136604', 1, false, 'http://i.vimeocdn.com/video/583829022_200x150.jpg');
INSERT INTO exercises VALUES (40, 6, '176552772', 2, 0.400000000000000022, 2, 1, false, 'Dumbbell Decline Press', false, NULL, '2016-10-04 19:40:07.432026', 1, false, 'http://i.vimeocdn.com/video/583829790_200x150.jpg');
INSERT INTO exercises VALUES (49, 7, '176552758', 2, 0.890000000000000013, 1, 1, false, 'Decline Press', false, NULL, '2016-10-04 19:40:08.727494', 1, false, 'http://i.vimeocdn.com/video/583829775_200x150.jpg');
INSERT INTO exercises VALUES (52, 7, '176552759', 2, 0.770000000000000018, 1, 1, false, 'Close Grip Decline Press', false, NULL, '2016-10-04 19:40:09.154115', 1, false, 'http://i.vimeocdn.com/video/583829422_200x150.jpg');
INSERT INTO exercises VALUES (55, 7, '176552762', NULL, NULL, 3, 1, true, 'Decline Pushup', false, NULL, '2016-10-04 19:40:09.593201', 1, false, 'http://i.vimeocdn.com/video/583829526_200x150.jpg');
INSERT INTO exercises VALUES (58, 7, '185273468', 2, 1.25, 7, 2, true, 'Assisted Dip', false, NULL, '2016-10-04 19:40:10.025504', 1, false, 'http://i.vimeocdn.com/video/594974374_200x150.jpg');
INSERT INTO exercises VALUES (64, 9, '176557785', 2, 0.599999999999999978, 1, 1, false, 'Shoulder Press', false, NULL, '2016-10-04 19:40:10.87073', 1, false, 'http://i.vimeocdn.com/video/583834774_200x150.jpg');
INSERT INTO exercises VALUES (69, 10, '176550346', 3, 0.540000000000000036, 2, 1, false, 'Bent Over Dumbbell Alternating Row', false, NULL, '2016-10-04 19:40:11.613984', 1, false, 'http://i.vimeocdn.com/video/583824701_200x150.jpg');
INSERT INTO exercises VALUES (72, 10, '176557648', NULL, NULL, 3, 1, false, 'Horizontal Side To Side Pullup', false, NULL, '2016-10-04 19:40:12.318563', 1, false, 'http://i.vimeocdn.com/video/583834373_200x150.jpg');
INSERT INTO exercises VALUES (80, 12, '176557653', 3, 0.719999999999999973, 7, 1, false, 'Single Arm Pulldown', false, NULL, '2016-10-04 19:40:13.941831', 1, false, 'http://i.vimeocdn.com/video/583835061_200x150.jpg');
INSERT INTO exercises VALUES (83, 13, '176552752', NULL, NULL, 3, 2, true, 'Chinup', false, NULL, '2016-10-04 19:40:14.366814', 1, false, 'http://i.vimeocdn.com/video/583829431_200x150.jpg');
INSERT INTO exercises VALUES (88, 14, '185274402', 2, 0.100000000000000006, 9, 1, false, 'Swiss Ball Weight Roll', false, NULL, '2016-10-04 19:40:15.084898', 1, false, 'http://i.vimeocdn.com/video/594976281_200x150.jpg');
INSERT INTO exercises VALUES (93, 14, '83077933', 2, 0.910000000000000031, 7, 1, false, 'Cable Rotating Crunch', false, NULL, '2016-10-04 19:40:15.759047', 1, false, 'http://i.vimeocdn.com/video/459558576_200x150.jpg');
INSERT INTO exercises VALUES (96, 14, '185274384', 2, 1, 6, 1, false, 'Medicine Ball 1-2-3 Throw', false, NULL, '2016-10-04 19:40:16.186595', 1, false, 'http://i.vimeocdn.com/video/594973275_200x150.jpg');
INSERT INTO exercises VALUES (99, 15, '176550351', NULL, NULL, 4, 1, false, '3 Point Plank', false, NULL, '2016-10-04 19:40:16.628162', 1, true, 'http://i.vimeocdn.com/video/583824745_200x150.jpg');
INSERT INTO exercises VALUES (101, 15, '176557788', NULL, NULL, 4, 1, false, 'Side Plank', false, NULL, '2016-10-04 19:40:16.895237', 1, true, 'http://i.vimeocdn.com/video/583834956_200x150.jpg');
INSERT INTO exercises VALUES (108, 15, '176550355', NULL, NULL, 4, 2, false, 'Barbell Rollout', false, NULL, '2016-10-04 19:40:17.943811', 1, false, 'http://i.vimeocdn.com/video/583824862_200x150.jpg');
INSERT INTO exercises VALUES (109, 16, '176552767', NULL, NULL, 3, 1, false, 'Double Crunch', false, NULL, '2016-10-04 19:40:18.113511', 1, false, 'http://i.vimeocdn.com/video/583828410_200x150.jpg');
INSERT INTO exercises VALUES (114, 16, '185274401', NULL, NULL, 3, 1, false, 'Swiss Ball Crunch', false, NULL, '2016-10-04 19:40:18.854879', 1, false, 'http://i.vimeocdn.com/video/594974008_200x150.jpg');
INSERT INTO exercises VALUES (119, 7, '176550405', NULL, NULL, 3, 1, true, 'Assisted Pushup', false, NULL, '2016-10-04 19:40:19.557501', 1, false, 'http://i.vimeocdn.com/video/583824850_200x150.jpg');
INSERT INTO exercises VALUES (121, 11, '176557786', 3, 1, 7, 1, false, 'Seated Cable Row', false, NULL, '2016-10-04 19:40:19.835574', 1, false, 'http://i.vimeocdn.com/video/583835160_200x150.jpg');
INSERT INTO exercises VALUES (130, 9, '185274698', 2, 0.479999999999999982, 1, 2, false, 'Split Push Press', false, NULL, '2016-10-04 19:40:21.109124', 1, false, 'http://i.vimeocdn.com/video/594975294_200x150.jpg');
INSERT INTO exercises VALUES (132, 13, '185273467', 3, 1.30000000000000004, 7, 1, true, 'Assisted Wide Grip Pullup', false, NULL, '2016-10-04 19:40:21.385286', 1, false, 'http://i.vimeocdn.com/video/594971055_200x150.jpg');
INSERT INTO exercises VALUES (135, 13, '176556419', 3, 1.5, 8, 3, true, 'Wide Grip Pullup With Weight Belt', false, NULL, '2016-10-04 19:40:21.806107', 1, false, 'http://i.vimeocdn.com/video/583832847_200x150.jpg');
INSERT INTO exercises VALUES (139, 11, '176551435', NULL, NULL, 4, 1, false, 'Battleropes Side to Side', false, NULL, '2016-10-04 19:40:23.101563', 2, true, 'http://i.vimeocdn.com/video/583826091_200x150.jpg');
INSERT INTO exercises VALUES (191, 11, '176550401', 3, 1, 7, 1, false, 'Angled Cable Row', false, NULL, '2016-10-04 19:40:22.235723', 1, false, 'http://i.vimeocdn.com/video/583824893_200x150.jpg');
INSERT INTO exercises VALUES (194, 11, '176551431', NULL, NULL, 4, 1, false, 'Battleropes Front Raises', false, NULL, '2016-10-04 19:40:22.677565', 1, true, 'http://i.vimeocdn.com/video/583825962_200x150.jpg');
INSERT INTO exercises VALUES (77, 11, '176553008', NULL, NULL, 3, 2, false, 'Elevated Horizontal Pullup', false, NULL, '2016-10-04 19:40:13.422877', 2, false, 'http://i.vimeocdn.com/video/583829779_200x150.jpg');
INSERT INTO exercises VALUES (141, 1, '176551437', NULL, NULL, 4, 1, false, 'Battleropes Slams', false, NULL, '2016-10-04 19:40:23.393604', 1, true, 'http://i.vimeocdn.com/video/583826172_200x150.jpg');
INSERT INTO exercises VALUES (145, 15, '176551450', NULL, NULL, 4, 1, false, 'Bosu Plank 1', false, NULL, '2016-10-04 19:40:23.962422', 1, true, 'http://i.vimeocdn.com/video/583826793_200x150.jpg');
INSERT INTO exercises VALUES (43, 6, '176550399', 2, 0.299999999999999989, 2, 1, false, 'Alternating Dumbbell Decline Press', false, NULL, '2016-10-04 19:40:07.872485', 2, false, 'http://i.vimeocdn.com/video/583824878_200x150.jpg');
INSERT INTO exercises VALUES (151, 14, '185275112', 3, 0.599999999999999978, 7, 1, false, 'Cable Core Anti Rotation', false, NULL, '2016-10-04 19:40:24.687132', 1, true, 'http://i.vimeocdn.com/video/594976302_200x150.jpg');
INSERT INTO exercises VALUES (153, 2, '185275139', 1, 0.299999999999999989, 1, 2, false, 'Dumbbell Bulgarian Split Squat', false, NULL, '2016-10-04 19:40:24.974082', 1, false, 'http://i.vimeocdn.com/video/594974785_200x150.jpg');
INSERT INTO exercises VALUES (127, 1, '185274411', 2, 0.599999999999999978, 1, 3, false, 'Power Clean And Press', false, NULL, '2016-10-04 19:40:20.683615', 2, false, 'http://i.vimeocdn.com/video/594970902_200x150.jpg');
INSERT INTO exercises VALUES (124, 2, '176552776', 1, 0.23000000000000001, 2, 2, false, 'Dumbbell Lateral Stepup', false, NULL, '2016-10-04 19:40:20.264082', 2, false, 'http://i.vimeocdn.com/video/583829209_200x150.jpg');
INSERT INTO exercises VALUES (31, 5, '185274518', 1, 0.770000000000000018, 1, 1, false, 'Romanian Deadlift', false, NULL, '2016-10-04 19:40:06.250689', 2, false, 'http://i.vimeocdn.com/video/594975407_200x150.jpg');
INSERT INTO exercises VALUES (46, 6, '176557652', 2, 0.520000000000000018, 7, 1, false, 'One Arm Cable Chest Press', false, NULL, '2016-10-04 19:40:08.292989', 2, false, 'http://i.vimeocdn.com/video/583834960_200x150.jpg');
INSERT INTO exercises VALUES (147, 6, '176551452', NULL, NULL, 3, 1, false, 'Bosu Pushup', false, NULL, '2016-10-04 19:40:24.25324', 2, false, 'http://i.vimeocdn.com/video/583826727_200x150.jpg');
INSERT INTO exercises VALUES (60, 8, '176552769', 2, 0.25, 2, 1, false, 'Dumbbell Alternating Press', false, NULL, '2016-10-04 19:40:10.316644', 2, false, 'http://i.vimeocdn.com/video/583829468_200x150.jpg');
INSERT INTO exercises VALUES (66, 9, '176556604', 2, 0.349999999999999978, 1, 3, false, 'Split Jerk', false, NULL, '2016-10-04 19:40:11.165813', 2, false, 'http://i.vimeocdn.com/video/583832805_200x150.jpg');
INSERT INTO exercises VALUES (156, 10, '176553009', NULL, NULL, 3, 2, false, 'Elevated Horizontal Side to Side Pullup', false, NULL, '2016-10-04 19:40:25.404624', 2, false, 'http://i.vimeocdn.com/video/583829248_200x150.jpg');
INSERT INTO exercises VALUES (85, 13, '176556421', NULL, NULL, 3, 2, true, 'Wide Grip Pullup', false, NULL, '2016-10-04 19:40:14.656077', 2, false, 'http://i.vimeocdn.com/video/583832991_200x150.jpg');
INSERT INTO exercises VALUES (90, 14, '185273659', 2, 0.419999999999999984, 7, 1, false, 'Cable Rotation', false, NULL, '2016-10-04 19:40:15.358979', 2, false, 'http://i.vimeocdn.com/video/594970355_200x150.jpg');
INSERT INTO exercises VALUES (106, 15, '176557789', NULL, NULL, 4, 2, false, 'Side Plank Complex', false, NULL, '2016-10-04 19:40:17.646403', 2, true, 'http://i.vimeocdn.com/video/583835380_200x150.jpg');
INSERT INTO exercises VALUES (104, 15, '176553007', NULL, NULL, 4, 2, false, 'Dynamic Plank', false, NULL, '2016-10-04 19:40:17.340977', 2, true, 'http://i.vimeocdn.com/video/583829651_200x150.jpg');
INSERT INTO exercises VALUES (23, 3, '185274399', 2, 0.25, 1, 3, false, 'Overhead Squat', false, NULL, '2016-10-04 19:40:05.083587', 2, false, 'http://i.vimeocdn.com/video/594974053_200x150.jpg');
INSERT INTO exercises VALUES (24, 3, '176556605', 1, 0.719999999999999973, 1, 1, false, 'Split Squat', false, NULL, '2016-10-04 19:40:05.224768', 2, false, 'http://i.vimeocdn.com/video/583832976_200x150.jpg');
INSERT INTO exercises VALUES (3, 1, '176556603', 1, 0.680000000000000049, 1, 2, false, 'Snatch Pull', false, NULL, '2016-10-04 19:40:01.582292', 1, false, 'http://i.vimeocdn.com/video/583832954_200x150.jpg');
INSERT INTO exercises VALUES (2, 1, '176556418', 1, 0.25, 1, 2, false, 'Squat Jump', false, NULL, '2016-10-04 19:40:01.432209', 2, false, 'http://i.vimeocdn.com/video/583832696_200x150.jpg');
INSERT INTO exercises VALUES (1, 1, '176552753', 1, 0.650000000000000022, 1, 2, false, 'Clean Pull', false, NULL, '2016-10-04 19:40:01.260818', 2, false, 'http://i.vimeocdn.com/video/583828757_200x150.jpg');
INSERT INTO exercises VALUES (7, 1, '176556601', 1, 0.57999999999999996, 1, 2, false, 'Snatch High Pull', false, NULL, '2016-10-04 19:40:02.226852', 1, false, 'http://i.vimeocdn.com/video/583832980_200x150.jpg');
INSERT INTO exercises VALUES (8, 1, '185274189', 1, 0.479999999999999982, 1, 3, false, 'Hang Power Clean', false, NULL, '2016-10-04 19:40:02.370043', 1, false, 'http://i.vimeocdn.com/video/594973043_200x150.jpg');
INSERT INTO exercises VALUES (9, 1, '176555130', 1, 0.479999999999999982, 1, 3, false, 'Hang Power Snatch', false, NULL, '2016-10-04 19:40:02.851267', 1, false, 'http://i.vimeocdn.com/video/583830745_200x150.jpg');
INSERT INTO exercises VALUES (10, 1, '176557763', 1, 0.479999999999999982, 1, 3, false, 'Power Clean', false, NULL, '2016-10-04 19:40:02.996516', 1, false, 'http://i.vimeocdn.com/video/583835049_200x150.jpg');
INSERT INTO exercises VALUES (11, 1, '176557766', 1, 0.479999999999999982, 1, 3, false, 'Power Snatch', false, NULL, '2016-10-04 19:40:03.155143', 1, false, 'http://i.vimeocdn.com/video/583835334_200x150.jpg');
INSERT INTO exercises VALUES (12, 2, '185273551', 1, 0.479999999999999982, 1, 1, false, 'Forward Lunge', false, NULL, '2016-10-04 19:40:03.290753', 1, false, 'http://i.vimeocdn.com/video/594972996_200x150.jpg');
INSERT INTO exercises VALUES (13, 2, '185273566', 1, 0.5, 1, 1, false, 'Reverse Lunge', false, NULL, '2016-10-04 19:40:03.4295', 1, false, 'http://i.vimeocdn.com/video/594968942_200x150.jpg');
INSERT INTO exercises VALUES (29, 4, '176557658', NULL, NULL, 3, 1, false, 'Single Leg Hip Extension', false, NULL, '2016-10-04 19:40:05.967912', 2, false, 'http://i.vimeocdn.com/video/583834812_200x150.jpg');
INSERT INTO exercises VALUES (26, 4, '176557656', 1, 0.440000000000000002, 1, 3, false, 'Single Leg Good Morning', false, NULL, '2016-10-04 19:40:05.527694', 2, false, 'http://i.vimeocdn.com/video/583834546_200x150.jpg');
INSERT INTO exercises VALUES (16, 2, '83085721', 1, 0.550000000000000044, 1, 1, false, 'Stepup', false, NULL, '2016-10-04 19:40:03.866046', 1, false, 'http://i.vimeocdn.com/video/459562825_200x150.jpg');
INSERT INTO exercises VALUES (17, 2, '185274379', 1, 0.550000000000000044, 1, 2, false, 'Lateral Stepup', false, NULL, '2016-10-04 19:40:04.006136', 1, false, 'http://i.vimeocdn.com/video/594973625_200x150.jpg');
INSERT INTO exercises VALUES (18, 2, '185273658', 1, 0.479999999999999982, 1, 1, false, 'Bulgarian Split Squat', false, NULL, '2016-10-04 19:40:04.361582', 1, false, 'http://i.vimeocdn.com/video/594971232_200x150.jpg');
INSERT INTO exercises VALUES (19, 2, '185273657', 1, 0.489999999999999991, 1, 1, false, 'Bulgarian Split Deadlift', false, NULL, '2016-10-04 19:40:04.507924', 1, false, 'http://i.vimeocdn.com/video/594971146_200x150.jpg');
INSERT INTO exercises VALUES (20, 2, '185274640', 1, 0.320000000000000007, 1, 3, false, 'Single Leg Squats', false, NULL, '2016-10-04 19:40:04.642222', 1, false, 'http://i.vimeocdn.com/video/594973354_200x150.jpg');
INSERT INTO exercises VALUES (21, 3, '176556607', 1, 1, 1, 1, false, 'Squat', false, NULL, '2016-10-04 19:40:04.801659', 1, false, 'http://i.vimeocdn.com/video/583832971_200x150.jpg');
INSERT INTO exercises VALUES (22, 3, '176553013', 1, 0.619999999999999996, 1, 2, false, 'Front Squat', false, NULL, '2016-10-04 19:40:04.943152', 1, false, 'http://i.vimeocdn.com/video/583829438_200x150.jpg');
INSERT INTO exercises VALUES (181, 6, '176556401', NULL, NULL, 3, 1, false, 'TRX French Curl', false, NULL, '2016-10-04 19:40:29.346821', 2, false, 'http://i.vimeocdn.com/video/583832511_200x150.jpg');
INSERT INTO exercises VALUES (161, 7, '185333821', NULL, NULL, 6, 1, false, 'Kneeling Med Ball Wall Blasts', false, NULL, '2016-10-04 19:40:26.108035', 2, false, 'http://i.vimeocdn.com/video/595058884_200x150.jpg');
INSERT INTO exercises VALUES (25, 3, '176557643', 1, 0.489999999999999991, 1, 1, false, 'Side Squat', false, NULL, '2016-10-04 19:40:05.36896', 1, false, 'http://i.vimeocdn.com/video/583834025_200x150.jpg');
INSERT INTO exercises VALUES (179, 16, '176556400', NULL, NULL, 4, 2, false, 'TRX Ab Complex', false, NULL, '2016-10-04 19:40:28.666164', 2, true, 'http://i.vimeocdn.com/video/583832776_200x150.jpg');
INSERT INTO exercises VALUES (27, 4, '176557668', 1, 0.359999999999999987, 1, 2, false, 'Single Leg Romanian Deadlift', false, NULL, '2016-10-04 19:40:05.680692', 1, false, 'http://i.vimeocdn.com/video/583834226_200x150.jpg');
INSERT INTO exercises VALUES (28, 4, '176557654', 1, 0.149999999999999994, 9, 1, false, 'Single Leg Back Extension', false, NULL, '2016-10-04 19:40:05.823076', 1, false, 'http://i.vimeocdn.com/video/583834617_200x150.jpg');
INSERT INTO exercises VALUES (14, 2, '185273568', 1, 0.479999999999999982, 1, 1, false, 'Side Lunge', false, NULL, '2016-10-04 19:40:03.56505', 2, false, 'http://i.vimeocdn.com/video/594973626_200x150.jpg');
INSERT INTO exercises VALUES (6, 1, '185274266', 1, 0.57999999999999996, 1, 2, false, 'Clean High Pull', false, NULL, NULL, 1, false, 'http://i.vimeocdn.com/video/594974448_200x150.jpg');
INSERT INTO exercises VALUES (164, 14, '185430959', NULL, NULL, 6, 1, false, 'Med Ball Front Rotation', false, NULL, '2016-10-04 19:40:26.496485', 1, false, 'http://i.vimeocdn.com/video/595176864_200x150.jpg');
INSERT INTO exercises VALUES (195, 2, '185567184', 2, 0.25, 2, 3, false, 'Dumbbel Stepup with Press', false, NULL, '2016-10-04 23:02:23.902652', 2, false, 'http://i.vimeocdn.com/video/595349430_200x150.jpg');
INSERT INTO exercises VALUES (167, 15, '185334194', NULL, NULL, 4, 2, false, 'One Arm Bosu Plank', false, NULL, '2016-10-04 19:40:26.91447', 1, true, 'http://i.vimeocdn.com/video/595058995_200x150.jpg');
INSERT INTO exercises VALUES (172, 16, '176557787', NULL, NULL, 3, 1, false, 'Side Crunch', false, NULL, '2016-10-04 19:40:27.643523', 1, false, 'http://i.vimeocdn.com/video/583835201_200x150.jpg');
INSERT INTO exercises VALUES (174, 16, '176556615', NULL, NULL, 6, 2, false, 'Suitcase Crunch with Med Ball', false, NULL, '2016-10-04 19:40:27.94794', 1, false, 'http://i.vimeocdn.com/video/583832707_200x150.jpg');
INSERT INTO exercises VALUES (177, 1, '176556397', 1, 0.5, 1, 2, false, 'Sumo Deadlift', false, NULL, '2016-10-04 19:40:28.385372', 1, false, 'http://i.vimeocdn.com/video/583833222_200x150.jpg');
INSERT INTO exercises VALUES (169, 15, '185334202', NULL, NULL, 4, 2, false, 'Swiss Ball Plank Complex', false, NULL, '2016-10-04 19:40:27.183734', 1, true, 'http://i.vimeocdn.com/video/595057692_200x150.jpg');
INSERT INTO exercises VALUES (159, 1, '185333812', 2, 0.23000000000000001, 2, 3, false, 'Kettlebell Snatch', false, NULL, '2016-10-04 19:40:25.84028', 2, false, 'http://i.vimeocdn.com/video/595055483_200x150.jpg');
INSERT INTO exercises VALUES (5, 1, '176552965', 1, 0.709999999999999964, 1, 2, false, 'Hang Jump Shrug', false, NULL, '2016-10-04 19:40:01.902787', 2, false, 'http://i.vimeocdn.com/video/583829428_200x150.jpg');
INSERT INTO exercises VALUES (4, 1, '176553001', 2, 0.23000000000000001, 2, 2, false, 'One Arm Dumbbell Snatch', false, NULL, '2016-10-04 19:40:01.731366', 2, false, 'http://i.vimeocdn.com/video/583829036_200x150.jpg');
INSERT INTO exercises VALUES (15, 2, '176552768', 1, 0.520000000000000018, 1, 2, false, 'Drop Lunge', false, NULL, '2016-10-04 19:40:03.71343', 2, false, 'http://i.vimeocdn.com/video/583829447_200x150.jpg');
INSERT INTO exercises VALUES (184, 2, '176556409', NULL, NULL, 3, 2, false, 'TRX Single Leg Lunge', false, NULL, '2016-10-04 19:40:29.647791', 2, false, 'http://i.vimeocdn.com/video/583832946_200x150.jpg');
INSERT INTO exercises VALUES (32, 5, '176552963', 1, 0.550000000000000044, 1, 1, false, 'Good Morning', false, NULL, '2016-10-04 19:40:06.398782', 1, false, 'http://i.vimeocdn.com/video/583829167_200x150.jpg');
INSERT INTO exercises VALUES (41, 6, '176550357', 2, 0.450000000000000011, 2, 1, false, 'Alternating Dumbbell Bench Press', false, NULL, '2016-10-04 19:40:07.573562', 2, false, 'http://i.vimeocdn.com/video/583824860_200x150.jpg');
INSERT INTO exercises VALUES (35, 5, '176553011', NULL, NULL, 3, 1, false, 'Supine Hip Extension', false, NULL, '2016-10-04 19:40:06.827387', 1, false, 'http://i.vimeocdn.com/video/583829268_200x150.jpg');
INSERT INTO exercises VALUES (36, 5, '176556396', NULL, NULL, 3, 1, false, 'Swiss Ball Pull In', false, NULL, '2016-10-04 19:40:06.983199', 1, false, 'http://i.vimeocdn.com/video/583832311_200x150.jpg');
INSERT INTO exercises VALUES (39, 6, '176552775', 2, 0.299999999999999989, 2, 1, false, 'Dumbbell Incline Press', false, NULL, '2016-10-04 19:40:07.276076', 1, false, 'http://i.vimeocdn.com/video/583829534_200x150.jpg');
INSERT INTO exercises VALUES (42, 6, '176550400', 2, 0.270000000000000018, 2, 1, false, 'Alternating Dumbbell Incline Press', false, NULL, '2016-10-04 19:40:07.73125', 2, false, 'http://i.vimeocdn.com/video/583824889_200x150.jpg');
INSERT INTO exercises VALUES (44, 6, '176557645', 2, 0.450000000000000011, 2, 1, false, 'One Arm Dumbbell Bench Press', false, NULL, '2016-10-04 19:40:08.022536', 2, false, 'http://i.vimeocdn.com/video/583835097_200x150.jpg');
INSERT INTO exercises VALUES (50, 7, '176552755', 2, 0.869999999999999996, 1, 1, false, 'Close Grip Bench Press', false, NULL, '2016-10-04 19:40:08.86391', 2, false, 'http://i.vimeocdn.com/video/583829768_200x150.jpg');
INSERT INTO exercises VALUES (45, 6, '176552775', 2, 0.299999999999999989, 2, 1, false, 'One Arm Dumbbell Incline Press', false, NULL, '2016-10-04 19:40:08.1515', 1, false, 'http://i.vimeocdn.com/video/583829534_200x150.jpg');
INSERT INTO exercises VALUES (51, 7, '185274370', 2, 0.67000000000000004, 1, 1, false, 'Close Grip Incline Press', false, NULL, '2016-10-04 19:40:09.006713', 2, false, 'http://i.vimeocdn.com/video/594975545_200x150.jpg');
INSERT INTO exercises VALUES (47, 7, '176551438', 2, 1, 1, 1, false, 'Bench Press', false, NULL, '2016-10-04 19:40:08.436821', 2, false, 'http://i.vimeocdn.com/video/583826708_200x150.jpg');
INSERT INTO exercises VALUES (48, 7, '185274368', 2, 0.849999999999999978, 1, 1, false, 'Incline Press', false, NULL, '2016-10-04 19:40:08.577125', 2, false, 'http://i.vimeocdn.com/video/594975297_200x150.jpg');
INSERT INTO exercises VALUES (56, 7, '185274373', NULL, NULL, 3, 1, true, 'Incline Pushup', false, NULL, '2016-10-04 19:40:09.736595', 2, false, 'http://i.vimeocdn.com/video/594976214_200x150.jpg');
INSERT INTO exercises VALUES (53, 7, '176557772', NULL, NULL, 3, 1, true, 'Pushup', false, NULL, '2016-10-04 19:40:09.301766', 1, false, 'http://i.vimeocdn.com/video/583835276_200x150.jpg');
INSERT INTO exercises VALUES (54, 13, '185273466', 3, 1.5, 7, 1, true, 'Assisted Pullup', false, NULL, '2016-10-04 19:40:09.44114', 1, false, 'http://i.vimeocdn.com/video/594969575_200x150.jpg');
INSERT INTO exercises VALUES (61, 8, '176553002', 2, 0.25, 2, 1, false, 'Dumbbell Press', false, NULL, NULL, 2, false, 'http://i.vimeocdn.com/video/583829350_200x150.jpg');
INSERT INTO exercises VALUES (57, 7, '176552765', NULL, NULL, 3, 2, true, 'Dip', false, NULL, '2016-10-04 19:40:09.878266', 1, false, 'http://i.vimeocdn.com/video/583829770_200x150.jpg');
INSERT INTO exercises VALUES (59, 7, '176552763', 2, 1.5, 8, 3, true, 'Dip With Dip Belt', false, NULL, '2016-10-04 19:40:10.177866', 1, false, 'http://i.vimeocdn.com/video/583829653_200x150.jpg');
INSERT INTO exercises VALUES (62, 8, '185274394', 2, 0.25, 2, 1, false, 'Dumbbell One Arm Press', false, NULL, '2016-10-04 19:40:10.579908', 1, false, 'http://i.vimeocdn.com/video/594972537_200x150.jpg');
INSERT INTO exercises VALUES (63, 8, '185274374', NULL, NULL, 3, 2, true, 'Side To Side Jackknife Pushup', false, NULL, '2016-10-04 19:40:10.717428', 1, false, 'http://i.vimeocdn.com/video/594973374_200x150.jpg');
INSERT INTO exercises VALUES (70, 10, '176551442', 3, 0.5, 2, 1, false, 'Bent Over 2 Point Dumbbell Row', false, NULL, '2016-10-04 19:40:11.82799', 2, false, 'http://i.vimeocdn.com/video/583826540_200x150.jpg');
INSERT INTO exercises VALUES (67, 9, '176557771', 2, 0.5, 1, 2, false, 'Push Press', false, NULL, '2016-10-04 19:40:11.308576', 1, false, 'http://i.vimeocdn.com/video/583834862_200x150.jpg');
INSERT INTO exercises VALUES (68, 9, '185274374', NULL, NULL, 3, 2, true, 'Jackknife Pushup', false, NULL, '2016-10-04 19:40:11.446889', 1, false, 'http://i.vimeocdn.com/video/594973374_200x150.jpg');
INSERT INTO exercises VALUES (78, 11, '176556610', 3, 1.27000000000000002, 7, 1, false, 'Standing Cable Row To Abdomen', false, NULL, '2016-10-04 19:40:13.581681', 2, false, 'http://i.vimeocdn.com/video/583832884_200x150.jpg');
INSERT INTO exercises VALUES (71, 10, '185274392', 3, 0.979999999999999982, 7, 1, false, 'One Arm Standing Cable Row', false, NULL, '2016-10-04 19:40:11.969719', 1, false, 'http://i.vimeocdn.com/video/594972904_200x150.jpg');
INSERT INTO exercises VALUES (73, 10, '185274393', NULL, NULL, 3, 3, false, 'One Arm Horizontal Pullup', false, NULL, '2016-10-04 19:40:12.458808', 1, false, 'http://i.vimeocdn.com/video/594973896_200x150.jpg');
INSERT INTO exercises VALUES (79, 11, '176556611', 3, 1.04000000000000004, 7, 1, false, 'Standing Cable Row To Chin', false, NULL, '2016-10-04 19:40:13.797148', 2, false, 'http://i.vimeocdn.com/video/583832893_200x150.jpg');
INSERT INTO exercises VALUES (76, 11, '185274361', NULL, NULL, 3, 2, false, 'Horizontal Pullup', false, NULL, '2016-10-04 19:40:13.269966', 1, false, 'http://i.vimeocdn.com/video/594974328_200x150.jpg');
INSERT INTO exercises VALUES (74, 11, '176551440', 3, 1, 1, 1, false, 'Bent Over Row', false, NULL, '2016-10-04 19:40:12.600982', 2, false, 'http://i.vimeocdn.com/video/583826103_200x150.jpg');
INSERT INTO exercises VALUES (82, 13, '185274377', 3, 1.30000000000000004, 7, 1, false, 'Lat Pulldown', false, NULL, '2016-10-04 19:40:14.228675', 1, false, 'http://i.vimeocdn.com/video/594976189_200x150.jpg');
INSERT INTO exercises VALUES (81, 12, '176557646', NULL, NULL, 3, 2, true, 'Side To Side Pullup', false, NULL, '2016-10-04 19:40:14.090905', 1, false, 'http://i.vimeocdn.com/video/583835050_200x150.jpg');
INSERT INTO exercises VALUES (84, 13, '176557769', NULL, NULL, 3, 2, true, 'Pullup', false, NULL, '2016-10-04 19:40:14.515864', 2, false, 'http://i.vimeocdn.com/video/583835311_200x150.jpg');
INSERT INTO exercises VALUES (97, 14, '185274389', 2, 1, 6, 1, false, 'Med Ball Over The Shoulder Throw', false, NULL, '2016-10-04 19:40:16.317412', 2, false, 'http://i.vimeocdn.com/video/594973681_200x150.jpg');
INSERT INTO exercises VALUES (87, 14, '176552757', 2, 0.170000000000000012, 9, 2, false, 'Corkscrew', false, NULL, '2016-10-04 19:40:14.947635', 2, false, 'http://i.vimeocdn.com/video/583829418_200x150.jpg');
INSERT INTO exercises VALUES (92, 14, '185274380', 2, 0.640000000000000013, 7, 1, false, 'Reverse Cable Wood Chop', false, NULL, '2016-10-04 19:40:15.628773', 2, false, 'http://i.vimeocdn.com/video/594974492_200x150.jpg');
INSERT INTO exercises VALUES (91, 14, '185274359', 2, 0.530000000000000027, 7, 1, false, 'Cable Wood Chop', false, NULL, '2016-10-04 19:40:15.496017', 2, false, 'http://i.vimeocdn.com/video/594975310_200x150.jpg');
INSERT INTO exercises VALUES (86, 14, '176557782', 3, 0.340000000000000024, 9, 1, false, 'Seated Russian Twist', false, NULL, '2016-10-04 19:40:14.803109', 2, false, 'http://i.vimeocdn.com/video/583835251_200x150.jpg');
INSERT INTO exercises VALUES (107, 15, '176552754', 3, 0.479999999999999982, 2, 2, false, 'Core Row', false, NULL, '2016-10-04 19:40:17.796885', 2, false, 'http://i.vimeocdn.com/video/583828832_200x150.jpg');
INSERT INTO exercises VALUES (94, 14, '83077936', 2, 0.609999999999999987, 7, 1, false, 'Cable Rotating Extension', false, NULL, '2016-10-04 19:40:15.894552', 1, false, 'http://i.vimeocdn.com/video/459558595_200x150.jpg');
INSERT INTO exercises VALUES (95, 14, '185274385', 2, 1, 6, 1, false, 'Medicine Ball Wall Throw', false, NULL, '2016-10-04 19:40:16.044328', 1, false, 'http://i.vimeocdn.com/video/594975737_200x150.jpg');
INSERT INTO exercises VALUES (89, 14, '176556420', NULL, NULL, 3, 1, false, 'Windshield Wiper', false, NULL, '2016-10-04 19:40:15.224215', 2, false, 'http://i.vimeocdn.com/video/583833094_200x150.jpg');
INSERT INTO exercises VALUES (105, 15, '185274404', NULL, NULL, 4, 2, false, 'Plank w/ Elbow To Knee', false, NULL, '2016-10-04 19:40:17.487498', 2, true, 'http://i.vimeocdn.com/video/594974377_200x150.jpg');
INSERT INTO exercises VALUES (100, 15, '176550347', NULL, NULL, 4, 2, false, '2 Point Plank', false, NULL, '2016-10-04 19:40:16.763037', 1, true, 'http://i.vimeocdn.com/video/583824644_200x150.jpg');
INSERT INTO exercises VALUES (102, 15, '176550353', NULL, NULL, 4, 1, false, '4 Point Supine Bridge', false, NULL, '2016-10-04 19:40:17.040838', 1, true, 'http://i.vimeocdn.com/video/583824628_200x150.jpg');
INSERT INTO exercises VALUES (103, 15, '176550352', NULL, NULL, 4, 1, false, '3 Point Supine Bridge', false, NULL, '2016-10-04 19:40:17.184873', 1, true, 'http://i.vimeocdn.com/video/583824775_200x150.jpg');
INSERT INTO exercises VALUES (98, 15, '176552956', NULL, NULL, 4, 1, false, '4 Point Plank', false, NULL, '2016-10-04 19:40:16.447772', 2, true, 'http://i.vimeocdn.com/video/583829851_200x150.jpg');
INSERT INTO exercises VALUES (65, 9, '176557770', 2, 0.349999999999999978, 1, 3, false, 'Push Jerk', false, NULL, '2016-10-04 19:40:11.030658', 2, false, 'http://i.vimeocdn.com/video/583834725_200x150.jpg');
INSERT INTO exercises VALUES (163, 16, '185334000', 2, 0.17, 8, 1, false, 'Little Bigs', false, NULL, '2016-10-04 19:40:26.365733', 1, false, 'http://i.vimeocdn.com/video/595059329_200x150.jpg');
INSERT INTO exercises VALUES (115, 16, '176557671', NULL, NULL, 3, 1, false, 'Crunch', false, NULL, '2016-10-04 19:40:19.0001', 2, false, 'http://i.vimeocdn.com/video/583835396_200x150.jpg');
INSERT INTO exercises VALUES (170, 6, '176557761', NULL, NULL, 3, 2, false, 'Plyo Pushup with Med Ball', false, NULL, '2016-10-04 19:40:27.3278', 1, false, 'http://i.vimeocdn.com/video/583835234_200x150.jpg');
INSERT INTO exercises VALUES (189, 16, '176550350', NULL, NULL, 3, 2, false, '2 to 1 V Up', false, NULL, '2016-10-04 19:40:21.94096', 2, false, 'http://i.vimeocdn.com/video/583824783_200x150.jpg');
INSERT INTO exercises VALUES (148, 8, '176551453', 2, 0.239999999999999991, 2, 3, false, 'Bosu Single Leg Shoulder Press', false, NULL, '2016-10-04 19:40:24.402617', 2, false, 'http://i.vimeocdn.com/video/583826187_200x150.jpg');
INSERT INTO exercises VALUES (146, 15, '176551451', NULL, NULL, 4, 1, false, 'Bosu Plank 2', false, NULL, '2016-10-04 19:40:24.112795', 2, true, 'http://i.vimeocdn.com/video/583826801_200x150.jpg');
INSERT INTO exercises VALUES (122, 2, '176550402', 1, 0.5, 1, 3, false, 'Cross Lateral Stepup', false, NULL, '2016-10-04 19:40:19.986208', 1, false, 'http://i.vimeocdn.com/video/583824798_200x150.jpg');
INSERT INTO exercises VALUES (123, 2, '176552999', 1, 0.23000000000000001, 2, 1, false, 'Dumbbell Stepup', false, NULL, '2016-10-04 19:40:20.121609', 1, false, 'http://i.vimeocdn.com/video/583829796_200x150.jpg');
INSERT INTO exercises VALUES (149, 2, '176551454', NULL, NULL, 4, 3, false, 'Bosu Single Leg Squat', false, NULL, '2016-10-04 19:40:24.544442', 2, true, 'http://i.vimeocdn.com/video/583826800_200x150.jpg');
INSERT INTO exercises VALUES (126, 1, '176557762', 2, 0.349999999999999978, 1, 3, false, 'Power Clean And Jerk', false, NULL, '2016-10-04 19:40:20.543115', 1, false, 'http://i.vimeocdn.com/video/583834784_200x150.jpg');
INSERT INTO exercises VALUES (129, 1, '185274159', 2, 0.5, 1, 3, false, 'Hang Power Clean And Press', false, NULL, '2016-10-04 19:40:20.970465', 2, false, 'http://i.vimeocdn.com/video/594970075_200x150.jpg');
INSERT INTO exercises VALUES (185, 2, '176556410', NULL, NULL, 3, 2, false, 'TRX Single Leg Squat', false, NULL, '2016-10-04 19:40:29.789891', 2, false, 'http://i.vimeocdn.com/video/583833088_200x150.jpg');
INSERT INTO exercises VALUES (131, 13, '185273465', 3, 1.5, 7, 1, true, 'Assisted Chinup', false, NULL, '2016-10-04 19:40:21.245981', 1, false, 'http://i.vimeocdn.com/video/594970626_200x150.jpg');
INSERT INTO exercises VALUES (120, 13, '185274388', 3, 1.21999999999999997, 7, 1, false, 'Neutral Grip Pulldown', false, NULL, '2016-10-04 19:40:19.695563', 2, false, 'http://i.vimeocdn.com/video/594975034_200x150.jpg');
INSERT INTO exercises VALUES (134, 13, '176552751', 3, 1.69999999999999996, 8, 3, true, 'Chinup With Weight Belt', false, NULL, '2016-10-04 19:40:21.674542', 1, false, 'http://i.vimeocdn.com/video/583829782_200x150.jpg');
INSERT INTO exercises VALUES (190, 15, '176550354', NULL, NULL, 4, 1, false, '6 Inches', false, NULL, '2016-10-04 19:40:22.087724', 1, true, 'http://i.vimeocdn.com/video/583824919_200x150.jpg');
INSERT INTO exercises VALUES (140, 11, '176551436', NULL, NULL, 4, 1, false, 'Battleropes Single Arm Circles', false, NULL, '2016-10-04 19:40:23.260261', 2, true, 'http://i.vimeocdn.com/video/583825997_200x150.jpg');
INSERT INTO exercises VALUES (193, 11, '176550407', NULL, NULL, 4, 1, false, 'Battleropes Drummers', false, NULL, '2016-10-04 19:40:22.530433', 1, true, 'http://i.vimeocdn.com/video/583824652_200x150.jpg');
INSERT INTO exercises VALUES (137, 11, '176551433', NULL, NULL, 4, 1, false, 'Battleropes Lateral Raises', false, NULL, '2016-10-04 19:40:22.816366', 1, true, 'http://i.vimeocdn.com/video/583826100_200x150.jpg');
INSERT INTO exercises VALUES (138, 11, '176551434', NULL, NULL, 4, 1, false, 'Battleropes Outward Circles', false, NULL, '2016-10-04 19:40:22.958089', 1, true, 'http://i.vimeocdn.com/video/583826044_200x150.jpg');
INSERT INTO exercises VALUES (133, 13, '176557768', 3, 1.69999999999999996, 8, 3, true, 'Pullup With Weight Belt', false, NULL, '2016-10-04 19:40:21.529368', 2, false, 'http://i.vimeocdn.com/video/583835265_200x150.jpg');
INSERT INTO exercises VALUES (143, 9, '176551444', NULL, NULL, 6, 3, false, 'Bosu Low to High Chop with Med Ball', false, NULL, '2016-10-04 19:40:23.659123', 1, false, 'http://i.vimeocdn.com/video/583826855_200x150.jpg');
INSERT INTO exercises VALUES (144, 6, '176551448', NULL, NULL, 3, 2, false, 'Bosu Over and Back Pushup', false, NULL, '2016-10-04 19:40:23.810547', 1, false, 'http://i.vimeocdn.com/video/583826426_200x150.jpg');
INSERT INTO exercises VALUES (178, 15, '176556394', NULL, NULL, 3, 2, false, 'Superman', false, NULL, '2016-10-04 19:40:28.530835', 2, false, 'http://i.vimeocdn.com/video/583832961_200x150.jpg');
INSERT INTO exercises VALUES (176, 9, '176556393', NULL, NULL, 3, 2, false, 'Suitcase Crunch', false, NULL, '2016-10-04 19:40:28.240115', 2, false, 'http://i.vimeocdn.com/video/583832439_200x150.jpg');
INSERT INTO exercises VALUES (118, 7, '176557764', NULL, NULL, 3, 3, true, 'Power Pushup', false, NULL, '2016-10-04 19:40:19.413237', 2, false, 'http://i.vimeocdn.com/video/583835149_200x150.jpg');
INSERT INTO exercises VALUES (152, 14, '176552756', NULL, NULL, 3, 2, false, 'Cliffhangers', false, NULL, '2016-10-04 19:40:24.830384', 1, false, 'http://i.vimeocdn.com/video/583829643_200x150.jpg');
INSERT INTO exercises VALUES (125, 2, '176552771', 1, 0.200000000000000011, 2, 3, false, 'Dumbbell Cross Lateral Stepup', false, NULL, '2016-10-04 19:40:20.406874', 2, false, 'http://i.vimeocdn.com/video/583829041_200x150.jpg');
INSERT INTO exercises VALUES (155, 16, '176553005', NULL, NULL, 3, 2, false, 'Elbow to Knee', false, NULL, '2016-10-04 19:40:25.254944', 1, false, 'http://i.vimeocdn.com/video/583829934_200x150.jpg');
INSERT INTO exercises VALUES (157, 15, '176553006', NULL, NULL, 4, 1, false, 'Front Plank Complex', false, NULL, '2016-10-04 19:40:25.548892', 1, true, 'http://i.vimeocdn.com/video/583829893_200x150.jpg');
INSERT INTO exercises VALUES (158, 1, '176552966', 2, 0.23000000000000001, 2, 3, false, 'Hang Kettlebell Snatch', false, NULL, '2016-10-04 19:40:25.696504', 1, false, 'http://i.vimeocdn.com/video/583829114_200x150.jpg');
INSERT INTO exercises VALUES (160, 1, '185333820', 2, 0.450000000000000011, 2, 2, false, 'Kettlebell Swing Through', false, NULL, '2016-10-04 19:40:25.980388', 1, false, 'http://i.vimeocdn.com/video/595058671_200x150.jpg');
INSERT INTO exercises VALUES (162, 1, '185430819', 2, 0.5, 8, 2, false, 'Landmine with Extension', false, NULL, '2016-10-04 19:40:26.230605', 1, false, 'http://i.vimeocdn.com/video/595177115_200x150.jpg');
INSERT INTO exercises VALUES (116, 16, '176551443', NULL, NULL, 3, 1, false, 'Bicycle', false, NULL, '2016-10-04 19:40:19.140655', 2, false, 'http://i.vimeocdn.com/video/583826846_200x150.jpg');
INSERT INTO exercises VALUES (165, 16, '185334098', NULL, NULL, 6, 2, false, 'Med Ball Reverse Crunch with Bridge', false, NULL, '2016-10-04 19:40:26.63797', 1, false, 'http://i.vimeocdn.com/video/595055279_200x150.jpg');
INSERT INTO exercises VALUES (166, 7, '176555252', NULL, NULL, 6, 1, false, 'Med Ball Wall Blasts', false, NULL, '2016-10-04 19:40:26.773014', 1, false, 'http://i.vimeocdn.com/video/583831070_200x150.jpg');
INSERT INTO exercises VALUES (168, 2, '185431089', 1, 0.260000000000000009, 1, 1, false, 'Paperboy', false, NULL, '2016-10-04 19:40:27.053952', 1, false, 'http://i.vimeocdn.com/video/595176829_200x150.jpg');
INSERT INTO exercises VALUES (171, 16, '176557776', NULL, NULL, 3, 2, false, 'Reverse Crunch with Bridge', false, NULL, '2016-10-04 19:40:27.48322', 1, false, 'http://i.vimeocdn.com/video/583835312_200x150.jpg');
INSERT INTO exercises VALUES (111, 16, '176557777', NULL, NULL, 3, 1, false, 'Reverse Crunch', false, NULL, '2016-10-04 19:40:18.392495', 2, false, 'http://i.vimeocdn.com/video/583835038_200x150.jpg');
INSERT INTO exercises VALUES (180, 10, '176556403', NULL, NULL, 3, 1, false, 'TRX Curl', false, NULL, '2016-10-04 19:40:29.060413', 2, false, 'http://i.vimeocdn.com/video/583832737_200x150.jpg');
INSERT INTO exercises VALUES (175, 9, '176556614', 2, 0.400000000000000022, 1, 3, false, 'Suitcase Crunch with Shoulder Press', false, NULL, '2016-10-04 19:40:28.097523', 1, false, 'http://i.vimeocdn.com/video/583832898_200x150.jpg');
INSERT INTO exercises VALUES (173, 16, '176557670', NULL, NULL, 3, 1, false, 'Situps with Twist', false, NULL, '2016-10-04 19:40:27.79819', 2, false, 'http://i.vimeocdn.com/video/583835014_200x150.jpg');
INSERT INTO exercises VALUES (183, 10, '176556407', NULL, NULL, 3, 2, false, 'TRX Row', false, NULL, '2016-10-04 19:40:29.204786', 2, false, 'http://i.vimeocdn.com/video/583833011_200x150.jpg');
INSERT INTO exercises VALUES (182, 6, '176556406', NULL, NULL, 3, 2, false, 'TRX Pushup', false, NULL, '2016-10-04 19:40:29.491734', 1, false, 'http://i.vimeocdn.com/video/583832279_200x150.jpg');
INSERT INTO exercises VALUES (192, 11, '176550403', NULL, NULL, 4, 1, false, 'Battleropes Big Circles', false, NULL, '2016-10-04 19:40:22.378395', 2, true, 'http://i.vimeocdn.com/video/583824478_200x150.jpg');
INSERT INTO exercises VALUES (154, 2, '176552773', 1, 0.25, 1, 2, false, 'Dumbbell Drop Lunge', false, NULL, '2016-10-04 19:40:25.116754', 2, false, 'http://i.vimeocdn.com/video/583829058_200x150.jpg');
INSERT INTO exercises VALUES (128, 1, '176553023', 2, 0.349999999999999978, 1, 3, false, 'Hang Power Clean And Jerk', false, NULL, '2016-10-04 19:40:20.825724', 2, false, 'http://i.vimeocdn.com/video/583829273_200x150.jpg');
INSERT INTO exercises VALUES (142, 1, '185543529', 2, 0.299999999999999989, 2, 3, false, 'Bosu Kettlebell Swing Through', false, NULL, NULL, 1, false, 'http://i.vimeocdn.com/video/595316736_200x150.jpg');
INSERT INTO exercises VALUES (186, 16, '176556415', 2, 0.170000000000000012, 8, 1, false, 'Upper Ab Crunch', false, NULL, '2016-10-04 19:40:29.937198', 1, false, 'http://i.vimeocdn.com/video/583832818_200x150.jpg');
INSERT INTO exercises VALUES (187, 16, '176556416', NULL, NULL, 3, 2, false, 'V Ups', false, NULL, '2016-10-04 19:40:30.080564', 1, false, 'http://i.vimeocdn.com/video/583832984_200x150.jpg');
INSERT INTO exercises VALUES (34, 5, '176550406', 1, 0.190000000000000002, 9, 1, false, 'Back Extension', false, NULL, '2016-10-04 19:40:06.68581', 2, false, 'http://i.vimeocdn.com/video/583824761_200x150.jpg');
INSERT INTO exercises VALUES (188, 16, '176557662', NULL, NULL, 6, 2, false, 'Single Leg Med Ball Slams', false, NULL, '2016-10-04 19:40:30.222461', 2, false, 'http://i.vimeocdn.com/video/583835390_200x150.jpg');


--
-- TOC entry 2628 (class 0 OID 0)
-- Dependencies: 184
-- Name: exercises_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brianregan
--

SELECT pg_catalog.setval('exercises_id_seq', 195, true);


--
-- TOC entry 2593 (class 0 OID 93958)
-- Dependencies: 191
-- Data for Name: goal_definitions; Type: TABLE DATA; Schema: public; Owner: brianregan
--

INSERT INTO goal_definitions VALUES (1, 1, 'Complete your workout schedule', 'Yes! You''ve completed your workout schedule!', 10, '2016-10-01 02:01:10.112688', '2016-10-01 02:01:10.112688', 1);
INSERT INTO goal_definitions VALUES (2, 2, 'Complete Quadfit onboarding', 'Yoooo, onboarding complete! You''re a Quadfit expert now.', 30, '2016-10-01 02:02:16.952857', '2016-10-01 02:02:16.952857', 3);
INSERT INTO goal_definitions VALUES (3, 3, 'Create a username so that we can display your fine work in the Leaderboards', 'Done and done. Now you''re eligible to be shown on the Leaderboards,
    and you can start communicating with other Quadfit members!', 10, '2016-10-01 02:03:02.640625', '2016-10-01 02:03:02.640625', 3);
INSERT INTO goal_definitions VALUES (5, 5, 'Don''t keep all this workout goodness to yourself! Share your workouts
    so other people can see your domination!', 'You''ve leveled up! Sharing really is caring.', 50, '2016-10-01 02:04:42.579825', '2016-10-01 02:04:42.579825', 3);
INSERT INTO goal_definitions VALUES (6, 6, 'Start building your Quad Pod! Invite people to join your QP, and you''ll
    be able to see each other''s workouts, compete, and send messages of motivation...or
    trash talk', 'Swwweeeet, mission accomplished. Now the real fun begins.', 75, '2016-10-01 02:05:19.083784', '2016-10-01 02:05:19.083784', 3);
INSERT INTO goal_definitions VALUES (8, 2, 'Create a workout for an athlete.', 'Great, now make sure that the workout results get recorded so that
    Quadfit can track progress and give better future workouts.', 250, '2016-10-01 02:06:44.35944', '2016-10-01 02:06:44.35944', 2);
INSERT INTO goal_definitions VALUES (9, 2, 'Complete Quadfit onboarding', 'Yoooo, onboarding complete! You''re a Quadfit expert now.', 30, '2016-10-01 02:07:17.319091', '2016-10-01 02:07:17.319091', 2);
INSERT INTO goal_definitions VALUES (10, 3, 'Create a username so that we can display your fine work in the Leaderboards', 'Done and done. Now you''re eligible to be shown on the Leaderboards,
    and you can start communicating with other Quadfit members!', 10, '2016-10-01 02:07:51.878493', '2016-10-01 02:07:51.878493', 2);
INSERT INTO goal_definitions VALUES (11, 4, 'Complete a workout and enter in what you accomplished during the workout.
    This allows Quadfit to track your progress, and give you better workouts in the
    future', 'That''s what''s up! You completed your first workout. Now keep up that
    momentum!', 100, '2016-10-01 02:08:25.925276', '2016-10-01 02:08:25.925276', 2);
INSERT INTO goal_definitions VALUES (12, 5, 'Don''t keep all this workout goodness to yourself! Share your workouts
    so other people can see your domination!', 'You''ve leveled up! Sharing really is caring.', 50, '2016-10-01 02:09:00.402227', '2016-10-01 02:09:00.402227', 2);
INSERT INTO goal_definitions VALUES (13, 6, 'Start building your Quad Pod! Invite people to join your QP, and you''ll
    be able to see each other''s workouts, compete, and send messages of motivation...or
    trash talk', 'Swwweeeet, mission accomplished. Now the real fun begins.', 75, '2016-10-01 02:09:32.114782', '2016-10-01 02:09:32.114782', 2);
INSERT INTO goal_definitions VALUES (4, 4, 'Complete a workout and enter in what you accomplished during the workout.
    This allows Quadfit to track your progress, and give you better workouts in the
    future', 'That''s what''s up! You completed your first workout. Now keep up that
    momentum!', 100, '2016-10-01 02:03:50.486265', '2016-10-01 02:03:50.486265', 3);
INSERT INTO goal_definitions VALUES (7, 1, 'Create an account for an athlete, or use your sign up code to invite
    an athlete to join.', 'Next up, let Quadfit help you create some workouts!', 150, '2016-10-01 02:06:00.778262', '2016-10-01 02:06:00.778262', 2);


--
-- TOC entry 2629 (class 0 OID 0)
-- Dependencies: 190
-- Name: goal_definitions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brianregan
--

SELECT pg_catalog.setval('goal_definitions_id_seq', 13, true);


--
-- TOC entry 2595 (class 0 OID 94100)
-- Dependencies: 221
-- Data for Name: one_rep_maxes; Type: TABLE DATA; Schema: public; Owner: brianregan
--

INSERT INTO one_rep_maxes VALUES (1, 1, 1, NULL, NULL);
INSERT INTO one_rep_maxes VALUES (2, 2, 0.92000000000000004, NULL, NULL);
INSERT INTO one_rep_maxes VALUES (3, 3, 0.900000000000000022, NULL, NULL);
INSERT INTO one_rep_maxes VALUES (4, 4, 0.869999999999999996, NULL, NULL);
INSERT INTO one_rep_maxes VALUES (5, 5, 0.849999999999999978, NULL, NULL);
INSERT INTO one_rep_maxes VALUES (6, 6, 0.819999999999999951, NULL, NULL);
INSERT INTO one_rep_maxes VALUES (7, 7, 0.800000000000000044, NULL, NULL);
INSERT INTO one_rep_maxes VALUES (8, 8, 0.75, NULL, NULL);
INSERT INTO one_rep_maxes VALUES (9, 9, 0.729999999999999982, NULL, NULL);
INSERT INTO one_rep_maxes VALUES (10, 10, 0.699999999999999956, NULL, NULL);
INSERT INTO one_rep_maxes VALUES (11, 11, 0.680000000000000049, NULL, NULL);
INSERT INTO one_rep_maxes VALUES (12, 12, 0.650000000000000022, NULL, NULL);
INSERT INTO one_rep_maxes VALUES (13, 13, 0.619999999999999996, NULL, NULL);
INSERT INTO one_rep_maxes VALUES (14, 14, 0.57999999999999996, NULL, NULL);
INSERT INTO one_rep_maxes VALUES (15, 15, 0.540000000000000036, NULL, NULL);
INSERT INTO one_rep_maxes VALUES (16, 16, 0.5, NULL, NULL);
INSERT INTO one_rep_maxes VALUES (17, 17, 0.46000000000000002, NULL, NULL);
INSERT INTO one_rep_maxes VALUES (18, 18, 0.419999999999999984, NULL, NULL);
INSERT INTO one_rep_maxes VALUES (19, 19, 0.380000000000000004, NULL, NULL);
INSERT INTO one_rep_maxes VALUES (20, 20, 0.340000000000000024, NULL, NULL);


--
-- TOC entry 2630 (class 0 OID 0)
-- Dependencies: 220
-- Name: one_rep_maxes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brianregan
--

SELECT pg_catalog.setval('one_rep_maxes_id_seq', 20, true);


--
-- TOC entry 2597 (class 0 OID 94140)
-- Dependencies: 231
-- Data for Name: phases; Type: TABLE DATA; Schema: public; Owner: brianregan
--

INSERT INTO phases VALUES (1, 4, 6, 4, 15, 4, 6, 4, 15, NULL, NULL);
INSERT INTO phases VALUES (2, 4, 6, 4, 10, 4, 6, 4, 10, NULL, NULL);
INSERT INTO phases VALUES (3, 4, 6, 4, 15, 4, 6, 4, 18, NULL, NULL);
INSERT INTO phases VALUES (4, 4, 6, 4, 12, 4, 6, 4, 12, NULL, NULL);
INSERT INTO phases VALUES (5, 5, 3, 4, 8, 5, 4, 4, 8, NULL, NULL);
INSERT INTO phases VALUES (6, 5, 4, 4, 6, 5, 4, 4, 10, NULL, NULL);
INSERT INTO phases VALUES (7, 5, 3, 4, 8, 5, 4, 4, 6, NULL, NULL);
INSERT INTO phases VALUES (8, 5, 4, 4, 4, 5, 4, 4, 8, NULL, NULL);
INSERT INTO phases VALUES (9, 4, 5, 4, 10, 4, 6, 4, 10, NULL, NULL);
INSERT INTO phases VALUES (10, 5, 3, 4, 6, 4, 5, 4, 15, NULL, NULL);
INSERT INTO phases VALUES (11, 4, 5, 4, 8, 4, 6, 4, 8, NULL, NULL);
INSERT INTO phases VALUES (12, 5, 3, 4, 6, 4, 5, 4, 12, NULL, NULL);


--
-- TOC entry 2631 (class 0 OID 0)
-- Dependencies: 230
-- Name: phases_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brianregan
--

SELECT pg_catalog.setval('phases_id_seq', 12, true);


--
-- TOC entry 2599 (class 0 OID 94148)
-- Dependencies: 233
-- Data for Name: plyometrics; Type: TABLE DATA; Schema: public; Owner: brianregan
--

INSERT INTO plyometrics VALUES (1, 'Bound', '176552766', '3 x 5 Bounds', NULL, '2016-10-04 19:39:46.39765', 1, 'http://i.vimeocdn.com/video/583828768_200x150.jpg');
INSERT INTO plyometrics VALUES (17, 'Lateral Box Jumps', '176555148', '3 x 10 Jumps', NULL, '2016-10-04 19:39:48.64481', 2, 'http://i.vimeocdn.com/video/583831204_200x150.jpg');
INSERT INTO plyometrics VALUES (3, 'Ice Skater', '185274366', '3 x 15 Seconds', NULL, '2016-10-04 19:39:46.737334', 1, 'http://i.vimeocdn.com/video/594972974_200x150.jpg');
INSERT INTO plyometrics VALUES (14, 'Squat Jump', '176556606', '3 x 20 Seconds', NULL, '2016-10-04 19:39:48.212948', 2, 'http://i.vimeocdn.com/video/583832788_200x150.jpg');
INSERT INTO plyometrics VALUES (24, 'Scissors', '176557783', '3 x 5 Jumps Per Leg', NULL, '2016-10-04 19:39:49.660545', 2, 'http://i.vimeocdn.com/video/583835286_200x150.jpg');
INSERT INTO plyometrics VALUES (6, 'Ladder High Knee', '185431837', '3 x 2 Lengths of the Ladder', NULL, '2016-10-04 19:39:47.145826', 1, 'http://i.vimeocdn.com/video/595176831_200x150.jpg');
INSERT INTO plyometrics VALUES (26, 'Single Leg Jump with Rotation', '176557660', '3 x 5 Jumps Per Leg', NULL, '2016-10-04 19:39:49.945523', 2, 'http://i.vimeocdn.com/video/583834235_200x150.jpg');
INSERT INTO plyometrics VALUES (8, 'Ladder One Two', '185333848', '3 x 1 Length of the Ladder', NULL, '2016-10-04 19:39:47.403349', 1, 'http://i.vimeocdn.com/video/595050831_200x150.jpg');
INSERT INTO plyometrics VALUES (10, 'Lunge Hop', '176556609', '3 x 10 Hops', NULL, '2016-10-04 19:39:47.670063', 1, 'http://i.vimeocdn.com/video/583832924_200x150.jpg');
INSERT INTO plyometrics VALUES (30, 'Ladder 1 Hopscotch', '185333841', '3 x 1 Length of the Ladder', NULL, '2016-10-04 19:39:50.361053', 2, 'http://i.vimeocdn.com/video/595053797_200x150.jpg');
INSERT INTO plyometrics VALUES (12, 'Single Leg Jump', '176557661', '3 x 5 Jumps per leg', NULL, '2016-10-04 19:39:47.948367', 1, 'http://i.vimeocdn.com/video/583835010_200x150.jpg');
INSERT INTO plyometrics VALUES (9, 'Ladder One', '185431838', '3 x 2 Lengths of the Ladder', NULL, '2016-10-04 19:39:47.528316', 2, 'http://i.vimeocdn.com/video/595176763_200x150.jpg');
INSERT INTO plyometrics VALUES (16, 'Box Jumps', '176551458', '3 x 10 Jumps', NULL, '2016-10-04 19:39:48.497902', 2, 'http://i.vimeocdn.com/video/583826669_200x150.jpg');
INSERT INTO plyometrics VALUES (18, 'Box Over And Back', '185273656', '3 x 20 Seconds', NULL, '2016-10-04 19:39:48.791869', 1, 'http://i.vimeocdn.com/video/594967987_200x150.jpg');
INSERT INTO plyometrics VALUES (19, '2 to 1 Box Jump', '176550348', '3 x 14 Jumps', NULL, '2016-10-04 19:39:48.94319', 1, 'http://i.vimeocdn.com/video/583824851_200x150.jpg');
INSERT INTO plyometrics VALUES (21, 'Bosu Jump', '176551439', '3 x 14 Jumps', NULL, '2016-10-04 19:39:49.240359', 1, 'http://i.vimeocdn.com/video/583826812_200x150.jpg');
INSERT INTO plyometrics VALUES (23, 'Bosu Taps', '176551457', '3 x 20 Seconds', NULL, '2016-10-04 19:39:49.522541', 1, 'http://i.vimeocdn.com/video/583826290_200x150.jpg');
INSERT INTO plyometrics VALUES (25, 'Single Leg Box Jumps', '176557657', '3 x 5 Jumps Per Leg', NULL, '2016-10-04 19:39:49.800837', 1, 'http://i.vimeocdn.com/video/583834598_200x150.jpg');
INSERT INTO plyometrics VALUES (27, 'Single Leg Lateral Box Jump', '176557663', '3 x 8 Jumps Per Leg', NULL, '2016-10-04 19:39:50.09693', 1, 'http://i.vimeocdn.com/video/583835242_200x150.jpg');
INSERT INTO plyometrics VALUES (28, 'Staggered Box Jump', '176556608', '3 x 10 Jumps', NULL, '2016-10-04 19:39:50.235932', 1, 'http://i.vimeocdn.com/video/583832935_200x150.jpg');
INSERT INTO plyometrics VALUES (32, 'Ladder 2 Lateral', '185333825', '3 x 2 Lengths of the Ladder', NULL, '2016-10-04 19:39:50.632166', 1, 'http://i.vimeocdn.com/video/595051375_200x150.jpg');
INSERT INTO plyometrics VALUES (34, 'Ladder 2 In 2 Out Lateral', '185431848', '3 x 1 Length of the Ladder', NULL, '2016-10-04 19:39:50.903627', 1, 'http://i.vimeocdn.com/video/595177136_200x150.jpg');
INSERT INTO plyometrics VALUES (35, 'Ladder Hopscotch', '185333851', '3 x 1 Length of the Ladder', NULL, '2016-10-04 19:39:51.038906', 1, 'http://i.vimeocdn.com/video/595051620_200x150.jpg');
INSERT INTO plyometrics VALUES (38, 'Ladder Lateral Split Exchange', '185333871', '3 x 2 Lengths of the Ladder', NULL, '2016-10-04 19:39:51.44494', 1, 'http://i.vimeocdn.com/video/595053629_200x150.jpg');
INSERT INTO plyometrics VALUES (39, 'Ladder Trailing Tap', '185333870', '3 x 1 Length of the Ladder', NULL, '2016-10-04 19:39:51.57264', 1, 'http://i.vimeocdn.com/video/595052656_200x150.jpg');
INSERT INTO plyometrics VALUES (31, 'Ladder 1 2 High Knees', '185333825', '3 x 2 Lengths of the Ladder', NULL, '2016-10-04 19:39:50.502492', 2, 'http://i.vimeocdn.com/video/595051375_200x150.jpg');
INSERT INTO plyometrics VALUES (33, 'Ladder 2 In 2 Out', '185333850', '3 x 1 Length of the Ladder', NULL, '2016-10-04 19:39:50.769994', 2, 'http://i.vimeocdn.com/video/595053035_200x150.jpg');
INSERT INTO plyometrics VALUES (37, 'Ladder Karaoke', '185333852', '3 x 2 Lengths of the Ladder', NULL, '2016-10-04 19:39:51.297451', 2, 'http://i.vimeocdn.com/video/595053174_200x150.jpg');
INSERT INTO plyometrics VALUES (36, 'Ladder Ickey Shuffle', '185431851', '3 x 1 Length of the Ladder', NULL, '2016-10-04 19:39:51.171772', 2, 'http://i.vimeocdn.com/video/595177238_200x150.jpg');
INSERT INTO plyometrics VALUES (22, 'Bosu On and Off', '176551447', '3 x 20 Seconds', NULL, '2016-10-04 19:39:49.38061', 2, 'http://i.vimeocdn.com/video/583825663_200x150.jpg');
INSERT INTO plyometrics VALUES (20, 'Alternating Bound', '176550356', '3 x 10 Bounds', NULL, '2016-10-04 19:39:49.100971', 2, 'http://i.vimeocdn.com/video/583824363_200x150.jpg');
INSERT INTO plyometrics VALUES (15, 'Tuck Jump', '176556413', '3 x 15 Seconds', NULL, '2016-10-04 19:39:48.344645', 2, 'http://i.vimeocdn.com/video/583832389_200x150.jpg');
INSERT INTO plyometrics VALUES (11, 'Single Leg Bound', '176557655', '3 x 5 Bounds per leg', NULL, '2016-10-04 19:39:47.80831', 2, 'http://i.vimeocdn.com/video/583833990_200x150.jpg');


--
-- TOC entry 2632 (class 0 OID 0)
-- Dependencies: 232
-- Name: plyometrics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brianregan
--

SELECT pg_catalog.setval('plyometrics_id_seq', 39, true);


--
-- TOC entry 2601 (class 0 OID 94168)
-- Dependencies: 237
-- Data for Name: program_day_sequences; Type: TABLE DATA; Schema: public; Owner: brianregan
--

INSERT INTO program_day_sequences VALUES (1, 1, 2, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL);
INSERT INTO program_day_sequences VALUES (2, 2, 4, 3, 4, 5, 6, 0, 0, 0, 0, 0, 0, NULL, NULL);
INSERT INTO program_day_sequences VALUES (3, 3, 6, 3, 2, 4, 5, 1, 6, 0, 0, 0, 0, NULL, NULL);
INSERT INTO program_day_sequences VALUES (4, 4, 8, 3, 2, 4, 1, 5, 2, 6, 1, 0, 0, NULL, NULL);
INSERT INTO program_day_sequences VALUES (5, 5, 4, 7, 8, 9, 10, 0, 0, 0, 0, 0, 0, NULL, NULL);


--
-- TOC entry 2633 (class 0 OID 0)
-- Dependencies: 236
-- Name: program_day_sequences_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brianregan
--

SELECT pg_catalog.setval('program_day_sequences_id_seq', 5, true);


--
-- TOC entry 2603 (class 0 OID 94176)
-- Dependencies: 239
-- Data for Name: program_days; Type: TABLE DATA; Schema: public; Owner: brianregan
--

INSERT INTO program_days VALUES (1, 'Full A', NULL, NULL);
INSERT INTO program_days VALUES (2, 'Full B', NULL, NULL);
INSERT INTO program_days VALUES (3, 'Half A1', NULL, NULL);
INSERT INTO program_days VALUES (4, 'Half B1', NULL, NULL);
INSERT INTO program_days VALUES (5, 'Half A2', NULL, NULL);
INSERT INTO program_days VALUES (6, 'Half B2', NULL, NULL);
INSERT INTO program_days VALUES (7, 'T4P A1', NULL, NULL);
INSERT INTO program_days VALUES (8, 'T4P B1', NULL, NULL);
INSERT INTO program_days VALUES (9, 'T4P A2', NULL, NULL);
INSERT INTO program_days VALUES (10, 'T4P B2', NULL, NULL);


--
-- TOC entry 2634 (class 0 OID 0)
-- Dependencies: 238
-- Name: program_days_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brianregan
--

SELECT pg_catalog.setval('program_days_id_seq', 10, true);


--
-- TOC entry 2605 (class 0 OID 94184)
-- Dependencies: 241
-- Data for Name: program_phase_lookups; Type: TABLE DATA; Schema: public; Owner: brianregan
--

INSERT INTO program_phase_lookups VALUES (1, 1, 1, 1, NULL, NULL);
INSERT INTO program_phase_lookups VALUES (2, 1, 2, 5, NULL, NULL);
INSERT INTO program_phase_lookups VALUES (3, 1, 3, 9, NULL, NULL);
INSERT INTO program_phase_lookups VALUES (4, 2, 1, 2, NULL, NULL);
INSERT INTO program_phase_lookups VALUES (5, 2, 2, 6, NULL, NULL);
INSERT INTO program_phase_lookups VALUES (6, 2, 3, 10, NULL, NULL);
INSERT INTO program_phase_lookups VALUES (7, 3, 1, 3, NULL, NULL);
INSERT INTO program_phase_lookups VALUES (8, 3, 2, 7, NULL, NULL);
INSERT INTO program_phase_lookups VALUES (9, 3, 3, 11, NULL, NULL);
INSERT INTO program_phase_lookups VALUES (10, 4, 1, 4, NULL, NULL);
INSERT INTO program_phase_lookups VALUES (11, 4, 2, 8, NULL, NULL);
INSERT INTO program_phase_lookups VALUES (12, 4, 3, 12, NULL, NULL);


--
-- TOC entry 2635 (class 0 OID 0)
-- Dependencies: 240
-- Name: program_phase_lookups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brianregan
--

SELECT pg_catalog.setval('program_phase_lookups_id_seq', 12, true);


--
-- TOC entry 2607 (class 0 OID 94192)
-- Dependencies: 243
-- Data for Name: program_types; Type: TABLE DATA; Schema: public; Owner: brianregan
--

INSERT INTO program_types VALUES (1, 'PowerLean', NULL, NULL);
INSERT INTO program_types VALUES (2, 'PowerMass', NULL, NULL);
INSERT INTO program_types VALUES (3, 'PowerRip', NULL, NULL);


--
-- TOC entry 2636 (class 0 OID 0)
-- Dependencies: 242
-- Name: program_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brianregan
--

SELECT pg_catalog.setval('program_types_id_seq', 3, true);


--
-- TOC entry 2609 (class 0 OID 94200)
-- Dependencies: 245
-- Data for Name: programs; Type: TABLE DATA; Schema: public; Owner: brianregan
--

INSERT INTO programs VALUES (1, 'Full', NULL, NULL);
INSERT INTO programs VALUES (2, 'Half', NULL, NULL);
INSERT INTO programs VALUES (3, '3 Day Mixed', NULL, NULL);
INSERT INTO programs VALUES (4, '4 Day Mixed', NULL, NULL);
INSERT INTO programs VALUES (5, 'T4P', NULL, NULL);


--
-- TOC entry 2637 (class 0 OID 0)
-- Dependencies: 244
-- Name: programs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brianregan
--

SELECT pg_catalog.setval('programs_id_seq', 5, true);


--
-- TOC entry 2611 (class 0 OID 94244)
-- Dependencies: 253
-- Data for Name: sprint_detail_sequences; Type: TABLE DATA; Schema: public; Owner: brianregan
--

INSERT INTO sprint_detail_sequences VALUES (1, 1, 1, 1, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (2, 1, 1, 2, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (3, 1, 1, 3, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (4, 1, 2, 4, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (5, 2, 1, 1, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (6, 2, 1, 2, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (7, 2, 1, 3, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (8, 2, 3, 4, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (9, 2, 1, 5, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (10, 2, 1, 6, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (11, 2, 1, 7, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (12, 2, 2, 8, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (13, 3, 1, 1, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (14, 3, 1, 2, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (15, 3, 1, 3, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (16, 3, 3, 4, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (17, 3, 1, 5, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (18, 3, 1, 6, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (19, 3, 1, 7, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (20, 3, 3, 8, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (21, 3, 1, 9, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (22, 3, 1, 10, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (23, 3, 1, 11, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (24, 3, 2, 12, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (25, 4, 1, 1, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (26, 4, 1, 2, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (27, 4, 1, 3, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (28, 4, 3, 4, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (29, 4, 1, 5, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (30, 4, 1, 6, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (31, 4, 1, 7, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (32, 4, 3, 8, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (33, 4, 1, 9, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (34, 4, 1, 10, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (35, 4, 1, 11, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (36, 4, 3, 12, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (37, 4, 1, 13, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (38, 4, 1, 14, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (39, 4, 1, 15, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (40, 4, 2, 16, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (41, 5, 4, 1, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (42, 5, 4, 2, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (43, 5, 4, 3, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (44, 5, 5, 4, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (45, 6, 4, 1, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (46, 6, 4, 2, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (47, 6, 4, 3, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (48, 6, 4, 4, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (49, 6, 4, 5, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (50, 6, 4, 6, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (51, 6, 4, 7, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (52, 6, 5, 8, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (53, 7, 4, 1, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (54, 7, 4, 2, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (55, 7, 4, 3, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (56, 7, 4, 4, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (57, 7, 4, 5, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (58, 7, 4, 6, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (59, 7, 4, 7, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (60, 7, 4, 8, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (61, 7, 4, 9, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (62, 7, 4, 10, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (63, 7, 4, 11, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (64, 7, 5, 12, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (65, 8, 6, 1, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (66, 8, 6, 2, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (67, 8, 6, 3, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (68, 8, 7, 4, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (69, 9, 6, 1, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (70, 9, 6, 2, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (71, 9, 6, 3, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (72, 9, 8, 4, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (73, 9, 6, 5, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (74, 9, 6, 6, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (75, 9, 6, 7, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (76, 9, 7, 8, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (77, 10, 6, 1, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (78, 10, 6, 2, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (79, 10, 6, 3, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (80, 10, 8, 4, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (81, 10, 6, 5, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (82, 10, 6, 6, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (83, 10, 6, 7, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (84, 10, 8, 8, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (85, 10, 6, 9, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (86, 10, 6, 10, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (87, 10, 6, 11, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (88, 10, 7, 12, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (89, 11, 6, 1, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (90, 11, 6, 2, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (91, 11, 6, 3, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (92, 11, 8, 4, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (93, 11, 6, 5, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (94, 11, 6, 6, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (95, 11, 6, 7, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (96, 11, 8, 8, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (97, 11, 6, 9, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (98, 11, 6, 10, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (99, 11, 6, 11, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (100, 11, 8, 12, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (101, 11, 6, 13, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (102, 11, 6, 14, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (103, 11, 6, 15, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (104, 11, 7, 16, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (105, 12, 9, 1, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (106, 12, 9, 2, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (107, 12, 9, 3, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (108, 12, 10, 4, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (109, 13, 9, 1, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (110, 13, 9, 2, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (111, 13, 9, 3, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (112, 13, 9, 4, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (113, 13, 9, 5, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (114, 13, 9, 6, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (115, 13, 9, 7, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (116, 13, 10, 8, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (117, 14, 9, 1, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (118, 14, 9, 2, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (119, 14, 9, 3, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (120, 14, 9, 4, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (121, 14, 9, 5, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (122, 14, 9, 6, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (123, 14, 9, 7, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (124, 14, 9, 8, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (125, 14, 9, 9, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (126, 14, 9, 10, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (127, 14, 9, 11, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (128, 14, 10, 12, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (129, 15, 11, 1, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (130, 15, 11, 2, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (131, 15, 11, 3, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (132, 15, 11, 4, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (133, 16, 11, 1, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (134, 16, 11, 2, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (135, 16, 11, 3, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (136, 16, 11, 4, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (137, 16, 11, 5, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (138, 16, 11, 6, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (139, 17, 11, 1, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (140, 17, 11, 2, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (141, 17, 11, 3, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (142, 17, 11, 4, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (143, 17, 11, 5, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (144, 17, 11, 6, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (145, 17, 11, 7, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (146, 17, 11, 8, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (147, 17, 11, 9, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (148, 17, 11, 10, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (149, 18, 11, 1, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (150, 18, 11, 2, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (151, 18, 11, 3, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (152, 18, 11, 4, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (153, 18, 11, 5, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (154, 18, 11, 6, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (155, 18, 11, 7, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (156, 18, 11, 8, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (157, 18, 11, 9, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (158, 18, 11, 10, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (159, 18, 11, 11, NULL, NULL);
INSERT INTO sprint_detail_sequences VALUES (160, 18, 11, 12, NULL, NULL);


--
-- TOC entry 2638 (class 0 OID 0)
-- Dependencies: 252
-- Name: sprint_detail_sequences_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brianregan
--

SELECT pg_catalog.setval('sprint_detail_sequences_id_seq', 160, true);


--
-- TOC entry 2613 (class 0 OID 94252)
-- Dependencies: 255
-- Data for Name: sprint_details; Type: TABLE DATA; Schema: public; Owner: brianregan
--

INSERT INTO sprint_details VALUES (1, 'Sprint 100 yards, rest 15-18 secs', NULL, NULL);
INSERT INTO sprint_details VALUES (2, 'Sprint 100 yards', NULL, NULL);
INSERT INTO sprint_details VALUES (3, 'Sprint 100 yards, rest 60 secs', NULL, NULL);
INSERT INTO sprint_details VALUES (4, 'Sprint 200 yards, rest 33 secs', NULL, NULL);
INSERT INTO sprint_details VALUES (5, 'Sprint 200 yards', NULL, NULL);
INSERT INTO sprint_details VALUES (6, 'Sprint from 1 baseline to the other 3 times, rest 15-18 secs', NULL, NULL);
INSERT INTO sprint_details VALUES (7, 'Sprint from 1 baseline to the other 3 times', NULL, NULL);
INSERT INTO sprint_details VALUES (8, 'Sprint from 1 baseline to the other, rest 60 secs', NULL, NULL);
INSERT INTO sprint_details VALUES (9, 'Sprint from 1 baseline to the other 6 times, rest 33 secs', NULL, NULL);
INSERT INTO sprint_details VALUES (10, 'Sprint from 1 baseline to the other 6 times', NULL, NULL);
INSERT INTO sprint_details VALUES (11, 'Jog for 1 minute, sprint for 30 seconds', NULL, NULL);


--
-- TOC entry 2639 (class 0 OID 0)
-- Dependencies: 254
-- Name: sprint_details_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brianregan
--

SELECT pg_catalog.setval('sprint_details_id_seq', 11, true);


--
-- TOC entry 2615 (class 0 OID 94263)
-- Dependencies: 257
-- Data for Name: sprints; Type: TABLE DATA; Schema: public; Owner: brianregan
--

INSERT INTO sprints VALUES (1, 1, '4 X 100 yards X 1', 1, 4, NULL, NULL);
INSERT INTO sprints VALUES (2, 2, '4 X 100 yards X 2', 1, 8, NULL, NULL);
INSERT INTO sprints VALUES (3, 3, '4 X 100 yards X 3', 1, 12, NULL, NULL);
INSERT INTO sprints VALUES (4, 4, '4 X 100 yards X 4', 1, 16, NULL, NULL);
INSERT INTO sprints VALUES (5, 2, '4 X 200 yards', 1, 4, NULL, NULL);
INSERT INTO sprints VALUES (6, 4, '8 X 200 yards', 1, 8, NULL, NULL);
INSERT INTO sprints VALUES (7, 5, '12 X 200 yards', 1, 12, NULL, NULL);
INSERT INTO sprints VALUES (8, 1, '4 X 3 Court Lengths X 1', 2, 4, NULL, NULL);
INSERT INTO sprints VALUES (9, 2, '4 X 3 Court Lengths X 2', 2, 8, NULL, NULL);
INSERT INTO sprints VALUES (10, 3, '4 X 3 Court Lengths X 3', 2, 12, NULL, NULL);
INSERT INTO sprints VALUES (11, 4, '4 X 3 Court Lengths X 4', 2, 16, NULL, NULL);
INSERT INTO sprints VALUES (12, 2, '4 X 6 Court Lengths', 2, 4, NULL, NULL);
INSERT INTO sprints VALUES (13, 4, '8 X 6 Court Lengths', 2, 8, NULL, NULL);
INSERT INTO sprints VALUES (14, 5, '12 X 6 Court Lengths', 2, 12, NULL, NULL);
INSERT INTO sprints VALUES (15, 1, '6 mins treadmill', 3, 4, NULL, NULL);
INSERT INTO sprints VALUES (16, 2, '9 mins treadmill', 3, 6, NULL, NULL);
INSERT INTO sprints VALUES (17, 3, '15 mins treadmill', 3, 10, NULL, NULL);
INSERT INTO sprints VALUES (18, 4, '18 mins treadmill', 3, 12, NULL, NULL);


--
-- TOC entry 2640 (class 0 OID 0)
-- Dependencies: 256
-- Name: sprints_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brianregan
--

SELECT pg_catalog.setval('sprints_id_seq', 18, true);


--
-- TOC entry 2617 (class 0 OID 94271)
-- Dependencies: 259
-- Data for Name: tips; Type: TABLE DATA; Schema: public; Owner: brianregan
--

INSERT INTO tips VALUES (1, 2, 'Hold the bar with an overhand grip, about shoulder width apart.', 1, NULL, NULL);
INSERT INTO tips VALUES (2, 2, 'Step towards the bar so that your shin is nearly touching it.', 1, NULL, NULL);
INSERT INTO tips VALUES (3, 2, 'Keep your back straight, feet flat, and hips down.', 1, NULL, NULL);
INSERT INTO tips VALUES (4, 2, 'Push through your heels, and explode to a standing position, keeping your arms straight.', 1, NULL, NULL);
INSERT INTO tips VALUES (5, 2, 'Make sure your back is never rounded.', 1, NULL, NULL);
INSERT INTO tips VALUES (6, 2, 'You should be using your legs to lift the weight, not your arms.', 1, NULL, NULL);
INSERT INTO tips VALUES (7, 2, 'As your legs begin to straighten, shrug your shoulders, and go up on your toes.', 1, NULL, NULL);
INSERT INTO tips VALUES (8, 2, 'Lower the weight back towards the ground, keeping your arms and back straight.', 1, NULL, NULL);
INSERT INTO tips VALUES (9, 2, 'On the way down, shift your hips backwards, as if sitting in a chair.', 1, NULL, NULL);
INSERT INTO tips VALUES (10, 2, 'Hold the dumbbells at your side, feet about shoulder width apart.', 2, NULL, NULL);
INSERT INTO tips VALUES (11, 2, 'Move to a squating position, as if sitting in a chair.', 2, NULL, NULL);
INSERT INTO tips VALUES (12, 2, 'Jump as high as you can, while keeping your arms straight.', 2, NULL, NULL);
INSERT INTO tips VALUES (13, 2, 'When you land, catch your weight by shifting you hips backwards, as if sitting in a chair.', 2, NULL, NULL);
INSERT INTO tips VALUES (14, 2, 'Immediately explode into the next jump.', 2, NULL, NULL);
INSERT INTO tips VALUES (15, 2, 'Hold the bar with a wide, overhand grip.', 3, NULL, NULL);
INSERT INTO tips VALUES (16, 2, 'Step towards the bar so that your shin is nearly touching it.', 3, NULL, NULL);
INSERT INTO tips VALUES (17, 2, 'Keep your back straight, feet flat, and hips down.', 3, NULL, NULL);
INSERT INTO tips VALUES (18, 2, 'Push through your heels, and explode to a standing position, keeping your arms straight.', 3, NULL, NULL);
INSERT INTO tips VALUES (19, 2, 'Make sure your back is never rounded.', 3, NULL, NULL);
INSERT INTO tips VALUES (20, 2, 'You should be using your legs to lift the weight, not your arms.', 3, NULL, NULL);
INSERT INTO tips VALUES (21, 2, 'As your legs begin to straighten, shrug your shoulders, and go up on your toes.', 3, NULL, NULL);
INSERT INTO tips VALUES (22, 2, 'Lower the weight back towards the ground, keeping your arms and back straight.', 3, NULL, NULL);
INSERT INTO tips VALUES (23, 2, 'On the way down, shift your hips backwards, as if sitting in a chair.', 3, NULL, NULL);
INSERT INTO tips VALUES (24, 2, 'Place a dumbbell on the floor in between your feet, just in front of you.', 4, NULL, NULL);
INSERT INTO tips VALUES (25, 2, 'Squat down in front of the dumbbell, as if sitting in a chair.', 4, NULL, NULL);
INSERT INTO tips VALUES (26, 2, 'Keeping your back straight, grab the dumbbell.', 4, NULL, NULL);
INSERT INTO tips VALUES (27, 2, 'Pushing through your heels, explode into a standing position.', 4, NULL, NULL);
INSERT INTO tips VALUES (28, 2, 'As you are lifting the dumbbell, keep it close to your body.  On the way up, it should pass by the side of your head.', 4, NULL, NULL);
INSERT INTO tips VALUES (29, 2, 'As the dumbbell is passing your chest, shrug your shoulders and raise up on your toes.', 4, NULL, NULL);
INSERT INTO tips VALUES (30, 2, 'At the dumbbell''s highest point, rotate underneath the dumbbell into a catching base (move into a slightly wider stance.', 4, NULL, NULL);
INSERT INTO tips VALUES (31, 2, 'As the dumbbell begins to descend, keep your arms straight, and rotate your hips backwards slightly.', 4, NULL, NULL);
INSERT INTO tips VALUES (32, 2, 'Straighten your legs, and repeat the exercise.', 4, NULL, NULL);
INSERT INTO tips VALUES (33, 2, 'Stand straight up, holding the bar about shoulder width apart, with an overhand grip.', 5, NULL, NULL);
INSERT INTO tips VALUES (34, 2, 'Lower the bar to just above your kneecaps, by bending the knees slightly, and pushing your hips backwards.', 5, NULL, NULL);
INSERT INTO tips VALUES (35, 2, 'Keep your back straight at all times, and your head up', 5, NULL, NULL);
INSERT INTO tips VALUES (36, 2, 'Explode upward, while shrugging your shoulders, and keeping your arms straight.', 5, NULL, NULL);
INSERT INTO tips VALUES (37, 2, 'Land flat footed, while shifting your hips backwards.', 5, NULL, NULL);
INSERT INTO tips VALUES (38, 2, 'Lower the bar to the starting position, and repeat.', 5, NULL, NULL);
INSERT INTO tips VALUES (39, 2, 'Hold the bar with an overhand grip, about shoulder width apart.', 6, NULL, NULL);
INSERT INTO tips VALUES (40, 2, 'Step towards the bar so that your shin is nearly touching it.', 6, NULL, NULL);
INSERT INTO tips VALUES (41, 2, 'Keep your back straight, feet flat, and hips down.', 6, NULL, NULL);
INSERT INTO tips VALUES (42, 2, 'Push through your heels, and explode to a standing position, keeping your arms straight.', 6, NULL, NULL);
INSERT INTO tips VALUES (43, 2, 'Make sure your back is never rounded.', 6, NULL, NULL);
INSERT INTO tips VALUES (44, 2, 'You should be using your legs to lift the weight, not your arms.', 6, NULL, NULL);
INSERT INTO tips VALUES (45, 2, 'As your legs begin to straighten, shrug your shoulders, and go up on your toes.', 6, NULL, NULL);
INSERT INTO tips VALUES (46, 2, 'As the weight passes your thighs, begin bending your elbows, and continue to lift the weight up to your chin.', 6, NULL, NULL);
INSERT INTO tips VALUES (47, 2, 'Lower the weight back towards the ground, keeping your back straight.', 6, NULL, NULL);
INSERT INTO tips VALUES (48, 2, 'On the way down, shift your hips backwards, as if sitting in a chair.', 6, NULL, NULL);
INSERT INTO tips VALUES (49, 2, 'Hold the bar with a wide, overhand grip.', 7, NULL, NULL);
INSERT INTO tips VALUES (50, 2, 'Step towards the bar so that your shin is nearly touching it.', 7, NULL, NULL);
INSERT INTO tips VALUES (51, 2, 'Keep your back straight, feet flat, and hips down.', 7, NULL, NULL);
INSERT INTO tips VALUES (52, 2, 'Push through your heels, and explode to a standing position, keeping your arms straight.', 7, NULL, NULL);
INSERT INTO tips VALUES (53, 2, 'Make sure your back is never rounded.', 7, NULL, NULL);
INSERT INTO tips VALUES (54, 2, 'You should be using your legs to lift the weight, not your arms.', 7, NULL, NULL);
INSERT INTO tips VALUES (55, 2, 'As your legs begin to straighten, shrug your shoulders, and go up on your toes.', 7, NULL, NULL);
INSERT INTO tips VALUES (56, 2, 'As the weight passes your thighs, begin bending your elbows, and continue to lift the weight up to your chin.', 7, NULL, NULL);
INSERT INTO tips VALUES (57, 2, 'Lower the weight back towards the ground, keeping your back straight.', 7, NULL, NULL);
INSERT INTO tips VALUES (58, 2, 'On the way down, shift your hips backwards, as if sitting in a chair.', 7, NULL, NULL);
INSERT INTO tips VALUES (59, 2, 'Stand straight up, holding the bar about shoulder width apart, with an overhand grip.', 8, NULL, NULL);
INSERT INTO tips VALUES (60, 2, 'Lower the bar to just above your kneecaps, by bending the knees slightly, and pushing your hips backwards.', 8, NULL, NULL);
INSERT INTO tips VALUES (61, 2, 'Keep your back straight at all times, and your head up', 8, NULL, NULL);
INSERT INTO tips VALUES (62, 2, 'Push through your heels, and explode to a standing position.', 8, NULL, NULL);
INSERT INTO tips VALUES (63, 2, 'Make sure your back is never rounded.', 8, NULL, NULL);
INSERT INTO tips VALUES (64, 2, 'You should be using your legs to lift the weight, not your arms.', 8, NULL, NULL);
INSERT INTO tips VALUES (65, 2, 'As your legs begin to straighten, shrug your shoulders, and go up on your toes.', 8, NULL, NULL);
INSERT INTO tips VALUES (66, 2, 'As the weight passes your thighs, begin bending your elbows, and continue to lift the weight up to your chin.', 8, NULL, NULL);
INSERT INTO tips VALUES (67, 2, 'When the bar is at the highest point, rotate underneath it into a catching base (slightly wide stance, hips back).', 8, NULL, NULL);
INSERT INTO tips VALUES (68, 2, 'Rotate your elbows down and around the bar.', 8, NULL, NULL);
INSERT INTO tips VALUES (69, 2, 'Open your hands slightly, and finish the repetition with the bar resting on the front of your shoulders.', 8, NULL, NULL);
INSERT INTO tips VALUES (70, 2, 'Stand straight up, with an overhand, wide grip.', 9, NULL, NULL);
INSERT INTO tips VALUES (71, 2, 'Lower the bar to just above your kneecaps, by bending the knees slightly, and pushing your hips backwards.', 9, NULL, NULL);
INSERT INTO tips VALUES (72, 2, 'Keep your back straight at all times, and your head up', 9, NULL, NULL);
INSERT INTO tips VALUES (73, 2, 'Push through your heels, and explode to a standing position.', 9, NULL, NULL);
INSERT INTO tips VALUES (74, 2, 'Make sure your back is never rounded.', 9, NULL, NULL);
INSERT INTO tips VALUES (75, 2, 'You should be using your legs to lift the weight, not your arms.', 9, NULL, NULL);
INSERT INTO tips VALUES (76, 2, 'As your legs begin to straighten, shrug your shoulders, and go up on your toes.', 9, NULL, NULL);
INSERT INTO tips VALUES (77, 2, 'As the weight passes your thighs, begin bending your elbows, and continue to lift the weight up to your chin.', 9, NULL, NULL);
INSERT INTO tips VALUES (78, 2, 'When the bar is at the highest point, rotate underneath it into a catching base (slightly wide stance, hips back).', 9, NULL, NULL);
INSERT INTO tips VALUES (79, 2, 'Rotate your elbows down and around the bar.', 9, NULL, NULL);
INSERT INTO tips VALUES (80, 2, 'Open your hands slightly, and finish the repetition with the bar resting on the front of your shoulders.', 9, NULL, NULL);
INSERT INTO tips VALUES (81, 2, 'Hold the bar with an overhand grip, about shoulder width apart.', 10, NULL, NULL);
INSERT INTO tips VALUES (82, 2, 'Step towards the bar so that your shin is nearly touching it.', 10, NULL, NULL);
INSERT INTO tips VALUES (83, 2, 'Keep your back straight, feet flat, and hips down.', 10, NULL, NULL);
INSERT INTO tips VALUES (84, 2, 'Push through your heels, and explode to a standing position.', 10, NULL, NULL);
INSERT INTO tips VALUES (85, 2, 'Make sure your back is never rounded.', 10, NULL, NULL);
INSERT INTO tips VALUES (86, 2, 'You should be using your legs to lift the weight, not your arms.', 10, NULL, NULL);
INSERT INTO tips VALUES (87, 2, 'As your legs begin to straighten, shrug your shoulders, and go up on your toes.', 10, NULL, NULL);
INSERT INTO tips VALUES (88, 2, 'As the weight passes your thighs, begin bending your elbows, and continue to lift the weight up to your chin.', 10, NULL, NULL);
INSERT INTO tips VALUES (89, 2, 'When the bar is at the highest point, rotate underneath it into a catching base (slightly wide stance, hips back).', 10, NULL, NULL);
INSERT INTO tips VALUES (90, 2, 'Rotate your elbows down and around the bar.', 10, NULL, NULL);
INSERT INTO tips VALUES (91, 2, 'Open your hands slightly, and finish the repetition with the bar resting on the front of your shoulders.', 10, NULL, NULL);
INSERT INTO tips VALUES (92, 2, 'Hold the bar with a wide, overhand grip.', 11, NULL, NULL);
INSERT INTO tips VALUES (93, 2, 'Step towards the bar so that your shin is nearly touching it.', 11, NULL, NULL);
INSERT INTO tips VALUES (94, 2, 'Keep your back straight, feet flat, and hips down.', 11, NULL, NULL);
INSERT INTO tips VALUES (95, 2, 'Push through your heels, and explode to a standing position.', 11, NULL, NULL);
INSERT INTO tips VALUES (96, 2, 'Make sure your back is never rounded.', 11, NULL, NULL);
INSERT INTO tips VALUES (97, 2, 'You should be using your legs to lift the weight, not your arms.', 11, NULL, NULL);
INSERT INTO tips VALUES (98, 2, 'As your legs begin to straighten, shrug your shoulders, and go up on your toes.', 11, NULL, NULL);
INSERT INTO tips VALUES (99, 2, 'As the weight passes your thighs, begin bending your elbows, and continue to lift the weight up to your chin.', 11, NULL, NULL);
INSERT INTO tips VALUES (100, 2, 'When the bar is at the highest point, rotate underneath it into a catching base (slightly wide stance, hips back).', 11, NULL, NULL);
INSERT INTO tips VALUES (101, 2, 'Rotate your elbows down and around the bar.', 11, NULL, NULL);
INSERT INTO tips VALUES (102, 2, 'Open your hands slightly, and finish the repetition with the bar resting on the front of your shoulders.', 11, NULL, NULL);
INSERT INTO tips VALUES (103, 2, 'Place the bar behind your head, resting on the back of your shoulders.', 12, NULL, NULL);
INSERT INTO tips VALUES (104, 2, 'Stand with your feet about hip width apart.', 12, NULL, NULL);
INSERT INTO tips VALUES (105, 2, 'Step forward as far as possible, landing on your heel.', 12, NULL, NULL);
INSERT INTO tips VALUES (106, 2, 'Lower your body until your back knee is nearly touching the ground.', 12, NULL, NULL);
INSERT INTO tips VALUES (107, 2, 'Immediately push through the heel, and drive yourself back to the starting position.', 12, NULL, NULL);
INSERT INTO tips VALUES (108, 2, 'One repetition = performing the lunge with each leg once.', 12, NULL, NULL);
INSERT INTO tips VALUES (109, 2, 'Place the bar behind your head, resting on the back of your shoulders.', 13, NULL, NULL);
INSERT INTO tips VALUES (110, 2, 'Stand with your feet about hip width apart.', 13, NULL, NULL);
INSERT INTO tips VALUES (111, 2, 'Step backward as far as possible, landing on the ball of your foot.', 13, NULL, NULL);
INSERT INTO tips VALUES (112, 2, 'Lower your body until your back knee is nearly touching the ground.', 13, NULL, NULL);
INSERT INTO tips VALUES (113, 2, 'Immediately push through the heel, and drive yourself back to the starting position.', 13, NULL, NULL);
INSERT INTO tips VALUES (114, 2, 'One repetition = performing the lunge with each leg once.', 13, NULL, NULL);
INSERT INTO tips VALUES (115, 2, 'Place the bar behind your head, resting on the back of your shoulders.', 14, NULL, NULL);
INSERT INTO tips VALUES (116, 2, 'Stand with your feet close together.', 14, NULL, NULL);
INSERT INTO tips VALUES (117, 2, 'Step sideways, as far as possible, landing flat footed.', 14, NULL, NULL);
INSERT INTO tips VALUES (118, 2, 'Place the bar behind your head, resting on the back of your shoulders.', 14, NULL, NULL);
INSERT INTO tips VALUES (119, 2, 'Lower into a lunge position, and then immediately drive your self back to the starting position.', 14, NULL, NULL);
INSERT INTO tips VALUES (120, 2, 'One repetition = performing the lunge with each leg once.', 14, NULL, NULL);
INSERT INTO tips VALUES (121, 2, 'Place the bar behind your head, resting on the back of your shoulders.', 15, NULL, NULL);
INSERT INTO tips VALUES (122, 2, 'Stand with your feet about hip width apart.', 15, NULL, NULL);
INSERT INTO tips VALUES (123, 2, 'Step one leg backwards, and across the opposite leg, landing on the ball of your foot.', 15, NULL, NULL);
INSERT INTO tips VALUES (124, 2, 'Lower into a lunge position, and then immediately drive your self back to the starting position.', 15, NULL, NULL);
INSERT INTO tips VALUES (125, 2, 'One repetition = performing the lunge with each leg once.', 15, NULL, NULL);
INSERT INTO tips VALUES (126, 2, 'Place the bar behind your head, resting on the back of your shoulders.', 16, NULL, NULL);
INSERT INTO tips VALUES (127, 2, 'Step up, until your other foot is even with the bench (but do not place it on the bench).', 16, NULL, NULL);
INSERT INTO tips VALUES (128, 2, 'Lower back down and repeat.', 16, NULL, NULL);
INSERT INTO tips VALUES (129, 2, 'Do all of your repetitions with one leg, and then switch legs.', 16, NULL, NULL);
INSERT INTO tips VALUES (130, 2, 'Place the bar behind your head, resting on the back of your shoulders.', 17, NULL, NULL);
INSERT INTO tips VALUES (131, 2, 'Attempt to keep your toe pointed straight ahead, as you step your outside foot onto the bench.', 17, NULL, NULL);
INSERT INTO tips VALUES (132, 2, 'One repetition is performing this exercise with both legs once.', 17, NULL, NULL);
INSERT INTO tips VALUES (133, 2, 'Place the bar behind your head, resting on the back of your shoulders.', 18, NULL, NULL);
INSERT INTO tips VALUES (134, 2, 'Place one foot out in front of you, with the top of your other foot resting on a bench or box behind you.', 18, NULL, NULL);
INSERT INTO tips VALUES (135, 2, 'Descend, keeping your back straight, and drive back to the starting position through your heel.', 18, NULL, NULL);
INSERT INTO tips VALUES (136, 2, 'Grip the bar with and overhand grip, about shoulder width apart.', 19, NULL, NULL);
INSERT INTO tips VALUES (137, 2, 'Place one foot out in front of you, with the top of your other foot resting on a bench or box behind you.', 19, NULL, NULL);
INSERT INTO tips VALUES (138, 2, 'As you descend, control the weight with your front leg, shift your hips back, and keep your arms straight.', 19, NULL, NULL);
INSERT INTO tips VALUES (139, 2, 'Drive through your heel and return to the starting position, while simultaneously straightening your leg and leaning back.', 19, NULL, NULL);
INSERT INTO tips VALUES (140, 2, 'Shift your hips backward, as if sitting in a chair.', 20, NULL, NULL);
INSERT INTO tips VALUES (141, 2, 'Drive through your heels, back to the starting position.', 20, NULL, NULL);
INSERT INTO tips VALUES (142, 2, 'Perform all repetitions with one leg, and then switch legs.', 20, NULL, NULL);
INSERT INTO tips VALUES (143, 2, 'Stand with your feet about shoulder width apart.', 21, NULL, NULL);
INSERT INTO tips VALUES (144, 2, 'Place the bar behind your head, resting on the back of your shoulders.', 21, NULL, NULL);
INSERT INTO tips VALUES (145, 2, 'Shift your hips backward, as if sitting in a chair.', 21, NULL, NULL);
INSERT INTO tips VALUES (146, 2, 'Drive through your heels, back to the starting position.', 21, NULL, NULL);
INSERT INTO tips VALUES (147, 2, 'Keep your back rigid.', 21, NULL, NULL);
INSERT INTO tips VALUES (148, 2, 'Stand with your feet about shoulder width apart.', 22, NULL, NULL);
INSERT INTO tips VALUES (149, 2, 'Place the bar across the front of your shoulders, at the base of your neck.', 22, NULL, NULL);
INSERT INTO tips VALUES (150, 2, 'Shift your hips backward, as if sitting in a chair.', 22, NULL, NULL);
INSERT INTO tips VALUES (151, 2, 'Drive through your heels, back to the starting position.', 22, NULL, NULL);
INSERT INTO tips VALUES (152, 2, 'Keep your back rigid.', 22, NULL, NULL);
INSERT INTO tips VALUES (153, 2, 'Using a wide grip, start with the bar resting on the back of your neck.', 23, NULL, NULL);
INSERT INTO tips VALUES (154, 2, 'Lift the bar above your head and lock your arms.', 23, NULL, NULL);
INSERT INTO tips VALUES (155, 2, 'Keep your back tensed and rigid.', 23, NULL, NULL);
INSERT INTO tips VALUES (156, 2, 'Keep your upper body as vertical as possible.', 23, NULL, NULL);
INSERT INTO tips VALUES (157, 2, 'Descend, while shifting your hips backward.', 23, NULL, NULL);
INSERT INTO tips VALUES (158, 2, 'Drive upward, back to the starting position.', 23, NULL, NULL);
INSERT INTO tips VALUES (159, 2, 'Keep the bar extended above your head until all repetitions have been performed.', 23, NULL, NULL);
INSERT INTO tips VALUES (160, 2, 'Keep your back straight at all times.', 24, NULL, NULL);
INSERT INTO tips VALUES (161, 2, 'Descend, then push back to the start position with both legs.', 24, NULL, NULL);
INSERT INTO tips VALUES (162, 2, 'Perform all repetitions with one leg, and then switch.', 24, NULL, NULL);
INSERT INTO tips VALUES (163, 2, 'Stand with a wide stance, and your toes pointed slightly outward.', 25, NULL, NULL);
INSERT INTO tips VALUES (164, 2, 'Move to the right and down, pushing your hips backward, and keeping your feet flat.', 25, NULL, NULL);
INSERT INTO tips VALUES (165, 2, 'Push back to the starting position, and repeat moving left and down-this is one repetition.', 25, NULL, NULL);
INSERT INTO tips VALUES (166, 2, 'Slightly bend one knee, and lift the other foot off the floor.', 26, NULL, NULL);
INSERT INTO tips VALUES (167, 2, 'Lean forward, while pushing your hips backward, and keeping your head up.', 26, NULL, NULL);
INSERT INTO tips VALUES (168, 2, 'Complete all repetitions with one leg, and then switch.', 26, NULL, NULL);
INSERT INTO tips VALUES (169, 2, 'Slightly bend one knee, and lift the other foot off the floor.', 27, NULL, NULL);
INSERT INTO tips VALUES (170, 2, 'Hold the bar slightly wider than shoulder width.', 27, NULL, NULL);
INSERT INTO tips VALUES (171, 2, 'Lean forward, keeping your head up.', 27, NULL, NULL);
INSERT INTO tips VALUES (172, 2, 'Complete all repetitions with one leg, and then switch.', 27, NULL, NULL);
INSERT INTO tips VALUES (173, 2, 'Keep your shoulders level-don''t twist your upper body.', 28, NULL, NULL);
INSERT INTO tips VALUES (174, 2, 'Complete all repetitions with one leg, and then switch.', 28, NULL, NULL);
INSERT INTO tips VALUES (175, 2, 'Don''t twist your upper body.', 29, NULL, NULL);
INSERT INTO tips VALUES (176, 2, 'Complete all repetitions with one leg, and then switch.', 29, NULL, NULL);
INSERT INTO tips VALUES (177, 2, 'Don''t twist your upper body.', 30, NULL, NULL);
INSERT INTO tips VALUES (178, 2, 'Complete all repetitions with one leg, and then switch.', 30, NULL, NULL);
INSERT INTO tips VALUES (179, 2, 'Keep knees slightly bent at all times.', 31, NULL, NULL);
INSERT INTO tips VALUES (180, 2, 'Keep your head up.', 31, NULL, NULL);
INSERT INTO tips VALUES (181, 2, 'Keep your lower back arched, not rounded.', 31, NULL, NULL);
INSERT INTO tips VALUES (182, 2, 'Keep knees slightly bent at all times.', 32, NULL, NULL);
INSERT INTO tips VALUES (183, 2, 'Keep your head up.', 32, NULL, NULL);
INSERT INTO tips VALUES (184, 2, 'Push your hips back as you bend forward.', 32, NULL, NULL);
INSERT INTO tips VALUES (185, 2, 'Keep your lower back arched, not rounded.', 32, NULL, NULL);
INSERT INTO tips VALUES (186, 2, 'With your off arm, do not grab on to anything for leverage.', 33, NULL, NULL);
INSERT INTO tips VALUES (187, 2, 'Place the pad low enough on the back of your leg so that you have full range of motion, bending at the waist.', 34, NULL, NULL);
INSERT INTO tips VALUES (188, 2, 'Don''t twist your upper body.', 34, NULL, NULL);
INSERT INTO tips VALUES (189, 2, 'Raise your hips until they are fully extended.', 35, NULL, NULL);
INSERT INTO tips VALUES (190, 2, 'Move the ball, pulling with your hamstrings.', 36, NULL, NULL);
INSERT INTO tips VALUES (192, 2, 'When you lower the weight, your arm should be bent at a 90 degree angle.', 38, NULL, NULL);
INSERT INTO tips VALUES (193, 2, 'When you lower the weight, your arm should be bent at a 90 degree angle.', 39, NULL, NULL);
INSERT INTO tips VALUES (194, 2, 'When you lower the weight, your arm should be bent at a 90 degree angle.', 40, NULL, NULL);
INSERT INTO tips VALUES (195, 2, 'Keep your arms in constant motion, like pistons.', 41, NULL, NULL);
INSERT INTO tips VALUES (196, 2, 'Keep your arms in constant motion, like pistons.', 42, NULL, NULL);
INSERT INTO tips VALUES (197, 2, 'Keep your arms in constant motion, like pistons.', 43, NULL, NULL);
INSERT INTO tips VALUES (198, 2, 'With your off arm, do not grab on to anything for leverage.', 44, NULL, NULL);
INSERT INTO tips VALUES (199, 2, 'With your off arm, do not grab on to anything for leverage.', 45, NULL, NULL);
INSERT INTO tips VALUES (200, 2, 'You can perform this with your feet even, or slightly staggered.', 46, NULL, NULL);
INSERT INTO tips VALUES (201, 2, 'On the way down, touch the bar gently on your chest. Do not bounce the weight off your chest.', 47, NULL, NULL);
INSERT INTO tips VALUES (202, 2, 'On the way down, touch the bar gently on your chest. Do not bounce the weight off your chest.', 48, NULL, NULL);
INSERT INTO tips VALUES (203, 2, 'Keep your arms perpendicular to the floor.', 49, NULL, NULL);
INSERT INTO tips VALUES (204, 2, 'Grip the bar, slightly wider than your outer chest.  This will put emphasis on your inner chest and triceps.', 50, NULL, NULL);
INSERT INTO tips VALUES (205, 2, 'Grip the bar, slightly wider than your outer chest.  This will put emphasis on your inner chest and triceps.', 51, NULL, NULL);
INSERT INTO tips VALUES (206, 2, 'Grip the bar, slightly wider than your outer chest.  This will put emphasis on your inner chest and triceps.', 52, NULL, NULL);
INSERT INTO tips VALUES (207, 2, 'Keep your back straight.', 53, NULL, NULL);
INSERT INTO tips VALUES (208, 2, 'Use an overhand grip.', 54, NULL, NULL);
INSERT INTO tips VALUES (209, 2, 'Keep your back straight.', 55, NULL, NULL);
INSERT INTO tips VALUES (210, 2, 'Keep your back straight.', 56, NULL, NULL);
INSERT INTO tips VALUES (211, 2, 'Lower yourself until your upper arm is parallel with the ground.', 57, NULL, NULL);
INSERT INTO tips VALUES (212, 2, 'Lower yourself until your upper arm is parallel with the ground.', 58, NULL, NULL);
INSERT INTO tips VALUES (213, 2, 'Lower yourself until your upper arm is parallel with the ground.', 59, NULL, NULL);
INSERT INTO tips VALUES (214, 2, 'Perform the total number of recommended repetitions with each arm.', 60, NULL, NULL);
INSERT INTO tips VALUES (215, 2, 'Lower the weight to shoulder height, then extend arms fully.', 61, NULL, NULL);
INSERT INTO tips VALUES (216, 2, 'Perform the total number of recommended repetitions with each arm.', 62, NULL, NULL);
INSERT INTO tips VALUES (217, 2, 'Don''t round your back.  Keep your lower back arched.', 63, NULL, NULL);
INSERT INTO tips VALUES (218, 2, 'Grip the bar at about shoulder width.', 64, NULL, NULL);
INSERT INTO tips VALUES (219, 2, 'This can be performed with the bar in front, or behind your head.', 64, NULL, NULL);
INSERT INTO tips VALUES (220, 2, 'Keep looking forward at all times.', 64, NULL, NULL);
INSERT INTO tips VALUES (221, 2, 'Using your legs as well as your arms, push the weight up.', 65, NULL, NULL);
INSERT INTO tips VALUES (222, 2, 'As the weight reaches the apex, bend your knees and widen your stance to catch the weight.', 65, NULL, NULL);
INSERT INTO tips VALUES (223, 2, 'Reset your stance, lower the weight, and repeat.', 65, NULL, NULL);
INSERT INTO tips VALUES (224, 2, 'Using your legs as well as your arms, push the weight up.', 66, NULL, NULL);
INSERT INTO tips VALUES (225, 2, 'As the weight reaches the apex, pop into a lunge position.', 66, NULL, NULL);
INSERT INTO tips VALUES (226, 2, 'Reset your stance, lower the weight, and repeat.', 66, NULL, NULL);
INSERT INTO tips VALUES (227, 2, 'Do not perform the total number of recommended repetitions on each side.', 66, NULL, NULL);
INSERT INTO tips VALUES (228, 2, 'For this exercise, you will perform half of the total of recommended repetitions on each side.', 66, NULL, NULL);
INSERT INTO tips VALUES (229, 2, 'Keep your back straight.', 67, NULL, NULL);
INSERT INTO tips VALUES (230, 2, 'Don''t round your back.  Keep your lower back arched.', 68, NULL, NULL);
INSERT INTO tips VALUES (231, 2, 'Perform the total number of recommended repetitions with each arm.', 69, NULL, NULL);
INSERT INTO tips VALUES (232, 2, 'Don''t round your back.  Keep your lower back arched.', 69, NULL, NULL);
INSERT INTO tips VALUES (233, 2, 'Perform the total number of recommended repetitions with each arm.', 70, NULL, NULL);
INSERT INTO tips VALUES (234, 2, 'Don''t rotate your upper body.', 70, NULL, NULL);
INSERT INTO tips VALUES (235, 2, 'Set the bar at a height so that, with your arms fully extended, your lower body is off of the floor.', 71, NULL, NULL);
INSERT INTO tips VALUES (236, 2, 'Use an overhand grip.', 72, NULL, NULL);
INSERT INTO tips VALUES (237, 2, 'Keep your knees slightly bent and lower back arched.', 73, NULL, NULL);
INSERT INTO tips VALUES (238, 2, 'Keep your knees slightly bent and lower back arched.', 74, NULL, NULL);
INSERT INTO tips VALUES (239, 2, 'Grip the bar with both hands, close to the weight.', 75, NULL, NULL);
INSERT INTO tips VALUES (240, 2, 'Set the bar at a height so that, with your arms fully extended, your lower body is off of the floor.', 76, NULL, NULL);
INSERT INTO tips VALUES (241, 2, 'Set the bar at a height so that, with your arms fully extended, your body is in a declined position.', 77, NULL, NULL);
INSERT INTO tips VALUES (242, 2, 'Keep your knees slightly bent and your weight back.', 78, NULL, NULL);
INSERT INTO tips VALUES (243, 2, 'When you finish a repetition, your arms should be in a position such that you like you''re flexing your biceps.', 79, NULL, NULL);
INSERT INTO tips VALUES (244, 2, 'Do not bend or rotate your upper body.', 80, NULL, NULL);
INSERT INTO tips VALUES (245, 2, 'Set your grip wider than shoulder width.', 81, NULL, NULL);
INSERT INTO tips VALUES (246, 2, 'Avoid leaning back.', 82, NULL, NULL);
INSERT INTO tips VALUES (247, 2, 'Use an underhand grip', 83, NULL, NULL);
INSERT INTO tips VALUES (248, 2, 'Use an overhand grip.', 84, NULL, NULL);
INSERT INTO tips VALUES (249, 2, 'Use an overhand grip.', 85, NULL, NULL);
INSERT INTO tips VALUES (250, 2, 'Lean back far enough to feel your abdominal muscles flex.', 86, NULL, NULL);
INSERT INTO tips VALUES (251, 2, 'Twist as far as possible, and touch the weight to the floor behind you.', 86, NULL, NULL);
INSERT INTO tips VALUES (252, 2, 'This can be performed with the heels on or off the floor.', 86, NULL, NULL);
INSERT INTO tips VALUES (253, 2, 'Keep your feet on the ground at all times.', 87, NULL, NULL);
INSERT INTO tips VALUES (254, 2, 'Touch the weight on the floor behind you.', 87, NULL, NULL);
INSERT INTO tips VALUES (255, 2, 'Twist up, and reach back with the weight as far as you can.', 87, NULL, NULL);
INSERT INTO tips VALUES (256, 2, 'Perform all reps on one side, and then switch sides.', 87, NULL, NULL);
INSERT INTO tips VALUES (257, 2, 'Start with your upper body parallel to the floor.', 88, NULL, NULL);
INSERT INTO tips VALUES (258, 2, 'Your knees should be bent at a 90 degree angle.', 89, NULL, NULL);
INSERT INTO tips VALUES (259, 2, 'Perform all reps on one side, and then switch sides.', 90, NULL, NULL);
INSERT INTO tips VALUES (260, 2, 'Perform all reps on one side, and then switch sides.', 91, NULL, NULL);
INSERT INTO tips VALUES (261, 2, 'Perform all reps on one side, and then switch sides.', 92, NULL, NULL);
INSERT INTO tips VALUES (262, 2, 'Perform all reps on one side, and then switch sides.', 93, NULL, NULL);
INSERT INTO tips VALUES (263, 2, 'Perform all reps on one side, and then switch sides.', 94, NULL, NULL);
INSERT INTO tips VALUES (264, 2, 'When the ball bounces off the wall, catch it, and rotate down in one motion-repeat the exercise.', 95, NULL, NULL);
INSERT INTO tips VALUES (265, 2, 'This can be performed with your heels on or off the ground.', 96, NULL, NULL);
INSERT INTO tips VALUES (266, 2, 'Lean back far enough to engage the abdominal muscles.', 96, NULL, NULL);
INSERT INTO tips VALUES (267, 2, 'When the ball bounces off the wall, catch it, and rotate down in one motion-repeat the exercise.', 97, NULL, NULL);
INSERT INTO tips VALUES (268, 2, 'Keep your back straight.', 98, NULL, NULL);
INSERT INTO tips VALUES (269, 2, 'Don''t tilt your body to one side or the other.', 99, NULL, NULL);
INSERT INTO tips VALUES (270, 2, 'Don''t tilt your body to one side or the other.', 100, NULL, NULL);
INSERT INTO tips VALUES (271, 2, 'Keep your body in a straight line, don''t let your hips sag.', 101, NULL, NULL);
INSERT INTO tips VALUES (272, 2, 'Perform the recommended time on each side.', 101, NULL, NULL);
INSERT INTO tips VALUES (273, 2, 'Keep your body in a straight line, don''t let your hips sag.', 102, NULL, NULL);
INSERT INTO tips VALUES (274, 2, 'Keep your body in a straight line, don''t let your hips sag.', 103, NULL, NULL);
INSERT INTO tips VALUES (275, 2, 'Maintain constant, slow movement for the recommended time.', 104, NULL, NULL);
INSERT INTO tips VALUES (276, 2, 'Alternate knee/elbow halfway through the recommended time.', 105, NULL, NULL);
INSERT INTO tips VALUES (277, 2, 'Maintain constant, slow movement for the recommended time.', 106, NULL, NULL);
INSERT INTO tips VALUES (278, 2, 'Perform for the recommended time, on each side.', 106, NULL, NULL);
INSERT INTO tips VALUES (279, 2, 'Lower the weight slowly, maintaining balance.', 107, NULL, NULL);
INSERT INTO tips VALUES (280, 2, 'Roll out as far as possible, and pause for a second.', 108, NULL, NULL);
INSERT INTO tips VALUES (281, 2, 'Focus on pulling the weight back in with your abdominals.', 108, NULL, NULL);
INSERT INTO tips VALUES (282, 2, 'Simultaneously lift your legs, while sitting up.', 109, NULL, NULL);
INSERT INTO tips VALUES (283, 2, 'Keep your legs straight.', 110, NULL, NULL);
INSERT INTO tips VALUES (284, 2, 'At the apex of the crunch, lift your lower back off of the floor.', 111, NULL, NULL);
INSERT INTO tips VALUES (285, 2, 'Keep your elbows locked.', 112, NULL, NULL);
INSERT INTO tips VALUES (286, 2, 'Lower your feet to 4-6 inches off of the ground.', 113, NULL, NULL);
INSERT INTO tips VALUES (287, 2, 'Allow the Swiss ball to make contact with your lower back.', 114, NULL, NULL);
INSERT INTO tips VALUES (288, 2, 'Keep your feet flat on the floor.', 115, NULL, NULL);
INSERT INTO tips VALUES (289, 2, 'Your back will curve, but attempt to keep it as straight as possible, using your abs to raise and lower your upper body.', 115, NULL, NULL);
INSERT INTO tips VALUES (290, 2, 'Don''t allow your feet to touch the floor.', 116, NULL, NULL);
INSERT INTO tips VALUES (291, 2, 'Keep your elbows locked, and arms straight out in front of you.', 117, NULL, NULL);
INSERT INTO tips VALUES (292, 2, 'Place your hands, slightly wider than shoulder width apart.', 118, NULL, NULL);
INSERT INTO tips VALUES (293, 2, 'Place your hands, slightly wider than shoulder width apart.', 119, NULL, NULL);
INSERT INTO tips VALUES (294, 2, 'Keep your back as vertical as possible.', 120, NULL, NULL);
INSERT INTO tips VALUES (295, 2, 'Keep your back as vertical as possible.', 121, NULL, NULL);
INSERT INTO tips VALUES (296, 2, 'Don''t twist your upper body, keep your shoulders squared.', 122, NULL, NULL);
INSERT INTO tips VALUES (297, 2, 'When you step up, step forward as well.', 122, NULL, NULL);
INSERT INTO tips VALUES (298, 2, 'When you step down, step back as well.', 122, NULL, NULL);
INSERT INTO tips VALUES (299, 2, 'Keep your back straight.', 123, NULL, NULL);
INSERT INTO tips VALUES (300, 2, 'Don''t twist your upper body, keep your shoulders squared.', 124, NULL, NULL);
INSERT INTO tips VALUES (301, 2, 'Don''t twist your upper body, keep your shoulders squared.', 125, NULL, NULL);
INSERT INTO tips VALUES (302, 2, 'When you step up, step forward as well.', 125, NULL, NULL);
INSERT INTO tips VALUES (303, 2, 'When you step down, step back as well.', 125, NULL, NULL);
INSERT INTO tips VALUES (304, 2, 'Hold the bar with an overhand grip, about shoulder width apart.', 126, NULL, NULL);
INSERT INTO tips VALUES (305, 2, 'Step towards the bar so that your shin is nearly touching it.', 126, NULL, NULL);
INSERT INTO tips VALUES (306, 2, 'Keep your back straight, feet flat, and hips down.', 126, NULL, NULL);
INSERT INTO tips VALUES (307, 2, 'Push through your heels, and explode to a standing position.', 126, NULL, NULL);
INSERT INTO tips VALUES (308, 2, 'Make sure your back is never rounded.', 126, NULL, NULL);
INSERT INTO tips VALUES (309, 2, 'You should be using your legs to lift the weight, not your arms.', 126, NULL, NULL);
INSERT INTO tips VALUES (310, 2, 'As your legs begin to straighten, shrug your shoulders, and go up on your toes.', 126, NULL, NULL);
INSERT INTO tips VALUES (311, 2, 'As the weight passes your thighs, begin bending your elbows, and continue to lift the weight up to your chin.', 126, NULL, NULL);
INSERT INTO tips VALUES (312, 2, 'When the bar is at the highest point, rotate underneath it into a catching base (slightly wide stance, hips back).', 126, NULL, NULL);
INSERT INTO tips VALUES (313, 2, 'Rotate your elbows down and around the bar.', 126, NULL, NULL);
INSERT INTO tips VALUES (314, 2, 'Open your hands slightly, and catch the weight with the bar resting on the front of your shoulders.', 126, NULL, NULL);
INSERT INTO tips VALUES (315, 2, 'Explode up, using your legs to help lift the weight above your head.', 126, NULL, NULL);
INSERT INTO tips VALUES (316, 2, 'Jump into a lunge position.', 126, NULL, NULL);
INSERT INTO tips VALUES (317, 2, 'The weight should be fully extended at the same time that your feet hit the floor.', 126, NULL, NULL);
INSERT INTO tips VALUES (318, 2, 'Hold the bar with an overhand grip, about shoulder width apart.', 127, NULL, NULL);
INSERT INTO tips VALUES (319, 2, 'Step towards the bar so that your shin is nearly touching it.', 127, NULL, NULL);
INSERT INTO tips VALUES (320, 2, 'Keep your back straight, feet flat, and hips down.', 127, NULL, NULL);
INSERT INTO tips VALUES (321, 2, 'Push through your heels, and explode to a standing position.', 127, NULL, NULL);
INSERT INTO tips VALUES (322, 2, 'Make sure your back is never rounded.', 127, NULL, NULL);
INSERT INTO tips VALUES (323, 2, 'You should be using your legs to lift the weight, not your arms.', 127, NULL, NULL);
INSERT INTO tips VALUES (324, 2, 'As your legs begin to straighten, shrug your shoulders, and go up on your toes.', 127, NULL, NULL);
INSERT INTO tips VALUES (325, 2, 'As the weight passes your thighs, begin bending your elbows, and continue to lift the weight up to your chin.', 127, NULL, NULL);
INSERT INTO tips VALUES (326, 2, 'When the bar is at the highest point, rotate underneath it into a catching base (slightly wide stance, hips back).', 127, NULL, NULL);
INSERT INTO tips VALUES (327, 2, 'Rotate your elbows down and around the bar.', 127, NULL, NULL);
INSERT INTO tips VALUES (328, 2, 'Open your hands slightly, and catch the weight with the bar resting on the front of your shoulders.', 127, NULL, NULL);
INSERT INTO tips VALUES (329, 2, 'Explode up, using your legs to help lift the weight above your head.', 127, NULL, NULL);
INSERT INTO tips VALUES (330, 2, 'Hold the bar with an overhand grip, about shoulder width apart.', 128, NULL, NULL);
INSERT INTO tips VALUES (331, 2, 'Lower the bar to just above your kneecaps, by bending the knees slightly, and pushing your hips backwards.', 128, NULL, NULL);
INSERT INTO tips VALUES (332, 2, 'Keep your back straight at all times, and your head up', 128, NULL, NULL);
INSERT INTO tips VALUES (333, 2, 'Push through your heels, and explode to a standing position.', 128, NULL, NULL);
INSERT INTO tips VALUES (334, 2, 'Make sure your back is never rounded.', 128, NULL, NULL);
INSERT INTO tips VALUES (335, 2, 'You should be using your legs to lift the weight, not your arms.', 128, NULL, NULL);
INSERT INTO tips VALUES (336, 2, 'As your legs begin to straighten, shrug your shoulders, and go up on your toes.', 128, NULL, NULL);
INSERT INTO tips VALUES (337, 2, 'As the weight passes your thighs, begin bending your elbows, and continue to lift the weight up to your chin.', 128, NULL, NULL);
INSERT INTO tips VALUES (338, 2, 'When the bar is at the highest point, rotate underneath it into a catching base (slightly wide stance, hips back).', 128, NULL, NULL);
INSERT INTO tips VALUES (339, 2, 'Rotate your elbows down and around the bar.', 128, NULL, NULL);
INSERT INTO tips VALUES (340, 2, 'Open your hands slightly, and catch the weight with the bar resting on the front of your shoulders.', 128, NULL, NULL);
INSERT INTO tips VALUES (341, 2, 'Explode up, using your legs to help lift the weight above your head.', 128, NULL, NULL);
INSERT INTO tips VALUES (342, 2, 'Jump into a lunge position.', 128, NULL, NULL);
INSERT INTO tips VALUES (343, 2, 'The weight should be fully extended at the same time that your feet hit the floor.', 128, NULL, NULL);
INSERT INTO tips VALUES (344, 2, 'Hold the bar with an overhand grip, about shoulder width apart.', 129, NULL, NULL);
INSERT INTO tips VALUES (345, 2, 'Lower the bar to just above your kneecaps, by bending the knees slightly, and pushing your hips backwards.', 129, NULL, NULL);
INSERT INTO tips VALUES (346, 2, 'Keep your back straight at all times, and your head up', 129, NULL, NULL);
INSERT INTO tips VALUES (347, 2, 'Push through your heels, and explode to a standing position.', 129, NULL, NULL);
INSERT INTO tips VALUES (348, 2, 'Make sure your back is never rounded.', 129, NULL, NULL);
INSERT INTO tips VALUES (349, 2, 'You should be using your legs to lift the weight, not your arms.', 129, NULL, NULL);
INSERT INTO tips VALUES (350, 2, 'As your legs begin to straighten, shrug your shoulders, and go up on your toes.', 129, NULL, NULL);
INSERT INTO tips VALUES (351, 2, 'As the weight passes your thighs, begin bending your elbows, and continue to lift the weight up to your chin.', 129, NULL, NULL);
INSERT INTO tips VALUES (352, 2, 'When the bar is at the highest point, rotate underneath it into a catching base (slightly wide stance, hips back).', 129, NULL, NULL);
INSERT INTO tips VALUES (353, 2, 'Rotate your elbows down and around the bar.', 129, NULL, NULL);
INSERT INTO tips VALUES (354, 2, 'Open your hands slightly, and catch the weight with the bar resting on the front of your shoulders.', 129, NULL, NULL);
INSERT INTO tips VALUES (355, 2, 'Explode up, using your legs to help lift the weight above your head.', 129, NULL, NULL);
INSERT INTO tips VALUES (356, 2, 'Stand with your feet staggered.', 130, NULL, NULL);
INSERT INTO tips VALUES (357, 2, 'Using your legs as well as your arms, push the weight up.', 130, NULL, NULL);
INSERT INTO tips VALUES (358, 2, 'Perform half of the repetitions with, then switch your stance to put the other foot forward, and perform the rest of the reps.', 130, NULL, NULL);
INSERT INTO tips VALUES (359, 1, 'Get on your hands and knees.', 1, NULL, NULL);
INSERT INTO tips VALUES (360, 1, 'Straighten your legs, but keep them slightly bent.', 1, NULL, NULL);
INSERT INTO tips VALUES (361, 1, 'Keeping your back straight, gently press one foot towards the floor.', 1, NULL, NULL);
INSERT INTO tips VALUES (362, 1, 'Perform for both legs.', 1, NULL, NULL);
INSERT INTO tips VALUES (363, 1, 'Lie on the floor with your knees bent.', 2, NULL, NULL);
INSERT INTO tips VALUES (364, 1, 'Straighten one leg and slowly pull it towards you, clasping the thigh or calf.', 2, NULL, NULL);
INSERT INTO tips VALUES (365, 1, 'Perform for both legs.', 2, NULL, NULL);
INSERT INTO tips VALUES (366, 1, 'Cross our right foot over your left knee.', 3, NULL, NULL);
INSERT INTO tips VALUES (367, 1, 'Clasp your hands behind your left thigh, and pull the leg towards you.', 3, NULL, NULL);
INSERT INTO tips VALUES (368, 1, 'Perform for both legs.', 3, NULL, NULL);
INSERT INTO tips VALUES (369, 1, 'Sit on the floor with your feet pressed together.', 4, NULL, NULL);
INSERT INTO tips VALUES (370, 1, 'Keeping your back straight, use your elbows to push your knees towards the floor.', 4, NULL, NULL);
INSERT INTO tips VALUES (371, 1, 'Lay down on the floor.', 5, NULL, NULL);
INSERT INTO tips VALUES (372, 1, 'Pull one knee towards your chest until you feel a stretch in your hip.', 5, NULL, NULL);
INSERT INTO tips VALUES (373, 1, 'Kneel down on one knee, with your other leg stretched out in front of you.', 6, NULL, NULL);
INSERT INTO tips VALUES (374, 1, 'Slowly move your hips backward, towards your back heel, while bending forward at the waist.', 6, NULL, NULL);
INSERT INTO tips VALUES (375, 1, 'Perform for both legs.', 6, NULL, NULL);
INSERT INTO tips VALUES (376, 1, 'Lying on the floor, pull our knees into your chest.', 7, NULL, NULL);
INSERT INTO tips VALUES (377, 1, 'Push your hips to the floor.', 7, NULL, NULL);
INSERT INTO tips VALUES (378, 1, 'Rest your back knee on the floor, with your front knee at a 90 degree angle.', 8, NULL, NULL);
INSERT INTO tips VALUES (379, 1, 'Press forward until you feel a stretch in the front of the leg/hip.', 8, NULL, NULL);
INSERT INTO tips VALUES (380, 1, 'Perform for both legs.', 8, NULL, NULL);
INSERT INTO tips VALUES (381, 1, 'Begin on your hands and knees.', 9, NULL, NULL);
INSERT INTO tips VALUES (467, 3, 'Use a speed ladder that is a minimum of 20'' long.', 13, NULL, NULL);
INSERT INTO tips VALUES (382, 1, 'Tuck your right leg underneath you by pulling your right knee up, and resting it on the floor between your hands.', 9, NULL, NULL);
INSERT INTO tips VALUES (383, 1, 'Move your right ankle so that it is on the outside of your left leg.', 9, NULL, NULL);
INSERT INTO tips VALUES (384, 1, 'Straighten your left leg out behind you.', 9, NULL, NULL);
INSERT INTO tips VALUES (385, 1, 'Lean forward as far as you can.', 9, NULL, NULL);
INSERT INTO tips VALUES (386, 1, 'Perform for both legs.', 9, NULL, NULL);
INSERT INTO tips VALUES (387, 1, 'Lie down your left side.', 10, NULL, NULL);
INSERT INTO tips VALUES (388, 1, 'Using your right arm, pull your right ankle up and towards you.', 10, NULL, NULL);
INSERT INTO tips VALUES (389, 1, 'Perform for both legs.', 10, NULL, NULL);
INSERT INTO tips VALUES (390, 1, 'Adjust the seat so that your legs are fully extended with each pedal.', 11, NULL, NULL);
INSERT INTO tips VALUES (391, 1, 'Keep your back straight.', 12, NULL, NULL);
INSERT INTO tips VALUES (392, 1, 'Straighten your legs while pulling the handle towards your chest.', 12, NULL, NULL);
INSERT INTO tips VALUES (393, 4, 'Perform each sprint at 80% max speed.', 1, NULL, NULL);
INSERT INTO tips VALUES (394, 4, 'Attempt to finish each sprint in 15-20 seconds.', 1, NULL, NULL);
INSERT INTO tips VALUES (395, 4, 'Perform each sprint at 80% max speed.', 2, NULL, NULL);
INSERT INTO tips VALUES (396, 4, 'Attempt to finish each sprint in 15-20 seconds.', 2, NULL, NULL);
INSERT INTO tips VALUES (397, 4, 'Perform each sprint at 80% max speed.', 3, NULL, NULL);
INSERT INTO tips VALUES (398, 4, 'Attempt to finish each sprint in 15-20 seconds.', 3, NULL, NULL);
INSERT INTO tips VALUES (399, 4, 'Perform each sprint at 80% max speed.', 4, NULL, NULL);
INSERT INTO tips VALUES (400, 4, 'Attempt to finish each sprint in 15-20 seconds.', 4, NULL, NULL);
INSERT INTO tips VALUES (401, 4, 'Perform each sprint at 80% max speed.', 5, NULL, NULL);
INSERT INTO tips VALUES (402, 4, 'Attempt to finish each sprint in 30-42 seconds.', 5, NULL, NULL);
INSERT INTO tips VALUES (403, 4, 'Perform each sprint at 80% max speed.', 6, NULL, NULL);
INSERT INTO tips VALUES (404, 4, 'Attempt to finish each sprint in 30-42 seconds.', 6, NULL, NULL);
INSERT INTO tips VALUES (405, 4, 'Perform each sprint at 80% max speed.', 7, NULL, NULL);
INSERT INTO tips VALUES (406, 4, 'Attempt to finish each sprint in 30-42 seconds.', 7, NULL, NULL);
INSERT INTO tips VALUES (407, 4, 'Perform each sprint at 80% max speed.', 8, NULL, NULL);
INSERT INTO tips VALUES (408, 4, 'Attempt to finish each sprint in 15-18 seconds.', 8, NULL, NULL);
INSERT INTO tips VALUES (409, 4, 'Perform each sprint at 80% max speed.', 9, NULL, NULL);
INSERT INTO tips VALUES (410, 4, 'Attempt to finish each sprint in 15-18 seconds.', 9, NULL, NULL);
INSERT INTO tips VALUES (411, 4, 'Perform each sprint at 80% max speed.', 10, NULL, NULL);
INSERT INTO tips VALUES (412, 4, 'Attempt to finish each sprint in 15-18 seconds.', 10, NULL, NULL);
INSERT INTO tips VALUES (413, 4, 'Perform each sprint at 80% max speed.', 11, NULL, NULL);
INSERT INTO tips VALUES (414, 4, 'Attempt to finish each sprint in 15-18 seconds.', 11, NULL, NULL);
INSERT INTO tips VALUES (415, 4, 'Perform each sprint at 80% max speed.', 12, NULL, NULL);
INSERT INTO tips VALUES (416, 4, 'Attempt to finish each sprint in 35-45 seconds.', 12, NULL, NULL);
INSERT INTO tips VALUES (417, 4, 'Perform each sprint at 80% max speed.', 13, NULL, NULL);
INSERT INTO tips VALUES (418, 4, 'Attempt to finish each sprint in 35-45 seconds.', 13, NULL, NULL);
INSERT INTO tips VALUES (419, 4, 'Perform each sprint at 80% max speed.', 14, NULL, NULL);
INSERT INTO tips VALUES (420, 4, 'Attempt to finish each sprint in 35-45 seconds.', 14, NULL, NULL);
INSERT INTO tips VALUES (421, 3, 'Standing with your feet should width apart, leap forward as far as you can.', 1, NULL, NULL);
INSERT INTO tips VALUES (422, 3, 'Swing your arms forward for momentum.', 1, NULL, NULL);
INSERT INTO tips VALUES (423, 3, 'When you land, catch your weight by moving your hips backward, similar to sitting in a chair.', 1, NULL, NULL);
INSERT INTO tips VALUES (424, 3, 'Line up 10 hurdles, spaced 2 feet apart.', 2, NULL, NULL);
INSERT INTO tips VALUES (425, 3, 'Start with your right foot outside of the hurdles.', 2, NULL, NULL);
INSERT INTO tips VALUES (426, 3, 'Move through the hurdles by alternating small steps with your right foot, and exaggerated steps with your left leg.', 2, NULL, NULL);
INSERT INTO tips VALUES (427, 3, 'Move through the hurdles as quickly as possible.', 2, NULL, NULL);
INSERT INTO tips VALUES (428, 3, 'Begin by standing on one leg, leaning forward, with knee slightly bent.', 3, NULL, NULL);
INSERT INTO tips VALUES (429, 3, 'Jump laterally, and land on the opposite leg, swinging your arms for momentum.', 3, NULL, NULL);
INSERT INTO tips VALUES (430, 3, 'Jumping from one side to the other, and then back to the original position is one repetition.', 3, NULL, NULL);
INSERT INTO tips VALUES (431, 3, 'Taking small, quick hops, move through the ladder as quickly as possible.', 4, NULL, NULL);
INSERT INTO tips VALUES (432, 3, 'Use a speed ladder that is a minimum of 20'' long.', 4, NULL, NULL);
INSERT INTO tips VALUES (433, 3, 'Two lengths of the ladder is one repetition.', 4, NULL, NULL);
INSERT INTO tips VALUES (434, 3, 'Using a scissor motion, alternate each foot in and out of the ladder.', 5, NULL, NULL);
INSERT INTO tips VALUES (435, 3, 'Move through the ladder as quickly as possible.', 5, NULL, NULL);
INSERT INTO tips VALUES (436, 3, 'One length of the ladder is one repetition.', 5, NULL, NULL);
INSERT INTO tips VALUES (437, 3, 'Use a speed ladder that is a minimum of 20'' long.', 5, NULL, NULL);
INSERT INTO tips VALUES (438, 3, 'High step through the ladder.', 6, NULL, NULL);
INSERT INTO tips VALUES (439, 3, 'Move through the ladder as quickly as possible.', 6, NULL, NULL);
INSERT INTO tips VALUES (440, 3, 'Two lengths of the ladder is one repetition.', 6, NULL, NULL);
INSERT INTO tips VALUES (441, 3, 'Use a speed ladder that is a minimum of 20'' long.', 6, NULL, NULL);
INSERT INTO tips VALUES (442, 3, 'Step both feet into an opening in the ladder, and then step your outside foot out side of the ladder.', 7, NULL, NULL);
INSERT INTO tips VALUES (443, 3, 'Move your inside foot into the next opening in the ladder, and repeat.', 7, NULL, NULL);
INSERT INTO tips VALUES (444, 3, 'Move through the ladder as quickly as possible.', 7, NULL, NULL);
INSERT INTO tips VALUES (445, 3, 'One length of the ladder is one repetition.', 7, NULL, NULL);
INSERT INTO tips VALUES (446, 3, 'Use a speed ladder that is a minimum of 20'' long.', 7, NULL, NULL);
INSERT INTO tips VALUES (447, 3, 'Move through the ladder, making sure each foot hits every opening in the ladder.', 8, NULL, NULL);
INSERT INTO tips VALUES (448, 3, 'Move through the ladder as quickly as possible.', 8, NULL, NULL);
INSERT INTO tips VALUES (449, 3, 'One length of the ladder is one repetition.', 8, NULL, NULL);
INSERT INTO tips VALUES (450, 3, 'Use a speed ladder that is a minimum of 20'' long.', 8, NULL, NULL);
INSERT INTO tips VALUES (451, 3, 'Move through the ladder, alternating ladder openings with each step.', 9, NULL, NULL);
INSERT INTO tips VALUES (452, 3, 'Move through the ladder as quickly as possible.', 9, NULL, NULL);
INSERT INTO tips VALUES (453, 3, 'Two lengths of the ladder is one repetition.', 9, NULL, NULL);
INSERT INTO tips VALUES (454, 3, 'Use a speed ladder that is a minimum of 20'' long.', 9, NULL, NULL);
INSERT INTO tips VALUES (455, 3, 'Jump as high as possible, moving your legs in a scissor motion.', 10, NULL, NULL);
INSERT INTO tips VALUES (456, 3, 'Land in a lunge position.', 10, NULL, NULL);
INSERT INTO tips VALUES (457, 3, 'One hop is one repetition.', 10, NULL, NULL);
INSERT INTO tips VALUES (458, 3, 'Standing on one leg, leap forward as far as you can.', 11, NULL, NULL);
INSERT INTO tips VALUES (459, 3, 'Swing your arms forward for momentum.', 11, NULL, NULL);
INSERT INTO tips VALUES (460, 3, 'When you land, catch your weight by moving your hips backward, similar to sitting in a chair.', 11, NULL, NULL);
INSERT INTO tips VALUES (461, 3, 'Standing on one leg, leap up as high as you can.', 12, NULL, NULL);
INSERT INTO tips VALUES (462, 3, 'Swing your arms up as you leap.', 12, NULL, NULL);
INSERT INTO tips VALUES (463, 3, 'When you land, catch your weight by moving your hips backward, similar to sitting in a chair.', 12, NULL, NULL);
INSERT INTO tips VALUES (464, 3, 'Move through the ladder by hopping on one leg.', 13, NULL, NULL);
INSERT INTO tips VALUES (465, 3, 'Move through the ladder as quickly as possible.', 13, NULL, NULL);
INSERT INTO tips VALUES (466, 3, 'One length of the ladder is one repetition.', 13, NULL, NULL);
INSERT INTO tips VALUES (468, 3, 'Standing with feet shoulder width apart, explode up.', 14, NULL, NULL);
INSERT INTO tips VALUES (469, 3, 'Swing your arms for momentum.', 14, NULL, NULL);
INSERT INTO tips VALUES (470, 3, 'When you land, catch your weight by moving your hips backward, similar to sitting in a chair.', 14, NULL, NULL);
INSERT INTO tips VALUES (471, 3, 'As soon as you have caught your weight, repeat.', 14, NULL, NULL);
INSERT INTO tips VALUES (472, 3, 'Standing with feet shoulder width apart, explode up.', 15, NULL, NULL);
INSERT INTO tips VALUES (473, 3, 'Swing your arms for momentum.', 15, NULL, NULL);
INSERT INTO tips VALUES (474, 3, 'As your reach your apex, pull your knees towards your chest.', 15, NULL, NULL);
INSERT INTO tips VALUES (475, 3, 'When you land, catch your weight by moving your hips backward, similar to sitting in a chair.', 15, NULL, NULL);
INSERT INTO tips VALUES (476, 3, 'As soon as you have caught your weight, repeat.', 15, NULL, NULL);
INSERT INTO tips VALUES (477, 3, 'Standing with feet shoulder width apart, explode up.', 16, NULL, NULL);
INSERT INTO tips VALUES (478, 3, 'Swing your arms for momentum.', 16, NULL, NULL);
INSERT INTO tips VALUES (479, 3, 'When you land, catch your weight by moving your hips backward, similar to sitting in a chair.', 16, NULL, NULL);
INSERT INTO tips VALUES (480, 3, 'Step down, repeat.', 16, NULL, NULL);
INSERT INTO tips VALUES (481, 3, 'Use a box height that challenges you.', 16, NULL, NULL);
INSERT INTO tips VALUES (482, 3, 'Standing with feet shoulder width apart, explode up.', 17, NULL, NULL);
INSERT INTO tips VALUES (483, 3, 'Swing your arms for momentum.', 17, NULL, NULL);
INSERT INTO tips VALUES (484, 3, 'When you land, catch your weight by moving your hips backward, similar to sitting in a chair.', 17, NULL, NULL);
INSERT INTO tips VALUES (485, 3, 'Step down to the other side, repeat.', 17, NULL, NULL);
INSERT INTO tips VALUES (486, 3, 'Use a box height that challenges you.', 17, NULL, NULL);
INSERT INTO tips VALUES (487, 3, 'Standing with feet shoulder width apart, explode up.', 18, NULL, NULL);
INSERT INTO tips VALUES (488, 3, 'Attempt to complete as many jumps as possible in the given time.', 18, NULL, NULL);
INSERT INTO tips VALUES (489, 3, 'Use a box/bench height that challenges you.', 18, NULL, NULL);
INSERT INTO tips VALUES (490, 1, 'Lean back as if you are sitting in a chair.', 13, NULL, NULL);
INSERT INTO tips VALUES (491, 1, 'Perform these at a moderate pace, no need to rush.', 14, NULL, NULL);
INSERT INTO tips VALUES (492, 1, 'Perform these at a moderate pace, no need to rush.', 15, NULL, NULL);
INSERT INTO tips VALUES (493, 1, 'Perform these at a moderate pace, no need to rush.', 16, NULL, NULL);
INSERT INTO tips VALUES (494, 1, 'Perform these at a moderate pace, no need to rush.', 17, NULL, NULL);
INSERT INTO tips VALUES (495, 1, 'Perform these at a moderate pace, no need to rush.', 18, NULL, NULL);
INSERT INTO tips VALUES (496, 1, 'Perform these at a moderate pace, no need to rush.', 13, NULL, NULL);
INSERT INTO tips VALUES (497, 1, 'This exercise can be performed without a band if you do not have access to one.', 18, NULL, NULL);
INSERT INTO tips VALUES (498, 1, 'Bend your knee slightly.', 17, NULL, NULL);
INSERT INTO tips VALUES (499, 4, 'Perform each sprint at 80% max speed.', 15, NULL, NULL);
INSERT INTO tips VALUES (500, 4, 'Your jogging period is your recovery time.', 15, NULL, NULL);
INSERT INTO tips VALUES (501, 4, 'Perform each sprint at 80% max speed.', 16, NULL, NULL);
INSERT INTO tips VALUES (502, 4, 'Your jogging period is your recovery time.', 16, NULL, NULL);
INSERT INTO tips VALUES (503, 4, 'Perform each sprint at 80% max speed.', 17, NULL, NULL);
INSERT INTO tips VALUES (504, 4, 'Your jogging period is your recovery time.', 17, NULL, NULL);
INSERT INTO tips VALUES (505, 4, 'Perform each sprint at 80% max speed.', 18, NULL, NULL);
INSERT INTO tips VALUES (506, 4, 'Your jogging period is your recovery time.', 18, NULL, NULL);
INSERT INTO tips VALUES (507, 3, 'Use a shorter box than you would normally use for box jumps.', 19, NULL, NULL);
INSERT INTO tips VALUES (508, 3, 'Jump off of 2 feet, and land on one foot, alternating the foot you land on.', 19, NULL, NULL);
INSERT INTO tips VALUES (509, 3, 'Focus on distance over height.', 20, NULL, NULL);
INSERT INTO tips VALUES (510, 3, 'Swing your arms to help maintain your momentum.', 20, NULL, NULL);
INSERT INTO tips VALUES (511, 3, 'Focus on height, and swing your arms to help achieve a greater height.', 21, NULL, NULL);
INSERT INTO tips VALUES (512, 3, 'Focus on pushing through the leg that is on the bosu.', 21, NULL, NULL);
INSERT INTO tips VALUES (513, 3, 'Focus on speed, and swinging your arms.', 22, NULL, NULL);
INSERT INTO tips VALUES (514, 3, 'Your knee should not come forward over your toe, keep your weight back.', 22, NULL, NULL);
INSERT INTO tips VALUES (515, 3, 'Focus on speed, swinging your arms, and lightly tapping the bosu.', 23, NULL, NULL);
INSERT INTO tips VALUES (516, 3, 'Your knee should not come forward over your toe, keep your weight back.', 23, NULL, NULL);
INSERT INTO tips VALUES (517, 3, 'Perform the recommended jumps on one leg, and then switch legs.', 24, NULL, NULL);
INSERT INTO tips VALUES (518, 3, 'Focus on height and landing in a balanced position, ready to spring up again.', 24, NULL, NULL);
INSERT INTO tips VALUES (519, 3, 'Focus on a soft landing, keeping your weight back.', 25, NULL, NULL);
INSERT INTO tips VALUES (520, 3, 'Focus on a soft landing, keeping your weight back.', 26, NULL, NULL);
INSERT INTO tips VALUES (521, 3, 'Do not let your knee come forward over your toe.', 26, NULL, NULL);
INSERT INTO tips VALUES (522, 3, 'On landing, focus on using your glute and hamstring to catch yourself.', 26, NULL, NULL);
INSERT INTO tips VALUES (523, 3, 'Use a shorter box than you would normally use for box jumps.', 27, NULL, NULL);
INSERT INTO tips VALUES (524, 3, 'Try to strike an even balance between height and distance.', 27, NULL, NULL);
INSERT INTO tips VALUES (525, 3, 'Focus on height and keeping your chest up.', 28, NULL, NULL);
INSERT INTO tips VALUES (526, 3, 'Focus on height and landing in a lunge position.', 29, NULL, NULL);
INSERT INTO tips VALUES (527, 3, 'Do not let your knee come forward over your toe.', 29, NULL, NULL);
INSERT INTO tips VALUES (528, 1, 'Perform these at a moderate pace, no need to rush.', 19, NULL, NULL);
INSERT INTO tips VALUES (529, 1, 'Keep your weight back.', 19, NULL, NULL);
INSERT INTO tips VALUES (530, 1, 'Try to keep the bosu as stable as possible.', 19, NULL, NULL);
INSERT INTO tips VALUES (531, 1, 'Keep your knee slightly bent.', 20, NULL, NULL);
INSERT INTO tips VALUES (532, 1, 'Perform these at a moderate pace, no need to rush.', 20, NULL, NULL);
INSERT INTO tips VALUES (533, 1, 'Spend half the recommended time on one leg, then switch.', 20, NULL, NULL);
INSERT INTO tips VALUES (534, 1, 'Spend half the recommended time on one leg, then switch.', 21, NULL, NULL);
INSERT INTO tips VALUES (535, 1, 'Spend half the recommended time on one leg, then switch.', 22, NULL, NULL);
INSERT INTO tips VALUES (536, 1, 'Perform these at a moderate pace, no need to rush.', 23, NULL, NULL);
INSERT INTO tips VALUES (537, 1, 'Use your elbows to push your knees out at the bottom of the squat.', 23, NULL, NULL);
INSERT INTO tips VALUES (538, 1, 'Perform these at a moderate pace, no need to rush.', 24, NULL, NULL);
INSERT INTO tips VALUES (539, 1, 'Perform these at a moderate pace, no need to rush.', 25, NULL, NULL);
INSERT INTO tips VALUES (540, 1, 'Your arms should slightly bent at the elbow, and parallel to the ground.', 26, NULL, NULL);
INSERT INTO tips VALUES (541, 1, 'Keep your legs straight to stretch your hamstrings and hips.', 27, NULL, NULL);
INSERT INTO tips VALUES (542, 1, 'Keep your chest up, and do not allow your knee to come forward over your toes.', 28, NULL, NULL);
INSERT INTO tips VALUES (543, 2, 'Try to have your arms and legs meet in the middle.', 189, NULL, NULL);
INSERT INTO tips VALUES (544, 2, 'Don''t let your hands or feet touch the ground.', 189, NULL, NULL);
INSERT INTO tips VALUES (545, 2, 'Keep your legs as straight as possible.', 190, NULL, NULL);
INSERT INTO tips VALUES (546, 2, 'Maintain good posture by squeezing your shoulder blades, and keeping your shoulders rolled back.', 191, NULL, NULL);
INSERT INTO tips VALUES (547, 2, 'This isn''t strictly a horizontal pull exercise, but it fits best in this category.', 193, NULL, NULL);
INSERT INTO tips VALUES (548, 2, 'Keep your knees slightly bent, and go for speed.', 192, NULL, NULL);
INSERT INTO tips VALUES (549, 2, 'This isn''t strictly a horizontal pull exercise, but it fits best in this category.', 193, NULL, NULL);
INSERT INTO tips VALUES (550, 2, 'Keep your knees slightly bent, and go for speed.', 193, NULL, NULL);
INSERT INTO tips VALUES (551, 2, 'This isn''t strictly a horizontal pull exercise, but it fits best in this category.', 194, NULL, NULL);
INSERT INTO tips VALUES (552, 2, 'Keep your knees slightly bent, and go for speed.', 194, NULL, NULL);
INSERT INTO tips VALUES (553, 2, 'This isn''t strictly a horizontal pull exercise, but it fits best in this category.', 137, NULL, NULL);
INSERT INTO tips VALUES (554, 2, 'Keep your knees slightly bent, and go for speed.', 137, NULL, NULL);
INSERT INTO tips VALUES (555, 2, 'Go for half the recommended time on one side, and then switch arms.', 137, NULL, NULL);
INSERT INTO tips VALUES (556, 2, 'This isn''t strictly a horizontal pull exercise, but it fits best in this category.', 138, NULL, NULL);
INSERT INTO tips VALUES (557, 2, 'Keep your knees slightly bent, and go for speed.', 138, NULL, NULL);
INSERT INTO tips VALUES (558, 2, 'This isn''t strictly a horizontal pull exercise, but it fits best in this category.', 139, NULL, NULL);
INSERT INTO tips VALUES (559, 2, 'Keep your knees slightly bent, and go for speed.', 139, NULL, NULL);
INSERT INTO tips VALUES (560, 2, 'Keep the movement equal with both arms. Don''t allow one arm to do more work than the other.', 139, NULL, NULL);
INSERT INTO tips VALUES (561, 2, 'This isn''t strictly a horizontal pull exercise, but it fits best in this category.', 140, NULL, NULL);
INSERT INTO tips VALUES (562, 2, 'Keep your knees slightly bent, and go for speed.', 140, NULL, NULL);
INSERT INTO tips VALUES (563, 2, 'Go for half the recommended time on one side, and then switch arms.', 140, NULL, NULL);
INSERT INTO tips VALUES (564, 2, 'This is a full body exercise, so be sure to get your legs involved.', 141, NULL, NULL);
INSERT INTO tips VALUES (565, 2, 'Extend up on your toes while bringing the ropes over your head, then bring the ropes down forcefully while sitting back into a squat.', 141, NULL, NULL);
INSERT INTO tips VALUES (566, 2, 'Use the force of your hips to help swing the kettlebell up. This should be more of a leg exercise than an arm exercise.', 142, NULL, NULL);
INSERT INTO tips VALUES (567, 2, 'Use the force of your hips to help swing the kettlebell up. This should be more of a leg exercise than an arm exercise.', 160, NULL, NULL);
INSERT INTO tips VALUES (568, 2, 'Move down slowly and up forcefully.', 143, NULL, NULL);
INSERT INTO tips VALUES (569, 2, 'Hold the medicine ball away from your body to make this exercise more challenging.', 143, NULL, NULL);
INSERT INTO tips VALUES (570, 2, 'Primarily push through the arm that''s on top of the bosu.', 144, NULL, NULL);
INSERT INTO tips VALUES (571, 2, 'Keep the bosu and steady as possible. Squeeze your core and glutes for stability.', 145, NULL, NULL);
INSERT INTO tips VALUES (572, 2, 'Keep the bosu and steady as possible. Squeeze your core and glutes for stability.', 146, NULL, NULL);
INSERT INTO tips VALUES (573, 2, 'Row quickly and land softly.', 147, NULL, NULL);
INSERT INTO tips VALUES (574, 2, 'Perform the total recommended reps on one side, then switch and do the same on the other side. That''s one set.', 148, NULL, NULL);
INSERT INTO tips VALUES (575, 2, 'Perform for the recommended time on one leg, then switch legs and perform for the recommended time. That''s one set.', 149, NULL, NULL);
INSERT INTO tips VALUES (576, 2, 'To fulfill your recommended weight load, you can use a dumbbell, weight plate, or kettlebell.', 150, NULL, NULL);
INSERT INTO tips VALUES (577, 2, 'The arm movements illustrated in the video are optional.', 151, NULL, NULL);
INSERT INTO tips VALUES (578, 2, 'Make sure you keep your body from rotating.', 151, NULL, NULL);
INSERT INTO tips VALUES (579, 2, 'As you work yourself around the bar, you should be working your biceps. Do not work yourself around while in a dead hang.', 152, NULL, NULL);
INSERT INTO tips VALUES (580, 2, 'Don''t allow your knee to come forward over your toe.', 153, NULL, NULL);
INSERT INTO tips VALUES (581, 2, 'Keep your chest up and sit back into a squat.', 153, NULL, NULL);
INSERT INTO tips VALUES (582, 2, 'For each set, do the total number of recommended reps on each leg.', 153, NULL, NULL);
INSERT INTO tips VALUES (583, 2, 'Stand with your feet about hip width apart.', 154, NULL, NULL);
INSERT INTO tips VALUES (584, 2, 'Step one leg backwards, and across the opposite leg, landing on the ball of your foot.', 154, NULL, NULL);
INSERT INTO tips VALUES (585, 2, 'Lower into a lunge position, and then immediately drive your self back to the starting position.', 154, NULL, NULL);
INSERT INTO tips VALUES (586, 2, 'One repetition = performing the lunge with each leg once.', 154, NULL, NULL);
INSERT INTO tips VALUES (587, 2, 'Work to get your elbow over and outside of your knee.', 155, NULL, NULL);
INSERT INTO tips VALUES (588, 2, 'Do as many as you can on one side, then switch to the other side. That''s one set.', 155, NULL, NULL);
INSERT INTO tips VALUES (589, 2, 'Use an overhand grip.', 156, NULL, NULL);
INSERT INTO tips VALUES (590, 2, 'Don''t allow your upper body to rotate as you work through the complex.', 157, NULL, NULL);
INSERT INTO tips VALUES (591, 2, 'You can work through all these variations at your own pace.', 157, NULL, NULL);
INSERT INTO tips VALUES (592, 2, 'Hold the kettlebell just below your knees.', 158, NULL, NULL);
INSERT INTO tips VALUES (593, 2, 'Keep your back straight.', 158, NULL, NULL);
INSERT INTO tips VALUES (594, 2, 'Keep your back straight.', 159, NULL, NULL);
INSERT INTO tips VALUES (595, 2, 'Pushing through your heels, explode into a standing position, rotating the kettlebell at the top.', 158, NULL, NULL);
INSERT INTO tips VALUES (596, 2, 'Pushing through your heels, explode into a standing position, rotating the kettlebell at the top.', 159, NULL, NULL);
INSERT INTO tips VALUES (597, 2, 'Spring off of the ground as quickly as possible.', 161, NULL, NULL);
INSERT INTO tips VALUES (598, 2, 'Try to fire the medicine ball in a straight line at the wall.', 161, NULL, NULL);
INSERT INTO tips VALUES (599, 2, 'Perform the recommended number of reps on one side, and then switch sides. That''s one set.', 162, NULL, NULL);
INSERT INTO tips VALUES (600, 2, 'Wedge the bottom of the bar up against a wall, or in a crack against the floor. It''s imperative that the bottom of the bar doesn''t slide out while you''re performing this exercise.', 162, NULL, NULL);
INSERT INTO tips VALUES (601, 2, 'The recommended weight for this exercise is just for the weight plate. It does not include the weight of the bar.', 162, NULL, NULL);
INSERT INTO tips VALUES (602, 2, 'Perform this exercise at a moderate pace. It is not meant to be performed for speed.', 163, NULL, NULL);
INSERT INTO tips VALUES (603, 2, 'Tighten your stomach and focus on keeping your lower back pressed to the floor.', 163, NULL, NULL);
INSERT INTO tips VALUES (604, 2, 'The power you use to fire the medicine ball into the wall should come from your hips.', 164, NULL, NULL);
INSERT INTO tips VALUES (605, 2, 'Bridge up on every other repetition.', 165, NULL, NULL);
INSERT INTO tips VALUES (606, 2, 'Bridge up on every other repetition.', 171, NULL, NULL);
INSERT INTO tips VALUES (607, 2, 'Bend your knees slightly for balance.', 166, NULL, NULL);
INSERT INTO tips VALUES (608, 2, 'Perform the plank for half the recommended time with one arm, and then switch for the remaining time.', 167, NULL, NULL);
INSERT INTO tips VALUES (609, 2, 'Keep your upper back tensed and your shoulders rolled back.', 168, NULL, NULL);
INSERT INTO tips VALUES (610, 2, 'Transferring the weights from one side to the other, and then back, is one rep.', 168, NULL, NULL);
INSERT INTO tips VALUES (611, 2, 'The goal is to have the glute and hip fire simultaneously.', 168, NULL, NULL);
INSERT INTO tips VALUES (612, 2, 'Focus on squeezing your abs and glutes for stability.', 169, NULL, NULL);
INSERT INTO tips VALUES (613, 2, 'Push through the hand that''s on the medicine ball.', 170, NULL, NULL);
INSERT INTO tips VALUES (614, 2, 'Focus on maintaining a straight back.', 170, NULL, NULL);
INSERT INTO tips VALUES (615, 2, 'Bring your feet up as high as your arms and head.', 172, NULL, NULL);
INSERT INTO tips VALUES (616, 2, 'Hold the crunch for a count before releasing back down.', 172, NULL, NULL);
INSERT INTO tips VALUES (617, 2, 'Your back will curve, but attempt to keep it as straight as possible, using your abs to raise and lower your upper body.', 173, NULL, NULL);
INSERT INTO tips VALUES (618, 2, 'Move your arms and legs simultaneously.', 174, NULL, NULL);
INSERT INTO tips VALUES (619, 2, 'Move your arms and legs simultaneously.', 175, NULL, NULL);
INSERT INTO tips VALUES (620, 2, 'Move your arms and legs simultaneously.', 176, NULL, NULL);
INSERT INTO tips VALUES (621, 2, 'Your arms should go up, not behind you.', 174, NULL, NULL);
INSERT INTO tips VALUES (622, 2, 'Your arms should go up, not behind you.', 175, NULL, NULL);
INSERT INTO tips VALUES (623, 2, 'Keep your back straight, and don''t allow your knees to come forward over your toes.', 177, NULL, NULL);
INSERT INTO tips VALUES (624, 2, 'Flex your glutes for stability.', 178, NULL, NULL);
INSERT INTO tips VALUES (625, 2, 'Flex your glutes for stability.', 179, NULL, NULL);
INSERT INTO tips VALUES (626, 2, 'Don''t allow your hands to raise above eye level.', 178, NULL, NULL);
INSERT INTO tips VALUES (627, 2, 'Use your glutes and abs to keep your body in a straight line.', 180, NULL, NULL);
INSERT INTO tips VALUES (628, 2, 'Use your glutes and abs to keep your body in a straight line.', 181, NULL, NULL);
INSERT INTO tips VALUES (629, 2, 'Use your glutes and abs to keep your body in a straight line.', 182, NULL, NULL);
INSERT INTO tips VALUES (630, 2, 'Use your glutes and abs to keep your body in a straight line.', 183, NULL, NULL);
INSERT INTO tips VALUES (631, 2, 'Perform as many as you can on one leg, then switch legs. That''s one set.', 184, NULL, NULL);
INSERT INTO tips VALUES (632, 2, 'Perform as many as you can on one leg, then switch legs. That''s one set.', 185, NULL, NULL);
INSERT INTO tips VALUES (633, 2, 'Don''t allow your knee to come forward over your toe.', 184, NULL, NULL);
INSERT INTO tips VALUES (634, 2, 'Don''t allow your knee to come forward over your toe.', 185, NULL, NULL);
INSERT INTO tips VALUES (635, 2, 'Your arms should be used primarily to help you keep balance, but the majority of the work should be done with your legs.', 185, NULL, NULL);
INSERT INTO tips VALUES (636, 2, 'Hold for a count at the top of the crunch, and slowly release back down.', 186, NULL, NULL);
INSERT INTO tips VALUES (637, 2, 'Be sure that your arms and legs meet in the middle.', 187, NULL, NULL);
INSERT INTO tips VALUES (638, 2, 'Use your core to fire the ball forward, not solely your arms.', 188, NULL, NULL);
INSERT INTO tips VALUES (639, 2, 'Perform a set on one leg, and then switch legs for the next set.', 188, NULL, NULL);
INSERT INTO tips VALUES (640, 1, 'Perform for half the recommended time on one leg, then switch legs. Repeat for each set.', 17, '2016-10-05 00:39:09.105282', '2016-10-05 00:39:09.105282');
INSERT INTO tips VALUES (641, 1, 'Keep your chest up, and make sure your knee doesn''t go in front of your toe.', 29, '2016-10-05 00:42:08.630389', '2016-10-05 00:42:08.630389');
INSERT INTO tips VALUES (642, 2, 'The recommended weight given is for each dumbbell.', 195, '2016-10-05 02:04:01.773959', '2016-10-05 02:04:01.773959');
INSERT INTO tips VALUES (643, 2, 'Perform the total number of recommended repetitions with one leg, and then switch and peform with the other to complete the set.', 195, '2016-10-05 02:05:37.985637', '2016-10-05 02:05:37.985637');
INSERT INTO tips VALUES (644, 2, 'The recommended weight given is for each dumbbell.', 60, '2016-10-05 02:07:08.497996', '2016-10-05 02:07:08.497996');
INSERT INTO tips VALUES (645, 2, 'The recommended weight given is for each dumbbell.', 38, '2016-10-05 02:07:27.4791', '2016-10-05 02:07:27.4791');
INSERT INTO tips VALUES (646, 2, 'The recommended weight given is for each dumbbell.', 153, '2016-10-05 02:07:56.222125', '2016-10-05 02:07:56.222125');
INSERT INTO tips VALUES (647, 2, 'The recommended weight given is for each dumbbell.', 125, '2016-10-05 02:08:10.509614', '2016-10-05 02:08:10.509614');
INSERT INTO tips VALUES (648, 2, 'The recommended weight given is for each dumbbell.', 40, '2016-10-05 02:08:26.572806', '2016-10-05 02:08:26.572806');
INSERT INTO tips VALUES (649, 2, 'The recommended weight given is for each dumbbell.', 154, '2016-10-05 02:08:54.81432', '2016-10-05 02:08:54.81432');
INSERT INTO tips VALUES (650, 2, 'The recommended weight given is for each dumbbell.', 39, '2016-10-05 02:09:05.075718', '2016-10-05 02:09:05.075718');
INSERT INTO tips VALUES (651, 2, 'The recommended weight given is for each dumbbell.', 124, '2016-10-05 02:09:12.772413', '2016-10-05 02:09:12.772413');
INSERT INTO tips VALUES (652, 2, 'The recommended weight given is for each dumbbell.', 62, '2016-10-05 02:09:21.003917', '2016-10-05 02:09:21.003917');
INSERT INTO tips VALUES (653, 2, 'The recommended weight given is for each dumbbell.', 61, '2016-10-05 02:09:24.978853', '2016-10-05 02:09:24.978853');


--
-- TOC entry 2641 (class 0 OID 0)
-- Dependencies: 258
-- Name: tips_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brianregan
--

SELECT pg_catalog.setval('tips_id_seq', 654, true);


--
-- TOC entry 2619 (class 0 OID 94340)
-- Dependencies: 271
-- Data for Name: warmups; Type: TABLE DATA; Schema: public; Owner: brianregan
--

INSERT INTO warmups VALUES (1, 'Calf Stretch', false, '176553003', NULL, '2016-10-04 19:40:42.580793', 2, 'http://i.vimeocdn.com/video/583829862_200x150.jpg', 1);
INSERT INTO warmups VALUES (4, 'Inner Thigh Stretch', true, '185333609', NULL, '2016-10-04 19:40:42.987934', 1, 'http://i.vimeocdn.com/video/595058876_200x150.jpg', 2);
INSERT INTO warmups VALUES (3, 'Hip/Glute Stretch', true, '185274026', NULL, '2016-10-04 19:40:42.852117', 1, 'http://i.vimeocdn.com/video/594975539_200x150.jpg', 2);
INSERT INTO warmups VALUES (11, 'Exercise Bike', false, 'https://s3.amazonaws.com/qfimg/bike.jpg', NULL, NULL, 3, NULL, 1);
INSERT INTO warmups VALUES (2, 'Hamstring Stretch', true, '185274866', NULL, '2016-10-04 19:40:42.71173', 1, 'http://i.vimeocdn.com/video/594975905_200x150.jpg', 1);
INSERT INTO warmups VALUES (5, 'Knee to Chest Stretch', true, '185274375', NULL, '2016-10-04 19:40:43.127771', 1, 'http://i.vimeocdn.com/video/594974472_200x150.jpg', 1);
INSERT INTO warmups VALUES (6, 'Kneeling Hamstring Stretch', true, '185274376', NULL, '2016-10-04 19:40:43.260788', 1, 'http://i.vimeocdn.com/video/594975852_200x150.jpg', 1);
INSERT INTO warmups VALUES (10, 'Quad Stretch', true, '185274494', NULL, '2016-10-04 19:40:43.757447', 1, 'http://i.vimeocdn.com/video/594976372_200x150.jpg', 1);
INSERT INTO warmups VALUES (12, 'Rowing Machine', false, '176557779', NULL, '2016-10-04 19:40:43.991476', 3, 'http://i.vimeocdn.com/video/583835060_200x150.jpg', 1);
INSERT INTO warmups VALUES (13, 'Air Squat', false, '83076191', NULL, '2016-10-04 19:40:44.125789', 2, 'http://i.vimeocdn.com/video/459558372_200x150.jpg', 1);
INSERT INTO warmups VALUES (14, 'Inchworm', false, '185274369', NULL, '2016-10-04 19:40:44.260149', 2, 'http://i.vimeocdn.com/video/594974508_200x150.jpg', 1);
INSERT INTO warmups VALUES (15, 'Medicine Ball Lunge and Twist', false, '185274387', NULL, '2016-10-04 19:40:44.392629', 2, 'http://i.vimeocdn.com/video/594975077_200x150.jpg', 1);
INSERT INTO warmups VALUES (16, 'Scorpion', false, '176557784', NULL, '2016-10-04 19:40:44.529965', 2, 'http://i.vimeocdn.com/video/583834648_200x150.jpg', 1);
INSERT INTO warmups VALUES (17, 'Single Leg Touch', false, '176557667', NULL, '2016-10-04 19:40:44.666112', 2, 'http://i.vimeocdn.com/video/583834852_200x150.jpg', 1);
INSERT INTO warmups VALUES (18, 'Slides With Band', false, '176556600', NULL, '2016-10-04 19:40:44.798708', 2, 'http://i.vimeocdn.com/video/583832958_200x150.jpg', 1);
INSERT INTO warmups VALUES (24, 'Leg Stretch Complex', false, '185333963', NULL, '2016-10-04 19:40:45.474752', 2, 'http://i.vimeocdn.com/video/595059184_200x150.jpg', 1);
INSERT INTO warmups VALUES (8, 'Lunge to Hamstring Stretch', false, '176555247', NULL, '2016-10-04 19:40:43.513076', 2, 'http://i.vimeocdn.com/video/583831009_200x150.jpg', 1);
INSERT INTO warmups VALUES (19, 'Bosu Body Weight Squat', false, '176551441', NULL, '2016-10-04 19:40:44.941571', 2, 'http://i.vimeocdn.com/video/583826589_200x150.jpg', 2);
INSERT INTO warmups VALUES (21, 'Bosu Single Leg Taps', false, '176551455', NULL, '2016-10-04 19:40:45.211998', 2, 'http://i.vimeocdn.com/video/583826864_200x150.jpg', 2);
INSERT INTO warmups VALUES (26, 'Seal Jacks', false, '176557781', NULL, '2016-10-04 19:40:45.608998', 2, 'http://i.vimeocdn.com/video/583834976_200x150.jpg', 2);
INSERT INTO warmups VALUES (29, 'Transverse Lunge', false, '176556399', NULL, '2016-10-04 19:40:45.886657', 2, 'http://i.vimeocdn.com/video/583832962_200x150.jpg', 2);
INSERT INTO warmups VALUES (23, 'Gate Swings', false, '176553010', NULL, '2016-10-04 19:40:45.345853', 2, 'http://i.vimeocdn.com/video/583829261_200x150.jpg', 2);
INSERT INTO warmups VALUES (20, 'Bosu One Leg Toe Touch', false, '176551449', NULL, '2016-10-04 19:40:45.078331', 2, 'http://i.vimeocdn.com/video/583826123_200x150.jpg', 2);
INSERT INTO warmups VALUES (27, 'Toy Soldiers', false, '176556398', NULL, '2016-10-04 19:40:45.750239', 2, 'http://i.vimeocdn.com/video/583832599_200x150.jpg', 2);


--
-- TOC entry 2642 (class 0 OID 0)
-- Dependencies: 270
-- Name: warmups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brianregan
--

SELECT pg_catalog.setval('warmups_id_seq', 29, true);


--
-- TOC entry 2621 (class 0 OID 94372)
-- Dependencies: 277
-- Data for Name: workout_schedule_suggestions; Type: TABLE DATA; Schema: public; Owner: brianregan
--

INSERT INTO workout_schedule_suggestions VALUES (1, 1, 0, 2, 0, 2, 2, NULL, NULL);
INSERT INTO workout_schedule_suggestions VALUES (2, 2, 0, 2, 0, 1, 1, NULL, NULL);
INSERT INTO workout_schedule_suggestions VALUES (3, 3, 0, 2, 0, 2, 2, NULL, NULL);
INSERT INTO workout_schedule_suggestions VALUES (4, 1, 1, 2, 2, 2, 2, NULL, NULL);
INSERT INTO workout_schedule_suggestions VALUES (5, 2, 1, 2, 2, 1, 1, NULL, NULL);
INSERT INTO workout_schedule_suggestions VALUES (6, 3, 1, 2, 2, 2, 2, NULL, NULL);
INSERT INTO workout_schedule_suggestions VALUES (7, 1, 2, 2, 3, 2, 2, NULL, NULL);
INSERT INTO workout_schedule_suggestions VALUES (8, 2, 2, 2, 3, 1, 1, NULL, NULL);
INSERT INTO workout_schedule_suggestions VALUES (9, 3, 2, 2, 3, 2, 2, NULL, NULL);
INSERT INTO workout_schedule_suggestions VALUES (10, 1, 3, 1, 2, 2, 2, NULL, NULL);
INSERT INTO workout_schedule_suggestions VALUES (11, 2, 3, 1, 2, 1, 1, NULL, NULL);
INSERT INTO workout_schedule_suggestions VALUES (12, 3, 3, 1, 2, 2, 2, NULL, NULL);
INSERT INTO workout_schedule_suggestions VALUES (13, 1, 4, 3, 3, 2, 2, NULL, NULL);
INSERT INTO workout_schedule_suggestions VALUES (14, 2, 4, 3, 3, 1, 1, NULL, NULL);
INSERT INTO workout_schedule_suggestions VALUES (15, 3, 4, 3, 3, 2, 2, NULL, NULL);
INSERT INTO workout_schedule_suggestions VALUES (16, 1, 5, 2, 4, 2, 2, NULL, NULL);
INSERT INTO workout_schedule_suggestions VALUES (17, 2, 5, 2, 4, 1, 1, NULL, NULL);
INSERT INTO workout_schedule_suggestions VALUES (18, 3, 5, 2, 4, 2, 2, NULL, NULL);
INSERT INTO workout_schedule_suggestions VALUES (19, 1, 6, 1, 3, 2, 2, NULL, NULL);
INSERT INTO workout_schedule_suggestions VALUES (20, 2, 6, 1, 3, 1, 1, NULL, NULL);
INSERT INTO workout_schedule_suggestions VALUES (21, 3, 6, 1, 3, 2, 2, NULL, NULL);
INSERT INTO workout_schedule_suggestions VALUES (22, 1, 7, 4, 4, 2, 2, NULL, NULL);
INSERT INTO workout_schedule_suggestions VALUES (23, 2, 7, 4, 4, 1, 1, NULL, NULL);
INSERT INTO workout_schedule_suggestions VALUES (24, 3, 7, 4, 4, 2, 2, NULL, NULL);
INSERT INTO workout_schedule_suggestions VALUES (25, 1, 8, 5, 4, 3, 2, NULL, NULL);
INSERT INTO workout_schedule_suggestions VALUES (26, 2, 8, 5, 4, 3, 2, NULL, NULL);
INSERT INTO workout_schedule_suggestions VALUES (27, 3, 8, 5, 4, 3, 2, NULL, NULL);


--
-- TOC entry 2643 (class 0 OID 0)
-- Dependencies: 276
-- Name: workout_schedule_suggestions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brianregan
--

SELECT pg_catalog.setval('workout_schedule_suggestions_id_seq', 27, true);


-- Completed on 2016-10-04 20:37:03 PDT

--
-- PostgreSQL database dump complete
--

