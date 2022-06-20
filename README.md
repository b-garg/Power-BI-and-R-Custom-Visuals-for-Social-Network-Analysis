# Power BI and R: Custom Visuals for Social Network Analysis

**Bharat Garg**

This repository contains code and sample data to build your custom Social network visual for Power BI using R.

## USAGE

The repo has complete code set required to create a custom Social Network Visual with pre compiled visual provided in "dist" directory and sample data and Power BI files placed in "Files" directory

## SAMPLE DATA USED IN THE PUBLICATION

Sample Data for use with the custom visual can be found in "Files" directory in a file named "Sample File Social Network.csv". It is a randomized data to simulate a Twitter feed.

### DATA STRUCTURE

- From User: It is numerical ID field to uniquely identify each user from which a connection is initiated
- To User: It is numerical ID field to uniquely identify each user to which a connection is initiated
- Number of Connection: A numerical count field to indicate how many times a pair of users interacted in the given time frame
- color: Sentiment Color code in HEX format
- color: Connection type Color code in HEX format	
- User Name: a character field with User Name of User from whom the connection is initiated
- User Name: a character field with User Name of User to whom the connection is initiated	
- Avatar: a character field with link to Profile Image (Avatar) of User from whom the connection is initiated	
- Avatar: a character field with link to Profile Image (Avatar) of User to whom the connection is initiated	
- Max of num_connections: A numeric field which acts as a filter and limits the number of connections plotted in the PowerBI visual

