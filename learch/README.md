### Init Docker
1. `docker build -t learch .`
2. `docker run -it learch`
### Compile Coreutils
1. `cd benchmarks`
2. `./prepare_coreutils.sh ${SOURCE_DIR}/benchmarks/coreutils_all.txt`
### Generate Dataset
1. `cd train`
2. `./train_data_coreutils_1.sh ${SOURCE_DIR}/benchmarks/coreutils_train_[YOUR NAME].txt`
3. Open another terminal
  - `docker ps`
  - `docker exec -it [CONTAINER ID] /bin/bash`
5. `./train_data_coreutils_2.sh ${SOURCE_DIR}/benchmarks/coreutils_train_[YOUR NAME].txt`
6. Upload `~\train_data\[STRATEGY]\[PROG]\all_features.npy` and `~\train_data\[STRATEGY]\[PROG]\all_leagths.npy` to google drive (create a folder for each program under a specific strategy)
7. Get train_data from docker in Windows terminal
  - `.\get_train_data_from_docker.ps1 -prog_list XY.txt -containerIDs b642b62ed8cc,6d19d65099df -output_dir C:\Users\yxcy\Desktop\train_data\`
9. Google Drive link:  https://drive.google.com/drive/folders/1UvnNy69O81Jj4JXLBOAgj1M8q5eoiis0?usp=sharing 
