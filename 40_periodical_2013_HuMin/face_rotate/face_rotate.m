

stImageFilePath  = 'D:\backupData\JiangFanBackup_Tech\videoImage\master\MATLAB_projects\40_periodical_2013_HuMin\KL_sets\KL\';
stImageSavePath  = 'D:\backupData\JiangFanBackup_Tech\videoImage\master\MATLAB_projects\40_periodical_2013_HuMin\KL_sets\KL_rotate\';
dirImagePathList = dir(strcat(stImageFilePath,'*.tiff'));        %��ȡ��Ŀ¼��ȫ��ͼƬ��·�����ַ�����ʽ��
iImageNum        = length(dirImagePathList);                    %��ȡͼƬ��������
if iImageNum > 0                                                %��������ͼƬ��������ټ�y����������y
    for i = 1 : iImageNum
        iSaveNum      = int2str(i);
        stImagePath   = dirImagePathList(i).name;
        mImageCurrent = imread(strcat(stImageFilePath,stImagePath));
        
        mFaceResult   = imageRotate(mImageCurrent,i,dirImagePathList(i).name);
     
        imwrite(mFaceResult,strcat(stImageSavePath,dirImagePathList(i).name,'.bmp')); 
    end 
end