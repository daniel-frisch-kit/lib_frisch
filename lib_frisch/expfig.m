function expfig(name,fig)
    folder = 'Figures';
    
    % PDF
    export_fig( sprintf('%s/%s.pdf',folder,name), fig, '-transparent', '-dNoOutputFonts' ); % '-nofontswap', 
    %print(fig, '-dpdf', sprintf('%s/%s.pdf',folder,name))  % needs rmws() for PDF resizing 

    % PNG
    export_fig( sprintf('%s/%s.png',folder,name), fig, '-transparent', '-m4'); 
    % print(fig, '-dpng', sprintf('%s/%s.png',folder,name), '-r300') 
    
    export_fig( sprintf('%s/%s.jpg',folder,name), fig); 
    saveas(fig, sprintf('%s/%s.svg',folder,name))
    savefig(fig, sprintf('%s/%s.fig',folder,name))
end

 
