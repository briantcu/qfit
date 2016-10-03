/*!40000 ALTER TABLE day_exercises DISABLE KEYS */;
INSERT INTO day_exercises VALUES (1,1,1,NULL,NULL),(2,1,3,NULL,NULL),(3,1,4,NULL,NULL),(4,1,7,NULL,NULL),(5,1,10,NULL,NULL),(6,1,9,NULL,NULL),(7,1,12,NULL,NULL),(8,1,14,NULL,NULL),(9,2,1,NULL,NULL),(10,2,2,NULL,NULL),(11,2,5,NULL,NULL),(12,2,6,NULL,NULL),(13,2,11,NULL,NULL),(14,2,8,NULL,NULL),(15,2,13,NULL,NULL),(16,2,14,NULL,NULL),(17,3,1,NULL,NULL),(18,3,3,NULL,NULL),(19,3,6,NULL,NULL),(20,3,9,NULL,NULL),(21,3,14,NULL,NULL),(22,4,1,NULL,NULL),(23,4,4,NULL,NULL),(24,4,11,NULL,NULL),(25,4,12,NULL,NULL),(26,4,14,NULL,NULL),(27,5,1,NULL,NULL),(28,5,2,NULL,NULL),(29,5,7,NULL,NULL),(30,5,8,NULL,NULL),(31,5,14,NULL,NULL),(32,6,1,NULL,NULL),(33,6,5,NULL,NULL),(34,6,10,NULL,NULL),(35,6,13,NULL,NULL),(36,6,14,NULL,NULL),(37,7,1,NULL,NULL),(38,7,3,NULL,NULL),(39,7,4,NULL,NULL),(40,7,2,NULL,NULL),(41,7,5,NULL,NULL),(42,7,14,NULL,NULL),(43,8,7,NULL,NULL),(44,8,10,NULL,NULL),(45,8,9,NULL,NULL),(46,8,12,NULL,NULL),(47,8,6,NULL,NULL),(48,8,11,NULL,NULL),(49,8,8,NULL,NULL),(50,8,13,NULL,NULL),(51,8,14,NULL,NULL),(52,9,1,NULL,NULL),(53,9,5,NULL,NULL),(54,9,2,NULL,NULL),(55,9,4,NULL,NULL),(56,9,3,NULL,NULL),(57,9,14,NULL,NULL),(58,10,8,NULL,NULL),(59,10,13,NULL,NULL),(60,10,6,NULL,NULL),(61,10,11,NULL,NULL),(62,10,9,NULL,NULL),(63,10,12,NULL,NULL),(64,10,7,NULL,NULL),(65,10,10,NULL,NULL),(66,10,14,NULL,NULL);
/*!40000 ALTER TABLE day_exercises ENABLE KEYS */;


/*!40000 ALTER TABLE exercise_types DISABLE KEYS */;
INSERT INTO exercise_types VALUES (1,'Power',NULL,NULL),(2,'Knee Dominant Unilateral',NULL,NULL),(3,'Knee Dominant Bilateral',NULL,NULL),(4,'Hip Dominant Unilateral',NULL,NULL),(5,'Hip Dominant Bilateral',NULL,NULL),(6,'Horizontal Push Unilateral',NULL,NULL),(7,'Horizontal Push Bilateral',NULL,NULL),(8,'Vertical Push Unilateral',NULL,NULL),(9,'Vertical Push Bilateral',NULL,NULL),(10,'Horizontal Pull Unilateral',NULL,NULL),(11,'Horizontal Pull Bilateral',NULL,NULL),(12,'Vertical Pull Unilateral',NULL,NULL),(13,'Vertical Pull Bilateral',NULL,NULL),(14,'Core, Rotational',NULL,NULL),(15,'Core, Bridging',NULL,NULL),(16,'Core',NULL,NULL);
/*!40000 ALTER TABLE exercise_types ENABLE KEYS */;

INSERT INTO one_rep_maxes (rep, percentage) VALUES (1,1.00),(2,0.92),(3,0.90),(4,0.87),(5,0.85),(6,0.82),(7,0.80),(8,0.75),(9,0.73),(10,0.70),(11,0.68),(12,0.65),(13,0.62),(14,0.58),(15,0.54),(16,0.50),(17,0.46),(18,0.42),(19,0.38),(20,0.34);

