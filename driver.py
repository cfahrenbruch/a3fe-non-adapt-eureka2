import os, a3fe as a3
print("CWD:", os.getcwd())
assert os.path.isdir("input"), "I don't see an 'input/' folder here. cd to your base run dir first."
calc = a3.Calculation(ensemble_size=5)
calc.setup()
calc.get_optimal_lam_vals()
calc.run(adaptive=False, runtime=5)   # 5 ns per replicate
calc.wait()
calc.set_equilibration_time(1)        # discard first 1 ns
calc.analyse()
calc.save()
print("Done.")
