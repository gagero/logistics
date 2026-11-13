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
    clear points;
    clear lines;
elseif exist("point", "var") || exist("lines", "var")
    error("Parsing failed.");
end
%%
%[text] keep?
geotable.points.highway(geotable.points.highway == "Parkoló tábla") = "";
geotable.points.highway(geotable.points.highway == "via_ferrata") = "";
%%
[graph, roads] = buildNodes(geotable) %[output:0e4ee244] %[output:7c65813c] %[output:30e6ab17]
%%
%save("digraph.mat", "graph", "-v7.3");
%save("rawroads.mat", "roads", "-v7.3");
%%


%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"inline"}
%---
%[output:0e4ee244]
%   data: {"dataType":"text","outputData":{"text":"\n39727×1 double\n\n    <strong>NumMissing<\/strong>           0  \n    <strong>Min       <\/strong>           2  \n    <strong>Median    <\/strong>           3  \n    <strong>Max       <\/strong>         185  \n    <strong>Mean      <\/strong>      5.2770  \n    <strong>Std       <\/strong>      5.7023  \n\n","truncated":false}}
%---
%[output:7c65813c]
%   data: {"dataType":"textualVariable","outputData":{"name":"graph","value":"  <a href=\"matlab:helpPopup('digraph')\" style=\"font-weight:bold\">digraph<\/a> with properties:\n\n    Edges: [1184×3 table]\n    Nodes: [449×2 table]\n"}}
%---
%[output:30e6ab17]
%   data: {"dataType":"tabular","outputData":{"columnNames":["Shape","osm_id","name","highway","waterway","aerialway","barrier","man_made","railway","other_tags","other_tags_dictionary"],"columns":11,"dataTypes":["object","string","string","string","string","string","string","string","string","string","cell"],"header":"39727×11 table","name":"roads","rows":39727,"type":"table","value":[["geolineshape","\"3175983\"","\"Határ köz\"","\"residential\"","\"\"","\"\"","\"\"","\"\"","\"\"","\"\"surface\"=>\"asphalt\"\"","dictionary (string ⟼ string) with 1 entry"],["geolineshape","\"3192356\"","\"Mohácsi út\"","\"secondary\"","\"\"","\"\"","\"\"","\"\"","\"\"","\"\"lanes\"=>\"3\",\"oneway\"=>\"yes\",\"ref\"=>\"5617\",\"turn:lanes\"=>\"left|left;through|through;right\"\"","dictionary (string ⟼ string) with 4 entries"],["geolineshape","\"3212111\"","\"Rákóczi út\"","\"tertiary\"","\"\"","\"\"","\"\"","\"\"","\"\"","\"\"lanes\"=>\"2\",\"maxspeed\"=>\"50\",\"surface\"=>\"asphalt\"\"","dictionary (string ⟼ string) with 3 entries"],["geolineshape","\"3390680\"","\"\"","\"primary\"","\"\"","\"\"","\"\"","\"\"","\"\"","\"\"HU:ed_direction\"=>\"forward\",\"cycleway:both\"=>\"no\",\"lanes\"=>\"2\",\"lanes:backward\"=>\"1\",\"lanes:forward\"=>\"1\",\"maxspeed\"=>\"60\",\"priority_road\"=>\"yes\",\"ref\"=>\"6\",\"ref:HU:edid\"=>\"6u203k394m\",\"source:maxspeed\"=>\"sign\",\"surface\"=>\"asphalt\",\"toll:bus\"=>\"yes\",\"toll:hgv\"=>\"yes\"\"","dictionary (string ⟼ string) with 13 entries"],["geolineshape","\"3414164\"","\"Engel János József utca\"","\"tertiary\"","\"\"","\"\"","\"\"","\"\"","\"\"","\"\"oneway\"=>\"yes\"\"","dictionary (string ⟼ string) with 1 entry"],["geolineshape","\"3425635\"","\"Abaligeti út\"","\"secondary\"","\"\"","\"\"","\"\"","\"\"","\"\"","\"\"cycleway:both\"=>\"no\",\"ref\"=>\"6604\",\"surface\"=>\"asphalt\"\"","dictionary (string ⟼ string) with 3 entries"],["geolineshape","\"3426019\"","\"Magyarürögi út\"","\"secondary\"","\"\"","\"\"","\"\"","\"\"","\"\"","\"\"maxspeed\"=>\"50\",\"ref\"=>\"6604\",\"surface\"=>\"asphalt\"\"","dictionary (string ⟼ string) with 3 entries"],["geolineshape","\"3426020\"","\"Fülemüle utca\"","\"residential\"","\"\"","\"\"","\"\"","\"\"","\"\"","\"\"surface\"=>\"asphalt\"\"","dictionary (string ⟼ string) with 1 entry"],["geolineshape","\"3426236\"","\"\"","\"secondary\"","\"\"","\"\"","\"\"","\"\"","\"\"","\"\"ref\"=>\"6604\",\"surface\"=>\"asphalt\"\"","dictionary (string ⟼ string) with 2 entries"],["geolineshape","\"3427029\"","\"\"","\"secondary\"","\"\"","\"\"","\"\"","\"\"","\"\"","\"\"ref\"=>\"6608\",\"surface\"=>\"asphalt\"\"","dictionary (string ⟼ string) with 2 entries"],["geolineshape","\"3427031\"","\"\"","\"secondary\"","\"\"","\"\"","\"\"","\"\"","\"\"","\"\"ref\"=>\"6611\",\"surface\"=>\"asphalt\"\"","dictionary (string ⟼ string) with 2 entries"],["geolineshape","\"3427032\"","\"Dollár út\"","\"secondary\"","\"\"","\"\"","\"\"","\"\"","\"\"","\"\"ref\"=>\"6609\",\"surface\"=>\"asphalt\"\"","dictionary (string ⟼ string) with 2 entries"],["geolineshape","\"3427034\"","\"\"","\"secondary\"","\"\"","\"\"","\"\"","\"\"","\"\"","\"\"ref\"=>\"6608\"\"","dictionary (string ⟼ string) with 1 entry"],["geolineshape","\"3427036\"","\"\"","\"secondary\"","\"\"","\"\"","\"\"","\"\"","\"\"","\"\"ref\"=>\"6602\"\"","dictionary (string ⟼ string) with 1 entry"]]}}
%---
