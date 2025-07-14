GRANT CREATE
  ON SCHEMA syschat
  TO sys_user;



-- CHAT TABLE(INSERT)
CREATE OR REPLACE VIEW syschat.view_insert_t_chat_r_sys_user AS
SELECT user_id, chat_name
FROM syschat.chat  



SET ROLE sys_user;

CREATE OR REPLACE FUNCTION
syschat.view_insert_function_t_chat_r_sys_user()
RETURNS trigger AS $$
BEGIN
    INSERT INTO syschat.chat (
      user_id, chat_name
    ) VALUES (
      NEW.user_id, NEW.chat_name
    );
  
  RETURN NEW;
END;
$$
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = syschat, pg_temp;

RESET ROLE;



CREATE OR REPLACE TRIGGER view_insert_trigger_chat_r_sys_user
INSTEAD OF INSERT ON syschat.view_insert_t_chat_r_sys_user
FOR EACH ROW
EXECUTE FUNCTION syschat.view_insert_function_t_chat_r_sys_user();



-- CHAT TABLE(SELECT)


SET ROLE sys_user;

CREATE OR REPLACE FUNCTION
syschat.function_select_t_chat_r_sys_user(id INTEGER)
RETURNS TABLE(
    chat_id         INTEGER,
    chat_name       VARCHAR(20),
    chat_start_date TIMESTAMPTZ
) AS $$
BEGIN
  RETURN QUERY
  SELECT c.chat_id, c.chat_name, c.chat_start_date
  FROM syschat.chat c
  WHERE c.chat_id = id;
END;
$$
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = syschat;


RESET ROLE;






-- CHAT TABLE(UPDATE)


CREATE OR REPLACE VIEW syschat.view_update_t_chat_r_sys_user AS
SELECT chat_name, user_id
FROM syschat.chat  



SET ROLE sys_user;

CREATE OR REPLACE FUNCTION
syschat.view_update_function_t_chat_r_sys_user()
RETURNS trigger AS $$
BEGIN
    UPDATE syschat.chat
    SET chat_name = COALESCE(NEW.chat_name, chat_name)
    WHERE user_id = NEW.user_id;
  
  RETURN NEW;
END;
$$
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = syschat, pg_temp;

RESET ROLE;



CREATE OR REPLACE TRIGGER view_update_trigger_chat_r_sys_user
INSTEAD OF INSERT ON syschat.view_update_t_chat_r_sys_user
FOR EACH ROW
EXECUTE FUNCTION syschat.view_update_function_t_chat_r_sys_user();




REVOKE CREATE ON SCHEMA sysChat FROM sys_user;



