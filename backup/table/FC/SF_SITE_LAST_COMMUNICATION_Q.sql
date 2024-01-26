  CREATE SEQUENCE SF_SI_LA_COMMUNICATI_Q_SQ
  MINVALUE 1
  NOMAXVALUE
  START WITH 1
  INCREMENT BY 1
  NOCYCLE
  NOCACHE
;
/
  CREATE TABLE "JAM"."SF_SITE_LAST_COMMUNICATION_Q" 
   (	"SITE_LAST_COMMUNICATION_ID" NUMBER(38,0), 
	"MSS_CUST_ID" NUMBER(19,0), 
	"MSS_SITE_ID" NUMBER(19,0), 
	"SF_SITE_ID" VARCHAR2(18 BYTE), 
	"SF_ASSET_ID" VARCHAR2(18 BYTE), 
	"LAST_MSS_ALARM_ID" NUMBER(14,0), 
	"LAST_RECEIVED_DATE" DATE, 
	"LAST_RECEIVED_DATE_UTC" DATE, 
	"SITE_STATUS" CHAR(1 BYTE), 
	"CREATED_ON" DATE, 
	"CREATED_BY" VARCHAR2(50 BYTE), 
	"MODIFIED_ON" DATE, 
	"MODIFIED_BY" VARCHAR2(50 BYTE), 
	"PROCESSED_FLAG" VARCHAR2(10 BYTE), 
	"SF_CUST_ID" VARCHAR2(18 BYTE), 
	 PRIMARY KEY ("SITE_LAST_COMMUNICATION_ID")
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

  CREATE OR REPLACE EDITIONABLE TRIGGER "JAM"."SF_SI_LA_COMMUNICATI_Q_TG" 
	  BEFORE INSERT ON SF_SITE_LAST_COMMUNICATION_Q
	  FOR EACH ROW
	  DECLARE
	    n_id NUMBER;
	    seq_name VARCHAR2(50);
	  BEGIN
	    seq_name := 'SF_SI_LA_COMMUNICATI_Q_SQ' || '.NEXTVAL';
	    EXECUTE IMMEDIATE 'SELECT ' || seq_name || ' FROM DUAL' INTO n_id;
	    :new.SITE_LAST_COMMUNICATION_ID := n_id;
	  END;

/
ALTER TRIGGER "JAM"."SF_SI_LA_COMMUNICATI_Q_TG" ENABLE;