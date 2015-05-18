function is = pcdIsGridded(file)

[width, height] = pcdGridSize(file);

if height == 1
    is = 0;
else
    is = 1;
end
