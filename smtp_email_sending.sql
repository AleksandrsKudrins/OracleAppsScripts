DECLARE
    l_mail_conn            UTL_SMTP.connection;
    l_host        CONSTANT VARCHAR2 (25) := 'host';
    l_from        CONSTANT VARCHAR2 (25) := 'from@domain.com';
    l_recipient   CONSTANT VARCHAR2 (25) := 'recipient@domain.com';
BEGIN
    l_mail_conn := UTL_SMTP.open_connection (l_host, 25);
    UTL_SMTP.helo (l_mail_conn, l_host);
    UTL_SMTP.mail (l_mail_conn, l_from);

    UTL_SMTP.rcpt (l_mail_conn, l_recipient);

    UTL_SMTP.Data (
        l_mail_conn,
           'Date: '
        || TO_CHAR (SYSDATE, 'Dy, DD Mon YYYY hh24:mi:ss')
        || UTL_TCP.CRLF
        || 'From: '
        || l_from
        || UTL_TCP.CRLF
        || 'Subject: '
        || 'Subject text'
        || UTL_TCP.CRLF
        || 'To: '
        || l_recipient
        || UTL_TCP.CRLF
        || UTL_TCP.CRLF
        || 'Message Body'
        || UTL_TCP.CRLF 
                       );
    UTL_SMTP.quit (l_mail_conn);
EXCEPTION
    WHEN OTHERS
    THEN
        DBMS_OUTPUT.PUT_LINE ('EXCEPTION: ' || SQLERRM);
END;