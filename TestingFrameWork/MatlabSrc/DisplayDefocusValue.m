function  DisplayDefocusValue(lens_pos, defocus_values, output_folder, fname)
    figure,
    plot(lens_pos, defocus_values, 'bo--');
    title('Defocus value at different lens locations');
    xlabel('Lens position');
    ylabel('Defocus value');
    hold on
    hold on
    l=line;
    l.XData=[lens_pos(1) lens_pos(end)];
    l.YData=[0 0];
    l.LineStyle='--';
    l.Color='blue';
    hold off
    FigSave(output_folder, fname);
end
