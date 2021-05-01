function DM = ComputeSBD_DM(X)

[m, ~]=size(X);

DM = zeros(m,m);

for i=1:m-1

    rowi = X(i,:);    

       parfor j=i+1:m
            rowj = X(j,:); 
            DM(i,j) = 1-max( NCCc(rowi,rowj) );
       end    
end
for i=1:m-1
       for j=i+1:m
            DM(j,i) = DM(i,j);
       end    
end



end