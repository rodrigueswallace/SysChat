GRANT CREATE
  ON SCHEMA syschat
  TO sys_user;



-- CHAT TABLE(INSERT)
CREATE OR REPLACE VIEW syschat.view_insert_t_chat_r_sys_user AS
SELECT chat_name
FROM syschat.chat  



SET ROLE sys_user;

CREATE OR REPLACE FUNCTION
syschat.view_insert_function_t_chat_r_sys_user()
RETURNS trigger AS $$
BEGIN
    INSERT INTO syschat.chat (
      chat_name
    ) VALUES (
      NEW.chat_name
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





REVOKE CREATE ON SCHEMA sysChat FROM sys_user;



