import subprocess
import time

initial_time = time.time()

subprocess.run("./busca_exaustiva_paralela < in4_busca_exaustiva.txt", shell=True)

final_time = time.time()

difference_between_times = final_time - initial_time
print(difference_between_times)