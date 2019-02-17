% 19/05/2016
% Curtin University, School of Information Systems
% Author: Dr. Omid Ameri Sianaki
% This Matlab code file is provided for TOPSIS implimentation function code  
% Excel Workbook name: SupplierSelection.xlsx
% Worksheet name: InputData
% Decision making matrix range: C4:j17
clear
clc
filename = 'supplierSelection.xlsx';
sheetread = 'InputData';
decisionMakingMatrix_range = 'c4:j17';
criteriaSign_range= 'c18:j18';
lambdaWeight_w1='c19:j19'; 
decisionMakingMatrix = xlsread(filename,sheetread, decisionMakingMatrix_range);
criteriaSign = xlsread(filename, sheetread, criteriaSign_range);
lambdaWeight = xlsread(filename, sheetread,lambdaWeight_w1);
topsis(decisionMakingMatrix, criteriaSign, lambdaWeight)

 








