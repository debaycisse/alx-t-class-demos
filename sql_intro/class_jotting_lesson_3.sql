/*
    Lesson Overview

    In this lesson you will be:

        > Creating Joins
        > Using Primary - Foreign Keys
        > Integrating Aliases
        > Evaluating Various Join Types
        > Integrating Filters with Joins

*/



### Database Normalization
/*********************************************************
    When creating a database, it is really important to think about how data will be stored. This is known as normalization, 
    and it is a huge part of most SQL classes. If you are in charge of setting up a new database, it is important to have a 
    thorough understanding of database normalization.

    There are essentially three ideas that are aimed at database normalization:

        1. Are the tables storing logical groupings of the data?
        2. Can I make changes in a single location, rather than in many tables for the same information?
        3. Can I access and manipulate data quickly and efficiently?
*********************************************************/










### JOIN & ON
/*********************************************************
    The whole purpose of JOIN statements is to allow us to pull data from more than one table at a time.
    JOINs are useful for allowing us to pull data from multiple tables. 

    ON
    With the addition of the JOIN statement to our toolkit, we will also be adding the ON statement.
    We use ON clause to specify a JOIN condition which is a logical statement to combine the table 
    in FROM and JOIN statements.
    In the ON, we will ALWAYs have the PK equal to the FK, though, the actual ordering of which table 
    name goes first in this statement doesn't matter so much; therefore it could go in the other 
    way - that is FK equal to the PK.
*********************************************************/
-- Examples

-- Try pulling all the data from the accounts table, and all the data from the orders table.
    SELECT *
    FROM orders
    JOIN accounts
    ON orders.account_id = accounts.id

/* Try pulling standard_qty, gloss_qty, and poster_qty from the orders table, and the website 
and the primary_poc from the accounts table.*/
    SELECT orders.standard_qty, orders.gloss_qty, orders.poster_qty, accounts.website, accounts.primary_poc
    FROM orders
    JOIN accounts
    ON orders.account_id = accounts.id
    








### JOINing more than 2 tables
/*********************************************************
    If we wanted to join all three of these tables, we could use the same logic. The code example below 
    pulls all of the data from all of the joined tables.
*********************************************************/
-- Examples
    -- To select all columns in the 3 tables
        SELECT *
        FROM web_events
        JOIN accounts
        ON web_events.account_id = accounts.id
        JOIN orders
        ON accounts.id = orders.account_id;

    -- To select some specific columns
        SELECT web_events.channel, accounts.name, orders.total
        FROM web_events
        JOIN accounts
        ON web_events.account_id = accounts.id
        JOIN orders
        ON accounts.id = orders.account_id









### Alias
/*********************************************************
    When we JOIN tables together, it is nice to give each table an alias. Frequently an alias 
    is just the first letter of the table name.
    You can give a table an alias in the FROM and JOIN section of a query.
    Using alias makes your query code much more shorter.
    Note that the alias can also be written using AS keyword before giving the alias as done 
    in the derived column example.
*********************************************************/
-- Example
    -- Use the first letter of a table name as its alias
        SELECT w.channel, a.name, o.total
        FROM web_events w
        JOIN accounts a
        ON w.account_id = a.id
        JOIN orders o
        ON a.id = o.account_id

    #### Aliases for Columns in Resulting Table
    /*********************************************************
        While aliasing tables is the most common use case. It can also be used to alias the 
        columns selected to have the resulting table reflect a more readable name.
    *********************************************************/
        -- Example
        
        SELECT t1.column1 aliasname, t2.column2 aliasname2
        FROM tablename AS t1
        JOIN tablename2 AS t2
        -- The alias name fields will be what shows up in the returned table instead 
        -- of t1.column1 and t2.column2
        
        -- Therefore, we can have, something like the below
        SELECT o.account_id accountID, a.name accountName
        FROM orders o
        JOIN accounts a
        ON o.account_id = a.id  

        /*
            If you have two or more columns in your SELECT that have the same name after the 
            table name such as accounts.name and sales_reps.name you will need to alias them. 
            Otherwise it will only show one of the columns. You can alias them like 
            accounts.name AS AcountName, sales_rep.name AS SalesRepName
        */
