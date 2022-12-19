# Investigatings Incidents By Digging Through Logs #

## Find log entries from a specific date/time ##

If your logs look like this:
```bash
2022-10-03 04:10:10 EDT [14165]: [2021-1] user=postgres, db=stage0_data, app=pg_dump, client=localhost LOG:  statement: COPY public.daily_average_measurements (_id, pollutant, monitor, date_lst, daily_average_value, completeness, actual_samples_count, anomalous_count, duplicate_samples_count, duplicate_time_count, expected_samples_count, negative_count, outlier_count, stuck_count, total_samples_count, unphysical_count, valid_count) TO stdout;
```
You can use the following RegEx to find time entries from `00:00` through `05:59`:
```bash
grep -E '^2022-10-03\s0[0-5]:[0-5][0-9]' postgresql12-Mon.log
```

