
GRANT USAGE
  ON SCHEMA sysChat
  TO sys_anonymous_user;


-- USER TABLE
  --INSERT
GRANT INSERT
  (user_photo_url, user_name, user_lastName, user_email, user_password)
  ON sysChat.users
  TO sys_anonymous_user;



  --SELECT
GRANT SELECT
  (user_email, user_password)
  ON syschat.users
  TO sys_anonymous_user;