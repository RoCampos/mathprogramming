#include <iostream>
#include <fstream>
#include <string>
#include <libgen.h>

using namespace std;

int main (int argv, char**argc) 
{

	//argc[1] arquivo do qual será extraído o resuldo
	//*.info gerado pelo gurobi
	ifstream file (argc[1]);
	string str;

	//getting the instance
	char* inst = basename (argc[1]);

	float best, bound;
	float gap;
	while ( getline (file, str) ) { //search for line where the result is

		//testing the matching with result
		sscanf (str.c_str(), "Best objective %f, best bound %f, gap %f%",
				&best,&bound,&gap);
	}

	//printing out the result
	printf ("%s\t%d\t%d\t%.2f\n",inst,(int)best,(int)bound,gap);
		

	return 0;
}
