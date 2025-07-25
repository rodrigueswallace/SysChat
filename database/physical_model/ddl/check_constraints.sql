
-- ============================
-- TABELA: syschat.users
-- ============================

-- user_name não pode ser vazio
ALTER TABLE syschat.users
ADD CONSTRAINT chk_users_user_name_not_empty
CHECK (char_length(user_name) > 0);

-- user_last_name não pode ser vazio
ALTER TABLE syschat.users
ADD CONSTRAINT chk_users_user_last_name_not_empty
CHECK (char_length(user_last_name) > 0);

-- user_email deve ter ao menos 6 caracteres e conter '@'
ALTER TABLE syschat.users
ADD CONSTRAINT chk_users_user_email_valid
CHECK (char_length(user_email) > 5 AND position('@' IN user_email) > 1);

-- user_password deve ter no mínimo 8 caracteres
ALTER TABLE syschat.users
ADD CONSTRAINT chk_users_user_password_min_length
CHECK (char_length(user_password) >= 8);

-- ============================
-- TABELA: syschat.chats
-- ============================

-- chat_name não pode ser vazio
ALTER TABLE syschat.chats
ADD CONSTRAINT chk_chats_chat_name_not_empty
CHECK (char_length(chat_name) > 0);

-- ============================
-- TABELA: syschat.messages
-- ============================

-- msg_context não pode ser vazio (se informado)
ALTER TABLE syschat.messages
ADD CONSTRAINT chk_messages_msg_context_not_empty
CHECK (msg_context IS NULL OR char_length(msg_context) > 0);