-- Questions on JOIN
/*
    Provide a table for all web_events associated with the account name of Walmart. There should be three columns. Be sure to include the primary_poc, time of the event, and the channel for each event. Additionally, you might choose to add a fourth column to assure only Walmart events were chosen.

*/
    SELECT ac.primary_poc primary_poc, we.occurred_at occurred_at, we.channel, ac.name
    FROM web_events we
    JOIN accounts ac
    ON we.account_id = ac.id 
    WHERE ac.name = 'Walmart';

/*
    Provide a table that provides the region for each sales_rep along with their associated accounts. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to the account name.

*/
    SELECT r.name AS RegionName, s.name AS SalesRepName, a.name AS AccountName 
    FROM sales_reps s
    JOIN region r
    ON s.region_id = r.id
    JOIN accounts a
    ON s.id = a.sales_rep_id
    ORDER BY a.name


/*
    Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. Your final table should have 3 columns: region name, account name, and unit price. A few accounts have 0 for total, so I divided by (total + 0.01) to assure not dividing by zero.        

*/
    SELECT region.name AS RegionName, accounts.name AS AccountName, orders.total_amt_usd / (orders.total + 0.01) AS unitPrice
    FROM orders
    JOIN accounts
    ON orders.account_id = accounts.id
    JOIN sales_reps
    ON accounts.sales_rep_id = sales_reps.id
    JOIN region
    ON sales_reps.region_id = region.id









### LEFT & RIGHT JOIN
/*********************************************************
    Both Left, Right, Full are all known as outer joins.

    Before this section, the join we have used so far is known ad inner join - it joins tables' rows where the logical expression of the ON statement is evaluated to true while it throws away any additional row that does not evalute to true on both involved tables.

    The behavior of every other joins (also, know as outer join) is the exact opposite of inner join.

    In other words, outer join outputs all the data or row in one table that are not in the other table in a join query.

    Left Join (Left Outer Join) only outputs both the rows where the ON statement evaluates to true and the remaining rows where the ON statement does not evaluate to true, from the left table, which is the table whose name is given on the FROM section of the query. We create left join by adding the word LEFT to the join keyword with space in between the two words.
    E.G
        SELECT a.id, a.name, o.total
        FROM orders o
        LEFT JOIN accounts a
        ON o.account_id = a.id

    Right Join (Right Outer Join) is similar to the left join but outputs the additional rows that do not match from the RIGHT table instead of the rows from the left table. We create left join by adding the word RIGHT to the join keyword with space in between the two words.
    E.G
        SELECT a.id, a.name, o.total
        FROM orders o
        RIGHT JOIN accounts a
        ON o.account_id = a.id

    If there is not matching information in the JOINed table, then you will have columns with empty cells. These empty cells introduce a new data type called NULL.

    LEFT OUTER JOIN
    OR
    RIGHT OUTER JOIN
    are the exact same commands as the LEFT JOIN and RIGHT JOIN.
*********************************************************/










### FULL OUTER JOIN
/*********************************************************
    This is similar to both Left & Right outer Join but displays the inner join results and the the rows that don't match up from the both involved tables in a query where this full outer join is used.

    It is declared by adding the word OUTER before the JOIN keyword and space is inserted in between them.

    his will return the inner join result set, as well as any unmatched rows from either of the two tables being joined.

    Again this returns rows that do not match one another from the two tables. The use cases for a full outer join are very rare.

    Similar to the above, you might see the language FULL OUTER JOIN, which is the same as OUTER JOIN.
*********************************************************/









