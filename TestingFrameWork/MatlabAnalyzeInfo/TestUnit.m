function TestUnit
    clear;

% Turn on/off comment to switch between different testing cases
%    select = '1710-001-the-guy';
%     select = '1710-001-the-guy';
%     select = '1709-001-palm-open';
%    select = '1709-002-two-faces';
%    select = '1610-001-mannique';
%     select = '1709-003-holding-toy';
%     select = '1709-004-holding-doll';
%     select = '1709-005-v-gesture';
%     select = '1709-006-fist-far';
%     select = '1709-007-fist-near';
%    select = '1709-008-outside-two-faces';
%    select = '1610-jake-30cm';
%    select = '1610-macadamia';
    select = '1610-jake-in-office';

    folder_setting = LoadFolderSetting(select);
    
    FileOpClearFolder(folder_setting.dst_folder);
    
    ProcessImage(folder_setting);
end