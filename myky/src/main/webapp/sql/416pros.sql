--------------------------------------------------------
--  파일이 생성됨 - 수요일-4월-16-2025   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure RESET_DONATION_YN
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "SYSTEM"."RESET_DONATION_YN" IS
BEGIN
  UPDATE membership
  SET donation_yn = 'N';
  COMMIT;
END;    

/

BEGIN
    DBMS_SCHEDULER.CREATE_JOB (
            job_name => '"SYSTEM".""',
            job_type => 'STORED_PROCEDURE',
            job_action => 'SYSTEM.RESET_DONATION_YN',
            number_of_arguments => 0,
            start_date => TO_TIMESTAMP_TZ('2025-05-01 00:00:00.000000000 +09:00','YYYY-MM-DD HH24:MI:SS.FF TZR'),
            repeat_interval => 'FREQ=MONTHLY;BYMONTHDAY=1;BYHOUR=0;BYMINUTE=0;BYSECOND=0',
            end_date => NULL,
            enabled => FALSE,
            auto_drop => TRUE,
            comments => '매월 1일 donation_yn 값을 N으로 초기화하는 작업');

         
     
 
    DBMS_SCHEDULER.SET_ATTRIBUTE( 
             name => '"SYSTEM".""', 
             attribute => 'store_output', value => TRUE);
    DBMS_SCHEDULER.SET_ATTRIBUTE( 
             name => '"SYSTEM".""', 
             attribute => 'logging_level', value => DBMS_SCHEDULER.LOGGING_OFF);
      
   
  
    
    DBMS_SCHEDULER.enable(
             name => '"SYSTEM".""');
END;

/