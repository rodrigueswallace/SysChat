GRANT CREATE
  ON SCHEMA sysChat
  TO sys_user;



-- USER TABLE (SELECT)
SET ROLE sys_user;
CREATE OR REPLACE FUNCTION
sysChat.function_select_t_users_r_sys_user()
RETURNS TABLE(name VARCHAR(50), active BOOLEAN) AS $$
BEGIN
  RETURN QUERY
  SELECT
    alias.name, alias.active
  FROM sysChat.user alias
  WHERE alias.email = sysChat.get_session_variable_email()
  LIMIT 1;
END;
$$
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = sysChat, pg_temp;
RESET ROLE;





-- USERS TABLE(UPDATE)


CREATE OR REPLACE VIEW sysChat.view_insert_user_r_sys_anonymous_user AS
SELECT user_name, user_lastName, user_email, user_password
FROM sysChat.users
LIMIT 0;  -- prevents any reading (view is only used for INSERT)



SET ROLE sys_user;


CREATE OR REPLACE FUNCTION
sysChat.view_update_function_t_users_r_sys_user()
RETURNS trigger AS $$
BEGIN
  IF NEW.user_photo_url IS NOT NULL THEN
    INSERT INTO sysChat.users (
      user_photo_url, user_name, user_lastName, user_email, user_password
    ) VALUES (
      NEW.user_photo_url, NEW.user_name, NEW.user_lastName, NEW.user_email, NEW.user_password
    );
  ELSE
    INSERT INTO sysChat.users (
      user_name, user_lastName, user_email, user_password
    ) VALUES (
      NEW.user_name, NEW.user_lastName, NEW.user_email, NEW.user_password
    );
  END IF;
  
  RETURN NEW;
END;
$$
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = sysChat, pg_temp;
RESET ROLE;




CREATE OR REPLACE TRIGGER view_insert_trigger_user_r_sys_anonymous_user
INSTEAD OF INSERT ON sysChat.view_insert_user_r_sys_anonymous_user
FOR EACH ROW
EXECUTE FUNCTION sysChat.view_insert_function_t_users_r_sys_anonymous_user();




REVOKE CREATE ON SCHEMA sysChat FROM sys_user;


