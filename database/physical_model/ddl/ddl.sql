


DROP SCHEMA IF EXISTS syschat CASCADE;
CREATE SCHEMA syschat;


CREATE TABLE syschat.users(
    user_id INTEGER GENERATED ALWAYS AS IDENTITY,

    user_photo_url  VARCHAR(200)                , 
    user_name       VARCHAR(40 )     NOT NULL   ,
    user_last_name  VARCHAR(40 )     NOT NULL   ,
    user_email      VARCHAR(30)      NOT NULL   ,
    user_password   VARCHAR(128)     NOT NULL   ,
    user_start_date TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
);



CREATE TABLE syschat.chat(
    chat_id INTEGER GENERATED ALWAYS AS IDENTITY,

    chat_name VARCHAR(20) NOT NULL DEFAULT 'Novo Chat',
    chat_start_date TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
	
	user_id UUID NOT NULL,

    CONSTRAINT pk_s_syschat_t_chat PRIMARY KEY (chat_id),
	
    CONSTRAINT fk_chat_user
     FOREIGN KEY (user_id)
     REFERENCES auth.users(id)
     ON UPDATE RESTRICT
     ON DELETE RESTRICT
);

CREATE TABLE syschat.msg(
    msg_id INTEGER GENERATED ALWAYS AS IDENTITY,

    chat_id INTEGER NOT NULL    ,
    is_user BOOLEAN NOT NULL    ,
    msg_context     VARCHAR(300),        ,
    msg_date TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,


    CONSTRAINT pk_s_syschat_t_msg PRIMARY KEY (msg_id),
    CONSTRAINT fk_msg_chat
     FOREIGN KEY (chat_id)
     REFERENCES syschat.chat(chat_id)
     ON UPDATE RESTRICT
     ON DELETE RESTRICT
);



CREATE TABLE syschat.login_log(
    ll_id UUID,

    ll_login_time TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,

	user_id UUID NOT NULL,

    CONSTRAINT pk_s_syschat_t_login_log PRIMARY KEY (ll_id),
    CONSTRAINT fk_ll_user
     FOREIGN KEY (user_id)
     REFERENCES auth.users(id)
     ON UPDATE RESTRICT
     ON DELETE RESTRICT

);


