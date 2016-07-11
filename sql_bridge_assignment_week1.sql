1. Which destination in the flights database is the furthest distance away, based on information in the flights table.
Show the SQL query(s) that support your conclusion.

# Answer: The destination 'HNL', Honolulu is furtherst distance away.

select distinct distance, dest
from flights
where distance = (select max(distance) from flights);



2. What are the different numbers of engines in the planes table? For each number of engines, which aircraft have
the most number of seats? Show the SQL statement(s) that support your result.

# Answer: The answer is provided in the table below

# engines	max(seats)	manufacturer 	model
# 1			16			DEHAVILLAND		OTTER DHC-3
# 2			400			BOEING			777-222
# 3			379			AIRBUS			A330-223
# 4			450			BOEING			747-451

select engines, seats, manufacturer, model
from planes
where seats IN (select max(seats) from planes group by engines)
group by engines;


3. Show the total number of flights.
4. Show the total number of flights by airline (carrier).
5. Show all of the airlines, ordered by number of flights in descending order.
6. Show only the top 5 airlines, by number of flights, ordered by number of flights in descending order.
7. Show only the top 5 airlines, by number of flights of distance 1,000 miles or greater, ordered by number of
flights in descending order.
8. Create a question that (a) uses data from the flights database, and (b) requires aggregation to answer it, and
write down both the question, and the query that answers the question.

