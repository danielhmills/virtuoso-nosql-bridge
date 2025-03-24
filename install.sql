CREATE PROCEDURE nosql_query(IN dsn VARCHAR, IN query VARCHAR){
  
    DECLARE mdta_out any;
    DECLARE res_vec_out, param_vec any;
    DECLARE sql_state, err_msg varchar;
    DECLARE inx integer;
    DECLARE num_cols_out integer;

    sql_state := '00000';
    param_vec := vector ('A', 'B');

    REXECUTE (dsn, query, sql_state, err_msg, param_vec,num_cols_out, mdta_out, res_vec_out, NULL);

    IF (sql_state <> '00000')
    {
      SIGNAL ('nosql_query',CONCAT ('Remote execution returned ', sql_state, ' ', err_msg));
    }

    EXEC_RESULT_NAMES (mdta_out[0]);
    inx := 0;
    WHILE (inx < length (res_vec_out))
    {
      EXEC_RESULT ( res_vec_out[inx]);
      inx := inx + 1;
    }
  
    END_RESULT ();
};