/*!40000 ALTER TABLE phases DISABLE KEYS */;
INSERT INTO phases VALUES (1,4,6,4,15,4,6,4,15,NULL,NULL),(2,4,6,4,10,4,6,4,10,NULL,NULL),(3,4,6,4,15,4,6,4,18,NULL,NULL),(4,4,6,4,12,4,6,4,12,NULL,NULL),(5,5,3,4,8,5,4,4,8,NULL,NULL),(6,5,4,4,6,5,4,4,10,NULL,NULL),(7,5,3,4,8,5,4,4,6,NULL,NULL),(8,5,4,4,4,5,4,4,8,NULL,NULL),(9,4,5,4,10,4,6,4,10,NULL,NULL),(10,5,3,4,6,4,5,4,15,NULL,NULL),(11,4,5,4,8,4,6,4,8,NULL,NULL),(12,5,3,4,6,4,5,4,12,NULL,NULL);
/*!40000 ALTER TABLE phases ENABLE KEYS */;

/*!40000 ALTER TABLE program_day_sequences DISABLE KEYS */;
INSERT INTO program_day_sequences VALUES (1,1,2,1,2,0,0,0,0,0,0,0,0,NULL,NULL),(2,2,4,3,4,5,6,0,0,0,0,0,0,NULL,NULL),(3,3,6,3,2,4,5,1,6,0,0,0,0,NULL,NULL),(4,4,8,3,2,4,1,5,2,6,1,0,0,NULL,NULL),(5,5,4,7,8,9,10,0,0,0,0,0,0,NULL,NULL);
/*!40000 ALTER TABLE program_day_sequences ENABLE KEYS */;

/*!40000 ALTER TABLE program_days DISABLE KEYS */;
INSERT INTO program_days VALUES (1,'Full A',NULL,NULL),(2,'Full B',NULL,NULL),(3,'Half A1',NULL,NULL),(4,'Half B1',NULL,NULL),(5,'Half A2',NULL,NULL),(6,'Half B2',NULL,NULL),(7,'T4P A1',NULL,NULL),(8,'T4P B1',NULL,NULL),(9,'T4P A2',NULL,NULL),(10,'T4P B2',NULL,NULL);
/*!40000 ALTER TABLE program_days ENABLE KEYS */;


/*!40000 ALTER TABLE program_phase_lookups DISABLE KEYS */;
INSERT INTO program_phase_lookups VALUES (1,1,1,1,NULL,NULL),(2,1,2,5,NULL,NULL),(3,1,3,9,NULL,NULL),(4,2,1,2,NULL,NULL),(5,2,2,6,NULL,NULL),(6,2,3,10,NULL,NULL),(7,3,1,3,NULL,NULL),(8,3,2,7,NULL,NULL),(9,3,3,11,NULL,NULL),(10,4,1,4,NULL,NULL),(11,4,2,8,NULL,NULL),(12,4,3,12,NULL,NULL);
/*!40000 ALTER TABLE program_phase_lookups ENABLE KEYS */;


/*!40000 ALTER TABLE program_types DISABLE KEYS */;
INSERT INTO program_types VALUES (1,'PowerLean',NULL,NULL),(2,'PowerMass',NULL,NULL),(3,'PowerRip',NULL,NULL);
/*!40000 ALTER TABLE program_types ENABLE KEYS */;


/*!40000 ALTER TABLE programs DISABLE KEYS */;
INSERT INTO programs VALUES (1,'Full',NULL,NULL),(2,'Half',NULL,NULL),(3,'3 Day Mixed',NULL,NULL),(4,'4 Day Mixed',NULL,NULL),(5,'T4P',NULL,NULL);
/*!40000 ALTER TABLE programs ENABLE KEYS */;

