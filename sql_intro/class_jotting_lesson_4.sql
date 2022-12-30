### Lesson 04 - SQL Aggregation
/*********************************************************
    NULL - this is queried by using IS and not =.
    For example.
        SELECT *
        FROM accounts
        WHERE primary_poc IS NOT NULL;
*********************************************************/









### Count aggregation function
/*********************************************************
    This is used to count all number rows of a given query.
    COUNT() can also be used to count a row of a given column name but it does not count any cell of given column with NULL value
*********************************************************/
    -- Example
        SELECT COUNT(*)
        FROM orders
        WHERE occurred_at >= '2016-12-01' AND occurred_at < '2017-01-01'
        -- OR
        SELECT COUNT(id)
        FROM orders
        WHERE occurred_at >= '2016-12-01' AND occurred_at < '2017-01-01'







### SUM
/*********************************************************
    Unlike COUNT, you can only use SUM on numeric columns. However, SUM will ignore NULL values.

    Aggregation Reminder
    An important thing to remember: aggregators only aggregate vertically - the values of a column. If you want to perform a calculation across rows, you would do this with simple arithmetic, just like we did for derived column.
*********************************************************/
    -- Example
        SELECT SUM(standard_qty) AS standard, 
        SUM(gloss_qty) AS gloss, 
        SUM(poster_qty) AS poster
        FROM orders

        /*
            Find the total amount of poster_qty paper ordered in the orders table.
        */
        SELECT SUM(poster_qty)
        FROM orders;


        /*
            Find the total amount of standard_qty paper ordered in the orders table.
        */
        SELECT SUM(standard_qty)
        FROM orders;


        /*
            Find the total dollar amount of sales using the total_amt_usd in the orders table.
        */
        SELECT SUM(total_amt_usd)
        FROM orders;


        /*
           Find the total amount spent on standard_amt_usd and gloss_amt_usd paper for each order in the orders table. This should give a dollar amount for each order in the table.
        */
        SELECT standard_amt_usd + gloss_amt_usd AS total_standard_gloss
        FROM orders;

        /*
            Find the standard_amt_usd per unit of standard_qty paper. Your solution should use both aggregation and a mathematical operator.
        */
        SELECT SUM(standard_amt_usd) / SUM(standard_qty) AS standard_amt_usd_per_unit
        FROM orders;









### MAX & MIN
/*********************************************************
    Notice that here we were simultaneously obtaining the MIN and MAX number of orders of each paper type - in other words, we can obtain both MIN & MAX at the same time.

    Notice that MIN and MAX are aggregators that again ignore NULL values. Check the expert tip below for a cool trick with MAX & MIN.

    Expert Tip
    Functionally, MIN and MAX are similar to COUNT in that they can be used on non-numerical columns. Depending on the column type, MIN will return the lowest number, earliest date, or non-numerical value as early in the alphabet as possible. As you might suspect, MAX does the opposite—it returns the highest number, the latest date, or the non-numerical value closest alphabetically to “Z.”
*********************************************************/
    -- Example
        SELECT MIN(standard_qty) AS standard_min, MIN(gloss_qty) AS gloss_min, MIN(poster_qty) AS poster_min, MAX(standard_qty) AS standard_max, MAX(gloss_qty) AS gloss_max, MAX(poster_qty) AS poster_max
        FROM orders;









