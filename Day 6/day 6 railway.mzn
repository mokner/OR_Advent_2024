include "globals.mzn";

int: N; % total number of railway nodes (stations)
int: R; % number of railway routes (sets of nodes)

set of int: NODES = 1..N;
set of int: ROUTES = 1..R;

array[ROUTES] of set of int: route_list;
array[ROUTES] of int: costs;

array[ROUTES] of var bool: selected;

var 0..sum(costs): total_cost;

constraint total_cost = sum(c in ROUTES)(selected[c] * costs[c]);
  
%constraint forall(r in ROUTES)(partition_set(route_list[r], ROUTES));

%
% ALTERNATE CONSTRAINT
%constraint forall(n in NODES)(exists (r in ROUTES where selected[r])(n in route_list[r]));

constraint forall(n in NODES)(sum(r in ROUTES where selected[r])(n in route_list[r]) >=1);

solve minimize total_cost;