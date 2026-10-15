function f = importMatMap(input_file, output_file)
% Import a geotable file as a .mat file.
% input_file corresponds to the downloaded geotable file, with a default
% value of "hungary-261014.osm.pbf".
% output_file is the .mat file to output the parsed geotable into, the
% default is "hungarymap.mat".
% Returns a matfile handle.
arguments
    input_file string = "hungary-261014.osm.pbf"
    output_file string = "hungarymap.mat"
end
T = readgeotable(input_file, "VariableNamingRule", "modify");
save(output_file, "T", "-v7.3");
f = matfile(output_file, Writable=false);
end