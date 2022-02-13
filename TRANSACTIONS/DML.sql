-- подготовка данных 
DROP TABLE b_users;
/
CREATE TABLE b_users(
user_id NUMBER NOT NULL,
first_name VARCHAR2(64) NOT NULL,
last_name VARCHAR2(64) NOT NULL,
is_admin NUMBER(1)DEFAULT 0  CHECK (is_admin IN (0,1)) NOT NULL ,
satus NUMBER(1) DEFAULT 0  CHECK (satus IN (0,1)) NOT NULL ,
CONSTRAINT b_users_pk PRIMARY KEY(user_id)
);

-- таблица категории
DROP TABLE b_categories;
/
CREATE TABLE b_categories(
category_id NUMBER NOT NULL,
title VARCHAR2(25) NOT NULL,
descr VARCHAR(255) NOT NULL,
parent_id NUMBER ,
CONSTRAINT b_categories_pk PRIMARY KEY(category_id),
CONSTRAINT b_categories_pearent_fk FOREIGN KEY(parent_id) REFERENCES b_categories(category_id) 
);

-- таблица постов 
DROP TABLE b_posts;
/
CREATE TABLE  b_posts(
 post_id NUMBER NOT NULL ,
 category_id NUMBER, 
 title VARCHAR2(25) NOT NULL,
 descr VARCHAR(255) NOT NULL,
 status NUMBER(1) NOT NULL DEFAULT 0,
 created_at DATE,
 updated_at DATE,
 CONSTRAINT b_posts_pk PRIMARY KEY(post_id),
 CONSTRAINT b_posts_category_fk FOREIGN KEY(category_id) REFERENCES b_categories(category_id),
 CONSTRAINT b_posts_status_chk CHECK (status IN (0,1))
);
/
-- таблица коментариев 
DROP TABLE b_comments;
/
CREATE TABLE b_comments(
comment_id NUMBER NOT NULL,
user_id NUMBER NOT NULL,
post_id NUMBER NOT NULL,
status NUMBER(1) DEFAULT 0 NOT NULL,
 created_at DATE,
 updated_at DATE,
 CONSTRAINT  b_comments_pk PRIMARY KEY (comment_id),
 CONSTRAINT  b_comments_user_fk FOREIGN KEY(comment_id) REFERENCES b_users(user_id),
 CONSTRAINT  b_comments_post_fk FOREIGN KEY(post_id) REFERENCES b_posts(post_id),
 CONSTRAINT  b_comments_status_chk CHECK(status IN (0,1))  
)