/*!40000 ALTER TABLE sprint_detail_sequences DISABLE KEYS */;
INSERT INTO sprint_detail_sequences VALUES (1,1,1,1,NULL,NULL),(2,1,1,2,NULL,NULL),(3,1,1,3,NULL,NULL),(4,1,2,4,NULL,NULL),(5,2,1,1,NULL,NULL),(6,2,1,2,NULL,NULL),(7,2,1,3,NULL,NULL),(8,2,3,4,NULL,NULL),(9,2,1,5,NULL,NULL),(10,2,1,6,NULL,NULL),(11,2,1,7,NULL,NULL),(12,2,2,8,NULL,NULL),(13,3,1,1,NULL,NULL),(14,3,1,2,NULL,NULL),(15,3,1,3,NULL,NULL),(16,3,3,4,NULL,NULL),(17,3,1,5,NULL,NULL),(18,3,1,6,NULL,NULL),(19,3,1,7,NULL,NULL),(20,3,3,8,NULL,NULL),(21,3,1,9,NULL,NULL),(22,3,1,10,NULL,NULL),(23,3,1,11,NULL,NULL),(24,3,2,12,NULL,NULL),(25,4,1,1,NULL,NULL),(26,4,1,2,NULL,NULL),(27,4,1,3,NULL,NULL),(28,4,3,4,NULL,NULL),(29,4,1,5,NULL,NULL),(30,4,1,6,NULL,NULL),(31,4,1,7,NULL,NULL),(32,4,3,8,NULL,NULL),(33,4,1,9,NULL,NULL),(34,4,1,10,NULL,NULL),(35,4,1,11,NULL,NULL),(36,4,3,12,NULL,NULL),(37,4,1,13,NULL,NULL),(38,4,1,14,NULL,NULL),(39,4,1,15,NULL,NULL),(40,4,2,16,NULL,NULL),(41,5,4,1,NULL,NULL),(42,5,4,2,NULL,NULL),(43,5,4,3,NULL,NULL),(44,5,5,4,NULL,NULL),(45,6,4,1,NULL,NULL),(46,6,4,2,NULL,NULL),(47,6,4,3,NULL,NULL),(48,6,4,4,NULL,NULL),(49,6,4,5,NULL,NULL),(50,6,4,6,NULL,NULL),(51,6,4,7,NULL,NULL),(52,6,5,8,NULL,NULL),(53,7,4,1,NULL,NULL),(54,7,4,2,NULL,NULL),(55,7,4,3,NULL,NULL),(56,7,4,4,NULL,NULL),(57,7,4,5,NULL,NULL),(58,7,4,6,NULL,NULL),(59,7,4,7,NULL,NULL),(60,7,4,8,NULL,NULL),(61,7,4,9,NULL,NULL),(62,7,4,10,NULL,NULL),(63,7,4,11,NULL,NULL),(64,7,5,12,NULL,NULL),(65,8,6,1,NULL,NULL),(66,8,6,2,NULL,NULL),(67,8,6,3,NULL,NULL),(68,8,7,4,NULL,NULL),(69,9,6,1,NULL,NULL),(70,9,6,2,NULL,NULL),(71,9,6,3,NULL,NULL),(72,9,8,4,NULL,NULL),(73,9,6,5,NULL,NULL),(74,9,6,6,NULL,NULL),(75,9,6,7,NULL,NULL),(76,9,7,8,NULL,NULL),(77,10,6,1,NULL,NULL),(78,10,6,2,NULL,NULL),(79,10,6,3,NULL,NULL),(80,10,8,4,NULL,NULL),(81,10,6,5,NULL,NULL),(82,10,6,6,NULL,NULL),(83,10,6,7,NULL,NULL),(84,10,8,8,NULL,NULL),(85,10,6,9,NULL,NULL),(86,10,6,10,NULL,NULL),(87,10,6,11,NULL,NULL),(88,10,7,12,NULL,NULL),(89,11,6,1,NULL,NULL),(90,11,6,2,NULL,NULL),(91,11,6,3,NULL,NULL),(92,11,8,4,NULL,NULL),(93,11,6,5,NULL,NULL),(94,11,6,6,NULL,NULL),(95,11,6,7,NULL,NULL),(96,11,8,8,NULL,NULL),(97,11,6,9,NULL,NULL),(98,11,6,10,NULL,NULL),(99,11,6,11,NULL,NULL),(100,11,8,12,NULL,NULL),(101,11,6,13,NULL,NULL),(102,11,6,14,NULL,NULL),(103,11,6,15,NULL,NULL),(104,11,7,16,NULL,NULL),(105,12,9,1,NULL,NULL),(106,12,9,2,NULL,NULL),(107,12,9,3,NULL,NULL),(108,12,10,4,NULL,NULL),(109,13,9,1,NULL,NULL),(110,13,9,2,NULL,NULL),(111,13,9,3,NULL,NULL),(112,13,9,4,NULL,NULL),(113,13,9,5,NULL,NULL),(114,13,9,6,NULL,NULL),(115,13,9,7,NULL,NULL),(116,13,10,8,NULL,NULL),(117,14,9,1,NULL,NULL),(118,14,9,2,NULL,NULL),(119,14,9,3,NULL,NULL),(120,14,9,4,NULL,NULL),(121,14,9,5,NULL,NULL),(122,14,9,6,NULL,NULL),(123,14,9,7,NULL,NULL),(124,14,9,8,NULL,NULL),(125,14,9,9,NULL,NULL),(126,14,9,10,NULL,NULL),(127,14,9,11,NULL,NULL),(128,14,10,12,NULL,NULL),(129,15,11,1,NULL,NULL),(130,15,11,2,NULL,NULL),(131,15,11,3,NULL,NULL),(132,15,11,4,NULL,NULL),(133,16,11,1,NULL,NULL),(134,16,11,2,NULL,NULL),(135,16,11,3,NULL,NULL),(136,16,11,4,NULL,NULL),(137,16,11,5,NULL,NULL),(138,16,11,6,NULL,NULL),(139,17,11,1,NULL,NULL),(140,17,11,2,NULL,NULL),(141,17,11,3,NULL,NULL),(142,17,11,4,NULL,NULL),(143,17,11,5,NULL,NULL),(144,17,11,6,NULL,NULL),(145,17,11,7,NULL,NULL),(146,17,11,8,NULL,NULL),(147,17,11,9,NULL,NULL),(148,17,11,10,NULL,NULL),(149,18,11,1,NULL,NULL),(150,18,11,2,NULL,NULL),(151,18,11,3,NULL,NULL),(152,18,11,4,NULL,NULL),(153,18,11,5,NULL,NULL),(154,18,11,6,NULL,NULL),(155,18,11,7,NULL,NULL),(156,18,11,8,NULL,NULL),(157,18,11,9,NULL,NULL),(158,18,11,10,NULL,NULL),(159,18,11,11,NULL,NULL),(160,18,11,12,NULL,NULL);
/*!40000 ALTER TABLE sprint_detail_sequences ENABLE KEYS */;

