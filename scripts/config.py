import re
import sys
import fileinput
from subprocess import Popen
import random
import shutil 


global_ip=False;

words="";
for line in fileinput.input():  #read data from input.txt and stored in words
    words+=line.strip()+","




nodes =("master","worker","proxy","management","boot")  #to check various type of entries to make correct entry in /opt/ibm.../cluster/hosts file
c=re.split(',| |\ ',words) #that make array form words string like eg [master,master_name,master_ip,worker,worker0,worker_ip]


indices = [i for i, x in enumerate(c) if x == "-w"]

f = open('hosts', 'w')   #this file for /otp/ibm.../cluster/hosts
h = open('new_worker_ip', 'w') # this check if entery for new nodes is availabel on /etc/hosts if not then stored in it
ip_file = open('ips_hosts', 'w')  #temproty file for storing ips
for_hosts = open('for_hosts', 'w')
for_new_hosts = open('for_new_hosts', 'w')
worker_index=0;

for val in nodes:
    #print(val)
    indices1 = [i for i, x in enumerate(c) if x == val]
    #print(indices1)
    checker = False;
    if val == "master":    #reading form input.txt and chek enteries for master
        # print ("-w")
        if len(indices1) >= 1:
            f.write("[master]")
            for x in indices1:
               
                f.write("\n" + c[x + 2])
                with open("/etc/hosts") as k:  # loop for chech entreies of ip exist in /etc/hosts
                    for line in k:
                        # print(c[x + 2])
                        if c[x + 2] in line:
                            # print("line is",line);
                            for_hosts.write(" " + c[x + 2])
                            for_hosts.write(" " + c[x + 1])
                            h.write("\n" + c[x + 2])
                            h.write("   " + c[x + 1])
                            checker = True;
                            global_ip=True;
                            break;
                    k.close()
                    if checker == False:
                        for_new_hosts.write(" " + c[x + 2])
                        for_new_hosts.write(" " + c[x + 1])

                        h.write("\n" + c[x + 2])
                        h.write("   " + c[x + 1])
                        ip_file.write("\n" + c[x + 2])
                        ip_file.write("   " + c[x + 1])
                        for_hosts.write(" " + c[x + 2])
                        for_hosts.write(" " + c[x + 1])

                    checker = False;

            f.write("\n")

    checker = False;
    checker = False;
    if val == "worker":
        # print ("-w")
        if len(indices1) >= 1:
            f.write("\n[worker]")
            for x in indices1:
                # print("indexes is", x)
                f.write("\n" + c[x + 2])

                with open("/etc/hosts") as k:  # loop for chech entreies of ip exist in /etc/hosts
                    for line in k:
                        # print(c[x + 2])
                        if c[x + 2] in line:
                            # print("line is",line);
                            for_hosts.write(" " + c[x + 2])
                            for_hosts.write(" " + c[x + 1])
                            h.write("\n" + c[x + 2])
                            h.write("   " + c[x + 1])
                            checker = True;
                            global_ip = True;
                            break;
                    k.close()
                    if checker == False:
                        for_new_hosts.write(" " + c[x + 2])
                        for_new_hosts.write(" " + c[x + 1])

                        h.write("\n" + c[x + 2])
                        h.write("   " + c[x + 1])
                        ip_file.write("\n" + c[x + 2])
                        ip_file.write("   " + c[x + 1])
                        for_hosts.write(" " + c[x + 2])
                        for_hosts.write(" " + c[x + 1])

                    checker = False;

            f.write("\n")

    checker = False;
    if val == "proxy":
        # print ("-w")
        if len(indices1) >= 1:
            f.write("\n[proxy]")
            for x in indices1:
                # print("indexes is", x)
                f.write("\n" + c[x + 2])
                with open("/etc/hosts") as k:  # loop for chech entreies of ip exist in /etc/hosts
                    for line in k:
                        # print(c[x + 2])
                        if c[x + 2] in line:
                            # print("line is",line);
                            for_hosts.write(" " + c[x + 2])
                            for_hosts.write(" " + c[x + 1])
                            h.write("\n" + c[x + 2])
                            h.write("   " + c[x + 1])
                            checker = True;
                            global_ip = True;
                            break;
                    k.close()
                    if checker == False:
                        for_new_hosts.write(" " + c[x + 2])
                        for_new_hosts.write(" " + c[x + 1])

                        h.write("\n" + c[x + 2])
                        h.write("   " + c[x + 1])
                        ip_file.write("\n" + c[x + 2])
                        ip_file.write("   " + c[x + 1])
                        for_hosts.write(" " + c[x + 2])
                        for_hosts.write(" " + c[x + 1])

                    checker = False;

            f.write("\n")

    checker = False;
    if val == "management":
        # print ("-w")
        if len(indices1) >= 1:
            f.write("\n[management]")
            for x in indices1:
                # print("indexes is", x)
                f.write("\n" + c[x + 2])
                with open("/etc/hosts") as k:  # loop for chech entreies of ip exist in /etc/hosts
                    for line in k:
                        # print(c[x + 2])
                        if c[x + 2] in line:
                            # print("line is",line);
                            for_hosts.write(" " + c[x + 2])
                            for_hosts.write(" " + c[x + 1])
                            h.write("\n" + c[x + 2])
                            h.write("   " + c[x + 1])
                            checker = True;
                            global_ip = True;
                            break;
                    k.close()
                    if checker == False:
                        for_new_hosts.write(" " + c[x + 2])
                        for_new_hosts.write(" " + c[x + 1])

                        h.write("\n" + c[x + 2])
                        h.write("   " + c[x + 1])
                        ip_file.write("\n" + c[x + 2])
                        ip_file.write("   " + c[x + 1])
                        for_hosts.write(" " + c[x + 2])
                        for_hosts.write(" " + c[x + 1])

                    checker = False;

            f.write("\n")

    checker = False;
    if val == "boot":
        # print ("-w")
        if len(indices1) >= 1:
            #f.write("\n[boot]")
            for x in indices1:
                with open("/etc/hosts") as k:  # loop for chech entreies of ip exist in /etc/hosts
                    for line in k:
                        # print(c[x + 2])
                        if c[x + 2] in line:
                            # print("line is",line);
                            for_hosts.write(" " + c[x + 2])
                            for_hosts.write(" " + c[x + 1])
                            h.write("\n" + c[x + 2])
                            h.write("   " + c[x + 1])
                            checker = True;   #if entry found then do nothing otherwise make new entry which file concat at all new nodes and old nodes
                            global_ip = True;
                            break;
                    k.close()
                    if checker == False:
                        for_new_hosts.write(" " + c[x + 2])
                        for_new_hosts.write(" " + c[x + 1])

                        h.write("\n" + c[x + 2])
                        h.write("   " + c[x + 1])
                        ip_file.write("\n" + c[x + 2])
                        ip_file.write("   " + c[x + 1])
                        for_hosts.write(" " + c[x + 2])
                        for_hosts.write(" " + c[x + 1])

                    checker = False;

            #f.write("\n")

