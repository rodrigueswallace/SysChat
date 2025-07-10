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
  ON FUNCTION syschat.function_select_t_chat_r_sys_user(INTEGER)
  TO login_user;


GRANT UPDATE
  ON syschat.view_update_t_chat_r_sys_user
  TO login_user;


GRANT SELECT 
	ON syschat.view_update_t_chat_r_sys_user
	TO login_user;

GRANT EXECUTE
  ON FUNCTION syschat.view_update_function_t_chat_r_sys_user()
  TO login_user;




-- MSG TABLE
GRANT INSERT
  ON sysChat.view_insert_msg_r_sys_user
  TO login_user;

GRANT EXECUTE
  ON FUNCTION sysChat.view_insert_function_t_msg_r_sys_user()
  TO login_user;

GRANT EXECUTE
  ON FUNCTION syschat.function_select_t_msg_r_sys_user(INTEGER)
  TO login_user;