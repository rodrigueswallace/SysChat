1 accesses_by_user_per_month

CREATE OR REPLACE VIEW syschat.logins_per_month_last_12_months AS 
SELECT
    user_id,
    TO_CHAR(ll_login_time, 'YYYY-MM') AS month, 
    COUNT(*) AS total_logins
FROM syschat.login_log
WHERE ll_login_time >= (CURRENT_DATE - INTERVAL '12 months')
GROUP BY user_id, TO_CHAR(ll_login_time, 'YYYY-MM')
ORDER BY user_id, month; 



2 accesses_all_users_per_month

CREATE OR REPLACE VIEW syschat.users_active_per_month_last_12_months  AS 
SELECT
    TO_CHAR(ll_login_time, 'YYYY-MM') AS month,
    COUNT(DISTINCT user_id) AS total_users 
FROM syschat.login_log
WHERE ll_login_time >= (CURRENT_DATE - INTERVAL '12 months')
GROUP BY TO_CHAR(ll_login_time, 'YYYY-MM')
ORDER BY month;

3 messages_by_user_per_month

CREATE OR REPLACE FUNCTION syschat.user_msgs_last_12_months(p_user_id INT)
RETURNS TABLE (
    mes TEXT,
    total_msgs INT
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        TO_CHAR(m.msg_date, 'YYYY-MM') AS mes,
        COUNT(*)::INT AS total_msgs  
    FROM syschat.msg m
    JOIN syschat.chat c ON m.chat_id = c.chat_id
    WHERE
        c.user_id = p_user_id
        AND m.msg_date >= (CURRENT_DATE - INTERVAL '12 months')
    GROUP BY TO_CHAR(m.msg_date, 'YYYY-MM')
    ORDER BY mes;
END;
$$ LANGUAGE plpgsql;

4 messages_all_users_per_month

CREATE OR REPLACE VIEW syschat.user_msgs_last_12_months  AS
SELECT
    TO_CHAR(msg_date, 'YYYY-MM') AS month,
    COUNT(*) AS total_msgs
FROM syschat.msg
WHERE msg_date >= (CURRENT_DATE - INTERVAL '12 months')
GROUP BY TO_CHAR(msg_date, 'YYYY-MM')
ORDER BY month;



5 top_user_chats_by_message_count

CREATE OR REPLACE FUNCTION syschat.top_5_chats_by_user(p_user_id INT)
RETURNS TABLE (
    chat_id INT,
    chat_name VARCHAR(20),  
    total_msgs INT
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        c.chat_id,
        c.chat_name,
        COUNT(m.msg_id)::INT AS total_msgs
    FROM syschat.chat c
    JOIN syschat.msg m ON c.chat_id = m.chat_id
    WHERE c.user_id = p_user_id
    GROUP BY c.chat_id, c.chat_name
    ORDER BY total_msgs DESC
    LIMIT 5;
END;
$$ LANGUAGE plpgsql;





6 top_global_chats_by_message_count

CREATE OR REPLACE VIEW syschat.top_5_chats_by_active_users AS
SELECT
    c.chat_id,
    c.chat_name,
    COUNT(m.msg_id) AS total_mensagens
FROM syschat.chat c
JOIN syschat.msg m ON c.chat_id = m.chat_id
GROUP BY c.chat_id, c.chat_name
ORDER BY total_mensagens DESC
LIMIT 5;


7 wordcloud_user_terms

CREATE OR REPLACE FUNCTION syschat.function_word_cloud_by_user(p_user_id UUID)
RETURNS TABLE(palavra TEXT, total_uso INTEGER)
LANGUAGE sql
STABLE
AS $$
  SELECT lower(word) AS palavra, COUNT(*) AS total_uso
  FROM (
    SELECT regexp_split_to_table(m.msg_context, '\s+') AS word
    FROM syschat.msg m
    JOIN syschat.chat c ON m.chat_id = c.chat_id
    WHERE c.user_id = p_user_id
  ) AS words
  WHERE word ~ '^[a-zA-Záéíóúãõâêôç]+$'
  GROUP BY lower(word)
  ORDER BY total_uso DESC
  LIMIT 10;
$$;

8 wordcloud_all_terms





9 messages_by_hour_user_today

CREATE OR REPLACE FUNCTION syschat.function_msgs_by_hour_user(p_user_id UUID)
RETURNS TABLE(hours INTEGER, total_msgs INTEGER)
LANGUAGE sql
STABLE
AS $$
  SELECT 
    EXTRACT(HOUR FROM m.msg_date)::INT AS hours,
    COUNT(*) AS total_msgs
  FROM syschat.msg m
  JOIN syschat.chat c ON m.chat_id = c.chat_id
  WHERE c.user_id = p_user_id
    AND m.msg_date::DATE = CURRENT_DATE
  GROUP BY hours
  ORDER BY hours;
$$;

10 messages_by_hour_all_users_today

CREATE OR REPLACE VIEW syschat.view_msgs_by_hour_all AS
SELECT 
  EXTRACT(HOUR FROM m.msg_date)::INT AS hours,
  COUNT(*) AS total_msgs
FROM syschat.msg m
WHERE m.msg_date::DATE = CURRENT_DATE
GROUP BY hours
ORDER BY hours;

11 messages_by_weekday_user

CREATE OR REPLACE FUNCTION syschat.function_msgs_by_weekday_user(p_user_id UUID)
RETURNS TABLE(day_week INTEGER, total_msgs INTEGER)
LANGUAGE sql
STABLE
AS $$
  SELECT 
    EXTRACT(DOW FROM m.msg_date)::INT AS day_week,
    COUNT(*) AS total_msgs
  FROM syschat.msg m
  JOIN syschat.chat c ON m.chat_id = c.chat_id
  WHERE c.user_id = p_user_id
  GROUP BY day_week
  ORDER BY day_week;
$$;

12 messages_by_weekday_all_users

CREATE OR REPLACE VIEW syschat.view_msgs_by_weekday_all AS
SELECT 
  EXTRACT(DOW FROM m.msg_date)::INT AS day_week,
  COUNT(*) AS total_msgs
FROM syschat.msg m
GROUP BY day_week
ORDER BY day_week;

13 avg_message_length_user_per_month

CREATE OR REPLACE FUNCTION syschat.function_avg_msg_size_by_month_user(p_user_id UUID)
RETURNS TABLE(year_menth TEXT, medium_size NUMERIC)
LANGUAGE sql
STABLE
AS $$
  SELECT 
    TO_CHAR(m.msg_date, 'YYYY-MM') AS year_menth,
    AVG(LENGTH(m.msg_context)) AS medium_size
  FROM syschat.msg m
  JOIN syschat.chat c ON m.chat_id = c.chat_id
  WHERE c.user_id = p_user_id
  GROUP BY year_menth
  ORDER BY year_menth;
$$;

14 avg_message_length_all_users_per_month

CREATE OR REPLACE VIEW syschat.view_avg_msg_size_by_month_all AS
SELECT 
  TO_CHAR(msg_date, 'YYYY-MM') AS year_mount,
  AVG(LENGTH(msg_context)) AS medium_size
FROM syschat.msg
GROUP BY year_mount
ORDER BY year_mount;

15 chats_started_user_per_month

CREATE OR REPLACE FUNCTION syschat.function_chats_by_month_user(p_user_id UUID)
RETURNS TABLE(year_month TEXT, total_chats INTEGER)
LANGUAGE sql
STABLE
AS $$
  SELECT 
    TO_CHAR(chat_start_date, 'YYYY-MM') AS year_month,
    COUNT(*) AS total_chats
  FROM syschat.chat
  WHERE user_id = p_user_id
    AND chat_start_date >= (CURRENT_DATE - INTERVAL '12 months')
  GROUP BY year_month
  ORDER BY year_month;
$$;

16 chats_started_all_users_per_month

CREATE OR REPLACE VIEW syschat.view_chats_by_month_all AS
SELECT 
  TO_CHAR(chat_start_date, 'YYYY-MM') AS year_month,
  COUNT(*) AS total_chats
FROM syschat.chat
WHERE chat_start_date >= (CURRENT_DATE - INTERVAL '12 months')
GROUP BY year_month
ORDER BY year_month;


17 avg_chat_duration_user_per_month

18 avg_chat_duration_all_users_per_month

