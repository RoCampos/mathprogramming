#include <iostream>
#include <fstream>
#include <string>
#include <libgen.h>
#include <cstdlib>

using namespace std;

int main (int argv, char**argc) 
{

	//argc[1] arquivo do qual será extraído o resuldo
	//*.info gerado pelo gurobi
	ifstream file (argc[1]);
	string str;

	//getting the instance
	char* inst = basename (argc[1]);

	float best = 0.0, bound, time, gap = 0.0;

	int nodes, exp;

	while ( getline (file, str) ) { //search for line where the result is
		//testing the matching with result

		string st(str);		
		sscanf (str.c_str(), "Best objective %f, best bound %f, gap %f",
				&best,&bound,&gap);
	
		sscanf (str.c_str(), "Best objective -, best bound %f, gap -",
				&bound);

		sscanf (st.c_str(), "Explored %d nodes (%d simplex iterations) in %f seconds",
				&nodes, &exp, &time);

	}

	printf ("%s\t%d\t%d\t%.2f\t%.2lf\n",inst,(int)best,(int)bound, gap, time);

	file.close ();

	file.open (argc[1]);

	if (!file.good () ) {
		exit(1);	
	}

/*
	ifstream file2 (argc[1]);

	std::cout << "here" << std::endl;
	while ( getline (file1, str)) {
		sscanf (str.c_str(), "Explored %d nodes (%d simplex iterations) in %f seconds",
				&nodes, &exp, time);
	}
	//printing out the result
	printf ("%s\t%d\t%d\t%.2f\t%.2lf\n",inst,(int)best,(int)bound,gap, time);
*/		

	return 0;
}
