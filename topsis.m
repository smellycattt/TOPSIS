function [ cc ] = topsis (decisionMakingMatrix,lambdaWeight,criteriaSign )
%Technique for Order of Preference by Similarity to Ideal Solution
%-This function implements TOPSIS method with Information entropy
% weighting Method
% criteriaSign is a vector specifying whether an criterion has to be maximized
% or minimized 
% Before executing the function define "decisionMakingMatrix"
% variable based on size of decision making matrix that you have.

sumDmm=sum(decisionMakingMatrix());
sumDmmMatrix=repmat(sumDmm,size(decisionMakingMatrix,1),1);
pij=decisionMakingMatrix./sumDmmMatrix; %Normalizing Decision Making Matrix  

lnm= -1 / log(size(decisionMakingMatrix,1)); 
lnNormDmm = log(pij);

%Step 3: Calculate weight of criteria by entropy technique
E=lnm .* sum(pij .* lnNormDmm);
dj=ones(1,size(E,2))-E ;%Calculating the information Entropy of Criterion j 
weightEntropy=dj ./sum(dj) ;% computing Entropy weight
wt=lambdaWeight .*weightEntropy ./sum(lambdaWeight .*weightEntropy); 
sqrtxij=sqrt(sum(decisionMakingMatrix().^2)) ;

%Step 4-Construct a normalized decision matrix:
N =decisionMakingMatrix./repmat(sqrtxij,[size(decisionMakingMatrix,1) 1]);										    
Wj=eye(size(wt,2)) .* repmat(wt.*criteriaSign,size(wt,2),1);

%Step 5: Construct the weighted normalized decision matrix by building the diagonal matrix
V=N*Wj;	

%Step 6: Compute the positive ideal solution (PIS) A+ and the negative ideal solution (NIS) A? of the alternatives:
Apositive=max(V); 
Anegetive= min(V);
ApositivMtrix=repmat(Apositive,size(V,1),1); 
AnegetiveMtrix=repmat(Anegetive,size(V,1),1);
s1=(V-ApositivMtrix).^2;
s2=(V-AnegetiveMtrix).^2;
for (j=1:1:size(s1,1))
sumAPositive(j)=sum(s1(j,:));
end
for (j=1:1:size(s2,1))
sumANegetive(j)=sum(s2(j,:));
end

%Step 7: Distance of each alternative from PIS and NIS
dPositive=sqrt(sumAPositive); 
dNegetive=sqrt(sumANegetive);
sumD=dNegetive+dPositive;

%Step 8: Closeness coefficient of each alternative:
cc=dNegetive./sumD;   

xlswrite( 'SupplierSelection.xlsx',cc,'OutputData CC' ,'B2:o2') 
xlswrite( 'SupplierSelection.xlsx',N,'OutputForN' ,'B4:I17') 
xlswrite( 'SupplierSelection.xlsx',V,'OutputForV' ,'B4:I17') 
xlswrite( 'SupplierSelection.xlsx',N,'TOPSIS OUTPUT Variables' ,'B4:I17') 
xlswrite( 'SupplierSelection.xlsx',V,'TOPSIS OUTPUT Variables' ,'B19:I32')
xlswrite( 'SupplierSelection.xlsx',Apositive,'TOPSIS OUTPUT Variables' ,'B36:I36')
xlswrite( 'SupplierSelection.xlsx',Anegetive,'TOPSIS OUTPUT Variables' ,'B37:I37')
xlswrite( 'SupplierSelection.xlsx',dPositive,'TOPSIS OUTPUT Variables' ,'B45:o45')
xlswrite( 'SupplierSelection.xlsx',dNegetive,'TOPSIS OUTPUT Variables' ,'B46:o46')
xlswrite( 'SupplierSelection.xlsx',cc,'TOPSIS OUTPUT Variables' ,'B47:o47')
xlswrite( 'SupplierSelection.xlsx',sumDmmMatrix,'Entropy Output' ,'B4:I17')
xlswrite( 'SupplierSelection.xlsx',pij,'Entropy Output' ,'B20:I33')
xlswrite( 'SupplierSelection.xlsx',wt,'Entropy Output' ,'B35:I48')
end