### AVERAGE Aggregation Function
/*********************************************************
    Similar to other software AVG returns the mean of the data - that is the sum of all of the values in the column divided by the number of values in a column. This aggregate function again ignores the NULL values in both the numerator and the denominator.

    If you want to count NULLs as zero, you will need to use SUM and COUNT. However, this is probably not a good idea if the NULL values truly just represent unknown values for a cell.

    MEDIAN - Expert Tip
    One quick note that a median might be a more appropriate measure of center for this data, but finding the median happens to be a pretty difficult thing to get using SQL alone — so difficult that finding a median is occasionally asked as an interview question.
*********************************************************/
    -- Example 
        SELECT AVG(standard_qty) AS standard_avg, AVG(gloss_qty) AS gloss_avg, AVG(poster_qty) AS poster_avg
        FROM orders;


        -- When was the earliest order ever placed? You only need to return the date.
        SELECT MAX(occurred_at)
        FROM orders;


        -- Try performing the same query as in question 1 without using an aggregation function.
        SELECT occurred_at
        FROM orders
        ORDER BY occurred_at DESC
        LIMIT 1;


        -- When did the most recent (latest) web_event occur?
        SELECT MAX(occurred_at)
        FROM web_events;


        -- Try to perform the result of the previous query without using an aggregation function.
        SELECT occurred_at
        FROM web_events
        ORDER BY occurred_at DESC
        LIMIT 1;


        -- Find the mean (AVERAGE) amount spent per order on each paper type, as well as the mean amount of each paper type purchased per order. Your final answer should have 6 values - one for each paper type for the average number of sales, as well as the average amount.
        SELECT AVG(standard_qty) AS standard_qty_avg, AVG(poster_qty) AS poster_qty_avg, AVG(gloss_qty) AS gloss_qty_avg, SUM(standard_qty) / COUNT(standard_qty) AS standard_qty_mean, SUM(poster_qty) / COUNT(poster_qty) AS poster_qty_mean, SUM(gloss_qty) / COUNT(gloss_qty) AS gloss_qty_mean
        FROM orders;


        -- Via the video, you might be interested in how to calculate the MEDIAN. Though this is more advanced than what we have covered so far try finding - what is the MEDIAN total_usd spent on all orders?
        SELECT *
        FROM (SELECT total_amt_usd
        FROM orders
        ORDER BY total_amt_usd
        LIMIT 3457) AS Table1
        ORDER BY total_amt_usd DESC
        LIMIT 2;









### GROUP BY
/*********************************************************
    The key takeaways here:

        GROUP BY can be used to aggregate data within subsets of the data. For example, grouping for different accounts, different regions, or different sales representatives.
        Any column in the SELECT statement that is not within an aggregator must be in the GROUP BY clause.
        The GROUP BY always goes in between WHERE and ORDER BY clauses.
        ORDER BY works like SORT in spreadsheet software.

    GROUP BY - Expert Tip
        Before we dive deeper into aggregations using GROUP BY statements, it is worth noting that SQL evaluates the aggregations before the LIMIT clause. If you don’t group by any columns, you’ll get a 1-row result—no problem there. If you group by a column with enough unique values that it exceeds the LIMIT number, the aggregates will be calculated, and then some rows will simply be omitted from the results.

        This is actually a nice way to do things because you know you’re going to get the correct aggregates. If SQL cuts the table down to 100 rows, then performed the aggregations, your results would be substantially different. The above query’s results exceed 100 rows, so it’s a perfect example. In the next concept, use the SQL environment to try removing the LIMIT and running it again to see what changes.
*********************************************************/
    -- Examples
        -- Which account (by name) placed the earliest order? Your solution should have the account name and the date of the order.

        SELECT a.name, o.occurred_at
        FROM orders o
        JOIN accounts a
        ON o.account_id = a.id
        ORDER BY o.occurred_at
        LIMIT 1;



        -- Find the total sales in usd for each account. You should include two columns - the total sales for each company's orders in usd and the company name.
        SELECT a.name, SUM(o.total_amt_usd) AS total_sales
        FROM orders o
        JOIN accounts a
        ON o.account_id = a.id
        GROUP BY a.name;


        -- Via what channel did the most recent (latest) web_event occur, which account was associated with this web_event? Your query should return only three values - the date, channel, and account name.
        SELECT MAX(w.occurred_at) AS order_date, w.channel, a.name
        FROM web_events w
        JOIN accounts a
        ON w.account_id = a.id
        GROUP BY a.name, w.channel
        ORDER BY order_date DESC;

        -- OR
        SELECT w.occurred_at, w.channel, a.name
        FROM web_events w
        JOIN accounts a
        ON w.account_id = a.id 
        ORDER BY w.occurred_at DESC
        LIMIT 1;


        -- Find the total number of times each type of channel from the web_events was used. Your final table should have two columns - the channel and the number of times the channel was used.
        SELECT w.channel AS channels_name, COUNT(w.channel) AS number_of_channels
        FROM web_events w
        GROUP BY channels_name;



        -- Who was the primary contact associated with the earliest web_event?
        SELECT a.primary_poc
        FROM web_events w
        JOIN accounts a
        ON a.id = w.account_id
        ORDER BY w.occurred_at
        LIMIT 1;


        -- What was the smallest order placed by each account in terms of total usd. Provide only two columns - the account name and the total usd. Order from smallest dollar amounts to largest.
        SELECT a.name, MIN(total_amt_usd) smallest_order
        FROM accounts a
        JOIN orders o
        ON a.id = o.account_id
        GROUP BY a.name
        ORDER BY smallest_order;



        -- Find the number of sales reps in each region. Your final table should have two columns - the region and the number of sales_reps. Order from the fewest reps to most reps.
        SELECT r.name, COUNT(s.id) AS reps_counts
        FROM sales_reps s
        JOIN region r
        ON s.region_id = r.id
        GROUP BY r.name
        ORDER BY reps_counts










