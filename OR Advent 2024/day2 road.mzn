include "globals.mzn";

int: N;
int: E;
int: F;

set of int: NODES = 1..N;
set of int: EDGES = 1..E;

array[EDGES] of int: start_cities;
array[EDGES] of int: end_cities;

array[NODES, NODES] of int: distance;
array[NODES, NODES] of int: fuel_costs;

array[NODES] of var bool: path_nodes;
array[EDGES] of var bool: path_edges;

var int: total_fuel;
var int: total_distance;

constraint dpath(N, E, start_cities, end_cities, 1, N, path_nodes, path_edges);

constraint total_distance = sum(e in EDGES)(path_edges[e]*(distance[start_cities[e], end_cities[e]]));
constraint total_fuel = sum(e in EDGES)(path_edges[e]*(fuel_costs[start_cities[e], end_cities[e]]));

constraint total_fuel <= F;

solve minimize(total_distance);

%% For output (optional)
