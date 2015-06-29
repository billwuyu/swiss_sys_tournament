create table players(
    id serial primary key,
    name text
    );

create table matches(
    wid integer references players(id),
    lid integer references players(id)
    );

create view winview as select players.id, players.name, count(matches.wid) as wincount from players left join matches on players.id = matches.wid group by players.id;

create view loseview as select players.id, players.name, count(matches.lid) as losecount from players left join matches on players.id = matches.lid group by players.id;

create or replace view standings as select winview.id, winview.name, winview.wincount, (winview.wincount+loseview.losecount) as total from winview join loseview on winview.id = loseview.id order by winview.wincount;