### GROUP BY Part II
/*********************************************************
    Key takeaways:

        You can GROUP BY multiple columns at once, as we showed here. This is often useful to aggregate across a number of different segments.

        The order of columns listed in the ORDER BY clause does make a difference. You are ordering the columns from left to right.

    GROUP BY - Expert Tips

        The order of column names in your GROUP BY clause doesn’t matter—the results will be the same regardless. If we run the same query and reverse the order in the GROUP BY clause, you can see we get the same results.

        As with ORDER BY, you can substitute numbers for column names in the GROUP BY clause. It’s generally recommended to do this only when you’re grouping many columns, or if something else is causing the text in the GROUP BY clause to be excessively long.

        A reminder here that any column that is not within an aggregation must show up in your GROUP BY statement. If you forget, you will likely get an error. However, in the off chance that your query does work, you might not like the results!
*********************************************************/
-- Examples

    -- For each account, determine the average amount of each type of paper they purchased across their orders. Your result should have four columns - one for the account name and one for the average quantity purchased for each of the paper types for each account.
    SELECT a.name, AVG(o.standard_qty) AS standard_qty_avg, AVG(o.poster_qty) AS poster_qty_avg, AVG(o.gloss_qty) AS gloss_qty_avg
    FROM orders o
    JOIN accounts a
    ON o.account_id = a.id
    GROUP BY a.name;


    -- For each account, determine the average amount spent per order on each paper type. Your result should have four columns - one for the account name and one for the average amount spent on each paper type.
    SELECT a.name, AVG(o.standard_amt_usd) AS standard_amt_avg, AVG(o.poster_amt_usd) AS poster_amt_avg, AVG(o.gloss_amt_usd) AS gloss_amt_avg
    FROM orders o
    JOIN accounts a
    ON o.account_id = a.id
    GROUP BY a.name; 


    -- Determine the number of times a particular channel was used in the web_events table for each sales rep. Your final table should have three columns - the name of the sales rep, the channel, and the number of occurrences. Order your table with the highest number of occurrences first.
    SELECT s.name sales_rep_name, w.channel, COUNT(w.channel) web_channel_count
    FROM web_events w
    JOIN accounts a
    ON w.account_id = a.id
    JOIN sales_reps s
    ON a.sales_rep_id = s.id
    GROUP BY sales_rep_name, w.channel
    ORDER BY web_channel_count DESC


    -- Determine the number of times a particular channel was used in the web_events table for each region. Your final table should have three columns - the region name, the channel, and the number of occurrences. Order your table with the highest number of occurrences first.
    SELECT r.name region_name, w.channel, COUNT(w.channel) number_of_occurences
    FROM web_events w
    JOIN accounts a
    ON w.account_id = a.id
    JOIN sales_reps s
    ON a.sales_rep_id = s.id
    JOIN region r
    ON s.region_id = r.id
    GROUP BY region_name, w.channel
    ORDER BY number_of_occurences DESC









