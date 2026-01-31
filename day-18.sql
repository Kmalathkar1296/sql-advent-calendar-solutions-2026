-- SQL Advent Calendar - Day 18
-- Title: 12 Days of Data - Progress Tracking
-- Difficulty: hard
--
-- Question:
-- Over the 12 days of her data challenge, Data Dawn tracked her daily quiz scores across different subjects. Can you find each subject's first and last recorded score to see how much she improved?
--
-- Over the 12 days of her data challenge, Data Dawn tracked her daily quiz scores across different subjects. Can you find each subject's first and last recorded score to see how much she improved?
--

-- Table Schema:
-- Table: daily_quiz_scores
--   subject: VARCHAR
--   quiz_date: DATE
--   score: INTEGER
--

-- My Solution:

WITH score_rank as (SELECT subject, quiz_date, FIRST_VALUE(score) OVER(PARTITION BY subject ORDER BY quiz_date) as first_record,
  LAST_VALUE(score) OVER(PARTITION BY subject ORDER BY quiz_date ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_record
FROM daily_quiz_scores)
  
SELECT DISTINCT subject, first_record, last_record
  FROM score_rank;
