CREATE SCHEMA if not EXISTS dtm
/* SQLINES DEMO *** RACTER SET utf8mb4 */
;
drop table IF EXISTS dtm.trans_global;
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE SEQUENCE if not EXISTS dtm.trans_global_seq;
CREATE TABLE if not EXISTS dtm.trans_global (
  id bigint NOT NULL DEFAULT NEXTVAL ('dtm.trans_global_seq'),
  gid varchar(128) NOT NULL,
  trans_type varchar(45) not null,
  status varchar(45) NOT NULL,
  query_prepared varchar(128) NOT NULL,
  protocol varchar(45) not null,
  create_time timestamp(0) DEFAULT NULL,
  update_time timestamp(0) DEFAULT NULL,
  commit_time timestamp(0) DEFAULT NULL,
  finish_time timestamp(0) DEFAULT NULL,
  rollback_time timestamp(0) DEFAULT NULL,
  options varchar(256) DEFAULT '',
  custom_data varchar(256) DEFAULT '',
  next_cron_interval int default null,
  next_cron_time timestamp(0) default null,
  owner varchar(128) not null default '',
  PRIMARY KEY (id),
  CONSTRAINT gid UNIQUE (gid)
);
create index if not EXISTS owner on dtm.trans_global(owner);
create index if not EXISTS status_next_cron_time on dtm.trans_global (status, next_cron_time);
drop table IF EXISTS dtm.trans_branch_op;
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE SEQUENCE if not EXISTS dtm.trans_branch_op_seq;
CREATE TABLE IF NOT EXISTS dtm.trans_branch_op (
  id bigint NOT NULL DEFAULT NEXTVAL ('dtm.trans_branch_op_seq'),
  gid varchar(128) NOT NULL,
  url varchar(128) NOT NULL,
  data TEXT,
  bin_data BLOB,
  branch_id VARCHAR(128) NOT NULL,
  op varchar(45) NOT NULL,
  status varchar(45) NOT NULL,
  finish_time timestamp(0) DEFAULT NULL,
  rollback_time timestamp(0) DEFAULT NULL,
  create_time timestamp(0) DEFAULT NULL,
  update_time timestamp(0) DEFAULT NULL,
  PRIMARY KEY (id),
  CONSTRAINT gid_uniq UNIQUE (gid, branch_id, op)
);