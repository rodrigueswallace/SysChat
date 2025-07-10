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
        COUNT(*)::INT AS total_msgs  -- aqui está a correção
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

8 wordcloud_all_terms

9 messages_by_hour_user_today

10 messages_by_hour_all_users_today

11 messages_by_weekday_user

12 messages_by_weekday_all_users

13 avg_message_length_user_per_month

14 avg_message_length_all_users_per_month

15 chats_started_user_per_month

16 chats_started_all_users_per_month

17 avg_chat_duration_user_per_month

18 avg_chat_duration_all_users_per_month

