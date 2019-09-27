% 输入参数说明：samples为映射半径，mappingtype为LBP映射格式
% 输出参数说明：mapping为影射模板
% 函数作用：获得影射模板

function mapping = getmapping(samples,mappingtype)


  
% mapping = 0:2^samples-1;
mapping = 0:2^8-1;
newMax  = 0; %number of patterns in the resulting LBP code
index   = 0;

if strcmp(mappingtype,'u2') %Uniform 2
  newMax = samples*(samples-1) + 3; 
  for  i = 0:2^8-1
       samples=int8(samples);

     j = bitset(bitand(bitshift(i,1),2^8-1),1,bitget(i,samples)); % i 右移1位，然后把第1位设置为0或1(i小于128为0，反之为1，设sample为8时）


    numt = sum(bitget(bitxor(i,j),1:samples)); 
    
    if numt <= 2
      mapping(i+1) = index;
      index = index + 1;
    else
      mapping(i+1) = newMax - 1;
    end
  end
end

if strcmp(mappingtype,'ri') %旋转不变量
  tmpMap = zeros(2^samples) - 1;
  for i = 0:2^samples-1
    rm = i;
    r  = i;
    for j = 1:samples-1
      r = bitset(bitshift(r,1,samples),1,bitget(r,samples)); %左旋转
                                                             
      if r < rm
        rm = r;
      end
    end
    if tmpMap(rm+1) < 0
      tmpMap(rm+1) = newMax;
      newMax = newMax + 1;
    end
    mapping(i+1) = tmpMap(rm+1);
  end
end

if strcmp(mappingtype,'riu2') %均匀旋转不变量
  newMax = samples + 2;
  for i = 0:2^samples - 1
    j = bitset(bitshift(i,1,samples),1,bitget(i,samples)); %左旋转
    numt = sum(bitget(bitxor(i,j),1:samples));
    if numt <= 2
      mapping(i+1) = sum(bitget(i,1:samples));
    else
      mapping(i+1) = samples+1;
    end
  end
end
