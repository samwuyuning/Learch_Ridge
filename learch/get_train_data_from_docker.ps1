Param(
  [parameter(mandatory=$true)][string] $prog_list,
  [parameter(mandatory=$true)][String[]] $containerIDs,
  [parameter(mandatory=$true)][string] $output_dir
)
$strategies = @("random-path-0", "nurs:cpicnt-0", "nurs:depth-0","sgs:1-0","sgs:2-0","sgs:4-0")

foreach($containerID in $containerIDs){
    foreach($strategy in $strategies){
        $strategy_win = $strategy.Replace(":","-")
        $path_strategy = "$output_dir\$strategy_win"
        If(!(test-path $path_strategy)){
            New-Item -ItemType Directory -Force -Path $path_strategy
        }
        foreach($prog in Get-Content $prog_list){
            #Write-Host "$containerID $strategy $prog"
            $path_prog = "$output_dir\$strategy_win\$prog"
            If(!(test-path $path_prog)){
            New-Item -ItemType Directory -Force -Path $path_prog
            }
            docker cp $containerID/:"\root\train_data\$strategy\$prog\all_features.npy" "$output_dir\$strategy_win\$prog"
            docker cp $containerID/:"\root\train_data\$strategy\$prog\all_lengths.npy" "$output_dir\$strategy_win\$prog"
        }
    }    
}

