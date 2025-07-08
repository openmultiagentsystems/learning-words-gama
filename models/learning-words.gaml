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
	int group_red_amount;

	init {
		create group_red number: group_red_amount;
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
	int size <- 1;
	rgb color <- #black;
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
	}

}

species group_red parent: person {
	rgb color <- #red;

	init {
		loop i from: 1 to: 10 {
			language <- language + i;
		}
	}

	aspect base {
		draw circle(size) color: color;
	}
}

grid world_cell width: 50 height: 50 neighbors: MOORE_NEIGHBORHOOD {
}

experiment learningwords type: gui {
	parameter "Initial amount of people onto the RED group: " var: group_red_amount init: 1000 category: "Group RED";
	output {
		display main_display {
			grid world_cell border: #black;
			species group_red aspect: base;
		}

	}

}
