CREATE OR REPLACE PACKAGE BODY pkg_session_params
AS
   --Paramters
   l_user_localization_id NUMBER DEFAULT -98;

   -- Retrieving Application User - Localization schemes
   --* @param     p_user_name     - Application User unique name
   --* @return                    - Id of Localization schemes
   FUNCTION get_user_localization_id ( p_user_name VARCHAR2 := SYS_CONTEXT ( 'USERENV' , 'SESSION_USER' ) )
      RETURN NUMBER
   IS
   BEGIN
      RETURN l_user_localization_id;
   EXCEPTION
      WHEN OTHERS THEN
         -- do you cleanup here
         RAISE;
   END get_user_localization_id;

   -- Setting Application User - Localization schemes
   --* @param     p_user_name     - Application User unique name
   --* @return                    - Id of Localization schemes
   PROCEDURE set_user_localization_id ( p_localization_id NUMBER
                                      , p_user_name     VARCHAR2 := SYS_CONTEXT ( 'USERENV'
                                                                                , 'SESSION_USER' ) )
   IS
   BEGIN
      IF p_localization_id IS NOT NULL THEN
         l_user_localization_id := p_localization_id;
      ELSE
         --Get Defualt localization
         SELECT lc.localization_id
           INTO l_user_localization_id
           FROM u_dw_references.w_localizations lc
          WHERE lc.is_default = 1;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         -- do you cleanup here
         RAISE;
   END set_user_localization_id;
BEGIN
   BEGIN
      --Get Defualt localization
      SELECT lc.localization_id
        INTO l_user_localization_id
        FROM u_dw_references.w_localizations lc
       WHERE lc.is_default = 1;
   EXCEPTION
      WHEN OTHERS THEN
         l_user_localization_id := -98;
   END;
END pkg_session_params;
/