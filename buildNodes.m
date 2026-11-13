%[text] Brief summary of this function.
%[text] Detailed explanation of this function.
function [graph, roads] = buildNodes(map, opts)
    arguments (Input)
        map struct
        opts.Classes (1,:) string = ["motorway", "motorway_link", "primary", "primary_link", "residential", "service", "secondary", ...
            "secondary_link", "tertiary", "tertiary_link", "trunk", "road"]
    end
    arguments (Output)
        graph {mustBeDigraphorNavGraph}
        roads table
    end
    keptRows = ismember(map.lines.highway, opts.Classes);
	roads = map.lines(keptRows, :);
	hw = string(roads.highway);
	tags = strings(height(roads), 1);
	if ismember("other_tags", string(roads.Properties.VariableNames))
		tags = string(roads.other_tags);
		tags(ismissing(tags)) = "";
	end
	ow = lower(tagValue(roads, tags, "oneway"));
	jn = lower(tagValue(roads, tags, "junction"));
	implicit = ow == "" & (hw == "motorway" | hw == "motorway_link" | ...
		jn == "roundabout" | jn == "circular");
	ow(implicit) = "yes";
	fwdOnly = ismember(ow, ["yes","true","1"]);
	bwdOnly = ismember(ow, ["-1","reverse"]);
	shape = roads.Shape;
	assert(isa(shape, "geolineshape"));
	n = numel(shape);
	T = geotable2table(roads(:, "Shape"), ["Latitude", "Longitude"]);
	summary(cellfun(@numel, T.Latitude))
	latC = cellfun(@(x) x(:), T.Latitude, "UniformOutput", false);
	lonC = cellfun(@(x) x(:), T.Longitude, "UniformOutput", false);
	clear T;
	way = repelem((1:n)', cellfun(@numel, latC));
	lat = vertcat(latC{:});
	lon = vertcat(lonC{:});
	clear latC lonC;
	bad = isnan(lat) | isnan(lon);
	seg = cumsum([true; (diff(way) ~= 0 | bad(1:end-1))]);
	lat(bad) = [];  lon(bad) = [];  way(bad) = [];  seg(bad) = [];
	key = int64(round((lat + 90)  * 1e7)) * int64(4e9) + int64(round((lon + 180) * 1e7));
	[~, ~, vid] = unique(key);
	uses = accumarray(vid, 1);
	newSeg = diff(seg) ~= 0;
	isFirst = [true; newSeg];
	isLast  = [newSeg; true];
	keep = isFirst | isLast | uses(vid) > 1; % segment ends + vertices shared by several ways
	kIdx = find(keep);
	a = find(~newSeg); % vertex a and a+1 are in the same segment
	b = a + 1;
	R  = 6371008.8; % mean Earth radius in metres (haversine)
	dLa = deg2rad(lat(b) - lat(a));
	dLo = deg2rad(lon(b) - lon(a));
	h = sin(dLa/2).^2 + cos(deg2rad(lat(a))) .* cos(deg2rad(lat(b))) .* sin(dLo/2).^2;
	segLen = 2 * R * asin(sqrt(min(h, 1)));
	chainOf  = cumsum(keep); % index of the kept vertex that starts each chain
	chainLen = accumarray(chainOf(a), segLen, [numel(kIdx) 1]);
	[~, firstOcc, nodeOfKept] = unique(vid(kIdx), "first"); % compact node IDs 1..N
	m = find(seg(kIdx(1:end-1)) == seg(kIdx(2:end))); % consecutive kept vertices in the same segment
	u  = nodeOfKept(m);
	v  = nodeOfKept(m + 1);
	w  = chainLen(m);
	wy = way(kIdx(m));
	ok = u ~= v; % drop self-loops
	u = u(ok);  v = v(ok);  w = w(ok);  wy = wy(ok);
	%% 6. Directed edges
	canF = ~bwdOnly(wy);                          % forward edge exists
	canB = ~fwdOnly(wy);                          % reverse edge exists
	s  = [u(canF);  v(canB)];
	t  = [v(canF);  u(canB)];
	W  = [w(canF);  w(canB)];
	WY = [wy(canF); wy(canB)];
	E = table([s t], W, WY, 'VariableNames', {'EndNodes','Weight','Way'});
	N = table(lat(kIdx(firstOcc)), lon(kIdx(firstOcc)), 'VariableNames', {'Lat','Lon'});
	graph = digraph(E, N);
	%% 7. Keep the largest strongly connected component
	bins = conncomp(graph, "Type", "strong");
	[~, big] = max(accumarray(bins(:), 1));
	graph = subgraph(graph, bins == big);
end

function mustBeDigraphorNavGraph(value)
    if ~(isa(value, "digraph") || isa(value, "navGraph"))
        error("Value is neither a digraph or a navGraph.");
    end
end

function v = tagValue(tbl, tags, key)
% value of an OSM tag: a table column if it exists, otherwise parsed from the
% GDAL hstore string  "oneway"=>"yes","maxspeed"=>"50"
if ismember(key, string(tbl.Properties.VariableNames))
	v = string(tbl.(char(key)));
else
	v = string(regexp(tags, ['(?<="' char(key) '"=>")[^"]*'], 'match', 'once'));
end
v(ismissing(v)) = "";
end

%[appendix]{"version":"1.0"}
%---
