/***************************************************************************************************************************

Besides development, I am passionate about animals, and especially reptiles. This is a project I made to create (basic) reptile care guides, from a database with all of the information needed to do so. T-SQL is not the best medium for such a task but I went through with it anyway to see how it would work out, out of curiosity and for the sake of fun. It was a lot more work than anticipated but an interesting experience never the less. Not everything is flushed out. Currently the foreign keys are not all set up for example, but for a functional prototype I am satisfied with it for now.

***************************************************************************************************************************/

USE Reptiguide

GO

/* Diet table before and after denormalization */

SELECT* FROM [care].[Diet]

SELECT* FROM [guide].[VwDenormalizeDiet];

![image](https://user-images.githubusercontent.com/98998250/221330941-515863f8-40a1-4c1e-af79-660ce40e6792.png)

/* The feeding chart before and after denormalization */

SELECT * FROM [care].[FeedingChartSnake]

WHERE ReptileListId = 1;


SELECT * FROM [guide].[VwDenormalizeFeedingChartSnake]

WHERE ReptileName = 'Boa BCI';

/* The feeding chart note that has been created using [care].[FeedingChartSnake] and the View. */

SELECT Note FROM[care].[FeedingChartNote]

WHERE ReptileListId = 1;

![image](https://user-images.githubusercontent.com/98998250/221331171-5021d8db-cfbc-438f-9126-32ec3966d872.png)

/* Environment values */

SELECT * FROM [guide].[VwDenormalizeEnvironment];

/* Equipment List */

SELECT * FROM [guide].[VwDenormalizeEquipment]

ORDER BY CategoryInfo;

![image](https://user-images.githubusercontent.com/98998250/221331243-a83990b1-78e1-4b38-abb3-64e2069d90f3.png)

/* All three of the created notes, which make up the final guide */

SELECT* FROM [guide].[Note];

![image](https://user-images.githubusercontent.com/98998250/221331507-64819831-74e9-44ab-8b11-23e5655db2f1.png)

/* The final guide for a Boa Constrictor Imperator. */

EXEC guide.GetReptileGuide @SubSpecies = 'BCI';

![image](https://user-images.githubusercontent.com/98998250/221331657-56fd9554-5e78-4448-a720-86a3cdf6359d.png)

/* The final guide for a Russian Tortoise. */

EXEC guide.GetReptileGuide @SubSpecies = 'Russian Tortoise';

![image](https://user-images.githubusercontent.com/98998250/221331635-3aabffe0-7b2a-4c20-94a1-e56f462b4aea.png)
