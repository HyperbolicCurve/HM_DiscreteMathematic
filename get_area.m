function [ whiteRegions ] = get_area( imagePath )
    %UNTITLED 此处显示有关此函数的摘要
    %   此处显示详细说明
    imageData = imread(imagePath);
    grayImage = rgb2gray(imageData);

    % 对灰度图像进行阈值分割
    threshold = graythresh(grayImage);
    binaryImage = imbinarize(grayImage, threshold);

    % 对二值图像进行连通区域分析
    labeledImage = bwlabel(binaryImage,4);
    regionProps = regionprops(labeledImage, 'Area', 'PixelIdxList');

    % 获取面积大于阈值的白色区域
    areaThreshold = 0;  % 面积阈值，根据实际情况进行调整
    whiteRegions = [];
    for i = 1 : numel(regionProps)
        if regionProps(i).Area > areaThreshold
        whiteRegions{end+1} = regionProps(i).PixelIdxList;
        end

    end
end


