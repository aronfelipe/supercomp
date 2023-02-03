import subprocess
import time

initial_time = time.time()

subprocess.run("./busca_local < in4.txt", shell=True)

final_time = time.time()

difference_between_times = final_time - initial_time
print(difference_between_times)