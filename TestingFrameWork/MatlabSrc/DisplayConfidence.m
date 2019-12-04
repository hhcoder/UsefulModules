function DisplayConfidence(lens_pos, confidence_values, output_folder, fname)
    figure,
    plot(lens_pos, confidence_values, 'bo--');
    title('confidence value at different lens locations');
    xlabel('Lens position');
    ylabel('Confidence value');
    FigSave(output_folder, fname);
end

