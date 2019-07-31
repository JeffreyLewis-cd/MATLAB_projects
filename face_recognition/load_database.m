function output_value=load_database();

persistent loaded;
persistent numeric_Image;

if(isempty(loaded))
    all_Images=zeros(