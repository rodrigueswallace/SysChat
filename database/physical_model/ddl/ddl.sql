DROP SCHEMA IF EXISTS syschat CASCADE;
CREATE SCHEMA syschat;


CREATE TABLE syschat.users(
    user_id INTEGER GENERATED ALWAYS AS IDENTITY,

    user_photo_url  VARCHAR(200)                , 
    user_name       VARCHAR(10 )     NOT NULL   ,
    user_last_name  VARCHAR(20 )     NOT NULL   ,
    user_email      VARCHAR(100)     NOT NULL   ,
    user_password   VARCHAR(128)     NOT NULL   ,
    user_start_date TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,


    CONSTRAINT uq_s_syschat_t_user_c_user_email UNIQUE (user_email),
    CONSTRAINT pk_s_syschat_t_user PRIMARY KEY (user_id),
    CONSTRAINT ck_user_email_format CHECK (user_email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
);


CREATE TABLE syschat.chat(
    chat_id INTEGER GENERATED ALWAYS AS IDENTITY,

    user_id INTEGER NOT NULL,
    chat_name VARCHAR(20) NOT NULL DEFAULT 'Chat',
    chat_start_date TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,


    CONSTRAINT pk_s_syschat_t_chat PRIMARY KEY (chat_id),
    CONSTRAINT fk_chat_user
     FOREIGN KEY (user_id)
     REFERENCES syschat.users(user_id)
     ON UPDATE RESTRICT
     ON DELETE RESTRICT
);


CREATE TABLE syschat.msg(
    msg_id INTEGER GENERATED ALWAYS AS IDENTITY,

    chat_id INTEGER NOT NULL    ,
    is_user BOOLEAN NOT NULL    ,
    msg_context     TEXT        ,
    msg_date TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,


    CONSTRAINT pk_s_syschat_t_msg PRIMARY KEY (msg_id),
    CONSTRAINT fk_msg_chat
     FOREIGN KEY (chat_id)
     REFERENCES syschat.chat(chat_id)
     ON UPDATE RESTRICT
     ON DELETE RESTRICT
);



CREATE TABLE syschat.login_log(
    ll_id INTEGER GENERATED ALWAYS AS IDENTITY,

    user_id INTEGER NOT NULL,
    ll_login_time TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_s_syschat_t_login_log PRIMARY KEY (ll_id),
    CONSTRAINT fk_ll_user
     FOREIGN KEY (user_id)
     REFERENCES syschat.users(user_id)
     ON UPDATE RESTRICT
     ON DELETE RESTRICT

);


CREATE INDEX idx_user_email ON syschat.users(user_email);
CREATE INDEX idx_chat_users ON syschat.chat(user_id);
CREATE INDEX idx_msg_chat ON syschat.msg(chat_id);
CREATE INDEX idx_msg_date ON syschat.msg(msg_date);









