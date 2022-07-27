--DROP PACKAGE pkg_session_params;

CREATE OR REPLACE PACKAGE pkg_session_params
AS
   -- Retrieving Application User - Localization schemes
   --* @param     p_user_name     - Application User unique name
   --* @return                    - Id of Localization schemes
   FUNCTION get_user_localization_id ( p_user_name VARCHAR2 := SYS_CONTEXT ( 'USERENV' , 'SESSION_USER' ) )
      RETURN NUMBER;

   -- Setting Application User - Localization schemes
   --* @param     p_user_name     - Application User unique name
   --* @return                    - Id of Localization schemes
   PROCEDURE set_user_localization_id ( p_localization_id NUMBER
                                      , p_user_name     VARCHAR2 := SYS_CONTEXT ( 'USERENV'
                                                                                , 'SESSION_USER' ) );
END pkg_session_params;
/