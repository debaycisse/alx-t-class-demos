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









### Arithmetic Operators
/*********************************************************
    We can perform arithmetic operation, such as the following on a set of columns with
    numeric values and temporarily store the value in a new column, which is known as 
    DERIVED COLUMN using AS operator and display this on our query result.

    Arithmetic operators that are used for this kind of operations are : +, -, /, and *.

    Order of Operations:
    Remember PEMDAS from math class to help remember the order of operations? If not,
    check out this link as a reminder. The same order of operations applies when using
    arithmetic operators in SQL.

    The following two statements have very different end results:
    1. Standard_qty / standard_qty + gloss_qty + poster_qty
    2. standard_qty / (standard_qty + gloss_qty + poster_qty)

    It is likely that you mean to do the calculation as written in statement number 2!
*********************************************************/









### Logical Operators
/*********************************************************
    Logical Operators. Logical Operators include:

    1. LIKE This allows you to perform operations similar to using WHERE and =, but for
    cases when you might not know exactly what you are looking for.

    2. IN This allows you to perform operations similar to using WHERE and =, but for 
    more than one condition.

    3. NOT This is used with IN and LIKE to select all of the rows NOT LIKE or NOT IN a 
    certain condition.

    4. AND & BETWEEN These allow you to combine operations where all combined conditions 
    must be true.

    5. OR This allows you to combine operations where at least one of the combined 
    conditions must be true.
*********************************************************/









### LIKE
/*********************************************************
    The LIKE operator is extremely useful for working with text. You will use LIKE within a WHERE clause. 
    The LIKE operator is frequently used with %. The % tells us that we might want any number of
    characters leading up to a particular set of characters or following a certain set of characters, as we
    saw with the google syntax above. Remember you will need to use single quotes for the text you pass to
    the LIKE operator because these lower and uppercase letters are not the same within the string. Searching 
    for 'T' is not the same as searching for 't'. In other SQL environments (outside the classroom), you can
    use either single or double-quotes.
*********************************************************/
-- Examples

    -- Use the accounts table to find All the companies whose names start with 'C'.
    SELECT name
    FROM accounts
    WHERE name LIKE 'C%';

    -- Use the accounts table to find All companies whose names contain the string 'one' somewhere in the name.
    SELECT name
    FROM accounts
    WHERE name LIKE '%one%';

    -- Use the accounts table to find All companies whose names end with 's'.
    SELECT name
    FROM accounts
    WHERE name LIKE '%s';










### IN
/*********************************************************
    The IN operator is useful for working with both numeric and text columns. This operator allows you to use an =, 
    but for more than one item of that particular column. We can check one, two, or many column values for which we
    want to pull data, but all within the same query. In the upcoming concepts, you will see the OR operator that
    would also allow us to perform these tasks, but the IN operator is a cleaner way to write these queries.
    
    Expert Tip
    In most SQL environments, although not in our Udacity's classroom, you can use single or double quotation marks 
    - and you may NEED to use double quotation marks if you have an apostrophe within the text you are attempting to pull.

    In our Udacity SQL workspaces, note you can include an apostrophe by putting two single quotes together. For example,
    Macy's in our workspace would be 'Macy''s'.

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