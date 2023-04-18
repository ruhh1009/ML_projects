-- Question1: Create new schema as ecommerce
Create database ecommerce;

-- Question2: Import .csv file users_data into MySQL
-- Step followed and imported as given in question.
-- Using the created database to solve the further queries.
Use ecommerce;

-- Question3: Run SQL command to see the structure of table
Desc users_data;

-- Question4: Run SQL command to select first 100 rows of the database
SELECT 
    *
FROM
    users_data
LIMIT 100;

-- Question5: How many distinct values exist in table for field country and language
SELECT 
    COUNT(DISTINCT country), COUNT(DISTINCT language)
FROM
    users_data;

-- Question6: Check whether male users are having maximum followers or female users.
SELECT 
    gender, COUNT(socialNBfollowers)
FROM
    users_data
GROUP BY gender;

-- Question7: Calculate the total users those
      -- a) Uses Profile Picture in their Profile
	SELECT 
    COUNT(hasProfilePicture)
FROM
    users_data
WHERE
    hasProfilePicture = 'True';

      -- b) Uses Application for Ecommerce platform
SELECT 
    COUNT(type)
FROM
    users_data
WHERE
    hasAnyApp = 'True'
        OR hasAndroidApp = 'True'
        OR hasIosApp = 'True';
      
      -- c) Uses Android app
SELECT 
    COUNT(hasAndroidApp)
FROM
    users_data
WHERE
    hasAndroidApp = 'True';
      
      -- d) Uses ios app
SELECT 
    COUNT(hasIosApp)
FROM
    users_data
WHERE
    hasIosApp = 'True';

/* Question8: Calculate the total number of buyers for each country and sort the result in descending order
of total number of buyers. (Hint: consider only those users having at least 1 product bought.) */
SELECT 
    COUNT(productsBought)
FROM
    users_data
Where productsBought>=1
GROUP BY country
ORDER BY COUNT(productsBought) DESC;

/* Question9: Calculate the total number of sellers for each country and sort the result in ascending order
of total number of sellers. (Hint: consider only those users having at least 1 product sold.) */
SELECT 
    count(productsSold)
FROM
    users_data
where productsSold>=1
GROUP BY country
ORDER BY count(productsSold);

-- Question10: Display name of top 10 countries having maximum products pass rate.
SELECT 
    country, max(productsPassRate)
FROM
    users_data
Group by country
ORDER BY max(productsPassRate) DESC
LIMIT 10;

-- Question11: Calculate the number of users on an ecommerce platform for different language choices.
SELECT 
    language, COUNT(language)
FROM
    users_data
GROUP BY language;

/* Question12:Check the choice of female users about putting the product in a wishlist or to like socially on
an ecommerce platform. (Hint: use UNION to answer this question.) */
SELECT 'productsWished', 
    sum(productsWished)
FROM
    users_data
WHERE
    gender = 'F' 
UNION SELECT 'socialProductsLiked',
    sum(socialProductsLiked)
FROM
    users_data
WHERE
    gender = 'F';

/* Question13:Check the choice of male users about being seller or buyer. (Hint: use UNION to solve this 
question.)*/
Select 'choice', 'count'
union
Select 'Seller', count(productsSold) from users_data Where gender='M' and productssold>=1
union
Select 'buyer', count(productsBought) from users_data Where gender='M' and productsBought>=1;

-- Question14: Which country is having maximum number of buyers?
SELECT 
    country
FROM
    users_data
ORDER BY productsBought DESC
LIMIT 1;



-- Question15: List the name of 10 countries having zero number of sellers.
SELECT 
    country
FROM
    users_data
WHERE
    productsSold = 0
Group by country
LIMIT 10;


-- Question16: Display record of top 110 users who have used ecommerce platform recently.
SELECT 
    *
FROM
    users_data
ORDER BY daysSinceLastLogin
LIMIT 110;



-- Question17: Calculate the number of female users those who have not logged in since last 100 days.
SELECT 
    COUNT(type)
FROM
    users_data
WHERE
    gender = 'F'
        AND daysSinceLastLogin >= 100;



-- Question18:Display the number of female users of each country at ecommerce platform.
SELECT 
    country, COUNT(type)
FROM
    users_data
WHERE
    gender = 'F'
GROUP BY country;


-- Question19: Display the number of male users of each country at ecommerce platform.
SELECT 
    country, COUNT(type)
FROM
    users_data
WHERE
    gender = 'M'
GROUP BY country;


/* Question20: Calculate the average number of products sold and bought on ecommerce platform by male users
 for each country. */
SELECT 
    AVG(productsSold), AVG(productsBought)
FROM
    users_data
WHERE
    gender = 'M'
GROUP BY country;



      
	
