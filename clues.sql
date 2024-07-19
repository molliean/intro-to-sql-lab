-- Clue #1: We recently got word that someone fitting Carmen Sandiego's description has been traveling through Southern Europe. She's most likely traveling someplace where she won't be noticed, 
-- so find the least populated country in Southern Europe, and we'll start looking for her there.
 
-- Write SQL query here
SELECT code, name, population FROM countries WHERE region= 'Southern Europe' ORDER BY population ASC LIMIT 1;

-- Clue #2: Now that we're here, we have insight that Carmen was seen attending language classes in this country's officially recognized language. 
-- Check our databases and find out what language is spoken in this country, so we can call in a translator to work with you.


-- Write SQL query here
WITH lpc AS (
    SELECT code, name
    FROM countries
    WHERE region='Southern Europe'
    ORDER BY population ASC 
    LIMIT 1
)

SELECT countrylanguages.language FROM countrylanguages
JOIN lpc ON lpc.code = countrylanguages.countrycode;

-- Clue #3: We have new news on the classes Carmen attended – our gumshoes tell us she's moved on to a different country, a country where people speak only the language she was learning. 
-- Find out which nearby country speaks nothing but that language.

-- Write SQL query here
WITH sec AS (
    SELECT name, code
    FROM countries
    WHERE region='Southern Europe'
),
fullitalian AS (
    SELECT countrycode, language, percentage
    FROM countrylanguages
    WHERE language='Italian' AND percentage = 100
)

SELECT sec.name, sec.code FROM sec
JOIN fullitalian ON sec.code = fullitalian.countrycode;

-- Clue #4: We're booking the first flight out – maybe we've actually got a chance to catch her this time. 
-- There are only two cities she could be flying to in the country. One is named the same as the country – that would be too obvious. 
-- We're following our gut on this one; find out what other city in that country she might be flying to.

-- Write SQL query here
SELECT * FROM cities C
WHERE C.countrycode = 'SMR' AND C.name <> 'San Marino';

-- AKA: select from the cities table the city with country code SMR and the name that doesn't equal san marino


-- Clue #5: Oh no, she pulled a switch – there are two cities with very similar names, but in totally different parts of the globe! 
-- She's headed to South America as we speak; go find a city whose name is like the one we were headed to, but doesn't end the same. 
-- Find out the city, and do another search for what country it's in. Hurry!

-- Write SQL query here
SELECT CI.name AS city_name, CO.name AS country_name, CO.capital AS country_capital FROM countries CO
JOIN cities CI ON CO.code = CI.countrycode
WHERE CO.continent = 'South America' AND CI.name LIKE 'Serra%';

-- Clue #6: We're close! Our South American agent says she just got a taxi at the airport, and is headed towards
-- the capital! Look up the country's capital, and get there pronto! Send us the name of where you're headed and we'll
-- follow right behind you!

-- Write SQL query here
SELECT CI.name AS city FROM cities CI 
JOIN countries CO ON CO.capital = CI.id
WHERE CO.capital = 211;

-- Clue #7: She knows we're on to her – her taxi dropped her off at the international airport, and she beat us to the boarding gates. We have one chance to catch her, we just have to know where she's heading and beat her to the landing dock. Lucky for us, she's getting cocky. She left us a note (below), and I'm sure she thinks she's very clever, but if we can crack it, we can finally put her where she belongs – behind bars.


--               Our playdate of late has been unusually fun –
--               As an agent, I'll say, you've been a joy to outrun.
--               And while the food here is great, and the people – so nice!
--               I need a little more sunshine with my slice of life.
--               So I'm off to add one to the population I find
--               In a city of ninety-one thousand and now, eighty five.


-- We're counting on you, gumshoe. Find out where she's headed, send us the info, and we'll be sure to meet her at the gates with bells on.
-- Write SQL query here
SELECT name FROM cities CI WHERE population = 91084;

-- Final answer: Santa Monica