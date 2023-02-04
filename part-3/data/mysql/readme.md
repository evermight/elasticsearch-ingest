I find it helpful to load these csv files into mysql so I can evaluate the results and compare to elasticsearch.

I might need to make this change
```
/etc/mysql/mysql.conf.d/mysqld.conf
[mysqld]
secure-file-priv = ""
```

Then `systemctl restart mysql`


I put all files in the location `/var/lib/mysql/es/*`.  Take a look at the `load.sql` to confirm if the paths are correct.
