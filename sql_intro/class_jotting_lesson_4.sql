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









###
/*********************************************************
    
*********************************************************/









###
/*********************************************************
    
*********************************************************/









###
/*********************************************************
    
*********************************************************/