### Last Quiz or Question for lesson 3
/*********************************************************
    Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to the account name.
*********************************************************/
    SELECT  r.name AS region_name, s.name AS sales_rep_name, a.name AS account_name
    FROM sales_reps s
    JOIN region r
    ON s.region_id = r.id
    JOIN accounts a
    ON s.id = a.sales_rep_id
    WHERE r.name = 'Midwest'
    ORDER BY a.name;


/*********************************************************
    Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for accounts where the sales rep has a first name starting with S and in the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to the account name.
*********************************************************/
    SELECT r.name AS region_name, s.name AS sales_rep_name, a.name AS account_name
    FROM sales_reps s
    JOIN region r
    ON s.region_id = r.id
    JOIN accounts a
    ON s.id = a.sales_rep_id
    WHERE s.name LIKE 'S%' AND r.name = 'Midwest'
    ORDER BY a.name;


/*********************************************************
    Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for accounts where the sales rep has a last name starting with K and in the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to the account name.
*********************************************************/
    SELECT r.name AS region_name, s.name AS sales_rep_name, a.name AS account_name
    FROM sales_reps s
    JOIN region r
    ON s.region_id = r.id
    JOIN accounts a
    ON s.id = a.sales_rep_id
    WHERE s.name LIKE '% K%' AND r.name = 'Midwest'
    ORDER BY a.name;


/*********************************************************
    Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100. Your final table should have 3 columns: region name, account name, and unit price. In order to avoid a division by zero error, adding .01 to the denominator here is helpful total_amt_usd/(total+0.01).
*********************************************************/
    SELECT r.name AS region_name, a.name AS account_name, o.total_amt_usd / (o.total + 0.01) AS unit_price
    FROM orders o
    JOIN accounts a
    ON a.id = o.account_id
    JOIN sales_reps s
    ON a.sales_rep_id = s.id
    JOIN region r
    ON s.region_id = r.id
    WHERE o.standard_qty > 100;


/*********************************************************
    Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. Your final table should have 3 columns: region name, account name, and unit price. Sort for the smallest unit price first. In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01).
*********************************************************/
    SELECT r.name AS region_name, a.name AS account_name, o.total_amt_usd / (o.total + 0.01) AS unit_price
    FROM orders o
    JOIN accounts a
    ON a.id = o.account_id
    JOIN sales_reps s
    ON a.sales_rep_id = s.id
    JOIN region r
    ON s.region_id = r.id
    WHERE o.standard_qty > 100 AND o.poster_qty > 50
    ORDER BY unit_price;


/*********************************************************
    Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. Your final table should have 3 columns: region name, account name, and unit price. Sort for the largest unit price first. In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01).
*********************************************************/
    SELECT r.name AS region_name, a.name AS account_name, o.total_amt_usd / (o.total + 0.01) AS unit_price
    FROM orders o
    JOIN accounts a
    ON a.id = o.account_id
    JOIN sales_reps s
    ON a.sales_rep_id = s.id
    JOIN region r
    ON s.region_id = r.id
    WHERE o.standard_qty > 100 AND o.poster_qty > 50
    ORDER BY unit_price DESC;


/*********************************************************
    What are the different channels used by account id 1001? Your final table should have only 2 columns: account name and the different channels. You can try SELECT DISTINCT to narrow down the results to only the unique values.
*********************************************************/
    SELECT DISTINCT a.name AS account_name, w.channel AS web_channel
    FROM web_events w
    JOIN accounts a
    ON w.account_id = a.id
    WHERE w.account_id = 1001;


/*********************************************************
    Find all the orders that occurred in 2015. Your final table should have 4 columns: occurred_at, account name, order total, and order total_amt_usd.
*********************************************************/
    SELECT o.occurred_at AS order_date, a.name AS account_name, o.total, o.total_amt_usd
    FROM orders o
    JOIN accounts a
    ON o.account_id = a.id
    WHERE o.occurred_at BETWEEN '2015-01-01' AND '2016-01-01';
