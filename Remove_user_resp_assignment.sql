DECLARE
    v_user_name             VARCHAR2 (100) := 'user';
    v_responsibility_name   VARCHAR2 (100) := 'resp';

    l_user_id               INTEGER;
    l_responsibility_id     INTEGER;
    l_application_id        INTEGER;
    l_start_date            DATE;
    l_end_Date              DATE;
    l_description           VARCHAR2 (500);
BEGIN
    SELECT fu.user_id,
           fr.responsibility_id,
           fr.application_id,
           furg.START_DATE,
           SYSDATE,
           furg.description
      INTO l_user_id,
           l_responsibility_id,
           l_application_id,
           l_start_date,
           l_end_date,
           l_description
      FROM fnd_user_resp_groups_direct  furg,
           fnd_user                     fu,
           fnd_responsibility_tl        fr
     WHERE     fu.user_name = v_user_name
           AND fr.responsibility_name = v_responsibility_name
           AND furg.user_id = fu.user_id
           AND furg.responsibility_id = fr.responsibility_id
           AND fr.language = 'US';

    fnd_user_resp_groups_api.update_assignment (
        user_id                         => l_user_id,
        responsibility_id               => l_responsibility_id,
        responsibility_application_id   => l_application_id,
        start_date                      => l_start_date,
        end_date                        => l_end_Date,
        description                     => l_description);

        COMMIT;
        DBMS_OUTPUT.put_line (
           'Responsiblity '
        || v_responsibility_name
        || ' assignment is end dated for user '
        || v_user_name
        || ' successfully');
EXCEPTION
    WHEN OTHERS
    THEN
        DBMS_OUTPUT.put_line (
               'Exception occured: '
            || SQLERRM);
END;
