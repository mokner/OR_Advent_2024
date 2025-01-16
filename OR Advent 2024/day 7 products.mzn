include "globals.mzn";

int: P; % number of products
int: S; % number of subsets

set of int: PRODUCTS = 1..P;
set of int: SUBSETS = 1..S;

array[SUBSETS] of int: costs;
array[SUBSETS] of int: num_of_products;
array[SUBSETS] of set of int: product_list;

array[SUBSETS] of var bool: selected;

var 0..sum(costs): total_cost;

constraint total_cost = sum(s in SUBSETS)(selected[s] * costs[s]);

%constraint forall(p in PRODUCTS)(disjoint(PRODUCTS, product_list));

%constraint forall(p in PRODUCTS)(
%  sum(s in SUBSETS where p in product_list[s])(selected[p])=1
%);

%constraint forall(p in PRODUCTS)(
%  sum(s in SUBSETS where selected[p])(p in product_list[s]) == 1
%);

constraint forall(p in PRODUCTS)(sum(s in SUBSETS where selected[s])(p in product_list[s]) = 1);

solve minimize total_cost;