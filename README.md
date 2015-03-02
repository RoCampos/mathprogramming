Taking some lessons about Math Programming.

	EXECUÇÃO DE UMA SOLUÇÃO
./dat_to_lp.sh ../MPP_instances/n240 data/b240_lp ../projeto/build/lpGenerator; 
./run_gurobi.sh data/b240_lp data/b240_result; 
./filtro_sol.sh data/b240_result data/b240_result; 
./teste_solution.sh ../MPP_instances/n240 data/b240_result ../projeto/build/solutionTest

