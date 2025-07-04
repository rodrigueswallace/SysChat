GRANT USAGE
  ON SCHEMA syschat
  TO sys_user;


-- USERS TABLE

GRANT SELECT
  ( user_id,user_photo_url, user_name, user_last_name, user_email, user_password, user_start_date)
  ON syschat.users
  TO sys_user;

GRANT UPDATE
  (user_photo_url, user_name, user_last_name, user_email, user_password)
  ON syschat.users
  TO sys_user;


-- CHAT TABLE
GRANT INSERT
  (chat_name, user_id)
  ON syschat.chat
  TO sys_user;

GRANT SELECT
  (chat_id, chat_name, chat_start_date)
  ON syschat.chat
  TO sys_user;

GRANT UPDATE
  (chat_name)
  ON syschat.chat
  TO sys_user;



-- MSG TABLE
GRANT INSERT
  (is_user, msg_context)
  ON syschat.msg
  TO sys_user;

GRANT SELECT
  (msg_id, is_user, msg_context, msg_date)
  ON syschat.msg
  TO sys_user;

