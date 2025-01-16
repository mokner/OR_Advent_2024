include "globals.mzn";
include "alldifferent.mzn";

int: T; % number of teachers
int: S; % number of subjects
int: C; % number of classes
int: R; % number of rooms available
int: P; % number of periods

int: REQUIREMENTS;

set of int: TEACHERS = 1..T;
set of int: SUBJECTS = 1..S;
set of int: CLASSES = 1..C;
set of int: ROOMS = 1..R;
set of int: PERIODS = 1..P;

array[ROOMS, CLASSES, TEACHERS] of int: requirements_matrix;

array[PERIODS, ROOMS, CLASSES, TEACHERS] of var 0..1: schedule_matrix;

constraint forall(p in PERIODS, r in ROOMS)
  (sum(c in CLASSES, t in TEACHERS)(schedule_matrix[p, r, c, t]) = 1
);

constraint forall(p in PERIODS, t in TEACHERS)
  (sum(r in ROOMS, c in CLASSES)(schedule_matrix[p, r, c, t]) = 1
);

constraint forall(p in PERIODS, c in CLASSES)
  (sum(r in ROOMS, t in TEACHERS)(schedule_matrix[p, r, c, t]) = 1
);


constraint forall(r in ROOMS, c in CLASSES, t in TEACHERS)
  (sum(p in PERIODS)(schedule_matrix[p, r, c, t]) = requirements_matrix[r, c, t]
);

solve satisfy;

output ["{Period \(p), Room \(r)} -> {Teacher \(t), Class \(c)} \n" | p in PERIODS, r in ROOMS, t in TEACHERS, c in CLASSES where fix(schedule_matrix[p, r, c, t]) = 1];