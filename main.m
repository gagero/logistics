clear;
close all;
clc;
%[text] #### Prelude
if ~isfile(MATFILENAME)
    geotable = importMatMap; % points, lines
elseif ~exist("handle", "var")
    geotable = load(MATFILENAME); % geotable.points, geotable.lines
end
if exist("points", "var") && exist("lines", "var")
    geotable.points = points;
    geotable.lines = lines;
    clear points lines;
elseif exist("point", "var") || exist("lines", "var")
    error("Parsing failed.");
end
%%
%[text] keep?
geotable.points.highway(geotable.points.highway == "Parkoló tábla") = "";
geotable.points.highway(geotable.points.highway == "via_ferrata") = "";
%%
[G, roads] = buildNodes(geotable) %[output:3fdfa0d1]
%%
save("digraph.mat", "G", "-v7.3");
save("rawroads.mat", "roads", "-v7.3");
%%


%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"inline"}
%---
%[output:3fdfa0d1]
%   data: {"dataType":"error","outputData":{"errorType":"runtime","text":"Unrecognized function or variable 'geotable'."}}
%---
