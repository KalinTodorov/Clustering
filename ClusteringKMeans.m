function ClusteringKMeans(DataSetStartIndex, DataSetEndIndex)  
        
    Datasets = [cellstr('Adiac'),'Beef']; 
    
    
    % Sort Datasets
    [Datasets, DSOrder] = sort(Datasets);    

    rand_idxs = zeros(length(Datasets),1);
    timing_idxs = zeros(length(Datasets),1);
    
    results = zeros(length(Datasets),2);
    
    for i = 1:length(Datasets)

            if (i>=DataSetStartIndex && i<=DataSetEndIndex)

                    disp(['Dataset being processed: ', char(Datasets(i))]);
                    DS = LoadUCRdataset(char(Datasets(i)));

                    for rep = 1 : 10

                        tic;
                        [labels centroids] = kMeans(DS.Data, length(DS.ClassNames));
                        timing_idxs(i) = timing_idxs(i) + toc;
                        rand_idxs(i) = rand_idxs(i) + RandIndex(labels, DS.DataClassLabels);
                    end
                    results(i,1) = rand_idxs(i) / 10;
                    results(i,2) = timing_idxs(i) / 10;
                    
           
            end
            
            dlmwrite( strcat( 'RESULTS_ClusteringKMeans_', num2str(DataSetStartIndex), '_', num2str(DataSetEndIndex) ,'.results'), results, 'delimiter', '\t');
   
    end

end
