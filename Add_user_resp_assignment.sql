DECLARE
    l_user_name              VARCHAR2 (100) := 'user';
    l_responsibility_name    VARCHAR2 (100) := 'responsibility_name';

    l_resp_appl_short_name   VARCHAR2 (100);
    l_responsibility_key     VARCHAR2 (100);
    l_security_group_key     VARCHAR2 (100);
    l_resp_start_date        DATE := SYSDATE;
    l_resp_end_date          DATE := NULL;
    l_description            VARCHAR2 (250) := NULL;
BEGIN
    SELECT fr.responsibility_key,
           fa.application_short_name,
           fsg.security_group_key
      INTO l_responsibility_key, l_resp_appl_short_name, l_security_group_key
      FROM fnd_responsibility_tl  frt,
           fnd_responsibility     fr,
           fnd_application        fa,
           fnd_security_groups    fsg
     WHERE     frt.responsibility_name = l_responsibility_name
           AND frt.responsibility_id = fr.responsibility_id
           AND fa.application_id = frt.application_id
           AND fr.data_group_id = fsg.security_group_id;


    fnd_user_pkg.addresp (username         => l_user_name,
                          resp_app         => l_resp_appl_short_name,
                          resp_key         => l_responsibility_key,
                          security_group   => l_security_group_key,
                          description      => l_description,
                          start_date       => l_resp_start_date,
                          end_date         => l_resp_end_date);

    COMMIT;

    DBMS_OUTPUT.put_line (
           'Responsiblity '
        || l_responsibility_name
        || ' is assigned to the user '
        || l_user_name
        || ' successfully');
EXCEPTION
    WHEN OTHERS
    THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE (SQLERRM);
END;
/