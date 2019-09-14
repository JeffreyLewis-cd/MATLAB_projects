

stImageFilePath  = 'D:\backupData\JiangFanBackup_Tech\videoImage\master\MATLAB_projects\40_periodical_2013_HuMin\andy\';
stImageSavePath  = 'D:\backupData\JiangFanBackup_Tech\videoImage\master\MATLAB_projects\40_periodical_2013_HuMin\andy_face_only\';
dirImagePathList = dir(strcat(stImageFilePath,'*.jpg'));        %读取该目录下全部图片的路径（字符串格式）
iImageNum        = length(dirImagePathList);                    %获取图片的总数量
if iImageNum > 0                                                %批量读入图片，进行五官检測，再批量检測
    for i = 1 : iImageNum
        iSaveNum      = int2str(i);
        stImagePath   = dirImagePathList(i).name;
        mImageCurrent = imread(strcat(stImageFilePath,stImagePath));
        
        mFaceResult   = imageRotate(mImageCurrent,i);
     
        imwrite(mFaceResult,strcat(stImageSavePath,iSaveNum,'.bmp')); 
    end 
end