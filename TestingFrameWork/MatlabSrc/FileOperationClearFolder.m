function FileOperationClearFolder(output_folder)
    delete([output_folder '*.*']);
    if ~exist(output_folder, 'dir')
        mkdir(output_folder);
    end
end