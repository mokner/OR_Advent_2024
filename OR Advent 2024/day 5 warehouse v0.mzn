% Use this editor as a MiniZinc scratch book

int: C = 2;
int: W = 3;


set of int: CLIENTS = 1..C;
set of int: WAREHOUSES = 1..W;

array[CLIENTS] of int: client_demand = [160, 200];
array[WAREHOUSES] of int: capacity = [100, 150, 210];

array[CLIENTS, WAREHOUSES] of float: client_costs = array2d(CLIENTS, WAREHOUSES,
[
250, 5, 200,
600, 7, 500
]);

array[CLIENTS, WAREHOUSES] of var 0..max(client_demand): distribution;


%% Client demand has to be satisfied

constraint forall(c in CLIENTS)(sum(w in WAREHOUSES) (distribution[c,w]) = client_demand[c]);

constraint forall(w in WAREHOUSES)(sum(c in CLIENTS) (distribution[c,w]) <= capacity[w]);

%constraint sum(col(distribution, 1)) = 0;

solve minimize sum(c in CLIENTS, w in WAREHOUSES where distribution[c,w] > 0) (client_costs[c,w]);