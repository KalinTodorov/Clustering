function DM = ComputeDTW_DM(X,window)

[m, ~]=size(X);

DM = zeros(m,m);


for i=1:m-1
    disp(i);
    rowi = X(i,:);    
       %for j=i+1:m   
       parfor j=i+1:m   
            rowj = X(j,:); 
            DM(i,j) = cDTW(rowi,rowj,window);
       end    
end


for i=1:m-1
    %disp(i);
       for j=i+1:m
            DM(j,i) = DM(i,j);
       end    
end



end