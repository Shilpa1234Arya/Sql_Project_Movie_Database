                                         ## SQL Mandatory Project ##

Use moviedb;      -- using moviedb database

-- 1. Write a SQL query to find the actors who were cast in the movie 'Annie Hall'. Return actor first name, last name and role.

#Using these 3 tables to solve this query 
Select*from actors;        -- act_id 
Select*from movie;         -- mov_id
Select*from movie_cast;    -- act_id, mov_id

select a.act_fname, a.act_lname, mc.role
from movie_cast mc
inner join  movie m on mc.mov_id = m.mov_id 
inner join actors a on a.act_id = mc.act_id
where m.mov_title = 'ANNIE HALL';     -- Condition given in question

#Code Explanation:

-- The said query in SQL that retrieves the first name, last name, and role of actors who appear in the movie "Annie Hall".
-- The JOIN clauses connect the three tables together using their primary and foreign keys. This links the actor and movie_cast tables by their actor IDs, and the movie_cast and movie tables by their movie IDs.
-- The WHERE clause filters the results to only include actors who appear in the movie "Annie Hall".

                            ## OR ##
                            
select act_fname, act_lname, role
from actors natural join movie_cast natural join movie where mov_title = 'Annie Hall';                            


-- 2. From the following tables, write a SQL query to find the director who directed a movie that casted a role for 'Eyes Wide Shut'. 
-- Return director first name, last name and movie title.

#Using these 3 tables to solve this query  
Select*from Movie;                -- Mov_id
Select*from director;             -- dir_id
Select*from Movie_direction;      -- dir_id, mov_id
 
Select D.dir_fname, D.dir_lname , m.mov_title
from director D
inner join movie_direction MD on D.dir_id = MD.dir_id
inner join movie M on M.mov_id = MD.mov_id
where M.mov_title = 'Eyes Wide Shut';          -- Condition given in question

#Code Explanation:

-- The said query in SQL that retrieves the first and last name of the
-- director(s) who directed a movie in which any actor played
-- a role that was also played in the movie 'Eyes Wide Shut'.
-- 1. In the innermost subquery, it selects the mov_id of the movie 'Eyes Wide Shut' from the movie table.
-- Then, it uses that mov_id to select all roles played in
-- that movie from the movie_cast table.
-- 2. Then that list of roles are use to select all mov_id values from the movie_cast table where the same
-- roles were played. This effectively finds all movies that have at
-- least one actor playing the same roles as in 'Eyes Wide Shut'.
-- 3. Then, it selects the dir_id values from the movie_direction table for each of those movies found in the step 2.
-- 4. Then the outermost query selects the first, last names and movie title of
-- the director(s) whose dir_id values were found in the step 3.

                       ## OR ##
                       
 select dir_fname, dir_lname, mov_title
 from director natural join movie_direction natural join movie where mov_title = 'Eyes Wide Shut';                       


-- 3. Write a SQL query to find who directed a movie that casted a role as ‘Sean Maguire’.
-- Return director first name, last name and movie title.

#Using these 4 tables to solve this query 
Select*from director;           -- dir_id
Select*from movie;              -- mov_id
Select*from movie_cast;         -- mov_id    
Select*from movie_direction;    -- dir_id, mov_id 

Select D.dir_fname, D.dir_lname, M.mov_title
From movie_cast MC  
inner join movie M on MC.mov_id = M.mov_id
inner join movie_direction MD on MD.mov_id = MC.mov_id
inner join director D on D.dir_id = MD.dir_id
where MC.role = 'Sean Maguire';            -- Condition given in question

#Code Explanation:

-- The said query in SQL that retrieves the first name and last name of the director, as well as the title of the movie, and returns only the rows where the role is "Sean Maguire".
-- The JOIN clauses connect the four tables together using their primary and foreign keys. This links the director and movie_direction tables by their director IDs, the movie_direction and movie tables by their movie IDs, and the movie_cast and movie tables by their movie IDs.
-- The WHERE clause filters the results to only include rows where the role column in movie_cast is "Sean Maguire".

                         ## OR ##
                         
 select dir_fname, dir_lname, Mov_title, role 
 from director natural join movie_direction natural join movie natural join movie_cast where role = 'Sean Maguire';

-- 4. Write a SQL query to find the actors who have not acted in any movie between 1990 and 2000 (Begin and end values are included.). 
-- Return actor first name, last name, movie title and release year. 

#Using these 3 tables to solve this query 
Select * from actors;         -- act_id
Select * from movie;          -- mov_id
Select * from movie_cast;     -- act_id, mov_id

Select A.act_fname, A.act_lname, M.mov_title, M.mov_year
From actors A
inner join movie_cast MC on A.act_id = MC.act_id
inner join Movie M on M.mov_id = MC. mov_id
where M.mov_year not between 1990 and 2000;               -- Condition given in question

# Code Explanation:

-- The said query in SQL that joins the tables actor, movie_cast, and movie, and retrieves the first name and last name of the actors, the title of the movies they acted in, and the year of the movies. The query returns only those movies that were not released between 1990 and 2000.
-- The JOIN clause joins the actor table with the movie_cast table on the act_id column, and then join the resulting table with the movie table on the mov_id column.
-- The condition filters those movies that were not released between 1990 and 2000.

-- 5. Write a SQL query to find the directors with the number of genres of movies. 
-- Group the result set on director first name, last name and generic title. 
-- Sort the result-set in ascending order by director first name and last name. 
-- Return director first name, last name and number of genres of movies.

#Using these 5 tables to solve this query 
Select * from movie;             -- mov_id
Select * from movie_genres;      -- mov_id, gen_id
Select * from genres;            -- gen_id
Select * from movie_direction;   -- dir_id, mov_id
Select * from director;          -- dir_id


select D.dir_fname, D.dir_lname, G.gen_title, count(G.gen_title)
from movie_genres MG
inner join movie M on m.mov_id = MG.mov_id 
inner join genres G on G.gen_id=MG.gen_id
inner join movie_direction MD on MG.mov_id=MD.mov_id
inner join director D on D.dir_id=MD.dir_id
group by D.dir_fname, D.dir_lname, G.gen_title
order by D.dir_fname, D.dir_lname;

#Code Explanation:

-- The said query in SQL that joins the tables director, movie_direction, movie_genres, and genres, and retrieves the first name and last name of the directors, the genre titles, and the count of movies directed by each director in each genre. The query groups the results by director first name, last name, and genre title, and sorts the results by director first name and last name.
-- The NATURAL JOIN keyword, which joins tables based on columns with the same name in each table. This joins the director table with the movie_direction table to get the movies directed by each director. Then joins the resulting table with the movie_genres table to get the genre for each movie and then it join the resulting table with the genres table to get the genre title for each genre ID.
-- The results then grouped by the director first name, last name, and genre title and then it sort the results by director first name and last name.

---------------------------------------------------------------The End---------------------------------------------------------------------------------