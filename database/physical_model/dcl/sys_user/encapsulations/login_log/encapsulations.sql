GRANT CREATE
  ON SCHEMA syschat
  TO sys_user;



-- login_logs TABLE(INSERT)
CREATE OR REPLACE VIEW sysChat.view_insert_login_logs_r_sys_user AS
SELECT ll_id, ll_login_time, user_id
FROM syschat.login_logs




SET ROLE sys_user;


CREATE OR REPLACE FUNCTION
sysChat.view_insert_function_t_login_logs_r_sys_user()
RETURNS trigger AS $$
BEGIN
    INSERT INTO syschat.login_logs (
      user_id
    ) VALUES (
      NEW.user_id
    );
  
  RETURN NEW;
END;
$$
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = sysChat, pg_temp;
RESET ROLE;




CREATE OR REPLACE TRIGGER view_insert_trigger_login_logs_r_sys_user
INSTEAD OF INSERT ON sysChat.view_insert_login_logs_r_sys_user
FOR EACH ROW
EXECUTE FUNCTION sysChat.view_insert_function_t_login_logs_r_sys_user();




-- login_logs TABLE(SELECT)

SET ROLE sys_user;
CREATE OR REPLACE FUNCTION
syschat.function_select_t_login_logs_r_sys_user(id INTEGER)
RETURNS TABLE(
    login_logs_id         INTEGER,
    user_id               UUID,
    ll_login_time         TIMESTAMPTZ
) AS $$
BEGIN
  RETURN QUERY
  SELECT
    m.ll_id, m.ll_login_time, m.user_id
  FROM syschat.login_logs m
  WHERE m.user_id = id;
END;
$$
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = syschat, pg_temp;
RESET ROLE;




-- CHAT TABLE(DELETE)

CREATE OR REPLACE PROCEDURE syschat.delete_chat_by_id(p_login_log_id INTEGER)
LANGUAGE plpgsql
AS $$
BEGIN
  DELETE FROM syschat.login_logs
  WHERE ll_id = p_login_log_id;
END;
$$;







REVOKE CREATE ON SCHEMA sysChat FROM sys_user;

