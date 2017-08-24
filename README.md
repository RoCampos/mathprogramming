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


C++ codes
---------------------------------------------------------------------
filtro2 - main.cpp


src/multi

# Multiobjective Multicast Routing Packing Problem

In this module, the python library Jupyter is used to show the implementation of the models. So far, some
models were implement to test the Gurobi python API. 

## Installation

### creating virtualenv
	virtualenv --python=/usr/bin/python2.7 --system-site-packages multi
	pip install --ignore-installed <package-name>
	It is necessary to import gurobipy to solve the models

### Mathmatical Models

	Lee e Cho (2004) - Cost optimziation subject to the number of links in associated to each multicast tree

	Model1 - Optimizing Z (Residual Capacity)

	Model2 - Optimizing the solution cost

	Model3 - Steiner tree implementation

	Model4 - Multiobjective model (three objectives): cost, Z, hop counting

