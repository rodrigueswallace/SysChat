GRANT USAGE
  ON SCHEMA sysChat
  TO sys_user;


-- USERS TABLE

GRANT SELECT
  ( user_id,user_photo_url, user_name, user_lastName, user_email, user_password, user_start_date)
  ON sysChat.users
  TO sys_user;

GRANT UPDATE
  (user_photo_url, user_name, user_lastName, user_email, user_password)
  ON sysChat.users
  TO sys_user;


-- CHAT TABLE
GRANT INSERT
  (chat_name)
  ON sysChat.chat
  TO sys_user;

GRANT SELECT
  (chat_id, chat_name, chat_start_date)
  ON sysChat.chat
  TO sys_user;

GRANT UPDATE
  (chat_name)
  ON sysChat.chat
  TO sys_user;



-- MSG TABLE
GRANT INSERT
  (is_user, msg_context)
  ON sysChat.msg
  TO sys_user;

GRANT SELECT
  (msg_id, is_user, msg_context, msg_date)
  ON sysChat.msg
  TO sys_user;

