
int: W; % number of warehouses
int: C; % number of clients

set of int: WAREHOUSES = 1..W;
set of int: CLIENTS = 1..C;

array[CLIENTS, WAREHOUSES] of var 0..max(client_demand): assignments;

array[CLIENTS, WAREHOUSES] of float: cost_matrix;

array[CLIENTS] of int: client_demand;

array[WAREHOUSES] of int: warehouse_capacity;

array[WAREHOUSES] of int: warehouse_max_cost;

constraint forall(w in WAREHOUSES)(sum(c in CLIENTS)(assignments[c, w]) <= warehouse_capacity[w]);

constraint forall(c in CLIENTS)(sum(w in WAREHOUSES)(assignments[c, w]) = client_demand[c]);

constraint forall(w in WAREHOUSES)(sum(c in CLIENTS where assignments[c, w] > 0)(cost_matrix[c, w]) <= warehouse_max_cost[w]);

%FIXED CONSTRAINTS
%constraint assignments[1,3] = 1;

%constraint is_fixed(assignments[1,3] = 0);

solve minimize sum(c in CLIENTS)(sum(w in WAREHOUSES where assignments[c, w] > 0)(cost_matrix[c,w]));

