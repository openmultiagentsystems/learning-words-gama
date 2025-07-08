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
	
	int group_one_amount_of_agents;
	int group_one_dictionary;
	rgb group_one_color <- #red;
	
	int group_two_amount_of_agents;
	int group_two_dictionary;
	rgb group_two_color <- #blue;
	
	int group_three_amount_of_agents;
	int group_three_dictionary;
	rgb group_three_color <- #purple;
	
	int amount_of_words;
	string selected_group;
	
	list<int> language <- range(1, 10);
	
	list groups <- ["one", "two", "three"];
	
	init {
		create person number: group_one_amount_of_agents with: (group: "one", group_color: group_one_color);
		create person number: group_two_amount_of_agents with: (group: "two", group_color: group_two_color);
		create person number: group_three_amount_of_agents with: (group: "three", group_color: group_three_color);
		
//		create person number: amount_of_agents with: (group: groups[0], language: language);
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
	string group;
	rgb group_color;
	
	int size <- 1;
	rgb color <- group_color;
	list<int> language <- [];
	world_cell my_cell <- one_of(world_cell);

	init {
		location <- my_cell.location;
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
				write self.group;
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
	parameter "Initial amount of agents " var: group_one_amount_of_agents init: 10 category: "Group one";
	parameter "Amount of words on the dictionary " var: group_one_dictionary init: 10 category: "Group one";
	parameter "Color of the agents within group one " var: group_one_color category: "Group one";
	
	parameter "Initial amount of agents on group two " var: group_two_amount_of_agents init: 10 category: "Group two";
	parameter "Amount of words on the dictionar on group two " var: group_two_dictionary init: 10 category: "Group two";
	parameter "Color of the agents within on group two " var: group_two_color category: "Group two";
	
	parameter "Initial amount of agents on group three " var: group_three_amount_of_agents init: 10 category: "Group three";
	parameter "Amount of words on the dictionar on group three " var: group_three_dictionary init: 10 category: "Group three";
	parameter "Color of the agents within on group three " var: group_three_color category: "Group three";
	
	output {
		display main_display {
			grid world_cell border: #black;
			species person aspect: base;
		}
	}
}
