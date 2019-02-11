function M = splitFiles(s_path, d_path, dName, counter)
for i=1:counter
    name = dName(i).name;
rImagename = strcat(s_path,name);
image = imread(rImagename);
wImagename = strcat(d_path,name);
imwrite(image,wImagename,'jpg');
end

    