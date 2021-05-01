function ClusteringHierarchicalComplete(DataSetStartIndex, DataSetEndIndex, DistanceIndex)  
    
    Distances = [cellstr('ED'), 'NCCc', 'cDTW5'];
    
    % Datasets into consideration
    Datasets1 = [cellstr('ChlorineConcentration'), 'CinC_ECG_torso',  'DiatomSizeReduction', 'ECGFiveDays', 'FacesUCR', ... 
        'Haptics', 'InlineSkate', 'ItalyPowerDemand', 'MALLAT', 'MedicalImages', 'Motes', 'SonyAIBORobotSurface', ...
        'SonyAIBORobotSurfaceII', 'Symbols', 'TwoLeadECG', 'WordsSynonyms', 'Cricket_X', 'Cricket_Y', 'Cricket_Z',...
        'uWaveGestureLibrary_X', 'uWaveGestureLibrary_Y', 'uWaveGestureLibrary_Z', '50words', 'Adiac', 'Beef',    ...
        'CBF', 'Coffee', 'ECG200', 'FaceAll', 'FaceFour', 'Fish', 'Gun_Point', 'Lighting2', 'Lighting7', 'Plane', ...
        'OliveOil', 'OSULeaf', 'SwedishLeaf', 'Synthetic_control', 'Trace', 'Two_Patterns', 'Wafer', 'Yoga', 'Car'...
        'StarLightCurves', 'Insect','NonInvasiveFatalECG_Thorax1','NonInvasiveFatalECG_Thorax2'];
    Datasets = [cellstr('Adiac'),'Beef'];
    % Sort Datasets
    [Datasets, DSOrder] = sort(Datasets);    

    rand_idxs = zeros(length(Datasets),1);
	
    for i = 1:length(Datasets)

            if (i>=DataSetStartIndex && i<=DataSetEndIndex)

                    disp(['Dataset being processed: ', char(Datasets(i))]);
                    DS = LoadUCRdataset(char(Datasets(i)));
                    DM = dlmread( strcat( 'C:/Users/Kalin/Desktop/kShapeReproducibility/Code/DATASETS/',char(Datasets(i)),'/', char(Datasets(i)), '_', char(Distances(DistanceIndex)) ,'.distmatrix'));
                        
                    labels = HierarchicalClustering_Complete(DM, length(DS.ClassNames));
                       
                    rand_idxs(i) = rand_idxs(i) + RandIndex(labels, DS.DataClassLabels);
           
            end
            
            dlmwrite( strcat( 'RESULTS_ClusteringHierarchicalComplete', '_', char(Distances(DistanceIndex)), '_', num2str(DataSetStartIndex), '_', num2str(DataSetEndIndex) ,'.results'), rand_idxs, 'delimiter', '\t');
   
    end
    
end