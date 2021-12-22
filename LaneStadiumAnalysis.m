% (ENGE 1215) Fall 2021
% The purpose of this code is to represent one of the decisions for our
% problem.

clear
clc

% Sets counters for amount of people who got a student section seat and
% amount of people who broke in
StudentSectionCounter = 0;
BreakInCounter = 0;

% Asks the user how many games they would like to record data for and how
% large the sample size is 
GameSize = input('How many games would you like to record data for?\n');
SampleSize = input('How many people will be in your sample?\n');

% Creates arrays that will be used later to write to a csv
GameArray = 1:1:GameSize;
StudentSectionArray = 1:1:GameSize;
BreakInArray = 1:1:GameSize;

% A nested for loop that goes through the sample of people for each game
% that the user specified and asks questions to find the proportion of
% students who got a seat in the student section and the proportion of
% students who broke in
for i = 1:GameSize
    for j = 1:SampleSize
        StudentSectionData = input('Were you able to get a seat in the student section? (enter 1 for yes and 2 for no)\n');
        BreakInData = input('Did you enter the game without a ticket? (enter 1 for yes and 2 for no)\n');
    
        if StudentSectionData == 1
            StudentSectionCounter = StudentSectionCounter + 1;
        end
    
        if BreakInData == 1
            BreakInCounter = BreakInCounter + 1;
        end
        
        if j == SampleSize
            disp('End of one game.');
            StudentSectionProportion = StudentSectionCounter / SampleSize;
            BreakInProportion = BreakInCounter / SampleSize;
            StudentSectionArray(i) = StudentSectionProportion;
            BreakInArray(i) = BreakInProportion;
            StudentSectionCounter = 0;
            BreakInCounter = 0;
        end
    end
end

% Adds the proportions with that were calculated in the for loop with their
% corresponding game to a matrix
StudentSectionOutput = [GameArray' StudentSectionArray'];
BreakInOutput = [GameArray' BreakInArray'];

% Writes the output data that was calculated to a csv file
writematrix(StudentSectionOutput, 'StudentSectionOutput.csv');
writematrix(BreakInOutput, 'BreakInOutput.csv');

% Reads in the data for both plots
Data = readmatrix('StudentSectionOutput.csv');
Data2 = readmatrix('BreakInOutput.csv');

% Creates a scatter plot that includes data from both sets
plot(Data(:,1), Data(:,2), 'o', Data2(:,1), Data2(:,2), '+');
hold on

% Creates a line of best fit for both sets of data
Coeff = polyfit(Data(:,1), Data(:,2), 1);
Coeff2 = polyfit(Data2(:,1), Data2(:,2), 1);

FakeX = linspace(1, GameSize, 10);
FakeY = Coeff(1) * FakeX + Coeff(2);

FakeX2 = linspace(1, GameSize, 10);
FakeY2 = Coeff2(1) * FakeX + Coeff2(2);

% Plots the line of best fit for both sets of data
plot(FakeX, FakeY, 'blue');
plot(FakeX2, FakeY2, 'red');

hold off

% A decisison structure that decides whether or not overcrowding is a
% problem based on the data that was collected
StudentSectionSlope = Coeff(1);
BreakInSlope = Coeff2(1);

if StudentSectionSlope < 0 && BreakInSlope > 0
    disp('Based on the relationship between the amount of students who get a student section seat and the amount of students breaking in, overcrowding seems to be a problem at Lane Stadium.');
else
    disp('Based on the relationship between the amount of students who get a student section seat and the amount of students breaking in, overcrowding does not seem to be a problem at Lane Stadium.');
end
