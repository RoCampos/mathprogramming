#include <iostream>
#include <fstream>
#include <string>

using namespace std;

int main (int argv, char**argc) 
{

	//argc[1] arquivo do qual será extraído o resuldo
	//*.info gerado pelo gurobi
	ifstream file (argc[1]);
	string str;

	float best, bound;
	float gap;
	while ( getline (file, str) ) {

		sscanf (str.c_str(), "Best objective %f, best bound %f, gap %f%",
				&best,&bound,&gap);

	}

	printf ("%s\tBest %d\tBound %d\tGap %.2f\n",argc[1],(int)best,(int)bound,gap);
		

	return 0;
}
