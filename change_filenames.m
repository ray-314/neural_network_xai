function change_filenames(dir_name, old_str, new_str)


filenames = dir(dir_name);

for ii = 3 : length(filenames)
    if filenames(ii).isdir
        change_filenames([dir_name, '\', filenames(ii).name], old_str, new_str);
        newStr = strrep(filenames(ii).name, old_str, new_str);
        if contains(filenames(ii).name, old_str)
            [dir_name, '\', filenames(ii).name]
            [dir_name, '\', newStr]
            movefile([dir_name, '\', filenames(ii).name], ...
                [dir_name, '\', newStr])
        end
    else
        if contains(filenames(ii).name, old_str)
            newStr = strrep(filenames(ii).name, old_str, new_str);
            movefile([dir_name, '\', filenames(ii).name], ...
                [dir_name, '\', newStr])
        end
    end
end

