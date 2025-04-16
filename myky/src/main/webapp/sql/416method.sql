--------------------------------------------------------
--  파일이 생성됨 - 수요일-4월-16-2025   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Function GET_ACCESS_ID
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "SYSTEM"."GET_ACCESS_ID" RETURN NUMBER AS
num NUMBER;
BEGIN
  SELECT SEQ_ACCESS.nextval
  INTO num
  FROM dual;
  return num;
END GET_ACCESS_ID;

select get_order_details_id() from dual;




CREATE OR REPLACE FUNCTION get_order_details_id
RETURN NUMBER
IS
  next_id NUMBER;
BEGIN
  SELECT ORDER_DETAILS_SEQ.NEXTVAL INTO next_id FROM dual;
  RETURN next_id;
END;

/
--------------------------------------------------------
--  DDL for Function GET_ORDER_DETAILS_ID
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "SYSTEM"."GET_ORDER_DETAILS_ID" 
RETURN NUMBER
IS
  next_id NUMBER;
BEGIN
  SELECT ORDER_DETAILS_SEQ.NEXTVAL INTO next_id FROM dual;
  RETURN next_id;
END;

/
