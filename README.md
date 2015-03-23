Taking some lessons about Math Programming.

	EXECUÇÃO DE UMA SOLUÇÃO

	#gerar dados para otimização - utiliza glpsol ou lpGenerator
./dat_to_lp.sh ../MPP_instances/n240 data/b240_lp ../projeto/build/lpGenerator; 

	#executar os casos de teste no gurobi
./run_gurobi.sh data/b240_lp data/b240_result;

	#filtrar solução para gerar arquivos opt 
./filtro_sol.sh data/b240_result data/b240_result; 

	#analisar arquivos opt e pegar custo real
./teste_solution.sh ../MPP_instances/n240 data/b240_result ../projeto/build/solutionTest

	#pegar informações geradas pelo solver
./get_opt.sh data/b120_result > data/b120_result/b120_solver_resumo.txt
