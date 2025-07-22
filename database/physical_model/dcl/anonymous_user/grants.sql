GRANT USAGE
  ON SCHEMA sysChat
  TO anonymous_user;

  


-- USERS TABLE
GRANT INSERT
  ON sysChat.view_insert_user_r_sys_anonymous_user
  TO anonymous_user;

GRANT EXECUTE
  ON FUNCTION sysChat.view_insert_function_t_users_r_sys_anonymous_user()
  TO anonymous_user;


GRANT EXECUTE
  ON FUNCTION syschat.function_select_t_users_r_sys_anonymous_user(VARCHAR)
  TO anonymous_user;


