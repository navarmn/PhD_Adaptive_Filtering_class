
function [ ] = figure_postset(varargin)
% Fucntion call:
% =====================
% -- Format 01:
% figure_postset(xlabel, ylabel, 'Legend', legenda, 'Orientation', ori, 
%                title)
% -- Format 02:
% figure_postset(xlabel, ylabel, 'Title', title)
%
% -- Format 03:
% figure_postset(xlabel, ylabel)
%
% -- Format 04:
% figure_postset(xlabel, ylabel, 'Legend', legenda, 'Orientation', ori, 
%                title, gca)
% =====================
% Wherein:
% - xlabel: is a string with the x-label name.
% - ylabel: is a string with the y-label name.
% - title: a string containg the title name
% Pairwise variables: 
% 'Legend' and legenda (which is a string with the lagend name)
% 'Orientation' and ori (a string containg 'horizontal' or 'vertical' that
% is going to define legend's orientation)
%
%
% Obs.: If you would like latex standard you should type string names
% according late (e.g. uses $$ for formulas, \'c for ç and so on...)
%
% Obs.: If you do not disire any title in the figure you should leave the
% variable title as an empty string ('');
%
% =====================
% This is am alfa version, please let me know if you find any bugs, I really
% appreciate your effort and attention.
%
% Navar M M N
% navarmedeiros@gmail.com
%
% Last update: 15/11/2017
%
% =========================================================================
Font_size = 30;
Font_size_legend = 30;

set(gca,...
    'Units','normalized',...
    'Position', [.15 .2 .75 .7],...
    'FontUnits','points',...
    'FontWeight','normal',...
    'FontSize', Font_size,...
    'FontName','CMU Serif', ...
    'TickLabelInterpreter', 'latex')

if nargin > 1

xlabel(varargin{1}, ...
        'FontUnits','points',...
        'interpreter','latex',...
        'FontWeight','normal',...
        'FontSize',Font_size,...
        'FontName','CMU Serif')

ylabel(varargin{2} , ...
        'FontUnits','points',...
        'interpreter','latex',...
        'FontSize', Font_size,...
        'FontName', 'CMU Serif')
    
if nargin == 8    
    title(varargin{8} , ...
            'FontUnits','points',...
            'interpreter','latex',...
            'FontSize', Font_size+2,...
            'FontName', 'CMU Serif')
       
end

if nargin == 7    
    title(varargin{7} , ...
            'FontUnits','points',...
            'interpreter','latex',...
            'FontSize', Font_size+2,...
            'FontName', 'CMU Serif')
       
end

if nargin > 2
switch varargin{3}
    case 'Legend'           
        if nargin >= 8
            Font_size_legend = varargin{7};
            legend(gca, varargin{4},...
               'FontUnits', 'points', ...
               'interpreter','latex',...
               'FontSize', Font_size_legend, ...
               'FontName', 'CMU Serif', ...
               'Location', 'NorthEast', ...
               'Orientation', varargin{6})         
        else
            legend(varargin{4},...
                   'FontUnits', 'points', ...
                   'interpreter','latex',...
                   'FontSize', Font_size_legend, ...
                   'FontName', 'CMU Serif', ...
                   'Location', 'NorthEast', ...
                   'Orientation', varargin{6})
        end
    case 'Title'
        title(varargin{4} , ...
            'FontUnits','points',...
            'interpreter','latex',...
            'FontSize', Font_size+2,...
            'FontName', 'CMU Serif')
        
        
        
end

end


% Remove white borders:
ax = gca;
outerpos = ax.OuterPosition;
ti = ax.TightInset; 
left = outerpos(1) + ti(1);
bottom = outerpos(2) + ti(2);
ax_width = outerpos(3) - ti(1) - ti(3);
ax_height = outerpos(4) - ti(2) - ti(4);
ax.Position = [left*1.0 bottom ax_width ax_height];
ax.GridColor = [0, 0, 0];

grid on


% DONE!
   
end

