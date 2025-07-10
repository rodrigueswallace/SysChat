GRANT CREATE
  ON SCHEMA syschat
  TO sys_user;




-- MSG TABLE(INSERT)
CREATE OR REPLACE VIEW sysChat.view_insert_msg_r_sys_user AS
SELECT chat_id, is_user, msg_context
FROM syschat.msg




SET ROLE sys_user;


CREATE OR REPLACE FUNCTION
sysChat.view_insert_function_t_msg_r_sys_user()
RETURNS trigger AS $$
BEGIN
    INSERT INTO syschat.msg (
      chat_id, is_user, msg_context
    ) VALUES (
      NEW.chat_id, NEW.is_user, NEW.msg_context
    );
  
  RETURN NEW;
END;
$$
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = sysChat, pg_temp;
RESET ROLE;




CREATE OR REPLACE TRIGGER view_insert_trigger_msg_r_sys_user
INSTEAD OF INSERT ON sysChat.view_insert_msg_r_sys_user
FOR EACH ROW
EXECUTE FUNCTION sysChat.view_insert_function_t_msg_r_sys_user();




-- MSG TABLE(SELECT)

SET ROLE sys_user;
CREATE OR REPLACE FUNCTION
syschat.function_select_t_msg_r_sys_user(id INTEGER)
RETURNS TABLE(
    msg_id         INTEGER,
    is_user        BOOLEAN,
    msg_context    TEXT,
    msg_date       TIMESTAMPTZ
) AS $$
BEGIN
  RETURN QUERY
  SELECT
    m.msg_id, m.is_user, m.msg_context, m.msg_date
  FROM syschat.msg m
  WHERE m.msg_id = id;
END;
$$
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = syschat, pg_temp;
RESET ROLE;






REVOKE CREATE ON SCHEMA sysChat FROM sys_user;