indices1 = [i for i, x in enumerate(c) if x == "proxy"]  #check if ther is no proxy node exist
indices2 = [i for i, x in enumerate(c) if x == "master"]
val="master"
#print("No of Proxy IP is :",len(indices1))
if len(indices1) == 0:
    if val == "master":
        # print("-m")
        if len(indices2) >= 1:
            f.write("\n[proxy]")
            random_index = random.choice(indices2)
            f.write("\n" + c[random_index + 2])
            f.write("\n")

indices1 = [i for i, x in enumerate(c) if x == "management"]  #check if ther is no management node exist
#print("No of Management IP is :",len(indices1))
if len(indices1) == 0:
    if val == "master":
        # print("-m")
        if len(indices2) >= 1:
            f.write("\n[management]")
            random_index=random.choice(indices2) #make entery for some random master node as role for mangement(only single master)
            f.write("\n" + c[random_index + 2])
                
            f.write("\n")


f.close()
h.close()
ip_file.close()
for_hosts.close()
for_new_hosts.close()


#below_code#for appending ip address to other /etc/hosts file

fn=open("for_hosts", "r")
for_all_ssh=open("for_all_ssh", "w")
key_pair="";
for line in fn:
    #print(line+"on new line")
    key_pair+=line.strip()+","

array1=re.split(',| |\n|',key_pair)
array1.pop()

j=1;
temp1="test"
temp2="hi"


for i in range(len(array1)-1):
    if j+1<=len(array1):
        host=array1[j];
        # print(host)
        ip=array1[j-1]

        for_all_ssh.write(array1[j-1]+"\n")
        
        j=j+2
    else:
        break
# print("end of for loop");
fn.close()

for_all_ssh.close()
for_new_ssh=open("for_new_ssh", "w")  #beacus it write here it opens and make blank first entry when you run 
for_new_ssh.write("\n")

#below_code#all entries of all other nodes in new worker nodes
docker_run=""



if global_ip:        #this checke if new node entery in /etc/hosts if not then follows code
    # print("hello");
    fn1 = open("for_new_hosts", "r")
    key_pair = "";
    for line in fn1:
        # print(line+"on new line")
        key_pair += line.strip() + ","
    
    array1 = re.split(',| |\n|', key_pair)
    array1.pop()
    # print("output is", array1)
    j = 1;
    temp1 = "test"
    temp2 = "hi"
    

    for i in range(len(array1) - 1):
        if j + 1 <= len(array1):
            host = array1[j];
            for_new_ssh.write(array1[j - 1] + "\n")
            #print(host)
            ip = array1[j - 1]
            docker_run+=ip+",";
            
            j = j + 2
        else:
            break
    fn1.close()
#print("end of for loop2");

#that generat new script if new nodes added in cluster..(ie first terraform apply -> no new nodes; second terraform apply -> extra worker nodes ip). This script help to add newely created nodes in existing clustr
for_new_ssh.close()
docker_run = docker_run[:-1]
print(docker_run)
docker_run_bash=open("docker_run_bash.sh", "w")
docker_run_bash.write("#!/bin/bash")
docker_run_bash.write("\ncd /opt/ibm-cloud-private-ce-2.1.0/cluster")
docker_run_bash.write("\ndocker run -e LICENSE=accept --net=host -v $(pwd):/installer/cluster ibmcom/icp-inception:2.1.0 install -l ")
docker_run_bash.write(docker_run)

#this code remove extra added line from for_new_ssh file and make new file for_new_ssh1     
source_file = open('for_new_ssh', 'r')
source_file.readline()

# this will truncate the file, so need to use a different file name:
target_file = open('for_new_ssh1', 'w')
shutil.copyfileobj(source_file, target_file)
source_file.close()

#delete extra generated files by this script 
import os  
os.remove("for_new_hosts")
os.remove("for_hosts")
os.remove("for_new_ssh")
