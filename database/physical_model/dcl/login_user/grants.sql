GRANT USAGE
  ON SCHEMA syschat
  TO login_user;




-- USERS TABLE
GRANT EXECUTE
  ON FUNCTION syschat.function_select_t_users_r_sys_user(INTEGER)
  TO login_user;

GRANT EXECUTE
  ON FUNCTION syschat.view_update_function_t_users_r_sys_user(INTEGER, VARCHAR, VARCHAR, VARCHAR, VARCHAR, VARCHAR)
  TO login_user;



-- CHAT TABLE
GRANT INSERT
  ON syschat.view_insert_t_chat_r_sys_user
  TO login_user;

GRANT EXECUTE
  ON FUNCTION syschat.view_insert_function_t_chat_r_sys_user()
  TO login_user;


GRANT EXECUTE
  ON FUNCTION ...(funcion para select)
  TO login_user;


GRANT INSERT
  ON ...(view)
  TO login_user;

GRANT EXECUTE
  ON FUNCTION ...(funcion da view update )
  TO login_user;




-- CHAT TABLE
GRANT INSERT
  ON ...(view)
  TO login_user;

GRANT EXECUTE
  ON FUNCTION ...(funcion da view insert )
  TO login_user;

GRANT EXECUTE
  ON FUNCTION ...(funcion para select)
  TO login_user;