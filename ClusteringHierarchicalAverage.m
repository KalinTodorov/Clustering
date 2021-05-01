function ClusteringHierarchicalAverage(DataSetStartIndex, DataSetEndIndex, DistanceIndex)  
    
    Distances = [cellstr('ED'), 'NCCc', 'cDTW5'];
    
    %load data
    Datasets = [cellstr('Adiac'),'Beef'];
    
    % Sort Datasets
    [Datasets, DSOrder] = sort(Datasets);    
    
    rand_idxs = zeros(length(Datasets),1);
	
    for i = 1:length(Datasets)

            if (i>=DataSetStartIndex && i<=DataSetEndIndex)

                    disp(['Dataset being processed: ', char(Datasets(i))]);
                    DS = LoadUCRdataset(char(Datasets(i)));
                    DM = dlmread( strcat( 'DATASETS/',char(Datasets(i)),'/', char(Datasets(i)), '_', char(Distances(DistanceIndex)) ,'.distmatrix'));
                        
                    labels = HierarchicalClustering_Average(DM, length(DS.ClassNames));
                       
                    rand_idxs(i) = rand_idxs(i) + RandIndex(labels, DS.DataClassLabels);
           
            end
            
            dlmwrite( strcat( 'RESULTS_ClusteringHierarchicalAverage', '_', char(Distances(DistanceIndex)), '_', num2str(DataSetStartIndex), '_', num2str(DataSetEndIndex) ,'.results'), rand_idxs, 'delimiter', '\t');
   
    end
    
end