/*!40000 ALTER TABLE sprint_details DISABLE KEYS */;
INSERT INTO sprint_details VALUES (1,'Sprint 100 yards, rest 15-18 secs',NULL,NULL),(2,'Sprint 100 yards',NULL,NULL),(3,'Sprint 100 yards, rest 60 secs',NULL,NULL),(4,'Sprint 200 yards, rest 33 secs',NULL,NULL),(5,'Sprint 200 yards',NULL,NULL),(6,'Sprint from 1 baseline to the other 3 times, rest 15-18 secs',NULL,NULL),(7,'Sprint from 1 baseline to the other 3 times',NULL,NULL),(8,'Sprint from 1 baseline to the other, rest 60 secs',NULL,NULL),(9,'Sprint from 1 baseline to the other 6 times, rest 33 secs',NULL,NULL),(10,'Sprint from 1 baseline to the other 6 times',NULL,NULL),(11,'Jog for 1 minute, sprint for 30 seconds',NULL,NULL);
/*!40000 ALTER TABLE sprint_details ENABLE KEYS */;

/*!40000 ALTER TABLE sprints DISABLE KEYS */;
INSERT INTO sprints VALUES (1,1,'4 X 100 yards X 1',1,4,NULL,NULL),(2,2,'4 X 100 yards X 2',1,8,NULL,NULL),(3,3,'4 X 100 yards X 3',1,12,NULL,NULL),(4,4,'4 X 100 yards X 4',1,16,NULL,NULL),(5,2,'4 X 200 yards',1,4,NULL,NULL),(6,4,'8 X 200 yards',1,8,NULL,NULL),(7,5,'12 X 200 yards',1,12,NULL,NULL),(8,1,'4 X 3 Court Lengths X 1',2,4,NULL,NULL),(9,2,'4 X 3 Court Lengths X 2',2,8,NULL,NULL),(10,3,'4 X 3 Court Lengths X 3',2,12,NULL,NULL),(11,4,'4 X 3 Court Lengths X 4',2,16,NULL,NULL),(12,2,'4 X 6 Court Lengths',2,4,NULL,NULL),(13,4,'8 X 6 Court Lengths',2,8,NULL,NULL),(14,5,'12 X 6 Court Lengths',2,12,NULL,NULL),(15,1,'6 mins treadmill',3,4,NULL,NULL),(16,2,'9 mins treadmill',3,6,NULL,NULL),(17,3,'15 mins treadmill',3,10,NULL,NULL),(18,4,'18 mins treadmill',3,12,NULL,NULL);
/*!40000 ALTER TABLE sprints ENABLE KEYS */;

