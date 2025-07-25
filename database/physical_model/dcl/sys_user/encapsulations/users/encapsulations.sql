GRANT CREATE
  ON SCHEMA syschat
  TO sys_user;



-- USERS TABLES(SELECT)

SET ROLE sys_user;
CREATE OR REPLACE FUNCTION
syschat.function_select_t_users_r_sys_user(id INTEGER)
RETURNS TABLE(
    user_id         INTEGER,
    user_photo_url  VARCHAR,
    user_name       VARCHAR,
    user_last_name  VARCHAR,
    user_email      VARCHAR,
    user_start_date TIMESTAMPTZ
) AS $$
BEGIN
  RETURN QUERY
  SELECT
    user_id, user_photo_url, user_name, user_last_name, user_email, user_start_date
  FROM syschat.users
  WHERE user_id = id;
END;
$$
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = syschat, pg_temp;
RESET ROLE;





-- USERS TABLE(UPDATE)

SET ROLE sys_user;
CREATE OR REPLACE FUNCTION
sysChat.function_update_t_users_r_sys_user(
    p_user_id         INTEGER,
    p_user_photo_url  VARCHAR DEFAULT NULL,
    p_user_name       VARCHAR DEFAULT NULL,
    p_user_last_name  VARCHAR DEFAULT NULL,
    p_user_email      VARCHAR DEFAULT NULL,
    p_user_password   VARCHAR DEFAULT NULL
)
RETURNS VOID AS $$
BEGIN
  UPDATE syschat.users
  SET
    user_photo_url  = COALESCE(p_user_photo_url, user_photo_url),
    user_name       = COALESCE(p_user_name, user_name),
    user_last_name  = COALESCE(p_user_last_name, user_last_name),
    user_email      = COALESCE(p_user_email, user_email),
    user_password   = COALESCE(p_user_password, user_password)
  WHERE user_id = p_user_id;
END;
$$ LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = syschat, pg_temp;
RESET ROLE;


-- USERS TABLE(DELETE)

CREATE OR REPLACE PROCEDURE syschat.delete_user_by_id(p_user_id UUID)
LANGUAGE plpgsql
AS $$
BEGIN
  DELETE FROM syschat.users
  WHERE user_id = p_user_id;
END;
$$;




REVOKE CREATE ON SCHEMA syschat FROM sys_user;


