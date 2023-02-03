import subprocess
import time

initial_time = time.time()
    
subprocess.run("./question2 10 10 10", shell=True)

time_final = time.time() - initial_time

print(time_final)