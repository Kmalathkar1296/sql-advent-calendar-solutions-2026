-- SQL Advent Calendar - Day 12
-- Title: North Pole Network Most Active Users
-- Difficulty: hard
--
-- Question:
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--

-- Table Schema:
-- Table: npn_users
--   user_id: INT
--   user_name: VARCHAR
--
-- Table: npn_messages
--   message_id: INT
--   sender_id: INT
--   sent_at: TIMESTAMP
--

-- My Solution:

WITH daily_counts AS (SELECT
    u.user_id, u.user_name,
    DATE(m.sent_at) AS sent_date,
    COUNT(m.message_id) AS message_count
FROM npn_users u
JOIN npn_messages m
    ON u.user_id = m.sender_id
GROUP BY u.user_id, DATE(m.sent_at)
ORDER BY message_count DESC
)
SELECT user_name, sent_date
  FROM (
  SELECT *, rank() OVER(partition by sent_date ORDER BY message_count desc) as rnk
  FROM daily_counts
  ) as a where a.rnk=1;
