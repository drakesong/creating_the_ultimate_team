# Creating the Ultimate Team

#### CS 347 Machine Learning Final Project
#### Drake Song, Austin Lee
#### Fall Semester 2017, Professor Kathryn Leonard


###### Project description:
Using Machine Learning techniques learned in class over the semester, create the ultimate soccer team using data from over 25k matches from 2008 to 2016 and over 10k players.

###### How to run:
1. Required files:
    * cleanFIFA18.m
    * cleanMatch.m
    * cleanPlayerAttrib.m
    * cleanTeamAttrib.m
    * data.mat
    * determineID.m
    * FIFA18_data.mat
    * FIFA18_player.mat
    * finalproject.m
    * Match_player_attrib.mat
    * player_test.mat
    * predictFeatures.m
    * predictMatch.m
    * predictUltimate.m
    * prepareMatchData.m
    * preparePlayerData.m
    * prepareRegressionData.m
    * testUltimate.m
    * toty.mat
    * ultimateTeam_playerAttrib.mat
    <br><br>
2. Using MatLab, run *finalproject.m*

###### What to expect:
1. There will be comments displayed on the Command Window as the code runs
2. Some parts of the code and functions are commented out due to the long runtime. The output of the commented out code is loaded in instead to save time. Uncommenting out the blocks of code and commenting out the load function that follows right after will still work.
3. The following events will occur in order:
    * Create a logistic regression model that will predict the outcome of a match
    * Create a SVM model that will predict if a player will be on the UEFA Team of the Year
    * Using the most recent player data, determine the next Team of the Year aka the Ultimate Team
    * Calculate the team attributes of the Ultimate Team needed for predictMatch model created above
    * Test the Ultimate Team using the logistic regression model to see how well the team does against other teams.

###### Data Sources:
1. Match and player data
    * https://www.kaggle.com/hugomathien/soccer
      * ODbL v1.0
      * https://opendatacommons.org/licenses/odbl/1.0/
2. FIFA18 data
    * https://www.kaggle.com/thec03u5/fifa-18-demo-player-dataset
      * CC BY-NC-SA 4.0
      * https://creativecommons.org/licenses/by-nc-sa/4.0/
3. UEFA Team of the Year data
    * http://toty.uefa.com/en/history

