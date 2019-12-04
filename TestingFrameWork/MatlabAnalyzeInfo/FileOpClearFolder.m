function FileOpClearFolder(output_folder)
    if ~exist(output_folder, 'dir')
        mkdir(output_folder);
	else
	    delete([output_folder '*.*']);
    end
end