/*!40000 ALTER TABLE workout_schedule_suggestions DISABLE KEYS */;
INSERT INTO workout_schedule_suggestions VALUES (1,1,0,2,0,2,2,NULL,NULL),(2,2,0,2,0,1,1,NULL,NULL),(3,3,0,2,0,2,2,NULL,NULL),(4,1,1,2,2,2,2,NULL,NULL),(5,2,1,2,2,1,1,NULL,NULL),(6,3,1,2,2,2,2,NULL,NULL),(7,1,2,2,3,2,2,NULL,NULL),(8,2,2,2,3,1,1,NULL,NULL),(9,3,2,2,3,2,2,NULL,NULL),(10,1,3,1,2,2,2,NULL,NULL),(11,2,3,1,2,1,1,NULL,NULL),(12,3,3,1,2,2,2,NULL,NULL),(13,1,4,3,3,2,2,NULL,NULL),(14,2,4,3,3,1,1,NULL,NULL),(15,3,4,3,3,2,2,NULL,NULL),(16,1,5,2,4,2,2,NULL,NULL),(17,2,5,2,4,1,1,NULL,NULL),(18,3,5,2,4,2,2,NULL,NULL),(19,1,6,1,3,2,2,NULL,NULL),(20,2,6,1,3,1,1,NULL,NULL),(21,3,6,1,3,2,2,NULL,NULL),(22,1,7,4,4,2,2,NULL,NULL),(23,2,7,4,4,1,1,NULL,NULL),(24,3,7,4,4,2,2,NULL,NULL),(25,1,8,5,4,3,2,NULL,NULL),(26,2,8,5,4,3,2,NULL,NULL),(27,3,8,5,4,3,2,NULL,NULL);
/*!40000 ALTER TABLE workout_schedule_suggestions ENABLE KEYS */;


