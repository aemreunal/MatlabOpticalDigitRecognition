MatlabOpticalDigitRecognition
=============================

An optical digit recognition application, written in MATLAB.

Running The Application
=======================

To run the ODR system, run 'ODR.m'. You will be presented with 3 choices:

    1 - Load a pre-created network

Use this to load a network file you created before. The file you want to load must have the name
'networks.m'.

    2 - Create a network

Use this to create a new ODR network of specified number of hidden nodes and number of training
iterations. This created network will be saved with format
'network-\<day\>-\<month\>-\<year\>-\<hour\>-\<minute\>-\<numHiddeUnits-\<numIterations\>.m', with time values
taken from current time.

    3 - Exit the program

Exit the program without doing anything.

Performing Cross-Validation
===========================

To assess which network provides the best recognition, cross validation script tests each network
against the generated test data and tells which network provides the least amount of errors. To
do cross validation, run 'CrossValidation.m'. The networks to be tested should have format
'network-\<numHiddeUnits\>-\<numIterations\>.m' and each network must be added to the list in the
script, with each element having string format as '\<numHiddeUnits\>-\<numIterations\>'.

Creating Test Data
==================

Test data can be created by running 'CreateTestCases.m' script. You specify the digit to create
test cases for and the number of test cases you want to create. The script creates 'mid1test'
folder inside the current folder and puts test cases inside. The test case files have the same
structure as the provided training data files and has name format as 'test\<digit\>.txt'.

MATLAB Version
==============

MATLAB R2013A UNIX (v8.1.0.604)

