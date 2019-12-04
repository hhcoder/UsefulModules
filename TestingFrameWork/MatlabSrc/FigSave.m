function FigSave(out_folder, out_name)
    path = [out_folder '\' out_name];
    
    saveas(gcf, path, 'png');
    saveas(gcf, path, 'fig');
end