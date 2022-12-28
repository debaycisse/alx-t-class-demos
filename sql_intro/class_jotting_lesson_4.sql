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
        SELECT a.name, MAX(o.occurred_at) AS order_date
        FROM orders o
        JOIN accounts a
        ON o.account_id = a.id
        GROUP BY a.name
        LIMIT 1;

        SELECT a.name
        FROM orders o
        JOIN accounts a
        ON o.account_id = a.id
        ORDER BY o.occurred_at DESC
        LIMIT 1;



        -- Find the total sales in usd for each account. You should include two columns - the total sales for each company's orders in usd and the company name.



        -- Via what channel did the most recent (latest) web_event occur, which account was associated with this web_event? Your query should return only three values - the date, channel, and account name.



        -- Find the total number of times each type of channel from the web_events was used. Your final table should have two columns - the channel and the number of times the channel was used.



        -- Who was the primary contact associated with the earliest web_event?



        -- What was the smallest order placed by each account in terms of total usd. Provide only two columns - the account name and the total usd. Order from smallest dollar amounts to largest.



        -- Find the number of sales reps in each region. Your final table should have two columns - the region and the number of sales_reps. Order from the fewest reps to most reps.











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









###
/*********************************************************
    
*********************************************************/









###
/*********************************************************
    
*********************************************************/









###
/*********************************************************
    
*********************************************************/