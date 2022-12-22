### Arithmetic Operators
/*********************************************************
    
*********************************************************/








### WHERE
/*********************************************************
    Using the WHERE statement, we can display subsets of tables based on conditions 
    that must be met. You can also think of the WHERE command as filtering the data.

    Common symbols used in WHERE statements include:
    1.  > (greater than)
    2.  < (less than)
    3.  >= (greater than or equal to)
    4.  <= (less than or equal to)
    5.  = (equal to)
    6.  != (not equal to)
*********************************************************/
-- Examples --

/*********************************************************
    Write a query that:

    Pulls the first 5 rows and all columns from the orders table that have a dollar amount 
    of gloss_amt_usd greater than or equal to 1000.

*********************************************************/
SELECT *
FROM orders
WHERE gloss_amt_usd >= 1000
LIMIT 5;
    

/*********************************************************
    Write a query that:

    Pulls the first 10 rows and all columns from the orders table that have a total_amt_usd less
    than 500.
*********************************************************/
SELECT *
FROM orders
WHERE total_amt_usd < 500
LIMIT 10;


### WHERE with Non-Numeric Data
/*********************************************************
    The WHERE statement can also be used with non-numeric data. We can use the = and != operators here. 
    You need to be sure to use single quotes (just be careful if you have quotes in the original text) 
    with the text data, not double quotes.

    Commonly when we are using WHERE with non-numeric data fields, we use the LIKE, NOT, or IN operators. 
    We will see those before the end of this lesson!
*********************************************************/




    




### LIMIT
/*********************************************************
    Limit reduces number of lines of the output to just a given number of lines.
    
    The ORDER BY statement always comes in a query after the SELECT 
    and FROM statements, but before the LIMIT statement. If you are
    using the LIMIT statement, it will always appear last.
    
    Remember DESC can be added after the column in your ORDER BY 
    statement to sort in descending order, as the default is to sort
    in ascending order.
*********************************************************/
SELECT occurred_at, account_id, channel
FROM web_events
LIMIT 15;

-- Examples--
/*********************************************************
    Write a query to return the 10 earliest orders in the orders table.
    Include the id, occurred_at, and total_amt_usd
*********************************************************/
SELECT id, occurred_at, total_amt_usd
FROM orders
ORDER BY occurred_at
LIMIT 10;

/********************************************************
    Write a query to return the top 5 orders in terms of the largest
    total_amt_usd. Include the id, account_id, and total_amt_usd.
*********************************************************/
SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC
LIMIT 5;

/*********************************************************
    Write a query to return the lowest 20 orders in terms of the smallest
    total_amt_usd. Include the id, account_id, and total_amt_usd.
*********************************************************/
SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd
LIMIT 20;

/********************************************************
    Write a query that displays the order ID, account ID, and total dollar
    amount for all the orders, sorted first by the account ID (in ascending
    order), and then by the total dollar amount (in descending order).
********************************************************/
SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY account_id, total_amt_usd DESC;

/********************************************************
    Now write a query that again displays order ID, account ID, and total
    dollar amount for each order, but this time sorted first by total
    dollar amount (in descending order), and then by account ID (in 
    ascending order).
********************************************************/
SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC, account_id;

/********************************************************
    Compare the results of these two queries above. How are the results
    different when you switch the column you sort on first?

    In query #1, all of the orders for each account ID are grouped together,
    and then within each of those groupings, the orders appear from the 
    greatest order amount to the least. 
    In query #2, since you sorted by the total dollar amount first, the orders
    appear from greatest to least regardless of which account ID they were from. 
    Then they are sorted by account ID next. (The secondary sorting by account 
    ID is difficult to see here since only if there were two orders with equal
    total dollar amounts would there need to be any sorting by account ID.) 
********************************************************/
