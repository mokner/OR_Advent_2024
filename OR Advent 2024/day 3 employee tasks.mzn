include "globals.mzn";
include "alldifferent.mzn";

int: E = 100; % number of employees
int: T = 100; % number of tasks

var int: total_cost;

set of int: EMPLOYEES = 1..E;
set of int: TASKS = 1..T;

array[EMPLOYEES, TASKS] of int: task_cost_matrix;

array[TASKS] of var EMPLOYEES: task_assignments;

constraint alldifferent(task_assignments);

constraint total_cost = sum(e in EMPLOYEES)(task_cost_matrix[task_assignments[e], e]);

%constraint forall (e in EMPLOYEES) (alldifferent([TASKS]));


%constraint total_cost = sum(e in EMPLOYEES, t in TASKS)(employee_task_matrix[e, t]);

solve minimize total_cost;
