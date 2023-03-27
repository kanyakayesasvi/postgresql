--avg
select avg(movie_length)
from movies


create table avgnull(
i int )

insert into avgnull(i)
values
(1),
(2),
(3),
(4),
(null)
returning *


select avg
(i) from avgnull

--avg ignores null	