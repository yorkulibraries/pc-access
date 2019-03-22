

// YEARLY STATS
# Unique Users per computer
 select ip, count(distinct(username))
    from computer_activity_logs
    where year(activity_date) = 2016
    group by ip;

# Number of times each IP has been used
 select cal.ip, count(cal.ip), l.name, f.name,  a.name
    from computer_activity_logs cal
    left outer join computers c on c.id = cal.computer_id
    left outer join areas a on a.id = c.area_id
    left outer join locations l on l.id = c.location_id
    left outer join floors f on f.id = c.floor_id
    where year(activity_date) = 2016
    and (action = "logoff" or action = "logoff_inactive")
    group by ip;


## DATE RANGE

# Unique Users per computer
select ip, count(distinct(username))
   from computer_activity_logs
   where activity_date BETWEEN cast('2018-09-01' AS DATE) and cast('2018-12-31' as DATE)
   group by ip;

# Number of times each IP has been used
 select cal.ip, count(cal.ip), l.name, f.name,  a.name
        from computer_activity_logs cal
        left outer join computers c on c.id = cal.computer_id
        left outer join areas a on a.id = c.area_id
        left outer join locations l on l.id = c.location_id
        left outer join floors f on f.id = c.floor_id
        where activity_date BETWEEN cast('2018-09-01' AS DATE) and cast('2018-12-31' as DATE)
        and (action = "logoff" or action = "logoff_inactive")
        group by ip;



### OUTPUT INTO A FILE ####

        INTO OUTFILE '/tmp/2018_stats.csv'
        FIELDS TERMINATED BY ','
        ENCLOSED BY '"'
        LINES TERMINATED BY '\n';
