CREATE SEQUENCE sf_cust_site_controller_sq
  MINVALUE 999900000000001
  NOMAXVALUE
  START WITH 999900000000001
  INCREMENT BY 1
  NOCYCLE
  NOCACHE
;

/
--generate mss cust id for new customer
create or replace TRIGGER JAM.SF_CUSTOMER_TG BEFORE
  INSERT OR UPDATE ON JAM.SF_CUSTOMER FOR EACH ROW
DECLARE n_id NUMBER;
BEGIN
  IF :new.MSS_CUST_ID IS NULL AND INSERTING THEN
	EXECUTE IMMEDIATE 'SELECT sf_cust_site_controller_sq.NEXTVAL FROM DUAL' INTO n_id;
    :new.MSS_CUST_ID:=n_id;
  END IF;
  IF UPDATING AND :OLD.MSS_CUST_ID IS NOT NULL THEN
    :NEW.MSS_CUST_ID:=:OLD.MSS_CUST_ID;
  END IF;
END;

/
--generate mss site id for new site
create or replace TRIGGER SF_SITE_TG BEFORE
  INSERT OR UPDATE ON SF_SITE FOR EACH ROW
DECLARE n_id NUMBER;
BEGIN
  IF :new.MSS_SITE_ID IS NULL AND INSERTING THEN
    EXECUTE IMMEDIATE 'SELECT sf_cust_site_controller_sq.NEXTVAL FROM DUAL' INTO n_id;
    :new.MSS_SITE_ID:=n_id;
	FOR CUST IN( SELECT MSS_CUST_ID FROM SF_CUSTOMER WHERE SF_CUST_ID=:new.SF_CUST_ID)
    LOOP
      :new.MSS_CUST_ID:=CUST.MSS_CUST_ID;
    END LOOP;
  END IF;
  IF UPDATING AND :OLD.MSS_SITE_ID IS NOT NULL THEN
    :NEW.MSS_SITE_ID:=:OLD.MSS_SITE_ID;
  END IF;
END;

/
--generate mss control id for new asset
create or replace TRIGGER JAM.SF_CONTROL_SYS_TG BEFORE
  INSERT ON JAM.SF_CONTROL_SYS FOR EACH ROW
DECLARE n_id NUMBER;
BEGIN
  IF :new.MSS_EXT_ID IS NULL AND INSERTING THEN
	EXECUTE IMMEDIATE 'SELECT sf_cust_site_controller_sq.NEXTVAL FROM DUAL' INTO n_id;
    :new.MSS_EXT_ID:=n_id;
  END IF;
  IF UPDATING AND :OLD.MSS_EXT_ID IS NOT NULL THEN
   :NEW.MSS_EXT_ID:=:OLD.MSS_EXT_ID;
  END IF;
END
;