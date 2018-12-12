SELECT *
  FROM table_name A
 WHERE a.ROWID > ANY (SELECT B.ROWID
                        FROM table_name B
                       WHERE A.column1 = B.column1 AND A.column2 = B.column2);

DELETE FROM table_name A
      WHERE a.ROWID >
            ANY (SELECT B.ROWID
                   FROM table_name B
                  WHERE A.column1 = B.column1 AND A.column2 = B.column2);
