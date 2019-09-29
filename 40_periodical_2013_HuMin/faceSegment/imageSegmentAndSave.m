clear;
stImageFilePath  = 'C:\Users\jiang\Desktop\temp\jiangfan_face\AN\';
stImageSavePath  = 'C:\Users\jiang\Desktop\temp\jiangfan_face\AN_face_only\';
dirImagePathList = dir(strcat(stImageFilePath,'*.png'));        %读取该目录下全部图片的路径（字符串格式）
iImageNum        = length(dirImagePathList);                    %获取图片的总数量
if iImageNum > 0                                                %批量读入图片，进行五官检測，再批量检測
    for i = 1 : iImageNum
        iSaveNum      = int2str(i);
        stImagePath   = dirImagePathList(i).name;
        mImageCurrent = imread(strcat(stImageFilePath,stImagePath));
        
        mFaceResult   = face_segment(mImageCurrent);
        mFaceResult = histeq(imresize(mFaceResult,[256,256])); %图像尺寸缩放，并且直方图均衡化
        imwrite(mFaceResult,strcat(stImageSavePath,dirImagePathList(i).name)); 
    end 
end