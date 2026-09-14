-- Most played songs
select s.title, a.name as artist, count(*) as plays
from marts.fct_songplays f
join marts.dim_songs s   on f.song_id = s.song_id
join marts.dim_artists a on f.artist_id = a.artist_id
group by 1, 2
order by plays desc
limit 10;

-- Paid vs free users
select level, count(distinct user_id) as users, count(*) as plays
from marts.fct_songplays
group by 1;

-- Busiest hours
select t.hour, count(*) as plays
from marts.fct_songplays f
join marts.dim_time t on f.start_time = t.start_time
group by 1
order by plays desc;

-- Top locations
select location, count(*) as plays
from marts.fct_songplays
group by 1
order by plays desc
limit 10;