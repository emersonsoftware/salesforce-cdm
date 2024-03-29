CREATE TABLE SF_EXT_COMM_REQ_LOG
(
  ID   NUMBER(18)
 ,REQUEST_NAME VARCHAR2(255)
 ,REQ_START_TIME      DATE
 ,REQ_END_TIME      DATE
 ,STATUS           VARCHAR2(255)
 ,REQ_MESSAGE          CLOB
 ,RES_MESSAGE           CLOB
 ,created_on 		       DATE
 ,created_by 		       VARCHAR2(50)
 ,modified_on              DATE
 ,modified_by              VARCHAR2(50)
)
PCTFREE 10
INITRANS 1
MAXTRANS 255
TABLESPACE SFRCD01
STORAGE(INITIAL 16M
        NEXT 8M
        MINEXTENTS 1
        MAXEXTENTS UNLIMITED
        PCTINCREASE 0
        )
/

ALTER TABLE SF_EXT_COMM_REQ_LOG ADD (
  PRIMARY KEY
  (ID)
  USING INDEX
    TABLESPACE SFRCX01
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          16M
                NEXT             8M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               )
  ENABLE VALIDATE)
  
/
CREATE SEQUENCE  "JAM"."SF_EXT_COMM_REQ_LOG_SQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;

/

create or replace TRIGGER SF_EXT_COMM_REQ_LOG_TG
	  BEFORE INSERT ON SF_EXT_COMM_REQ_LOG
	  FOR EACH ROW
	  DECLARE
	    n_id NUMBER;
	    seq_name VARCHAR2(50);
	  BEGIN
	    seq_name := 'SF_EXT_COMM_REQ_LOG_SQ' || '.NEXTVAL';
	    EXECUTE IMMEDIATE 'SELECT ' || seq_name || ' FROM DUAL' INTO n_id;
	    :new.ID := n_id;
	  END;
/
