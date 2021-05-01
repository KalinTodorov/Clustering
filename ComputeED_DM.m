function DM = ComputeED_DM(X)
[m, ~]=size(X);

DM = zeros(m,m);

for i=1:m-1
    %disp(i);
    rowi = X(i,:);    
       %parfor j=i+1:m
       for j=i+1:m
            rowj = X(j,:); 
            DM(i,j) = ED(rowi,rowj);
       end    
end


for i=1:m-1
    %disp(i);
       for j=i+1:m
            DM(j,i) = DM(i,j);
       end    
end



end
