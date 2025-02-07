include "globals.mzn";


int: bin_size; % number of bins in problem class

set of int: BINS = 1..bin_size;

% lists of widths and heights of bins
array[BINS] of int: bin_widths;
array[BINS] of int: bin_heights;

int: item_size; % number of objects in problem class
int: item_area; % combined minimum item area of problem class

set of int: ITEMS = 1..item_size;

array[ITEMS] of int: item_widths; % list of widths of items
array[ITEMS] of int: item_heights; % list of heights of items

% coordinates
array[BINS] of var 0..max(bin_widths): x_coords;
array[BINS] of var 0..max(bin_heights): y_coords;

% Decision variable: assignment of items to bins (determines which item goes into which bin)
array[BINS] of var set of ITEMS: bin_item_lists;
array[ITEMS, BINS] of var 0..1: bin_assignments;

% each item can only be assigned to one bin
constraint forall(i in ITEMS)(sum(b in BINS)(bin_assignments[i, b]) = 1);

constraint forall(b in BINS)
  (sum(i in bin_item_lists[b])
    (item_widths[i]) <= bin_widths[b]);
    
constraint forall(b in BINS)
  (sum(i in bin_item_lists[b])
    (item_heights[i]) <= bin_heights[b]);    


solve satisfy;




