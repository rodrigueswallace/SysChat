GRANT CREATE
  ON SCHEMA sysChat
  TO sys_anonymous_user;



-- USERS TABLE(INSERT)
-- Create a view t o allow INSERT operations without exposing the real table
CREATE OR REPLACE VIEW sysChat.view_insert_user_r_sys_anonymous_user AS
SELECT user_name, user_last_name, user_email, user_password
FROM sysChat.users
LIMIT 0;  -- prevents any reading (view is only used for INSERT)



SET ROLE sys_anonymous_user;

-- Create the trigger function that handles the actual INSERT into the real table
CREATE OR REPLACE FUNCTION
sysChat.view_insert_function_t_users_r_sys_anonymous_user()
RETURNS trigger AS $$
BEGIN
    INSERT INTO sysChat.users (
      user_name, user_last_name, user_email, user_password
    ) VALUES (
      NEW.user_name, NEW.user_last_name, NEW.user_email, NEW.user_password
    );
  
  RETURN NEW;
END;
$$
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = sysChat, pg_temp;
RESET ROLE;



--  Create a trigger on the view to redirect INSERTs to the real table
CREATE OR REPLACE TRIGGER view_insert_trigger_user_r_sys_anonymous_user
INSTEAD OF INSERT ON sysChat.view_insert_user_r_sys_anonymous_user
FOR EACH ROW
EXECUTE FUNCTION sysChat.view_insert_function_t_users_r_sys_anonymous_user();




-- USERS TABLE(SELECT)

SET ROLE sys_anonymous_user;
CREATE OR REPLACE FUNCTION
syschat.function_select_t_users_r_sys_anonymous_user(user_email_login varchar)
RETURNS TABLE(
    user_email      VARCHAR(100),
    user_password   VARCHAR(128)
) AS $$
BEGIN
  RETURN QUERY
  SELECT
    user_email, user_password
  FROM syschat.users
  WHERE user_email = user_email_login;
END;
$$
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = syschat, pg_temp;
RESET ROLE;




REVOKE CREATE ON SCHEMA sysChat FROM sys_anonymous_user;



