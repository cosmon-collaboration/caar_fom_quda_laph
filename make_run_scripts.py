import sys,os,argparse
sys.path.append("templates")
import xml_input

parser = argparse.ArgumentParser(description='Generate Quda_laph perambulator tasks and input files')
parser.add_argument('fCfg',type=int,help='first cfg')
parser.add_argument('lCfg',type=int,help='last cfg')

args = parser.parse_args()
print('Arguments passed')
print(args)
print('')

#peramb_ud_s_task#
cfg_dir="./cfgs"


ini_cfg=args.fCfg
max_cfg=args.lCfg+1

print()

node_count=24*24*len(range(ini_cfg,max_cfg,4))
peramb_dir="./"+str(node_count)


if not os.path.exists(peramb_dir):
    os.makedirs(peramb_dir, exist_ok=True)

#can do scale for 2,4,6,8,10 configs
#rm 6*/mpirun*/*.xml

#write bash script
bash_job=open(peramb_dir+'/FOM_perambs_nodes_'+str(node_count)+".sh",'w')
bash_job.write(xml_input.bash_head%{'ENV':'env.sh','NODES':str(node_count),'PERAMB_DIR':peramb_dir})

for cfg in range(ini_cfg,max_cfg,4):
    cfg_file=cfg_dir+"/"+str(cfg)
    nmpi=0
    params={}
    for srct1 in range(2,186,8):
        if not os.path.exists(peramb_dir+"/"+str(cfg)+"/mpirun"+str(nmpi)):
            os.makedirs(peramb_dir+"/"+str(cfg)+"/mpirun"+str(nmpi), exist_ok=True)        
        params['SRCT1']      = str(srct1)
        params['SRCT2']      = str(srct1+4)
        params['NCFG']       = str(cfg)
        params['CFG_FILE']   = cfg_dir+"/E250r001n"+params['NCFG']
        params['NMPI']       = str(nmpi)
        params['PERAMB_DIR'] = peramb_dir

        task_name="perambs_cfg"+str(cfg)+"_srct1_"+params['SRCT1']+"_srct2_"+params['SRCT2']
        in_file=open(peramb_dir+"/"+str(cfg)+"/mpirun"+str(nmpi)+"/"+task_name+".xml",'w')
        in_file.write(xml_input.peramb_ud_s_task%params)   

        in_file.close()
        task_params ={'NODES':str(node_count),'PERAMB_DIR':peramb_dir,
                      'NCFG':str(cfg),       'NMPI':str(nmpi),
                      'TASKNAME':task_name}
        bash_job.write(xml_input.peramb_jobs%task_params)   
        nmpi+=1
bash_job.write("\nwait\n")
bash_job.close()

