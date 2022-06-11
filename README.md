#Power BI and R: Custom Visuals for Social Network Analysis

In the repository you will find the following files:
1. Package to create cusomt R visual for PowerBI
2. Compiled Visual - placed in the dist directory
3. Sample Power BI file - in Files Directory
4. Sample Data - in Files Directory

The sample data contains the following data:
1. From User - It is numerical ID field to uniquely identify each user from which a connection is initiated
2. To User - It is numerical ID field to uniquely identify each user to which a connection is initiated
3. Number of Connection	- A numerical count field to indicate how many times a pair of users interacted in the given time frame
4. color - Sentiment Color code in HEX format
5. color - Connection type Color code in HEX format	
6. User Name - a character field with User Name of User from whom the connection is initiated
7. User Name - a character field with User Name of User to whom the connection is initiated	
8. Avatar - a character field with link to Profile Image (Avatar) of User from whom the connection is initiated	
9. Avatar - a character field with link to Profile Image (Avatar) of User to whom the connection is initiated	
10. Max of num_connections - A numeric field which acts as a filter and limits the number of connections plotted in the PowerBI visual
