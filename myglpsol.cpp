#include <iostream>
#include <glpk.h>
#include <cassert>

int main (int argv, char**argc)
{

	glp_prob *lp = NULL;
	glp_tran *tran = NULL;

	lp = glp_create_prob ();
	tran = glp_mpl_alloc_wksp ();
		

	int ret = glp_mpl_read_model (tran, argc[1], 1);
	assert (ret == 0);
	ret = glp_mpl_read_data (tran, argc[2]);
	assert (ret == 0);

	ret = glp_mpl_generate (tran, NULL);
	assert (ret == 0);


	glp_mpl_build_prob (tran, lp);


	glp_write_lp (lp, NULL, "SAIDA.lp");

	glp_mpl_free_wksp (tran);

	return 0;
}
