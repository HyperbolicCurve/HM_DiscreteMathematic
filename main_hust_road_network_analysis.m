clc;clear gloabl;
%define_constants;
analysis_type=0;

if analysis_type==0
    if analysis_type==0
    imagePath = '4.tif'; 

    adjacencyMatrix = getAdjacencyMatrix(imagePath);
    
    stack = four_color(adjacencyMatrix);
    
     imageData = imread(imagePath);
    grayImage = rgb2gray(imageData);

   
    threshold = graythresh(grayImage);
    binaryImage = imbinarize(grayImage, threshold);

    
    labeledImage = bwlabel(binaryImage,4);
    
    for i=1:size(adjacencyMatrix,1)
        for j=1:size(adjacencyMatrix,1)
            if adjacencyMatrix(i,j)==1 && stack(i)==stack(j)
                fprintf("Error!");
            end
        end
    end
    
    
  colorMap = [
    0.9290 0.6940 0.1250;  
    0.8500 0.3250 0.0980;  
    0.4940 0.1840 0.5560;  
    0.4660 0.6740 0.1880   
];
    stackRGB = colorMap(stack, :);

   
    coloredImage = label2rgb(labeledImage, stackRGB, 'k', 'noshuffle');

    
    imshow(coloredImage);
    end
end
