clear;
close all;
clc;
%[text] #### Prelude
if ~isfile(MATFILENAME)
    geotable = importMatMap; % points, lines
elseif ~exist("handle", "var")
    geotable = load(MATFILENAME); % geotable.points, geotable.lines
end %[output:2ab5d52b]
%%
%[text] keep?
geotable.points.highway(geotable.points.highway == "Parkoló tábla") = "";
geotable.points.highway(geotable.points.highway == "via_ferrata") = "";
%%


%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"inline"}
%---
%[output:2ab5d52b]
%   data: {"dataType":"error","outputData":{"errorType":"runtime","text":"Unrecognized field name \"T\"."}}
%---