INSERT INTO goal_definitions (id, "order", goal_text, achieved_text, points, created_at, updated_at, goal_type) VALUES (1, 1, 'Complete your workout schedule', 'Yes! You''ve completed your workout schedule!', 10, '2016-10-01 02:01:10.112688', '2016-10-01 02:01:10.112688', 1);
INSERT INTO goal_definitions (id, "order", goal_text, achieved_text, points, created_at, updated_at, goal_type) VALUES (2, 2, 'Complete Quadfit onboarding', 'Yoooo, onboarding complete! You''re a Quadfit expert now.', 30, '2016-10-01 02:02:16.952857', '2016-10-01 02:02:16.952857', 3);
INSERT INTO goal_definitions (id, "order", goal_text, achieved_text, points, created_at, updated_at, goal_type) VALUES (3, 3, 'Create a username so that we can display your fine work in the Leaderboards', 'Done and done. Now you''re eligible to be shown on the Leaderboards,
    and you can start communicating with other Quadfit members!', 10, '2016-10-01 02:03:02.640625', '2016-10-01 02:03:02.640625', 3);
INSERT INTO goal_definitions (id, "order", goal_text, achieved_text, points, created_at, updated_at, goal_type) VALUES (5, 5, 'Don''t keep all this workout goodness to yourself! Share your workouts
    so other people can see your domination!', 'You''ve leveled up! Sharing really is caring.', 50, '2016-10-01 02:04:42.579825', '2016-10-01 02:04:42.579825', 3);
INSERT INTO goal_definitions (id, "order", goal_text, achieved_text, points, created_at, updated_at, goal_type) VALUES (6, 6, 'Start building your Quad Pod! Invite people to join your QP, and you''ll
    be able to see each other''s workouts, compete, and send messages of motivation...or
    trash talk', 'Swwweeeet, mission accomplished. Now the real fun begins.', 75, '2016-10-01 02:05:19.083784', '2016-10-01 02:05:19.083784', 3);
INSERT INTO goal_definitions (id, "order", goal_text, achieved_text, points, created_at, updated_at, goal_type) VALUES (8, 2, 'Create a workout for an athlete.', 'Great, now make sure that the workout results get recorded so that
    Quadfit can track progress and give better future workouts.', 250, '2016-10-01 02:06:44.359440', '2016-10-01 02:06:44.359440', 2);
INSERT INTO goal_definitions (id, "order", goal_text, achieved_text, points, created_at, updated_at, goal_type) VALUES (9, 2, 'Complete Quadfit onboarding', 'Yoooo, onboarding complete! You''re a Quadfit expert now.', 30, '2016-10-01 02:07:17.319091', '2016-10-01 02:07:17.319091', 2);
INSERT INTO goal_definitions (id, "order", goal_text, achieved_text, points, created_at, updated_at, goal_type) VALUES (10, 3, 'Create a username so that we can display your fine work in the Leaderboards', 'Done and done. Now you''re eligible to be shown on the Leaderboards,
    and you can start communicating with other Quadfit members!', 10, '2016-10-01 02:07:51.878493', '2016-10-01 02:07:51.878493', 2);
INSERT INTO goal_definitions (id, "order", goal_text, achieved_text, points, created_at, updated_at, goal_type) VALUES (11, 4, 'Complete a workout and enter in what you accomplished during the workout.
    This allows Quadfit to track your progress, and give you better workouts in the
    future', 'That''s what''s up! You completed your first workout. Now keep up that
    momentum!', 100, '2016-10-01 02:08:25.925276', '2016-10-01 02:08:25.925276', 2);
INSERT INTO goal_definitions (id, "order", goal_text, achieved_text, points, created_at, updated_at, goal_type) VALUES (12, 5, 'Don''t keep all this workout goodness to yourself! Share your workouts
    so other people can see your domination!', 'You''ve leveled up! Sharing really is caring.', 50, '2016-10-01 02:09:00.402227', '2016-10-01 02:09:00.402227', 2);
INSERT INTO goal_definitions (id, "order", goal_text, achieved_text, points, created_at, updated_at, goal_type) VALUES (13, 6, 'Start building your Quad Pod! Invite people to join your QP, and you''ll
    be able to see each other''s workouts, compete, and send messages of motivation...or
    trash talk', 'Swwweeeet, mission accomplished. Now the real fun begins.', 75, '2016-10-01 02:09:32.114782', '2016-10-01 02:09:32.114782', 2);
INSERT INTO goal_definitions (id, "order", goal_text, achieved_text, points, created_at, updated_at, goal_type) VALUES (4, 4, 'Complete a workout and enter in what you accomplished during the workout.
    This allows Quadfit to track your progress, and give you better workouts in the
    future', 'That''s what''s up! You completed your first workout. Now keep up that
    momentum!', 100, '2016-10-01 02:03:50.486265', '2016-10-01 02:03:50.486265', 3);
INSERT INTO goal_definitions (id, "order", goal_text, achieved_text, points, created_at, updated_at, goal_type) VALUES (7, 1, 'Create an account for an athlete, or use your sign up code to invite
    an athlete to join.', 'Next up, let Quadfit help you create some workouts!', 150, '2016-10-01 02:06:00.778262', '2016-10-01 02:06:00.778262', 2);
