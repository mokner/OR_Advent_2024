include "globals.mzn";
include "alldifferent.mzn";

int: N; % number of nodes
int: E; % number of edges
int: F; % fuel money in euros

var int: total_fuel;
var int: total_distance;

set of int: NODES = 1..N;
set of int: EDGES = 1..E;

array[EDGES] of int: start_cities;
array[EDGES] of int: end_cities;

array[NODES, NODES] of int: distance;
array[NODES, NODES] of int: fuel_costs;

array[NODES] of var bool: path_nodes;
array[EDGES] of var bool: path_edges;

constraint dpath(N, E, start_cities, end_cities, 1, N, path_nodes, path_edges);

constraint total_distance = sum(e in EDGES)(path_edges[e]*(distance[start_cities[e], end_cities[e]]));

constraint total_fuel = sum(e in EDGES)(path_edges[e]*(fuel_costs[start_cities[e], end_cities[e]]));

constraint total_fuel <= F;

%constraint total_distance > 0;

solve minimize(total_distance);