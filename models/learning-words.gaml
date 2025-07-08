/**
* Name: learningwords
* Based on the internal empty template. 
* Author: bruno
* Tags: 
*/
model learningwords

/* Insert your model definition here */

/*
 * Global variables
 * 
 * @var MOORE_NEGHBORHOOD how gama checks the surroundings(neighbors) of an agent.
 * @var group_red_amount the amount of agents that will be created for the group red.
 *
 */
global {
	int MOORE_NEIGHBORHOOD <- 8;
	int COLOR_INDEX <- 1;
	int DICTIONARY_INDEX <- 2;
	
	int group_one_amount_of_agents;
	int group_one_amount_of_words;
	list<int> group_one_dictionary <- range(1, group_one_amount_of_words);
	rgb group_one_color <- #red;
	int group_two_range_end <- group_two_amount_of_words + group_two_amount_of_words;
		
	
	int group_two_amount_of_agents;
	int group_two_amount_of_words;
	list<int> group_two_dictionary <- range(group_one_amount_of_words, group_two_range_end);
	rgb group_two_color <- #blue;
	int group_three_range_end <- group_one_amount_of_words + group_two_amount_of_words + group_three_amount_of_words;	
	
	int group_three_amount_of_agents;
	int group_three_amount_of_words;
	list<int> group_three_dictionary <- range(group_two_range_end, group_three_range_end);
	rgb group_three_color <- #purple;
	
	int amount_of_words;
	string selected_group;
		
	list groups <- ["one", "two", "three"];
	
	init {		
		create person number: group_one_amount_of_agents with: (data: ["one", group_one_color, group_one_dictionary]);
		create person number: group_two_amount_of_agents with: (data: ["two", group_two_color, group_two_dictionary]);
		create person number: group_three_amount_of_agents with: (data: ["three", group_three_color, group_three_dictionary]);
	}
}

/*
 * 
 * Details characteristics of a person on the simulation.
 * 
 * @var language a list of words that the agent knows.
 * @var size How big the agent will be rendered on the grid
 */
species person {
	list data;
	
	int size <- 1;
	rgb color <- data[COLOR_INDEX];
	list<int> language <- data[DICTIONARY_INDEX];
	world_cell my_cell <- one_of(world_cell);

	init {
		location <- my_cell.location;
		write self.language;
	}

	reflex move_around {
		my_cell <- one_of(my_cell.neighbors);
		location <- my_cell.location;
	}

	reflex update {
		list neighbors <- topology(self) neighbors_of self;
		person choosen_neighbor <- one_of(neighbors);
		
		if (choosen_neighbor != nil) {
			ask choosen_neighbor {
			}
		}
	}
	
	aspect base {
		draw circle(size) color: color;
	}
}

grid world_cell width: 50 height: 50 neighbors: MOORE_NEIGHBORHOOD {
}

experiment learningwords type: gui {	
	parameter "Initial amount of agents " var: group_one_amount_of_agents init: 1 category: "Group one";
	parameter "Amount of words on the dictionary " var: group_one_amount_of_words init: 10 category: "Group one";
	parameter "Color of the agents within group one " var: group_one_color category: "Group one";
	
	parameter "Initial amount of agents on group two " var: group_two_amount_of_agents init: 1 category: "Group two";
	parameter "Amount of words on the dictionary on group two " var: group_two_amount_of_words init: 10 category: "Group two";
	parameter "Color of the agents within on group two " var: group_two_color category: "Group two";

	parameter "Initial amount of agents on group three " var: group_three_amount_of_agents init: 1 category: "Group three";
	parameter "Amount of words on the dictionar on group three " var: group_three_amount_of_words init: 10 category: "Group three";
	parameter "Color of the agents within on group three " var: group_three_color category: "Group three";
	
	output {
		display main_display {
			grid world_cell border: #black;
			species person aspect: base;
		}
	}
}
