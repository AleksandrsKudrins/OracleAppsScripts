SELECT *
  FROM table_name A
 WHERE a.ROWID > ANY (SELECT B.ROWID
                        FROM table_name B
                       WHERE A.msg_id = B.msg_id AND A.msg_id = B.msg_id);

DELETE FROM table_name A
      WHERE a.ROWID >
            ANY (SELECT B.ROWID
                   FROM table_name B
                  WHERE A.msg_id = B.msg_id AND A.msg_id = B.msg_id);