### DISTINCT
/*********************************************************
    DISTINCT is always used in SELECT statements, and it provides the unique rows for all columns written in the SELECT statement. Therefore, you only use DISTINCT once in any particular SELECT statement.

    You could write:

    SELECT DISTINCT column1, column2, column3
    FROM table1;

    which would return the unique (or DISTINCT) rows across all three columns.

    You would not write:

    SELECT DISTINCT column1, DISTINCT column2, DISTINCT column3
    FROM table1;

    You can think of DISTINCT the same way you might think of the statement "unique".

    DISTINCT - Expert Tip
    It’s worth noting that using DISTINCT, particularly in aggregations, can slow your queries down quite a bit.
*********************************************************/
-- Examples

    -- Use DISTINCT to test if there are any accounts associated with more than one region.
        -- The below two queries have the same number of resulting rows (351), so we know that every account is associated with only one region. If each account was associated with more than one region, the first query should have returned more rows than the second query.

            SELECT a.id as "account id", r.id as "region id", 
            a.name as "account name", r.name as "region name"
            FROM accounts a
            JOIN sales_reps s
            ON s.id = a.sales_rep_id
            JOIN region r
            ON r.id = s.region_id;

            -- and

            SELECT DISTINCT id, name
            FROM accounts;



    -- Have any sales reps worked on more than one account?
        -- Actually, all of the sales reps have worked on more than one account. The fewest number of accounts any sales rep works on is 3. There are 50 sales reps, and they all have more than one account. Using DISTINCT in the second query assures that all of the sales reps are accounted for in the first query.

        SELECT s.id, s.name, COUNT(*) num_accounts
        FROM accounts a
        JOIN sales_reps s
        ON s.id = a.sales_rep_id
        GROUP BY s.id, s.name
        ORDER BY num_accounts;

        -- and

        SELECT DISTINCT id, name
        FROM sales_reps;











### HAVING
/*********************************************************
    HAVING - Expert Tip

    HAVING is the “clean” way to filter a query that has been aggregated, but this is also commonly done using a subquery. Essentially, any time you want to perform a WHERE on an element of your query that was created by an aggregate, you need to use HAVING instead.

    It is like WHERE clause but it works on logical statements involving aggregations.

    It used when you need to filter aggregated columns result. And where the aggregated columns are just two or more but not for an entire table data.

    It is placed after WHERE & GROUP BY but before the ORDER BY clauses.
*********************************************************/
    -- Examples
    -- To filter accounts whose total purchase was at least 250,000USD
    SELECT account_id, SUM(total_amt_usd) AS sum_total_amt_usd
    FROM orders
    GROUP BY 1
    HAVING SUM(total_amt_usd) >= 250000



    -- How many of the sales reps have more than 5 accounts that they manage?
    SELECT s.name AS sales_rep_name, COUNT(a.sales_rep_id) account_occurences
    FROM sales_reps s
    JOIN accounts a
    ON s.id = a.sales_rep_id
    GROUP BY s.name
    HAVING COUNT(a.sales_rep_id) > 5; 
        -- There are 34 sales reps who manage more than 5 accounts.


    -- How many accounts have more than 20 orders?
    SELECT a.name, COUNT(o.*) number_of_orders
    FROM accounts a
    JOIN orders o
    ON a.id = o.account_id
    GROUP by a.name
    HAVING COUNT(o.*) > 20;
        -- There are 120 accounts with more than 20 orders


    -- Which account has the most orders?
    SELECT a.name, COUNT(o.*) number_of_orders
    FROM accounts a
    JOIN orders o
    ON a.id = o.account_id
    GROUP by a.name
    ORDER BY 2 DESC
    LIMIT 1;
    -- OR
    SELECT a.name, COUNT(o.*) number_of_orders
    FROM accounts a
    JOIN orders o
    ON a.id = o.account_id
    GROUP by a.name
    HAVING COUNT(o.*) > 20
    ORDER BY 2 DESC
    LIMIT 1;
        -- Leucadia National has the most orders


    -- Which accounts spent more than 30,000 usd total across all orders?
    SELECT a.name, SUM(o.standard_amt_usd + o.gloss_amt_usd + o.poster_amt_usd) AS orders_total_usd
    FROM accounts a
    JOIN orders o
    ON a.id = o.account_id
    GROUP BY a.name
    HAVING SUM(o.standard_amt_usd + o.gloss_amt_usd + o.poster_amt_usd) > 30000
        -- There are 204 accounts that came up


    -- Which accounts spent less than 1,000 usd total across all orders?
    SELECT a.name, SUM(o.standard_amt_usd + o.gloss_amt_usd + o.poster_amt_usd) AS orders_total_usd
    FROM accounts a
    JOIN orders o
    ON a.id = o.account_id
    GROUP BY a.name
    HAVING SUM(o.standard_amt_usd + o.gloss_amt_usd + o.poster_amt_usd) < 1000
        -- There are 3 accounts that came up.


    -- Which account has spent the most with us?
    SELECT a.name, SUM(o.standard_amt_usd + o.gloss_amt_usd + o.poster_amt_usd) AS orders_total_usd
    FROM accounts a
    JOIN orders o
    ON a.id = o.account_id
    GROUP BY a.name
    HAVING SUM(o.standard_amt_usd + o.gloss_amt_usd + o.poster_amt_usd) > 30000
    ORDER BY orders_total_usd DESC
    LIMIT 1;
        -- EOG Resources


    -- Which account has spent the least with us?
    SELECT a.name, SUM(o.standard_amt_usd + o.gloss_amt_usd + o.poster_amt_usd) AS orders_total_usd
    FROM accounts a
    JOIN orders o
    ON a.id = o.account_id
    GROUP BY 1
    HAVING SUM(o.standard_amt_usd + o.gloss_amt_usd + o.poster_amt_usd) < 1000
    ORDER BY 2
    LIMIT 1;
        -- Nike


    -- Which accounts used facebook as a channel to contact customers more than 6 times?
    SELECT a.name, COUNT(w.channel) AS web_channel_count
    FROM accounts a
    JOIN web_events w
    ON a.id = w.account_id
    GROUP BY a.name, w.channel
    HAVING w.channel = 'facebook' AND COUNT(w.channel) > 6;
        -- there 46 accounts which used facebook channel to contact customers more than 6 times.


    -- Which account used facebook most as a channel?
    SELECT a.name, COUNT(w.channel) AS web_channel_count
    FROM accounts a
    JOIN web_events w
    ON a.id = w.account_id
    GROUP BY a.name, w.channel
    HAVING w.channel = 'facebook' AND COUNT(w.channel) > 6
    ORDER BY 2 DESC
    LIMIT 1;  
        -- Gilead Sciences and it used it for 16 times 


    -- Which channel was most frequently used by most accounts?
    SELECT a.name, w.channel, COUNT(w.channel) AS web_channel_count
    FROM accounts a
    JOIN web_events w
    ON a.id = w.account_id
    GROUP BY a.name, w.channel
    ORDER BY 2 DESC; 
        -- direct channel, which was used for 5,298 times.









###
/*********************************************************
    
*********************************************************/








###
/*********************************************************
    
*********************************************************/









###
/*********************************************************
    
*********************************************************/









###
/*********************************************************
    
*********************************************************/









###
/*********************************************************
    
*********************************************************/









###
/*********************************************************
    
*********************************************************/









###
/*********************************************************
    
*********************************************************/









###
/*********************************************************
    
*********************************************************/









###
/*********************************************************
    
*********************************************************/